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


module udp_stack #(
    parameter WIDTH = 64
)(
    input  wire                          clk,
    input  wire                          rst_n,
    // IP, Port configuration
    input  wire [31:0]                   local_ip_address,
    input  wire                          s_axis_udp_port_cmd_valid,
    output wire                          s_axis_udp_port_cmd_ready,
    input  wire [31 : 0]                 s_axis_udp_port_cmd_data,
    // Network RX TX Data interfaces
    input  wire                          s_axis_rx_data_valid,
    output wire                          s_axis_rx_data_ready,
    input  wire [WIDTH-1 : 0]            s_axis_rx_data_data,
    input  wire [(WIDTH/8)-1 : 0]        s_axis_rx_data_keep,
    input  wire                          s_axis_rx_data_last,
    output wire                          m_axis_tx_data_valid,
    input  wire                          m_axis_tx_data_ready,
    output wire [WIDTH-1 : 0]            m_axis_tx_data_data,
    output wire [(WIDTH/8)-1 : 0]        m_axis_tx_data_keep,
    output wire                          m_axis_tx_data_last,
    // UDP user Interface
    output wire                          m_axis_udp_rx_data_valid,
    input  wire                          m_axis_udp_rx_data_ready,
    output wire [WIDTH-1 : 0]            m_axis_udp_rx_data_data,
    output wire [(WIDTH/8)-1 : 0]        m_axis_udp_rx_data_keep,
    output wire                          m_axis_udp_rx_data_last,
    input  wire                          s_axis_udp_tx_data_valid,
    output wire                          s_axis_udp_tx_data_ready,
    input  wire [WIDTH-1 : 0]            s_axis_udp_tx_data_data,
    input  wire [(WIDTH/8)-1 : 0]        s_axis_udp_tx_data_keep,
    input  wire                          s_axis_udp_tx_data_last,
    output wire                          m_axis_udp_rx_metadata_valid,
    input  wire                          m_axis_udp_rx_metadata_ready,
    output wire [175 : 0]                m_axis_udp_rx_metadata_data,
    input  wire                          s_axis_udp_tx_metadata_valid,
    output wire                          s_axis_udp_tx_metadata_ready,
    input  wire [175 : 0]                s_axis_udp_tx_metadata_data
   
 );

    wire                          axis_ip_to_udp_slice_meta_valid;
    wire                          axis_ip_to_udp_slice_meta_ready;
    wire [47 : 0]                 axis_ip_to_udp_slice_meta_data;

    wire                          axis_ip_to_udp_meta_valid;
    wire                          axis_ip_to_udp_meta_ready;
    wire [47 : 0]                 axis_ip_to_udp_meta_data;

    wire                          axis_udp_to_ip_slice_meta_valid;
    wire                          axis_udp_to_ip_slice_meta_ready;
    wire [47 : 0]                 axis_udp_to_ip_slice_meta_data;

    wire                          axis_udp_to_ip_meta_valid;
    wire                          axis_udp_to_ip_meta_ready;
    wire [47 : 0]                 axis_udp_to_ip_meta_data;

    wire                          axis_ip_to_udp_data_valid;
    wire                          axis_ip_to_udp_data_ready;
    wire [WIDTH-1 : 0]            axis_ip_to_udp_data_data;
    wire [(WIDTH/8)-1 : 0]        axis_ip_to_udp_data_keep;
    wire                          axis_ip_to_udp_data_last;

    wire                          axis_udp_to_ip_data_valid;
    wire                          axis_udp_to_ip_data_ready;
    wire [WIDTH-1 : 0]            axis_udp_to_ip_data_data;
    wire [(WIDTH/8)-1 : 0]        axis_udp_to_ip_data_keep;
    wire                          axis_udp_to_ip_data_last;

    wire                          axis_udp_rx_metadata_valid;
    wire                          axis_udp_rx_metadata_ready;
    wire [175 : 0]                axis_udp_rx_metadata_data;

    wire                          axis_udp_tx_metadata_valid;
    wire                          axis_udp_tx_metadata_ready;
    wire [175 : 0]                axis_udp_tx_metadata_data;

    wire                          axis_udp_port_cmd_valid;
    wire                          axis_udp_port_cmd_ready;
    wire [31 : 0]                 axis_udp_port_cmd_data;
    
    ipv4_ip ipv4_inst (
        .local_ipv4_address_V(local_ip_address),
        .protocol_V(8'h11), //UDP_PROTOCOL
        //RX
        .s_axis_rx_data_TVALID(s_axis_rx_data_valid),
        .s_axis_rx_data_TREADY(s_axis_rx_data_ready),
        .s_axis_rx_data_TDATA(s_axis_rx_data_data),
        .s_axis_rx_data_TKEEP(s_axis_rx_data_keep),
        .s_axis_rx_data_TLAST(s_axis_rx_data_last),
        .m_axis_rx_meta_V_TVALID(axis_ip_to_udp_slice_meta_valid),
        .m_axis_rx_meta_V_TREADY(axis_ip_to_udp_slice_meta_ready),
        .m_axis_rx_meta_V_TDATA(axis_ip_to_udp_slice_meta_data),
        .m_axis_rx_data_TVALID(axis_ip_to_udp_data_valid),
        .m_axis_rx_data_TREADY(axis_ip_to_udp_data_ready),
        .m_axis_rx_data_TDATA(axis_ip_to_udp_data_data),
        .m_axis_rx_data_TKEEP(axis_ip_to_udp_data_keep),
        .m_axis_rx_data_TLAST(axis_ip_to_udp_data_last),
        //TX
        .s_axis_tx_meta_V_TVALID(axis_udp_to_ip_meta_valid),
        .s_axis_tx_meta_V_TREADY(axis_udp_to_ip_meta_ready),
        .s_axis_tx_meta_V_TDATA(axis_udp_to_ip_meta_data),
        .s_axis_tx_data_TVALID(axis_udp_to_ip_data_valid),
        .s_axis_tx_data_TREADY(axis_udp_to_ip_data_ready),
        .s_axis_tx_data_TDATA(axis_udp_to_ip_data_data),
        .s_axis_tx_data_TKEEP(axis_udp_to_ip_data_keep),
        .s_axis_tx_data_TLAST(axis_udp_to_ip_data_last),
        .m_axis_tx_data_TVALID(m_axis_tx_data_valid),
        .m_axis_tx_data_TREADY(m_axis_tx_data_ready),
        .m_axis_tx_data_TDATA(m_axis_tx_data_data),
        .m_axis_tx_data_TKEEP(m_axis_tx_data_keep),
        .m_axis_tx_data_TLAST(m_axis_tx_data_last),
        
        .ap_clk(clk),
        .ap_rst_n(rst_n)
    );

    meta_register_slice #(.WIDTH(48)) rx_ip_meta_slice(
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(axis_ip_to_udp_slice_meta_valid),
        .s_axis_ready(axis_ip_to_udp_slice_meta_ready),
        .s_axis_data(axis_ip_to_udp_slice_meta_data),
        .m_axis_valid(axis_ip_to_udp_meta_valid),
        .m_axis_ready(axis_ip_to_udp_meta_ready),
        .m_axis_data(axis_ip_to_udp_meta_data)
    );
    meta_register_slice #(.WIDTH(48)) tx_ip_meta_slice(
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(axis_udp_to_ip_slice_meta_valid),
        .s_axis_ready(axis_udp_to_ip_slice_meta_ready),
        .s_axis_data(axis_udp_to_ip_slice_meta_data),
        .m_axis_valid(axis_udp_to_ip_meta_valid),
        .m_axis_ready(axis_udp_to_ip_meta_ready),
        .m_axis_data(axis_udp_to_ip_meta_data)
    );

    
    udp_ip udp_inst (
        .reg_ip_address_V({local_ip_address,local_ip_address,local_ip_address,local_ip_address}),
        .s_axis_port_cmd_V_TVALID(axis_udp_port_cmd_valid),
        .s_axis_port_cmd_V_TREADY(axis_udp_port_cmd_ready),
        .s_axis_port_cmd_V_TDATA(axis_udp_port_cmd_data),
        //RX
        .s_axis_rx_meta_V_TVALID(axis_ip_to_udp_meta_valid),
        .s_axis_rx_meta_V_TREADY(axis_ip_to_udp_meta_ready),
        .s_axis_rx_meta_V_TDATA(axis_ip_to_udp_meta_data),
        .s_axis_rx_data_TVALID(axis_ip_to_udp_data_valid),
        .s_axis_rx_data_TREADY(axis_ip_to_udp_data_ready),
        .s_axis_rx_data_TDATA(axis_ip_to_udp_data_data),
        .s_axis_rx_data_TKEEP(axis_ip_to_udp_data_keep),
        .s_axis_rx_data_TLAST(axis_ip_to_udp_data_last),
        .m_axis_rx_meta_V_TVALID(axis_udp_rx_metadata_valid),
        .m_axis_rx_meta_V_TREADY(axis_udp_rx_metadata_ready),
        .m_axis_rx_meta_V_TDATA(axis_udp_rx_metadata_data),
        .m_axis_rx_data_TVALID(m_axis_udp_rx_data_valid),
        .m_axis_rx_data_TREADY(m_axis_udp_rx_data_ready),
        .m_axis_rx_data_TDATA(m_axis_udp_rx_data_data),
        .m_axis_rx_data_TKEEP(m_axis_udp_rx_data_keep),
        .m_axis_rx_data_TLAST(m_axis_udp_rx_data_last),
        //TX
        .s_axis_tx_meta_V_TVALID(axis_udp_tx_metadata_valid),
        .s_axis_tx_meta_V_TREADY(axis_udp_tx_metadata_ready),
        .s_axis_tx_meta_V_TDATA(axis_udp_tx_metadata_data),
        .s_axis_tx_data_TVALID(s_axis_udp_tx_data_valid),
        .s_axis_tx_data_TREADY(s_axis_udp_tx_data_ready),
        .s_axis_tx_data_TDATA(s_axis_udp_tx_data_data),
        .s_axis_tx_data_TKEEP(s_axis_udp_tx_data_keep),
        .s_axis_tx_data_TLAST(s_axis_udp_tx_data_last),
        .m_axis_tx_meta_V_TVALID(axis_udp_to_ip_slice_meta_valid),
        .m_axis_tx_meta_V_TREADY(axis_udp_to_ip_slice_meta_ready),
        .m_axis_tx_meta_V_TDATA(axis_udp_to_ip_slice_meta_data),
        .m_axis_tx_data_TVALID(axis_udp_to_ip_data_valid),
        .m_axis_tx_data_TREADY(axis_udp_to_ip_data_ready),
        .m_axis_tx_data_TDATA(axis_udp_to_ip_data_data),
        .m_axis_tx_data_TKEEP(axis_udp_to_ip_data_keep),
        .m_axis_tx_data_TLAST(axis_udp_to_ip_data_last),
        
        .ap_clk(clk),
        .ap_rst_n(rst_n)
    );
    
    // Register slices to avoid combinatorial loops created by HLS due to the new axis INTERFACE (enforced since 19.1)

    meta_register_slice #(.WIDTH(176)) rx_udp_meta_slice(
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(axis_udp_rx_metadata_valid),
        .s_axis_ready(axis_udp_rx_metadata_ready),
        .s_axis_data(axis_udp_rx_metadata_data),
        .m_axis_valid(m_axis_udp_rx_metadata_valid),
        .m_axis_ready(m_axis_udp_rx_metadata_ready),
        .m_axis_data(m_axis_udp_rx_metadata_data)
    );

    meta_register_slice #(.WIDTH(176)) tx_udp_meta_slice(
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(s_axis_udp_tx_metadata_valid),
        .s_axis_ready(s_axis_udp_tx_metadata_ready),
        .s_axis_data(s_axis_udp_tx_metadata_data),
        .m_axis_valid(axis_udp_tx_metadata_valid),
        .m_axis_ready(axis_udp_tx_metadata_ready),
        .m_axis_data(axis_udp_tx_metadata_data)
    );

    meta_register_slice #(.WIDTH(32)) port_cmd_udp_meta_slice(
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(s_axis_udp_port_cmd_valid),
        .s_axis_ready(s_axis_udp_port_cmd_ready),
        .s_axis_data(s_axis_udp_port_cmd_data),
        .m_axis_valid(axis_udp_port_cmd_valid),
        .m_axis_ready(axis_udp_port_cmd_ready),
        .m_axis_data(axis_udp_port_cmd_data)
    );

endmodule


