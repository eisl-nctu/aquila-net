// =============================================================================
//  Program : mem_arbiter.v
//  Author  : YI-DE, LEE
//  Date    : Apr/9/2022
// -----------------------------------------------------------------------------
//  Description:
//      The arbiter for mig native interface. (Only support CLSIZE == 256 currently)
// -----------------------------------------------------------------------------
//  Notes for UG586 7 Series FPGAs Memory Interface Solutions User Guide
//      - app_rdy      : indicates mig user interface is ready to accept command (if app_rdy change from 1 to 0, it means command is accepted)
//      - app_addr     : every address represent 8 bytes, there is only 1GB DDR in KC705 so the address space is 0x07FFFFFF ~ 0x00000000
//      - app_cmd      : 3'b000 for write command, 3'b001 for read command
//      - app_en       : request strobe to mig, app_addr and app_cmd need to be ready
//      - app_wdf_rdy  : indicates that the write data FIFO is ready to receive data
//      - app_wdf_mask : mask for wdf_data, 0 indicates overwrite byte, 1 indicates keep byte
//      - app_wdf_data : data need to be written into ddr
//      - app_wdf_wren : indicates that data on app_wdf_data is valid
//      - app_wdf_end  : indicates that current clock cycle is the last cycle of input data on wdf_data
// -----------------------------------------------------------------------------
//  License information:
//
//  This software is released under the BSD-3-Clause Licence,
//  see https://opensource.org/licenses/BSD-3-Clause for details.
//  In the following license statements, "software" refers to the
//  "source code" of the complete hardware/software system.
//
//  Copyright 2019,
//                    Embedded Intelligent Systems Lab (EISL)
//                    Deparment of Computer Science
//                    National Chiao Tung Uniersity
//                    Hsinchu, Taiwan.
//
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//
//  3. Neither the name of the copyright holder nor the names of its contributors
//     may be used to endorse or promote products derived from this software
//     without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
// =============================================================================

module mem_arbiter #(
    parameter XLEN   = 32,
    parameter CLSIZE = 256 // Currently only support CLSIZE == 256 
)(
    input                 clk_i, 
    input                 rst_i,

    // I$ slave interface (read-only)
    input                 S_IMEM_strobe_i,
    input  [XLEN-1 : 0]   S_IMEM_addr_i,
    output                S_IMEM_done_o,
    output [CLSIZE-1 : 0] S_IMEM_data_o,

    // D$ slave interface
    input                 S_DMEM_strobe_i,
    input  [XLEN-1 : 0]   S_DMEM_addr_i,
    input                 S_DMEM_rw_i,
    input  [CLSIZE-1 : 0] S_DMEM_data_i,
    output                S_DMEM_done_o,
    output [CLSIZE-1 : 0] S_DMEM_data_o,

    // 7 Series FPGA MIG native user interface
    output [ 27 : 0]      M_MEM_addr_o,
    output [  2 : 0]      M_MEM_cmd_o,
    output                M_MEM_en_o,
    output [511 : 0]      M_MEM_wdf_data_o,
    output                M_MEM_wdf_end_o,
    output [ 63 : 0]      M_MEM_wdf_mask_o,
    output                M_MEM_wdf_wren_o,
    input  [511 : 0]      M_MEM_rd_data_i,
    input                 M_MEM_rd_data_valid_i,
    input                 M_MEM_rdy_i,
    input                 M_MEM_wdf_rdy_i,
    output                M_MEM_sr_req_o,
    output                M_MEM_ref_req_o,
    output                M_MEM_zq_req_o
);

    // Strobe source, have two strobe source (I$, D$) 
    localparam I_STROBE = 0,
               D_STROBE = 1;

    localparam M_IDLE = 0, // wait for strobe
               M_SEND = 1, // wait for mig ready for request
               M_WAIT = 2, // wait for rd data readed from ddr
               M_DONE = 3; // delay one cycle, 'cause we need to reorder the readed data (for timming improvement)

    // Keep the strobe
    reg                 S_IMEM_strobe_r;
    reg  [XLEN-1 : 0]   S_IMEM_addr_r;

    reg                 S_DMEM_strobe_r;
    reg  [XLEN-1 : 0]   S_DMEM_addr_r;
    reg                 S_DMEM_rw_r;
    reg  [CLSIZE-1 : 0] S_DMEM_data_r;

    // input selection signals
    reg  [  1 : 0]      sel;
    reg  [ 26 : 0]      addr;
    reg                 rw;
    reg  [511 : 0]      wdata;
    reg  [ 63 : 0]      wmask;

    // registered input signals
    reg  [  1 : 0]      sel_r;
    reg  [ 26 : 0]      addr_r;
    reg                 rw_r;
    reg  [511 : 0]      wdata_r;
    reg  [ 63 : 0]      wmask_r;

    // FSM signals
    reg  [  1 : 0]      c_state, n_state;
    wire                have_strobe;
    wire                mig_ready;
    wire [ 63 : 0]      mig_data_i [0 : 7];

    // data readed from mig need reorder
    reg  [511 : 0] rdata_reorder;

    //=======================================================
    //  Keep the strobe (in case we miss strobe)
    //=======================================================
    // I$ slave interface (read only)
    always @(posedge clk_i) begin
        if (rst_i)
            S_IMEM_strobe_r <= 0;
        else if (S_IMEM_strobe_i)
            S_IMEM_strobe_r <= 1;
        else if (S_IMEM_done_o)
            S_IMEM_strobe_r <= 0; // Clear the strobe
    end

    always @(posedge clk_i) begin
        if (rst_i)
            S_IMEM_addr_r <= 0;
        else if (S_IMEM_strobe_i)
            S_IMEM_addr_r <= S_IMEM_addr_i;
    end

    // D$ slave interface
    always @(posedge clk_i) begin
        if (rst_i)
            S_DMEM_strobe_r <= 0;
        else if (S_DMEM_strobe_i)
            S_DMEM_strobe_r <= 1;
        else if (S_DMEM_done_o)
            S_DMEM_strobe_r <= 0;
    end

    always @(posedge clk_i) begin
        if (rst_i)
            S_DMEM_addr_r <= 0;
        else if (S_DMEM_strobe_i)
            S_DMEM_addr_r <= S_DMEM_addr_i;
    end

    always @(posedge clk_i) begin
        if (rst_i)
            S_DMEM_rw_r <= 0;
        else if (S_DMEM_strobe_i)
            S_DMEM_rw_r <= S_DMEM_rw_i;
    end

    always @(posedge clk_i) begin
        if (rst_i)
            S_DMEM_data_r <= 0;
        else if (S_DMEM_strobe_i)
            S_DMEM_data_r <= S_DMEM_data_i;
    end

    //=======================================================
    //  Strobe signals selection (Priority : I$ > D$ > Network module)
    //=======================================================
    always @(*) begin
        if (S_IMEM_strobe_r) 
            sel = I_STROBE;
        else if (S_DMEM_strobe_r) 
            sel = D_STROBE;
        else
            sel = 0;
    end

    always @(*) begin
        case (sel)
            I_STROBE: addr = S_IMEM_addr_r[29:3];    
            D_STROBE: addr = S_DMEM_addr_r[29:3]; 
            default : addr = 0;
        endcase
    end

    always @(*) begin
        case (sel)
            I_STROBE: rw = 0; // I$ is read-only
            D_STROBE: rw = S_DMEM_rw_r;
            default : rw = 0;
        endcase
    end

    always @(*) begin
        case (sel) // (for scalability, you may assign wdata only with D$'s case)
            I_STROBE: wdata = 0; // I$ is read-only
            D_STROBE: wdata = addr[2] ? {S_DMEM_data_r, 256'b0} : {256'b0, S_DMEM_data_r}; // cache line size is 256 bits, we need to place data in right place
            default : wdata = 0;
        endcase
    end
    
    always @(*) begin
        case (sel)
            I_STROBE: wmask = addr[2] ? 64'h0000_0000_FFFF_FFFF : 64'hFFFF_FFFF_0000_0000;
            D_STROBE: wmask = addr[2] ? 64'h0000_0000_FFFF_FFFF : 64'hFFFF_FFFF_0000_0000;
            default : wmask = 64'hFFFF_FFFF_FFFF_FFFF;
        endcase
    end

    //=======================================================
    //  Register selected strobe's signals in IDLE state (for timming improvement)
    //=======================================================
    always @(posedge clk_i) begin
        if (rst_i)
            sel_r <= 0;
        else if (c_state == M_IDLE) 
            sel_r <= sel;
    end

    always @(posedge clk_i) begin
        if (rst_i)
            addr_r <= 0;
        else if (c_state == M_IDLE)
            addr_r <= addr; 
    end

    always @(posedge clk_i) begin
        if (rst_i)
            rw_r <= 0;
        else if (c_state == M_IDLE)
            rw_r <= rw;
    end

    always @(posedge clk_i) begin
        if (rst_i)
            wdata_r <= 0;
        else if (c_state == M_IDLE)
            wdata_r <= wdata;
    end

    always @(posedge clk_i) begin
        if (rst_i)
            wmask_r <= 0;
        else if (c_state == M_IDLE)
            wmask_r <= wmask;
    end

    //=======================================================
    //  Main FSM
    //=======================================================
    always @(posedge clk_i) begin
        if (rst_i)
            c_state <= M_IDLE;
        else
            c_state <= n_state;
    end

    always @(*) begin
        case (c_state)
            M_IDLE: 
                if (have_strobe) 
                    n_state = M_SEND;
                else 
                    n_state = M_IDLE;
            M_SEND: 
                if (mig_ready) 
                    n_state = rw_r ? M_IDLE : M_WAIT;
                else 
                    n_state = M_SEND;
            M_WAIT:
                if (M_MEM_rd_data_valid_i)
                    n_state = M_DONE; // Delay the output one cycle for reorder readed data
                else 
                    n_state = M_WAIT;
            M_DONE:
                n_state = M_IDLE;
        endcase
    end

    assign have_strobe = S_IMEM_strobe_r | S_DMEM_strobe_r;
    assign mig_ready   = rw_r ? M_MEM_rdy_i && M_MEM_wdf_rdy_i : M_MEM_rdy_i;

    //=======================================================
    //  Logic for MIG native interface
    //=======================================================
    always @(posedge clk_i) begin
        if (rst_i)
            rdata_reorder <= 0;
        else if (M_MEM_rd_data_valid_i) begin
            case(addr_r[2:0])
                0: rdata_reorder <= {mig_data_i[7], mig_data_i[6], mig_data_i[5], mig_data_i[4], mig_data_i[3], mig_data_i[2], mig_data_i[1], mig_data_i[0]};
                1: rdata_reorder <= {mig_data_i[6], mig_data_i[5], mig_data_i[4], mig_data_i[7], mig_data_i[2], mig_data_i[1], mig_data_i[0], mig_data_i[3]};
                2: rdata_reorder <= {mig_data_i[5], mig_data_i[4], mig_data_i[7], mig_data_i[6], mig_data_i[1], mig_data_i[0], mig_data_i[3], mig_data_i[2]};
                3: rdata_reorder <= {mig_data_i[4], mig_data_i[7], mig_data_i[6], mig_data_i[5], mig_data_i[0], mig_data_i[3], mig_data_i[2], mig_data_i[1]};
                4: rdata_reorder <= {mig_data_i[3], mig_data_i[2], mig_data_i[1], mig_data_i[0], mig_data_i[7], mig_data_i[6], mig_data_i[5], mig_data_i[4]};
                5: rdata_reorder <= {mig_data_i[2], mig_data_i[1], mig_data_i[0], mig_data_i[3], mig_data_i[6], mig_data_i[5], mig_data_i[4], mig_data_i[7]};
                6: rdata_reorder <= {mig_data_i[1], mig_data_i[0], mig_data_i[3], mig_data_i[2], mig_data_i[5], mig_data_i[4], mig_data_i[7], mig_data_i[6]};
                7: rdata_reorder <= {mig_data_i[0], mig_data_i[3], mig_data_i[2], mig_data_i[1], mig_data_i[4], mig_data_i[7], mig_data_i[6], mig_data_i[5]};
            endcase 
        end
    end

    assign mig_data_i[0] = M_MEM_rd_data_i[(63 + 64 * 0) -: 64];
    assign mig_data_i[1] = M_MEM_rd_data_i[(63 + 64 * 1) -: 64];
    assign mig_data_i[2] = M_MEM_rd_data_i[(63 + 64 * 2) -: 64];
    assign mig_data_i[3] = M_MEM_rd_data_i[(63 + 64 * 3) -: 64];
    assign mig_data_i[4] = M_MEM_rd_data_i[(63 + 64 * 4) -: 64];
    assign mig_data_i[5] = M_MEM_rd_data_i[(63 + 64 * 5) -: 64];
    assign mig_data_i[6] = M_MEM_rd_data_i[(63 + 64 * 6) -: 64];
    assign mig_data_i[7] = M_MEM_rd_data_i[(63 + 64 * 7) -: 64];

    assign M_MEM_addr_o     = {1'b0, addr_r}; // the 28th bit always 0, because we only have one rank in KC705
    assign M_MEM_cmd_o      = rw_r ? 3'b000 : 3'b001;
    assign M_MEM_en_o       = (c_state == M_SEND) && mig_ready;
    assign M_MEM_wdf_data_o = wdata_r;
    assign M_MEM_wdf_wren_o = (c_state == M_SEND) && mig_ready && rw_r;
    assign M_MEM_wdf_end_o  = (c_state == M_SEND) && mig_ready && rw_r;
    assign M_MEM_wdf_mask_o = wmask_r;
    assign M_MEM_sr_req_o   = 0;
    assign M_MEM_ref_req_o  = 0;
    assign M_MEM_zq_req_o   = 0;

    //=======================================================
    //  Output logic
    //=======================================================
    assign S_IMEM_data_o = addr_r[2] ? rdata_reorder[511:256] : rdata_reorder[255:0];
    assign S_DMEM_data_o = addr_r[2] ? rdata_reorder[511:256] : rdata_reorder[255:0];
    assign S_NMEM_data_o = rdata_reorder;
    assign S_IMEM_done_o = (c_state != M_IDLE) && (n_state == M_IDLE) && (sel_r == I_STROBE);
    assign S_DMEM_done_o = (c_state != M_IDLE) && (n_state == M_IDLE) && (sel_r == D_STROBE);

endmodule
