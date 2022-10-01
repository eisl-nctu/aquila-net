/*
 * Copyright (c) 2019, Systems Group, ETH Zurich
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 * 3. Neither the name of the copyright holder nor the names of its contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * ----------------------------------------------------------------------------------------------------
 * Modification log (by ydlee)
 * 
 */

 `timescale 1ns / 1ps

module mem_inf (
    input  wire                          clk_core,
    input  wire                          clk_mem,
    input  wire                          rst_i,
    // TX Read Cmd
    input  wire                          s_axis_mem_read_cmd_valid,
    output wire                          s_axis_mem_read_cmd_ready,
    input  wire [71:0]                   s_axis_mem_read_cmd_data,
    // TX Read Status
    output wire                          s_axis_mem_read_sts_valid,
    input  wire                          s_axis_mem_read_sts_ready,
    output wire [7:0]                    s_axis_mem_read_sts_data,
    // TX Read Stream
    output wire [511:0]                  m_axis_mem_read_data,
    output wire [63:0]                   m_axis_mem_read_keep,
    output wire                          m_axis_mem_read_last,
    output wire                          m_axis_mem_read_valid,
    input  wire                          m_axis_mem_read_ready,
    // TX Write Cmd
    input  wire                          s_axis_mem_write_cmd_valid,
    output wire                          s_axis_mem_write_cmd_ready,
    input  wire [71:0]                   s_axis_mem_write_cmd_data,
    // TX Write Status
    output wire                          m_axis_mem_write_sts_valid,
    input  wire                          m_axis_mem_write_sts_ready,
    output wire [7:0]                    m_axis_mem_write_sts_data,
    // TX Write Stream
    input  wire [511:0]                  s_axis_mem_write_data,
    input  wire [63:0]                   s_axis_mem_write_keep,
    input  wire                          s_axis_mem_write_last,
    input  wire                          s_axis_mem_write_valid,
    output wire                          s_axis_mem_write_ready,
    // Mem interface
    input  wire                          N_MEM_done_i,
    input  wire [511:0]                  N_MEM_data_i,
    output wire                          N_MEM_strobe_o,
    output wire [31:0]                   N_MEM_addr_o,
    output wire [511:0]                  N_MEM_data_o,
    output wire [63:0]                   N_MEM_mask_o,
    output wire                          N_MEM_rw_o
);

    // Slave Interface Write Address Ports
    wire [31:0]                             mem_axi_awaddr;
    wire [7:0]                              mem_axi_awlen;
    wire                                    mem_axi_awvalid;
    wire                                    mem_axi_awready;
    // Slave Interface Write Data Ports
    wire [511:0]                            mem_axi_wdata;
    wire [63:0]                             mem_axi_wstrb;
    wire                                    mem_axi_wlast;
    wire                                    mem_axi_wvalid;
    wire                                    mem_axi_wready;
    // Slave Interface Write Response Ports
    wire                                    mem_axi_bready;
    wire [1:0]                              mem_axi_bresp;
    wire                                    mem_axi_bvalid;
    // Slave Interface Read Address Ports
    wire [31:0]                             mem_axi_araddr;
    wire [7:0]                              mem_axi_arlen;
    wire                                    mem_axi_arvalid;
    wire                                    mem_axi_arready;
    // Slave Interface Read Data Ports
    wire                                    mem_axi_rready;
    wire [511:0]                            mem_axi_rdata;
    wire [1:0]                              mem_axi_rresp;
    wire                                    mem_axi_rlast;
    wire                                    mem_axi_rvalid;
    

    /*
    * CLOCK CROSSING
    */

    wire         axis_mem_cc_to_dm_write_valid;
    wire         axis_mem_cc_to_dm_write_ready;
    wire [511:0] axis_mem_cc_to_dm_write_data;
    wire [63:0]  axis_mem_cc_to_dm_write_keep;
    wire         axis_mem_cc_to_dm_write_last;

    wire         axis_mem_dm_to_cc_read_valid;
    wire         axis_mem_dm_to_cc_read_ready;
    wire [511:0] axis_mem_dm_to_cc_read_data;
    wire [63:0]  axis_mem_dm_to_cc_read_keep;
    wire         axis_mem_dm_to_cc_read_last;


    axis_data_fifo_512_cc axis_write_data_fifo_tx (
        .s_axis_aclk(clk_core),                            
        .s_axis_aresetn(~rst_i),                           
        .s_axis_tvalid(s_axis_mem_write_valid),            
        .s_axis_tready(s_axis_mem_write_ready),            
        .s_axis_tdata(s_axis_mem_write_data),              
        .s_axis_tkeep(s_axis_mem_write_keep),              
        .s_axis_tlast(s_axis_mem_write_last),              
        
        .m_axis_aclk(clk_mem),                             
        .m_axis_tvalid(axis_mem_cc_to_dm_write_valid),     
        .m_axis_tready(axis_mem_cc_to_dm_write_ready),     
        .m_axis_tdata(axis_mem_cc_to_dm_write_data),       
        .m_axis_tkeep(axis_mem_cc_to_dm_write_keep),       
        .m_axis_tlast(axis_mem_cc_to_dm_write_last)        
    );

    axis_data_fifo_512_cc axis_read_data_fifo_tx (
        .s_axis_aclk(clk_mem),                             
        .s_axis_aresetn(~rst_i),                        
        .s_axis_tvalid(axis_mem_dm_to_cc_read_valid),      
        .s_axis_tready(axis_mem_dm_to_cc_read_ready),      
        .s_axis_tdata(axis_mem_dm_to_cc_read_data),        
        .s_axis_tkeep(axis_mem_dm_to_cc_read_keep),        
        .s_axis_tlast(axis_mem_dm_to_cc_read_last),        

        .m_axis_aclk(clk_core),                            
        .m_axis_tvalid(m_axis_mem_read_valid),             
        .m_axis_tready(m_axis_mem_read_ready),             
        .m_axis_tdata(m_axis_mem_read_data),               
        .m_axis_tkeep(m_axis_mem_read_keep),               
        .m_axis_tlast(m_axis_mem_read_last)                
    );

    /*
    * DATA MOVER
    */

    axi_datamover_512_to_512 datamover_tx (
        .m_axi_mm2s_aclk(clk_mem),
        .m_axi_mm2s_aresetn(~rst_i),
        .mm2s_err(),
        .m_axis_mm2s_cmdsts_aclk(clk_core),
        .m_axis_mm2s_cmdsts_aresetn(~rst_i),
        .s_axis_mm2s_cmd_tvalid(s_axis_mem_read_cmd_valid),
        .s_axis_mm2s_cmd_tready(s_axis_mem_read_cmd_ready),
        .s_axis_mm2s_cmd_tdata(s_axis_mem_read_cmd_data),
        .m_axis_mm2s_sts_tvalid(s_axis_mem_read_sts_valid),
        .m_axis_mm2s_sts_tready(s_axis_mem_read_sts_ready),
        .m_axis_mm2s_sts_tdata(s_axis_mem_read_sts_data),
        .m_axis_mm2s_sts_tkeep(),
        .m_axis_mm2s_sts_tlast(),
        .m_axi_mm2s_arid(),
        .m_axi_mm2s_araddr(mem_axi_araddr),
        .m_axi_mm2s_arlen(mem_axi_arlen),
        .m_axi_mm2s_arsize(),
        .m_axi_mm2s_arburst(),
        .m_axi_mm2s_arprot(),
        .m_axi_mm2s_arcache(),
        .m_axi_mm2s_aruser(),
        .m_axi_mm2s_arvalid(mem_axi_arvalid),
        .m_axi_mm2s_arready(mem_axi_arready),
        .m_axi_mm2s_rdata(mem_axi_rdata),
        .m_axi_mm2s_rresp(mem_axi_rresp),
        .m_axi_mm2s_rlast(mem_axi_rlast),
        .m_axi_mm2s_rvalid(mem_axi_rvalid),
        .m_axi_mm2s_rready(mem_axi_rready),
        .m_axis_mm2s_tdata(axis_mem_dm_to_cc_read_data),
        .m_axis_mm2s_tkeep(axis_mem_dm_to_cc_read_keep),
        .m_axis_mm2s_tlast(axis_mem_dm_to_cc_read_last),
        .m_axis_mm2s_tvalid(axis_mem_dm_to_cc_read_valid),
        .m_axis_mm2s_tready(axis_mem_dm_to_cc_read_ready),
        .m_axi_s2mm_aclk(clk_mem),
        .m_axi_s2mm_aresetn(~rst_i),
        .s2mm_err(),
        .m_axis_s2mm_cmdsts_awclk(clk_core),
        .m_axis_s2mm_cmdsts_aresetn(~rst_i),
        .s_axis_s2mm_cmd_tvalid(s_axis_mem_write_cmd_valid),
        .s_axis_s2mm_cmd_tready(s_axis_mem_write_cmd_ready),
        .s_axis_s2mm_cmd_tdata(s_axis_mem_write_cmd_data),
        .m_axis_s2mm_sts_tvalid(m_axis_mem_write_sts_valid),
        .m_axis_s2mm_sts_tready(m_axis_mem_write_sts_ready),
        .m_axis_s2mm_sts_tdata(m_axis_mem_write_sts_data),
        .m_axis_s2mm_sts_tkeep(),
        .m_axis_s2mm_sts_tlast(),
        .m_axi_s2mm_awid(),
        .m_axi_s2mm_awaddr(mem_axi_awaddr),
        .m_axi_s2mm_awlen(mem_axi_awlen),
        .m_axi_s2mm_awsize(),
        .m_axi_s2mm_awburst(),
        .m_axi_s2mm_awprot(),
        .m_axi_s2mm_awcache(),
        .m_axi_s2mm_awuser(),
        .m_axi_s2mm_awvalid(mem_axi_awvalid),
        .m_axi_s2mm_awready(mem_axi_awready),
        .m_axi_s2mm_wdata(mem_axi_wdata),
        .m_axi_s2mm_wstrb(mem_axi_wstrb),
        .m_axi_s2mm_wlast(mem_axi_wlast),
        .m_axi_s2mm_wvalid(mem_axi_wvalid),
        .m_axi_s2mm_wready(mem_axi_wready),
        .m_axi_s2mm_bresp(mem_axi_bresp),
        .m_axi_s2mm_bvalid(mem_axi_bvalid),
        .m_axi_s2mm_bready(mem_axi_bready),
        .s_axis_s2mm_tdata(axis_mem_cc_to_dm_write_data),
        .s_axis_s2mm_tkeep(axis_mem_cc_to_dm_write_keep),
        .s_axis_s2mm_tlast(axis_mem_cc_to_dm_write_last),
        .s_axis_s2mm_tvalid(axis_mem_cc_to_dm_write_valid),
        .s_axis_s2mm_tready(axis_mem_cc_to_dm_write_ready)   // : OUT STD_LOGIC;
    );

    // Interface Transform
    localparam [1:0] S_IDLE      = 0,
                     S_DDR_READ  = 1,
                     S_DDR_STALL = 2,
                     S_DDR_WRITE = 3;

    reg [1:0]  S, S_nxt;
    reg [31:0] axi_addr_r;
    reg [7:0]  axi_len_r;

    reg [511:0] N_MEM_data_r;

    wire axi_ar_transition;
    wire axi_aw_transition;
    wire axi_r_transition;
    wire axi_w_transition;

    assign axi_ar_transition = mem_axi_arvalid && mem_axi_arready;
    assign axi_aw_transition = mem_axi_awvalid && mem_axi_awready;
    assign axi_r_transition  = mem_axi_rvalid && mem_axi_rready;
    assign axi_w_transition  = mem_axi_wvalid && mem_axi_wready;

    assign mem_axi_arready = (S == S_IDLE);
    assign mem_axi_rvalid  = (S == S_DDR_READ && N_MEM_done_i) || (S == S_DDR_STALL);
    assign mem_axi_rdata   = (S == S_DDR_READ) ? N_MEM_data_i : N_MEM_data_r;
    assign mem_axi_rlast   = axi_len_r == 0;
    assign mem_axi_rresp   = 0;

    assign mem_axi_awready = (S == S_IDLE) && ~mem_axi_arvalid; // Read first
    assign mem_axi_wready  = (S == S_DDR_WRITE) && N_MEM_done_i;
    assign mem_axi_bresp   = 0;
    assign mem_axi_bvalid  = 1;

    always @(posedge clk_mem) begin
        if (rst_i) 
            S <= S_IDLE;
        else
            S <= S_nxt;
    end

    always @(*) begin
        case (S) 
            S_IDLE:
                // Wait for address channel
                if (mem_axi_arvalid)
                    S_nxt = S_DDR_READ;
                else if (mem_axi_awvalid)
                    S_nxt = S_DDR_WRITE;
                else
                    S_nxt = S_IDLE;
            S_DDR_READ:
                // Send strob to mem_arbiter
                if (N_MEM_done_i)
                    S_nxt = (~mem_axi_rready) ? S_DDR_STALL : (axi_len_r == 0) ? S_IDLE : S_DDR_READ;
                else
                    S_nxt = S_DDR_READ;
            S_DDR_STALL:
                // Wait datamover ready
                if (mem_axi_rready)
                    S_nxt = (axi_len_r == 0) ? S_IDLE : S_DDR_READ;
                else
                    S_nxt = S_DDR_STALL;
            S_DDR_WRITE:
                if (N_MEM_done_i && mem_axi_wvalid)
                    S_nxt = (axi_len_r == 0) ? S_IDLE : S_DDR_WRITE;
                else
                    S_nxt = S_DDR_WRITE;
            default:
                S_nxt = S_IDLE;
        endcase
    end

    always @(posedge clk_mem) begin
        if (rst_i)
            axi_addr_r <= 0;
        else if (axi_ar_transition)
            axi_addr_r <= mem_axi_araddr;
        else if (axi_aw_transition)
            axi_addr_r <= mem_axi_awaddr;
        else if (axi_r_transition || axi_w_transition)
            axi_addr_r <= axi_addr_r + 64;
    end

    always @(posedge clk_mem) begin
        if (rst_i)
            axi_len_r <= 0;
        else if (axi_ar_transition)
            axi_len_r <= mem_axi_arlen;
        else if (axi_aw_transition)
            axi_len_r <= mem_axi_awlen;
        else if ((axi_r_transition || axi_w_transition) && axi_len_r != 0)
            axi_len_r <= axi_len_r - 1;
    end

    // INF
    assign N_MEM_addr_o   = {axi_addr_r[31 : 5], 3'b0, 2'b0};
    assign N_MEM_data_o   = mem_axi_wdata;
    assign N_MEM_mask_o   = ~mem_axi_wstrb;
    assign N_MEM_rw_o     = (S == S_DDR_WRITE); // 1 for write
    assign N_MEM_strobe_o = (S == S_DDR_READ && mem_axi_rready) || (S == S_DDR_WRITE && mem_axi_wvalid); 

    always @(posedge clk_mem) begin
        if (rst_i)
            N_MEM_data_r <= 0;
        else if (N_MEM_done_i)
            N_MEM_data_r <= N_MEM_data_i;
    end

endmodule