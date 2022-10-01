`timescale 1ns / 1ps
// =============================================================================
//  Program : dca_controller.v
//  Author  : YI-DE, LEE
//  Date    : Apr/9/2022
// -----------------------------------------------------------------------------
//  Description:
//      The DCA Controller for data-cache sharing between the Aquila core
//      and the HW TCP/IP stack.
//
// -----------------------------------------------------------------------------
//  License information:
//
//  This software is released under the BSD-3-Clause Licence,
//  see https://opensource.org/licenses/BSD-3-Clause for details.
//  In the following license statements, "software" refers to the
//  "source code" of the complete hardware/software system.
//
//  Copyright 2022,
//                    Embedded Intelligent Systems Lab (EISL)
//                    Deparment of Computer Science
//                    National Yang Ming Chiao Tung Uniersity
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

module dca_controller (
    input  wire                          clk,
    input  wire                          rst_i,
    output wire                          doing_dca,
    // TCP signals (RX)
    input  wire                          rx_data_valid,
    output wire                          rx_data_ready,
    input  wire [255 : 0]                rx_data_data,
    // TCP signals (TX)
    output wire                          tx_data_valid,
    input  wire                          tx_data_ready,
    output wire [255 : 0]                tx_data_data,
    output wire [ 31 : 0]                tx_data_keep,
    output wire                          tx_data_last,
    // UDP signals (RX)
    input  wire                          udp_rx_data_valid,
    output wire                          udp_rx_data_ready,
    input  wire [255 : 0]                udp_rx_data_data,
    // UDP signals (TX)
    output wire                          udp_tx_data_valid,
    input  wire                          udp_tx_data_ready,
    output wire [255 : 0]                udp_tx_data_data,
    output wire [ 31 : 0]                udp_tx_data_keep,
    output wire                          udp_tx_data_last,
    // Core signals
    input  wire                          N_DCA_req_i,
    output wire                          N_DCA_ready_o,
    input  wire [  1 : 0]                N_DCA_cmd_i,
    input  wire [ 31 : 0]                N_DCA_addr_i,
    input  wire [ 31 : 0]                N_DCA_len_i,
    // Dcache signals
    output wire [ 31 : 0]                N_DCACHE_addr_o,
    input  wire [255 : 0]                N_DCACHE_data_i,
    output wire [255 : 0]                N_DCACHE_data_o,
    output wire                          N_DCACHE_strobe_o,
    output wire                          N_DCACHE_we_o,
    input  wire                          N_DCACHE_ready_i
);
    /*
       cmd[0] == 0, Store, Dcache -> Network Module
       cmd[0] == 1, Load, Dcache <- Network Module
       cmd[1] == 0, TCP
       cmd[1] == 1, UDP
    */

    function [255:0] endian_swap;

        input [255:0] in_data;
        
        endian_swap = {in_data[ 31:  0], 
                       in_data[ 63: 32], 
                       in_data[ 95: 64], 
                       in_data[127: 96], 
                       in_data[159:128], 
                       in_data[191:160], 
                       in_data[223:192], 
                       in_data[255:224]};

    endfunction

    // FSM
    localparam S_IDLE        = 0,
               S_SEND_STROBE = 1,
               S_WAIT_READY  = 2;

    reg [ 1:0] c_state, n_state;

    // Core
    reg [ 1:0] cmd;
    reg [31:0] addr;
    reg [31:0] line_num;
    // if the request length is zero, don't do anything. (only return ready one cycle later)
    reg length_equal_zero;
    reg ready_r;

    // TCP/UDP signals multiplex
    reg         inf_ready;
    reg [31:0]  keep_of_last;

    always @(posedge clk) begin
        if (rst_i)
            c_state <= S_IDLE;
        else 
            c_state <= n_state;
    end

    always @(*) begin
        case (c_state)
            S_IDLE:
                if (N_DCA_req_i && N_DCA_len_i != 0) 
                    n_state = S_SEND_STROBE;
                else 
                    n_state = S_IDLE;
            S_SEND_STROBE:
                if (inf_ready) 
                    // Send strobe to dcache
                    n_state = S_WAIT_READY; 
                else 
                    n_state = S_SEND_STROBE;
            S_WAIT_READY:
                // Wait for Dcache ready
                if (N_DCACHE_ready_i)
                    n_state = (line_num == 1) ? S_IDLE : S_SEND_STROBE;
                else 
                    n_state = S_WAIT_READY;
            default: 
                n_state = S_IDLE;
        endcase
    end

    // Main Control
    assign doing_dca   = (c_state != S_IDLE);

    always @(posedge clk) begin
        if (rst_i)
            length_equal_zero <= 0;
        else if (c_state == S_IDLE && N_DCA_req_i)
            length_equal_zero <= (N_DCA_len_i == 0);
        else
            length_equal_zero <= 0;
    end

    always @(posedge clk) begin
        if (rst_i)
            cmd <= 0;
        else if (c_state == S_IDLE && N_DCA_req_i)
            cmd <= N_DCA_cmd_i;
    end

    always @(posedge clk) begin
        if (rst_i)
            addr <= 0;
        else if (c_state == S_IDLE && N_DCA_req_i)
            addr <= N_DCA_addr_i;
        else if (S_WAIT_READY && N_DCACHE_ready_i)
            addr <= addr + 32; // 256 bits equals to 32 byte
    end

    always @(posedge clk) begin
        if (rst_i)
            line_num <= 0;
        else if (c_state == S_IDLE && N_DCA_req_i)
            line_num <= {5'b00000 , N_DCA_len_i[31:5]} + (N_DCA_len_i[4:0] != 0);
        else if (S_WAIT_READY && N_DCACHE_ready_i)
            line_num <= line_num - 1;
    end

    always @(posedge clk) begin
        if (rst_i)
            keep_of_last <= 0;
        else if (c_state == S_IDLE && N_DCA_req_i)
            keep_of_last <= (N_DCA_len_i[4:0] == 0) ? {32{1'b1}} : (1 << N_DCA_len_i[4:0]) - 1;
    end

    always @(posedge clk) begin
        if (rst_i)
            ready_r <= 0;
        else
            ready_r <= ((c_state != S_IDLE) && (n_state == S_IDLE));
    end

    always @(*) begin
        case (cmd)
            2'b00: inf_ready = tx_data_ready;     // TCP Store
            2'b01: inf_ready = rx_data_valid;     // TCP Load
            2'b10: inf_ready = udp_tx_data_ready; // UDP Store
            2'b11: inf_ready = udp_rx_data_valid; // UDP Load
        endcase
    end

    // TCP/UDP output logic
    assign tx_data_data      = endian_swap(N_DCACHE_data_i);
    assign udp_tx_data_data  = endian_swap(N_DCACHE_data_i);

    assign tx_data_keep      = (line_num == 1) ? keep_of_last : {32{1'b1}};
    assign udp_tx_data_keep  = (line_num == 1) ? keep_of_last : {32{1'b1}};

    assign tx_data_last      = (line_num == 1);
    assign udp_tx_data_last  = (line_num == 1);

    assign tx_data_valid     = (c_state == S_WAIT_READY) && (cmd == 2'b00) && N_DCACHE_ready_i;
    assign udp_tx_data_valid = (c_state == S_WAIT_READY) && (cmd == 2'b10) && N_DCACHE_ready_i;

    assign rx_data_ready     = (c_state == S_WAIT_READY) && (cmd == 2'b01) && N_DCACHE_ready_i;
    assign udp_rx_data_ready = (c_state == S_WAIT_READY) && (cmd == 2'b11) && N_DCACHE_ready_i;

    // Dcache output logic
    assign N_DCACHE_addr_o   = addr;
    assign N_DCACHE_data_o   = cmd[1] ? endian_swap(udp_rx_data_data) : endian_swap(rx_data_data);
    assign N_DCACHE_strobe_o = inf_ready && (c_state == S_SEND_STROBE);
    assign N_DCACHE_we_o     = cmd[0];

    // Core output logic
    assign N_DCA_ready_o = length_equal_zero || ready_r;

endmodule
