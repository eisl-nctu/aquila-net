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


module tcp_udp_core #(
    parameter WIDTH = 64
)(
    input  wire                          clk,
    input  wire                          rst_n,
    // Network stack configuration
    input  wire [47:0]                   mac_address_in,
    input  wire [31:0]                   ip_address_in,
    input  wire [31:0]                   ip_subnet_mask_in,
    input  wire [31:0]                   ip_default_gateway_in,
    // network interface streams
    input  wire                          s_axis_net_valid,
    output wire                          s_axis_net_ready,
    input  wire [WIDTH-1 : 0]            s_axis_net_data,
    input  wire [(WIDTH/8)-1 : 0]        s_axis_net_keep,
    input  wire                          s_axis_net_last,
    output wire                          m_axis_net_valid,
    input  wire                          m_axis_net_ready,
    output wire [WIDTH-1 : 0]            m_axis_net_data,
    output wire [(WIDTH/8)-1 : 0]        m_axis_net_keep,
    output wire                          m_axis_net_last,
    // TCP Interface
    // memory cmd streams
    output wire                          m_axis_mem_read_cmd_valid,
    input  wire                          m_axis_mem_read_cmd_ready,
    output wire [71 : 0]                 m_axis_mem_read_cmd_data,
    output wire                          m_axis_mem_write_cmd_valid,
    input  wire                          m_axis_mem_write_cmd_ready,
    output wire [71 : 0]                 m_axis_mem_write_cmd_data,
    // memory sts streams
    input  wire                          s_axis_mem_read_sts_valid,
    output wire                          s_axis_mem_read_sts_ready,
    input  wire [7 : 0]                  s_axis_mem_read_sts_data,
    input  wire                          s_axis_mem_write_sts_valid,
    output wire                          s_axis_mem_write_sts_ready,
    input  wire [7 : 0]                  s_axis_mem_write_sts_data,
    // memory data streams (may need modify to datamover data width)
    input  wire                          s_axis_mem_read_data_valid,
    output wire                          s_axis_mem_read_data_ready,
    input  wire [511 : 0]                s_axis_mem_read_data_data,
    input  wire [63 : 0]                 s_axis_mem_read_data_keep,
    input  wire                          s_axis_mem_read_data_last,
    output wire                          m_axis_mem_write_data_valid,
    input  wire                          m_axis_mem_write_data_ready,
    output wire [511 : 0]                m_axis_mem_write_data_data,
    output wire [63 : 0]                 m_axis_mem_write_data_keep,
    output wire                          m_axis_mem_write_data_last,    
    // Application interface streams
    input  wire                          s_axis_listen_port_valid,
    output wire                          s_axis_listen_port_ready,
    input  wire [15 : 0]                 s_axis_listen_port_data,
    output wire                          m_axis_listen_port_status_valid,
    input  wire                          m_axis_listen_port_status_ready,
    output wire [7 : 0]                  m_axis_listen_port_status_data,
    output wire                          m_axis_accept_status_valid,
    input  wire                          m_axis_accept_status_ready,
    output wire [63 : 0]                 m_axis_accept_status_data,
    input  wire                          s_axis_open_connection_valid,
    output wire                          s_axis_open_connection_ready,
    input  wire [47 : 0]                 s_axis_open_connection_data,
    output wire                          m_axis_open_status_valid,
    input  wire                          m_axis_open_status_ready,
    output wire [23 : 0]                 m_axis_open_status_data,
    input  wire                          s_axis_close_connection_valid,
    output wire                          s_axis_close_connection_ready,
    input  wire [15 : 0]                 s_axis_close_connection_data,
    output wire                          m_axis_notifications_valid,
    input  wire                          m_axis_notifications_ready,
    output wire [87 : 0]                 m_axis_notifications_data,
    input  wire                          s_axis_read_package_valid,
    output wire                          s_axis_read_package_ready,
    input  wire [31 : 0]                 s_axis_read_package_data,
    output wire                          m_axis_rx_metadata_valid,
    input  wire                          m_axis_rx_metadata_ready,
    output wire [15 : 0]                 m_axis_rx_metadata_data,
    output wire                          m_axis_rx_data_valid,
    input  wire                          m_axis_rx_data_ready,
    output wire [WIDTH-1 : 0]            m_axis_rx_data_data,
    output wire [(WIDTH/8)-1 : 0]        m_axis_rx_data_keep,
    output wire                          m_axis_rx_data_last,
    input  wire                          s_axis_tx_metadata_valid,
    output wire                          s_axis_tx_metadata_ready,
    input  wire [31 : 0]                 s_axis_tx_metadata_data,
    input  wire                          s_axis_tx_data_valid,
    output wire                          s_axis_tx_data_ready,
    input  wire [WIDTH-1 : 0]            s_axis_tx_data_data,
    input  wire [(WIDTH/8)-1 : 0]        s_axis_tx_data_keep,
    input  wire                          s_axis_tx_data_last,
    output wire                          m_axis_tx_status_valid,
    input  wire                          m_axis_tx_status_ready,
    output wire [63 : 0]                 m_axis_tx_status_data,
    // UDP/IP Interface
    input  wire                          s_axis_udp_port_cmd_valid,
    output wire                          s_axis_udp_port_cmd_ready,
    input  wire [31 : 0]                 s_axis_udp_port_cmd_data,
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

    // IP Handler Outputs
    wire                          axis_iph_to_arp_slice_valid;
    wire                          axis_iph_to_arp_slice_ready;
    wire [WIDTH-1 : 0]            axis_iph_to_arp_slice_data;
    wire [(WIDTH/8)-1 : 0]        axis_iph_to_arp_slice_keep;
    wire                          axis_iph_to_arp_slice_last;

    wire                          axis_iph_to_icmp_slice_valid;
    wire                          axis_iph_to_icmp_slice_ready;
    wire [WIDTH-1 : 0]            axis_iph_to_icmp_slice_data;
    wire [(WIDTH/8)-1 : 0]        axis_iph_to_icmp_slice_keep;
    wire                          axis_iph_to_icmp_slice_last;

    //Slice connections on RX path
    wire                          axis_arp_slice_to_arp_valid;
    wire                          axis_arp_slice_to_arp_ready;
    wire [WIDTH-1 : 0]            axis_arp_slice_to_arp_data;
    wire [(WIDTH/8)-1 : 0]        axis_arp_slice_to_arp_keep;
    wire                          axis_arp_slice_to_arp_last;

    wire                          axis_icmp_slice_to_icmp_valid;
    wire                          axis_icmp_slice_to_icmp_ready;
    wire [63 : 0]                 axis_icmp_slice_to_icmp_data;
    wire [ 7 : 0]                 axis_icmp_slice_to_icmp_keep;
    wire                          axis_icmp_slice_to_icmp_last;

    wire                          axis_iph_to_toe_valid;
    wire                          axis_iph_to_toe_ready;
    wire [WIDTH-1 : 0]            axis_iph_to_toe_data;
    wire [(WIDTH/8)-1 : 0]        axis_iph_to_toe_keep;
    wire                          axis_iph_to_toe_last;

    // MAC-IP Encode Inputs
    wire                          axis_intercon_to_mie_valid;
    wire                          axis_intercon_to_mie_ready;
    wire [WIDTH-1 : 0]            axis_intercon_to_mie_data;
    wire [(WIDTH/8)-1 : 0]        axis_intercon_to_mie_keep;
    wire                          axis_intercon_to_mie_last;

    wire                          axis_mie_to_intercon_valid;
    wire                          axis_mie_to_intercon_ready;
    wire [WIDTH-1 : 0]            axis_mie_to_intercon_data;
    wire [(WIDTH/8)-1 : 0]        axis_mie_to_intercon_keep;
    wire                          axis_mie_to_intercon_last;

    //Slice connections on RX path
    wire                          axis_arp_to_arp_slice_valid;
    wire                          axis_arp_to_arp_slice_ready;
    wire [WIDTH-1 : 0]            axis_arp_to_arp_slice_data;
    wire [(WIDTH/8)-1 : 0]        axis_arp_to_arp_slice_keep;
    wire                          axis_arp_to_arp_slice_last;

    wire                          axis_icmp_to_icmp_slice_valid;
    wire                          axis_icmp_to_icmp_slice_ready;
    wire [63 : 0]                 axis_icmp_to_icmp_slice_data;
    wire [ 7 : 0]                 axis_icmp_to_icmp_slice_keep;
    wire                          axis_icmp_to_icmp_slice_last;

    //TCP
    wire                          axis_iph_to_toe_slice_valid;
    wire                          axis_iph_to_toe_slice_ready;
    wire [WIDTH-1 : 0]            axis_iph_to_toe_slice_data;
    wire [(WIDTH/8)-1 : 0]        axis_iph_to_toe_slice_keep;
    wire                          axis_iph_to_toe_slice_last;

    wire                          axis_toe_slice_to_toe_valid;
    wire                          axis_toe_slice_to_toe_ready;
    wire [WIDTH-1 : 0]            axis_toe_slice_to_toe_data;
    wire [(WIDTH/8)-1 : 0]        axis_toe_slice_to_toe_keep;
    wire                          axis_toe_slice_to_toe_last;

    wire                          axis_toe_slice_to_merge_valid;
    wire                          axis_toe_slice_to_merge_ready;
    wire [WIDTH-1 : 0]            axis_toe_slice_to_merge_data;
    wire [(WIDTH/8)-1 : 0]        axis_toe_slice_to_merge_keep;
    wire                          axis_toe_slice_to_merge_last;

    wire                          axis_toe_to_toe_slice_valid;
    wire                          axis_toe_to_toe_slice_ready;
    wire [WIDTH-1 : 0]            axis_toe_to_toe_slice_data;
    wire [(WIDTH/8)-1 : 0]        axis_toe_to_toe_slice_keep;
    wire                          axis_toe_to_toe_slice_last;

    wire                          axis_mem_read_sts_valid;
    wire                          axis_mem_read_sts_ready;
    wire [7 : 0]                  axis_mem_read_sts_data;
    wire                          axis_mem_write_sts_valid;
    wire                          axis_mem_write_sts_ready;
    wire [7 : 0]                  axis_mem_write_sts_data;

    wire                          axis_mem_read_data_valid;
    wire                          axis_mem_read_data_ready;
    wire [511 : 0]                axis_mem_read_data_data;
    wire [63 : 0]                 axis_mem_read_data_keep;
    wire                          axis_mem_read_data_last;

    wire                          axis_tx_data_valid;
    wire                          axis_tx_data_ready;
    wire [WIDTH-1 : 0]            axis_tx_data_data;
    wire [(WIDTH/8)-1 : 0]        axis_tx_data_keep;
    wire                          axis_tx_data_last;

    //UDP
    wire                          axis_udp_to_udp_slice_valid;
    wire                          axis_udp_to_udp_slice_ready;
    wire [WIDTH-1 : 0]            axis_udp_to_udp_slice_data;
    wire [(WIDTH/8)-1 : 0]        axis_udp_to_udp_slice_keep;
    wire                          axis_udp_to_udp_slice_last;

    wire                          axis_udp_slice_to_merge_valid;
    wire                          axis_udp_slice_to_merge_ready;
    wire [WIDTH-1 : 0]            axis_udp_slice_to_merge_data;
    wire [(WIDTH/8)-1 : 0]        axis_udp_slice_to_merge_keep;
    wire                          axis_udp_slice_to_merge_last;

    wire                          axis_iph_to_udp_slice_valid;
    wire                          axis_iph_to_udp_slice_ready;
    wire [WIDTH-1 : 0]            axis_iph_to_udp_slice_data;
    wire [(WIDTH/8)-1 : 0]        axis_iph_to_udp_slice_keep;
    wire                          axis_iph_to_udp_slice_last;

    wire                          axis_udp_slice_to_udp_valid;
    wire                          axis_udp_slice_to_udp_ready;
    wire [WIDTH-1 : 0]            axis_udp_slice_to_udp_data;
    wire [(WIDTH/8)-1 : 0]        axis_udp_slice_to_udp_keep;
    wire                          axis_udp_slice_to_udp_last;

    wire                          axis_slice_to_ibh_valid;
    wire                          axis_slice_to_ibh_ready;
    wire [WIDTH-1 : 0]            axis_slice_to_ibh_data;
    wire [(WIDTH/8)-1 : 0]        axis_slice_to_ibh_keep;
    wire                          axis_slice_to_ibh_last;

    wire                          axis_udp_rx_data_valid;
    wire                          axis_udp_rx_data_ready;
    wire [WIDTH-1 : 0]            axis_udp_rx_data_data;
    wire [(WIDTH/8)-1 : 0]        axis_udp_rx_data_keep;
    wire                          axis_udp_rx_data_last;

    wire                          axis_udp_tx_data_valid;
    wire                          axis_udp_tx_data_ready;
    wire [WIDTH-1 : 0]            axis_udp_tx_data_data;
    wire [(WIDTH/8)-1 : 0]        axis_udp_tx_data_keep;
    wire                          axis_udp_tx_data_last;
    
    // Register and distribute ip address
    reg  [47:0]                   mie_mac_address;
    reg  [47:0]                   arp_mac_address;
    reg  [31:0]                   iph_ip_address;
    reg  [31:0]                   arp_ip_address;
    reg  [31:0]                   toe_ip_address;
    reg  [31:0]                   ip_subnet_mask;
    reg  [31:0]                   ip_default_gateway;

    // Dummy
    wire                          axis_host_arp_lookup_request_TVALID;
    wire                          axis_host_arp_lookup_request_TREADY;
    wire [31:0]                   axis_host_arp_lookup_request_TDATA;
    wire                          axis_host_arp_lookup_reply_TVALID;
    wire                          axis_host_arp_lookup_reply_TREADY;
    wire [55:0]                   axis_host_arp_lookup_reply_TDATA;

    always @(posedge clk)
    begin
        if (rst_n == 0) begin
            mie_mac_address    <= 48'h000000000000;
            arp_mac_address    <= 48'h000000000000;
            iph_ip_address     <= 32'h00000000;
            arp_ip_address     <= 32'h00000000;
            toe_ip_address     <= 32'h00000000;
            ip_subnet_mask     <= 32'h00000000;
            ip_default_gateway <= 32'h00000000;
        end else begin
            mie_mac_address    <= mac_address_in;
            arp_mac_address    <= mac_address_in;
            iph_ip_address     <= ip_address_in;
            arp_ip_address     <= ip_address_in;
            toe_ip_address     <= ip_address_in;
            ip_subnet_mask     <= ip_subnet_mask_in;
            ip_default_gateway <= ip_default_gateway_in;
        end
    end

    // TCP/IP
    tcp_stack #(
        .WIDTH(WIDTH)
    ) tcp_stack_inst(
        .clk(clk),
        .rst_n(rst_n),
        // TCP stack configuration
        .local_ip_address(toe_ip_address),
        .session_count_valid(),
        .session_count_data(),
        // streams to network
        .s_axis_rx_data_valid(axis_toe_slice_to_toe_valid),
        .s_axis_rx_data_ready(axis_toe_slice_to_toe_ready),
        .s_axis_rx_data_data(axis_toe_slice_to_toe_data),
        .s_axis_rx_data_keep(axis_toe_slice_to_toe_keep),
        .s_axis_rx_data_last(axis_toe_slice_to_toe_last),
        .m_axis_tx_data_valid(axis_toe_to_toe_slice_valid),
        .m_axis_tx_data_ready(axis_toe_to_toe_slice_ready),
        .m_axis_tx_data_data(axis_toe_to_toe_slice_data),
        .m_axis_tx_data_keep(axis_toe_to_toe_slice_keep),
        .m_axis_tx_data_last(axis_toe_to_toe_slice_last),
        
        // memory cmd streams
        .m_axis_mem_read_cmd_valid(m_axis_mem_read_cmd_valid),
        .m_axis_mem_read_cmd_ready(m_axis_mem_read_cmd_ready),
        .m_axis_mem_read_cmd_data(m_axis_mem_read_cmd_data),
        .m_axis_mem_write_cmd_valid(m_axis_mem_write_cmd_valid),
        .m_axis_mem_write_cmd_ready(m_axis_mem_write_cmd_ready),
        .m_axis_mem_write_cmd_data(m_axis_mem_write_cmd_data),
        // memory sts streams
        .s_axis_mem_read_sts_valid(axis_mem_read_sts_valid),
        .s_axis_mem_read_sts_ready(axis_mem_read_sts_ready),
        .s_axis_mem_read_sts_data(axis_mem_read_sts_data),
        .s_axis_mem_write_sts_valid(axis_mem_write_sts_valid),
        .s_axis_mem_write_sts_ready(axis_mem_write_sts_ready),
        .s_axis_mem_write_sts_data(axis_mem_write_sts_data),
        // memory data streams
        .s_axis_mem_read_data_valid(axis_mem_read_data_valid),
        .s_axis_mem_read_data_ready(axis_mem_read_data_ready),
        .s_axis_mem_read_data_data(axis_mem_read_data_data),
        .s_axis_mem_read_data_keep(axis_mem_read_data_keep),
        .s_axis_mem_read_data_last(axis_mem_read_data_last),
        .m_axis_mem_write_data_valid(m_axis_mem_write_data_valid),
        .m_axis_mem_write_data_ready(m_axis_mem_write_data_ready),
        .m_axis_mem_write_data_data(m_axis_mem_write_data_data),
        .m_axis_mem_write_data_keep(m_axis_mem_write_data_keep),
        .m_axis_mem_write_data_last(m_axis_mem_write_data_last),
        
        //Application
        .s_axis_listen_port_valid(s_axis_listen_port_valid),
        .s_axis_listen_port_ready(s_axis_listen_port_ready),
        .s_axis_listen_port_data(s_axis_listen_port_data),
        .m_axis_listen_port_status_valid(m_axis_listen_port_status_valid),
        .m_axis_listen_port_status_ready(m_axis_listen_port_status_ready),
        .m_axis_listen_port_status_data(m_axis_listen_port_status_data),
        .m_axis_accept_status_valid(m_axis_accept_status_valid),
        .m_axis_accept_status_ready(m_axis_accept_status_ready),
        .m_axis_accept_status_data(m_axis_accept_status_data),

        .s_axis_open_connection_valid(s_axis_open_connection_valid),
        .s_axis_open_connection_ready(s_axis_open_connection_ready),
        .s_axis_open_connection_data(s_axis_open_connection_data),
        .m_axis_open_status_valid(m_axis_open_status_valid),
        .m_axis_open_status_ready(m_axis_open_status_ready),
        .m_axis_open_status_data(m_axis_open_status_data),
        .s_axis_close_connection_valid(s_axis_close_connection_valid),
        .s_axis_close_connection_ready(s_axis_close_connection_ready),
        .s_axis_close_connection_data(s_axis_close_connection_data),
        
        .m_axis_notifications_valid(m_axis_notifications_valid),
        .m_axis_notifications_ready(m_axis_notifications_ready),
        .m_axis_notifications_data(m_axis_notifications_data),
        .s_axis_read_package_valid(s_axis_read_package_valid),
        .s_axis_read_package_ready(s_axis_read_package_ready),
        .s_axis_read_package_data(s_axis_read_package_data),
        
        .m_axis_rx_metadata_valid(m_axis_rx_metadata_valid),
        .m_axis_rx_metadata_ready(m_axis_rx_metadata_ready),
        .m_axis_rx_metadata_data(m_axis_rx_metadata_data),
        .m_axis_rx_data_valid(m_axis_rx_data_valid),
        .m_axis_rx_data_ready(m_axis_rx_data_ready),
        .m_axis_rx_data_data(m_axis_rx_data_data),
        .m_axis_rx_data_keep(m_axis_rx_data_keep),
        .m_axis_rx_data_last(m_axis_rx_data_last),
        
        .s_axis_tx_metadata_valid(s_axis_tx_metadata_valid),
        .s_axis_tx_metadata_ready(s_axis_tx_metadata_ready),
        .s_axis_tx_metadata_data(s_axis_tx_metadata_data),
        .s_axis_tx_data_valid(axis_tx_data_valid),
        .s_axis_tx_data_ready(axis_tx_data_ready),
        .s_axis_tx_data_data(axis_tx_data_data),
        .s_axis_tx_data_keep(axis_tx_data_keep),
        .s_axis_tx_data_last(axis_tx_data_last),
        .m_axis_tx_status_valid(m_axis_tx_status_valid),
        .m_axis_tx_status_ready(m_axis_tx_status_ready),
        .m_axis_tx_status_data(m_axis_tx_status_data)
    );


    // UDP/IP
    udp_stack #(
        .WIDTH(WIDTH)
    ) udp_stack_inst(
        .clk(clk),
        .rst_n(rst_n),
        // IP, Port configuration
        .local_ip_address(ip_address_in),
        .s_axis_udp_port_cmd_valid(s_axis_udp_port_cmd_valid),
        .s_axis_udp_port_cmd_ready(s_axis_udp_port_cmd_ready),
        .s_axis_udp_port_cmd_data(s_axis_udp_port_cmd_data),
        // Network RX TX Data interfaces
        .s_axis_rx_data_valid(axis_udp_slice_to_udp_valid),
        .s_axis_rx_data_ready(axis_udp_slice_to_udp_ready),
        .s_axis_rx_data_data(axis_udp_slice_to_udp_data),
        .s_axis_rx_data_keep(axis_udp_slice_to_udp_keep),
        .s_axis_rx_data_last(axis_udp_slice_to_udp_last),
        .m_axis_tx_data_valid(axis_udp_to_udp_slice_valid),
        .m_axis_tx_data_ready(axis_udp_to_udp_slice_ready),
        .m_axis_tx_data_data(axis_udp_to_udp_slice_data),
        .m_axis_tx_data_keep(axis_udp_to_udp_slice_keep),
        .m_axis_tx_data_last(axis_udp_to_udp_slice_last),
        
        // UDP user Interface
        .m_axis_udp_rx_metadata_valid(m_axis_udp_rx_metadata_valid),
        .m_axis_udp_rx_metadata_ready(m_axis_udp_rx_metadata_ready),
        .m_axis_udp_rx_metadata_data(m_axis_udp_rx_metadata_data),
        .m_axis_udp_rx_data_valid(axis_udp_rx_data_valid),
        .m_axis_udp_rx_data_ready(axis_udp_rx_data_ready),
        .m_axis_udp_rx_data_data(axis_udp_rx_data_data),
        .m_axis_udp_rx_data_keep(axis_udp_rx_data_keep),
        .m_axis_udp_rx_data_last(axis_udp_rx_data_last),
        .s_axis_udp_tx_metadata_valid(s_axis_udp_tx_metadata_valid),
        .s_axis_udp_tx_metadata_ready(s_axis_udp_tx_metadata_ready),
        .s_axis_udp_tx_metadata_data(s_axis_udp_tx_metadata_data),
        .s_axis_udp_tx_data_valid(axis_udp_tx_data_valid),
        .s_axis_udp_tx_data_ready(axis_udp_tx_data_ready),
        .s_axis_udp_tx_data_data(axis_udp_tx_data_data),
        .s_axis_udp_tx_data_keep(axis_udp_tx_data_keep),
        .s_axis_udp_tx_data_last(axis_udp_tx_data_last)
        
    );

    // Network interface to IP handler
    data_register_slice #(.WIDTH(WIDTH)) axis_register_AXI_S (
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(s_axis_net_valid),
        .s_axis_ready(s_axis_net_ready),
        .s_axis_data(s_axis_net_data),
        .s_axis_keep(s_axis_net_keep),
        .s_axis_last(s_axis_net_last),
        .m_axis_valid(axis_slice_to_ibh_valid),
        .m_axis_ready(axis_slice_to_ibh_ready),
        .m_axis_data(axis_slice_to_ibh_data),
        .m_axis_keep(axis_slice_to_ibh_keep),
        .m_axis_last(axis_slice_to_ibh_last)
    );
    
    ip_handler_ip ip_handler_inst (
        .m_axis_arp_TVALID(axis_iph_to_arp_slice_valid),
        .m_axis_arp_TREADY(axis_iph_to_arp_slice_ready),
        .m_axis_arp_TDATA(axis_iph_to_arp_slice_data),
        .m_axis_arp_TKEEP(axis_iph_to_arp_slice_keep),
        .m_axis_arp_TLAST(axis_iph_to_arp_slice_last),

        .m_axis_icmp_TVALID(axis_iph_to_icmp_slice_valid),
        .m_axis_icmp_TREADY(axis_iph_to_icmp_slice_ready),
        .m_axis_icmp_TDATA(axis_iph_to_icmp_slice_data),
        .m_axis_icmp_TKEEP(axis_iph_to_icmp_slice_keep),
        .m_axis_icmp_TLAST(axis_iph_to_icmp_slice_last),

        .m_axis_icmpv6_TVALID(),
        .m_axis_icmpv6_TREADY(1'b1),
        .m_axis_icmpv6_TDATA(),
        .m_axis_icmpv6_TKEEP(),
        .m_axis_icmpv6_TLAST(),

        .m_axis_ipv6udp_TVALID(),
        .m_axis_ipv6udp_TREADY(1'b1),
        .m_axis_ipv6udp_TDATA(), 
        .m_axis_ipv6udp_TKEEP(),
        .m_axis_ipv6udp_TLAST(),

        .m_axis_udp_TVALID(axis_iph_to_udp_slice_valid),
        .m_axis_udp_TREADY(axis_iph_to_udp_slice_ready),
        .m_axis_udp_TDATA(axis_iph_to_udp_slice_data),
        .m_axis_udp_TKEEP(axis_iph_to_udp_slice_keep),
        .m_axis_udp_TLAST(axis_iph_to_udp_slice_last),

        .m_axis_tcp_TVALID(axis_iph_to_toe_slice_valid),
        .m_axis_tcp_TREADY(axis_iph_to_toe_slice_ready),
        .m_axis_tcp_TDATA(axis_iph_to_toe_slice_data),
        .m_axis_tcp_TKEEP(axis_iph_to_toe_slice_keep),
        .m_axis_tcp_TLAST(axis_iph_to_toe_slice_last),

        .m_axis_roce_TVALID(),
        .m_axis_roce_TREADY(1'b1),
        .m_axis_roce_TDATA(),
        .m_axis_roce_TKEEP(),
        .m_axis_roce_TLAST(),

        .s_axis_raw_TVALID(axis_slice_to_ibh_valid),
        .s_axis_raw_TREADY(axis_slice_to_ibh_ready),
        .s_axis_raw_TDATA(axis_slice_to_ibh_data),
        .s_axis_raw_TKEEP(axis_slice_to_ibh_keep),
        .s_axis_raw_TLAST(axis_slice_to_ibh_last),

        .myIpAddress_V(iph_ip_address),

        .ap_clk(clk),
        .ap_rst_n(rst_n)
    );

    // ARP lookup
    wire         axis_arp_lookup_request_TVALID;
    wire         axis_arp_lookup_request_TREADY;
    wire [31:0]  axis_arp_lookup_request_TDATA;
    wire         axis_arp_lookup_reply_TVALID;
    wire         axis_arp_lookup_reply_TREADY;
    wire [55:0]  axis_arp_lookup_reply_TDATA;

    mac_ip_encode_ip mac_ip_encode_inst (
        .m_axis_ip_TVALID(axis_mie_to_intercon_valid),
        .m_axis_ip_TREADY(axis_mie_to_intercon_ready),
        .m_axis_ip_TDATA(axis_mie_to_intercon_data),
        .m_axis_ip_TKEEP(axis_mie_to_intercon_keep),
        .m_axis_ip_TLAST(axis_mie_to_intercon_last),
        .m_axis_arp_lookup_request_V_V_TVALID(axis_arp_lookup_request_TVALID),
        .m_axis_arp_lookup_request_V_V_TREADY(axis_arp_lookup_request_TREADY),
        .m_axis_arp_lookup_request_V_V_TDATA(axis_arp_lookup_request_TDATA),
        .s_axis_ip_TVALID(axis_intercon_to_mie_valid),
        .s_axis_ip_TREADY(axis_intercon_to_mie_ready),
        .s_axis_ip_TDATA(axis_intercon_to_mie_data),
        .s_axis_ip_TKEEP(axis_intercon_to_mie_keep),
        .s_axis_ip_TLAST(axis_intercon_to_mie_last),
        .s_axis_arp_lookup_reply_V_TVALID(axis_arp_lookup_reply_TVALID),
        .s_axis_arp_lookup_reply_V_TREADY(axis_arp_lookup_reply_TREADY),
        .s_axis_arp_lookup_reply_V_TDATA(axis_arp_lookup_reply_TDATA),

        .myMacAddress_V(mie_mac_address),
        .regSubNetMask_V(ip_subnet_mask),
        .regDefaultGateway_V(ip_default_gateway),
        
        .ap_clk(clk),
        .ap_rst_n(rst_n)
    );

    generate
        if (WIDTH==64) begin
            // merges icmp and tcp
            axis_interconnect_4to1 ip_merger (
                .ACLK(clk),
                .ARESETN(rst_n),
                .S00_AXIS_ACLK(clk),
                .S01_AXIS_ACLK(clk),
                .S02_AXIS_ACLK(clk),
                .S03_AXIS_ACLK(clk),
                .S00_AXIS_ARESETN(rst_n),
                .S01_AXIS_ARESETN(rst_n),
                .S02_AXIS_ARESETN(rst_n),
                .S03_AXIS_ARESETN(rst_n),
                
                .S00_AXIS_TVALID(axis_icmp_to_icmp_slice_valid),
                .S00_AXIS_TREADY(axis_icmp_to_icmp_slice_ready),
                .S00_AXIS_TDATA(axis_icmp_to_icmp_slice_data),
                .S00_AXIS_TKEEP(axis_icmp_to_icmp_slice_keep),
                .S00_AXIS_TLAST(axis_icmp_to_icmp_slice_last),

                .S01_AXIS_TVALID(axis_udp_slice_to_merge_valid),
                .S01_AXIS_TREADY(axis_udp_slice_to_merge_ready),
                .S01_AXIS_TDATA(axis_udp_slice_to_merge_data),
                .S01_AXIS_TKEEP(axis_udp_slice_to_merge_keep),
                .S01_AXIS_TLAST(axis_udp_slice_to_merge_last),

                .S02_AXIS_TVALID(axis_toe_slice_to_merge_valid),
                .S02_AXIS_TREADY(axis_toe_slice_to_merge_ready),
                .S02_AXIS_TDATA(axis_toe_slice_to_merge_data),
                .S02_AXIS_TKEEP(axis_toe_slice_to_merge_keep),
                .S02_AXIS_TLAST(axis_toe_slice_to_merge_last),

                .S03_AXIS_TVALID(1'b0),
                .S03_AXIS_TREADY(),
                .S03_AXIS_TDATA(0),
                .S03_AXIS_TKEEP(0),
                .S03_AXIS_TLAST(0),

                .M00_AXIS_ACLK(clk),
                .M00_AXIS_ARESETN(rst_n),
                .M00_AXIS_TVALID(axis_intercon_to_mie_valid),
                .M00_AXIS_TREADY(axis_intercon_to_mie_ready),
                .M00_AXIS_TDATA(axis_intercon_to_mie_data),
                .M00_AXIS_TKEEP(axis_intercon_to_mie_keep),
                .M00_AXIS_TLAST(axis_intercon_to_mie_last),
                .S00_ARB_REQ_SUPPRESS(1'b0),
                .S01_ARB_REQ_SUPPRESS(1'b0),
                .S02_ARB_REQ_SUPPRESS(1'b0),
                .S03_ARB_REQ_SUPPRESS(1'b0)
            );

            // merges ip and arp
            axis_interconnect_2to1 mac_merger (
                .ACLK(clk),
                .ARESETN(rst_n),
                .S00_AXIS_ACLK(clk),
                .S01_AXIS_ACLK(clk),
                //.S02_AXIS_ACLK(clk),
                .S00_AXIS_ARESETN(rst_n),
                .S01_AXIS_ARESETN(rst_n),
                //.S02_AXIS_ARESETN(rst_n),
                .S00_AXIS_TVALID(axis_arp_to_arp_slice_valid),
                .S00_AXIS_TREADY(axis_arp_to_arp_slice_ready),
                .S00_AXIS_TDATA(axis_arp_to_arp_slice_data),
                .S00_AXIS_TKEEP(axis_arp_to_arp_slice_keep),
                .S00_AXIS_TLAST(axis_arp_to_arp_slice_last),
                
                .S01_AXIS_TVALID(axis_mie_to_intercon_valid),
                .S01_AXIS_TREADY(axis_mie_to_intercon_ready),
                .S01_AXIS_TDATA(axis_mie_to_intercon_data),
                .S01_AXIS_TKEEP(axis_mie_to_intercon_keep),
                .S01_AXIS_TLAST(axis_mie_to_intercon_last),
                
                .M00_AXIS_ACLK(clk),
                .M00_AXIS_ARESETN(rst_n),
                .M00_AXIS_TVALID(m_axis_net_valid),
                .M00_AXIS_TREADY(m_axis_net_ready),
                .M00_AXIS_TDATA(m_axis_net_data),
                .M00_AXIS_TKEEP(m_axis_net_keep),
                .M00_AXIS_TLAST(m_axis_net_last),
                .S00_ARB_REQ_SUPPRESS(1'b0),
                .S01_ARB_REQ_SUPPRESS(1'b0)
            );
        end
        if (WIDTH==128) begin

            wire                          axis_icmp_slice_to_merge_valid;
            wire                          axis_icmp_slice_to_merge_ready;
            wire [127 : 0]                axis_icmp_slice_to_merge_data;
            wire [ 15 : 0]                axis_icmp_slice_to_merge_keep;
            wire                          axis_icmp_slice_to_merge_last;

            axis_64_to_128_converter icmp_out_data_converter (
                .aclk(clk),
                .aresetn(rst_n),
                .s_axis_tvalid(axis_icmp_to_icmp_slice_valid),
                .s_axis_tready(axis_icmp_to_icmp_slice_ready),
                .s_axis_tdata(axis_icmp_to_icmp_slice_data),
                .s_axis_tkeep(axis_icmp_to_icmp_slice_keep),
                .s_axis_tlast(axis_icmp_to_icmp_slice_last),
                .m_axis_tvalid(axis_icmp_slice_to_merge_valid),
                .m_axis_tready(axis_icmp_slice_to_merge_ready),
                .m_axis_tdata(axis_icmp_slice_to_merge_data),
                .m_axis_tkeep(axis_icmp_slice_to_merge_keep),
                .m_axis_tlast(axis_icmp_slice_to_merge_last)
            );

            // merges icmp and tcp
            axis_interconnect_128_4to1 ip_merger (
                .ACLK(clk),
                .ARESETN(rst_n),
                .S00_AXIS_ACLK(clk),
                .S01_AXIS_ACLK(clk),
                .S02_AXIS_ACLK(clk),
                .S03_AXIS_ACLK(clk),
                .S00_AXIS_ARESETN(rst_n),
                .S01_AXIS_ARESETN(rst_n),
                .S02_AXIS_ARESETN(rst_n),
                .S03_AXIS_ARESETN(rst_n),
                
                .S00_AXIS_TVALID(axis_icmp_slice_to_merge_valid),
                .S00_AXIS_TREADY(axis_icmp_slice_to_merge_ready),
                .S00_AXIS_TDATA(axis_icmp_slice_to_merge_data),
                .S00_AXIS_TKEEP(axis_icmp_slice_to_merge_keep),
                .S00_AXIS_TLAST(axis_icmp_slice_to_merge_last),

                .S01_AXIS_TVALID(axis_udp_slice_to_merge_valid),
                .S01_AXIS_TREADY(axis_udp_slice_to_merge_ready),
                .S01_AXIS_TDATA(axis_udp_slice_to_merge_data),
                .S01_AXIS_TKEEP(axis_udp_slice_to_merge_keep),
                .S01_AXIS_TLAST(axis_udp_slice_to_merge_last),

                .S02_AXIS_TVALID(axis_toe_slice_to_merge_valid),
                .S02_AXIS_TREADY(axis_toe_slice_to_merge_ready),
                .S02_AXIS_TDATA(axis_toe_slice_to_merge_data),
                .S02_AXIS_TKEEP(axis_toe_slice_to_merge_keep),
                .S02_AXIS_TLAST(axis_toe_slice_to_merge_last),

                .S03_AXIS_TVALID(1'b0),
                .S03_AXIS_TREADY(),
                .S03_AXIS_TDATA(0),
                .S03_AXIS_TKEEP(0),
                .S03_AXIS_TLAST(0),

                .M00_AXIS_ACLK(clk),
                .M00_AXIS_ARESETN(rst_n),
                .M00_AXIS_TVALID(axis_intercon_to_mie_valid),
                .M00_AXIS_TREADY(axis_intercon_to_mie_ready),
                .M00_AXIS_TDATA(axis_intercon_to_mie_data),
                .M00_AXIS_TKEEP(axis_intercon_to_mie_keep),
                .M00_AXIS_TLAST(axis_intercon_to_mie_last),
                .S00_ARB_REQ_SUPPRESS(1'b0),
                .S01_ARB_REQ_SUPPRESS(1'b0),
                .S02_ARB_REQ_SUPPRESS(1'b0),
                .S03_ARB_REQ_SUPPRESS(1'b0)
            );

            // merges ip and arp
            axis_interconnect_128_2to1 mac_merger (
                .ACLK(clk),
                .ARESETN(rst_n),
                .S00_AXIS_ACLK(clk),
                .S01_AXIS_ACLK(clk),
                //.S02_AXIS_ACLK(clk),
                .S00_AXIS_ARESETN(rst_n),
                .S01_AXIS_ARESETN(rst_n),
                //.S02_AXIS_ARESETN(rst_n),
                .S00_AXIS_TVALID(axis_arp_to_arp_slice_valid),
                .S00_AXIS_TREADY(axis_arp_to_arp_slice_ready),
                .S00_AXIS_TDATA(axis_arp_to_arp_slice_data),
                .S00_AXIS_TKEEP(axis_arp_to_arp_slice_keep),
                .S00_AXIS_TLAST(axis_arp_to_arp_slice_last),
                
                .S01_AXIS_TVALID(axis_mie_to_intercon_valid),
                .S01_AXIS_TREADY(axis_mie_to_intercon_ready),
                .S01_AXIS_TDATA(axis_mie_to_intercon_data),
                .S01_AXIS_TKEEP(axis_mie_to_intercon_keep),
                .S01_AXIS_TLAST(axis_mie_to_intercon_last),
                
                .M00_AXIS_ACLK(clk),
                .M00_AXIS_ARESETN(rst_n),
                .M00_AXIS_TVALID(m_axis_net_valid),
                .M00_AXIS_TREADY(m_axis_net_ready),
                .M00_AXIS_TDATA(m_axis_net_data),
                .M00_AXIS_TKEEP(m_axis_net_keep),
                .M00_AXIS_TLAST(m_axis_net_last),
                .S00_ARB_REQ_SUPPRESS(1'b0),
                .S01_ARB_REQ_SUPPRESS(1'b0)
                //.S02_ARB_REQ_SUPPRESS(1'b0)
            );
        end
        if (WIDTH==256) begin

            wire                          axis_icmp_slice_to_merge_valid;
            wire                          axis_icmp_slice_to_merge_ready;
            wire [255 : 0]                axis_icmp_slice_to_merge_data;
            wire [ 31 : 0]                axis_icmp_slice_to_merge_keep;
            wire                          axis_icmp_slice_to_merge_last;

            axis_64_to_256_converter icmp_out_data_converter (
                .aclk(clk),
                .aresetn(rst_n),
                .s_axis_tvalid(axis_icmp_to_icmp_slice_valid),
                .s_axis_tready(axis_icmp_to_icmp_slice_ready),
                .s_axis_tdata(axis_icmp_to_icmp_slice_data),
                .s_axis_tkeep(axis_icmp_to_icmp_slice_keep),
                .s_axis_tlast(axis_icmp_to_icmp_slice_last),
                .m_axis_tvalid(axis_icmp_slice_to_merge_valid),
                .m_axis_tready(axis_icmp_slice_to_merge_ready),
                .m_axis_tdata(axis_icmp_slice_to_merge_data),
                .m_axis_tkeep(axis_icmp_slice_to_merge_keep),
                .m_axis_tlast(axis_icmp_slice_to_merge_last)
            );

            // merges icmp and tcp
            axis_interconnect_256_4to1 ip_merger (
                .ACLK(clk),
                .ARESETN(rst_n),
                .S00_AXIS_ACLK(clk),
                .S01_AXIS_ACLK(clk),
                .S02_AXIS_ACLK(clk),
                .S03_AXIS_ACLK(clk),
                .S00_AXIS_ARESETN(rst_n),
                .S01_AXIS_ARESETN(rst_n),
                .S02_AXIS_ARESETN(rst_n),
                .S03_AXIS_ARESETN(rst_n),
                
                .S00_AXIS_TVALID(axis_icmp_slice_to_merge_valid),
                .S00_AXIS_TREADY(axis_icmp_slice_to_merge_ready),
                .S00_AXIS_TDATA(axis_icmp_slice_to_merge_data),
                .S00_AXIS_TKEEP(axis_icmp_slice_to_merge_keep),
                .S00_AXIS_TLAST(axis_icmp_slice_to_merge_last),

                .S01_AXIS_TVALID(axis_udp_slice_to_merge_valid),
                .S01_AXIS_TREADY(axis_udp_slice_to_merge_ready),
                .S01_AXIS_TDATA(axis_udp_slice_to_merge_data),
                .S01_AXIS_TKEEP(axis_udp_slice_to_merge_keep),
                .S01_AXIS_TLAST(axis_udp_slice_to_merge_last),

                .S02_AXIS_TVALID(axis_toe_slice_to_merge_valid),
                .S02_AXIS_TREADY(axis_toe_slice_to_merge_ready),
                .S02_AXIS_TDATA(axis_toe_slice_to_merge_data),
                .S02_AXIS_TKEEP(axis_toe_slice_to_merge_keep),
                .S02_AXIS_TLAST(axis_toe_slice_to_merge_last),

                .S03_AXIS_TVALID(1'b0),
                .S03_AXIS_TREADY(),
                .S03_AXIS_TDATA(0),
                .S03_AXIS_TKEEP(0),
                .S03_AXIS_TLAST(0),

                .M00_AXIS_ACLK(clk),
                .M00_AXIS_ARESETN(rst_n),
                .M00_AXIS_TVALID(axis_intercon_to_mie_valid),
                .M00_AXIS_TREADY(axis_intercon_to_mie_ready),
                .M00_AXIS_TDATA(axis_intercon_to_mie_data),
                .M00_AXIS_TKEEP(axis_intercon_to_mie_keep),
                .M00_AXIS_TLAST(axis_intercon_to_mie_last),
                .S00_ARB_REQ_SUPPRESS(1'b0),
                .S01_ARB_REQ_SUPPRESS(1'b0),
                .S02_ARB_REQ_SUPPRESS(1'b0),
                .S03_ARB_REQ_SUPPRESS(1'b0)
            );

            // merges ip and arp
            axis_interconnect_256_2to1 mac_merger (
                .ACLK(clk),
                .ARESETN(rst_n),
                .S00_AXIS_ACLK(clk),
                .S01_AXIS_ACLK(clk),
                //.S02_AXIS_ACLK(clk),
                .S00_AXIS_ARESETN(rst_n),
                .S01_AXIS_ARESETN(rst_n),
                //.S02_AXIS_ARESETN(rst_n),
                .S00_AXIS_TVALID(axis_arp_to_arp_slice_valid),
                .S00_AXIS_TREADY(axis_arp_to_arp_slice_ready),
                .S00_AXIS_TDATA(axis_arp_to_arp_slice_data),
                .S00_AXIS_TKEEP(axis_arp_to_arp_slice_keep),
                .S00_AXIS_TLAST(axis_arp_to_arp_slice_last),
                
                .S01_AXIS_TVALID(axis_mie_to_intercon_valid),
                .S01_AXIS_TREADY(axis_mie_to_intercon_ready),
                .S01_AXIS_TDATA(axis_mie_to_intercon_data),
                .S01_AXIS_TKEEP(axis_mie_to_intercon_keep),
                .S01_AXIS_TLAST(axis_mie_to_intercon_last),

                .M00_AXIS_ACLK(clk),
                .M00_AXIS_ARESETN(rst_n),
                .M00_AXIS_TVALID(m_axis_net_valid),
                .M00_AXIS_TREADY(m_axis_net_ready),
                .M00_AXIS_TDATA(m_axis_net_data),
                .M00_AXIS_TKEEP(m_axis_net_keep),
                .M00_AXIS_TLAST(m_axis_net_last),
                .S00_ARB_REQ_SUPPRESS(1'b0),
                .S01_ARB_REQ_SUPPRESS(1'b0)
                //.S02_ARB_REQ_SUPPRESS(1'b0)
            );
        end
        if (WIDTH==512) begin

            wire                          axis_icmp_slice_to_merge_valid;
            wire                          axis_icmp_slice_to_merge_ready;
            wire [511 : 0]                axis_icmp_slice_to_merge_data;
            wire [ 63 : 0]                axis_icmp_slice_to_merge_keep;
            wire                          axis_icmp_slice_to_merge_last;

            axis_64_to_512_converter icmp_out_data_converter (
                .aclk(clk),
                .aresetn(rst_n),
                .s_axis_tvalid(axis_icmp_to_icmp_slice_valid),
                .s_axis_tready(axis_icmp_to_icmp_slice_ready),
                .s_axis_tdata(axis_icmp_to_icmp_slice_data),
                .s_axis_tkeep(axis_icmp_to_icmp_slice_keep),
                .s_axis_tlast(axis_icmp_to_icmp_slice_last),
                .m_axis_tvalid(axis_icmp_slice_to_merge_valid),
                .m_axis_tready(axis_icmp_slice_to_merge_ready),
                .m_axis_tdata(axis_icmp_slice_to_merge_data),
                .m_axis_tkeep(axis_icmp_slice_to_merge_keep),
                .m_axis_tlast(axis_icmp_slice_to_merge_last)
            );

            axis_interconnect_512_4to1 ip_merger (
                .ACLK(clk),
                .ARESETN(rst_n),
                .S00_AXIS_ACLK(clk),
                .S01_AXIS_ACLK(clk),
                .S02_AXIS_ACLK(clk),
                .S03_AXIS_ACLK(clk),
                .S00_AXIS_ARESETN(rst_n),
                .S01_AXIS_ARESETN(rst_n),
                .S02_AXIS_ARESETN(rst_n),
                .S03_AXIS_ARESETN(rst_n),
                
                .S00_AXIS_TVALID(axis_icmp_slice_to_merge_valid),
                .S00_AXIS_TREADY(axis_icmp_slice_to_merge_ready),
                .S00_AXIS_TDATA(axis_icmp_slice_to_merge_data),
                .S00_AXIS_TKEEP(axis_icmp_slice_to_merge_keep),
                .S00_AXIS_TLAST(axis_icmp_slice_to_merge_last),

                .S01_AXIS_TVALID(axis_udp_slice_to_merge_valid),
                .S01_AXIS_TREADY(axis_udp_slice_to_merge_ready),
                .S01_AXIS_TDATA(axis_udp_slice_to_merge_data),
                .S01_AXIS_TKEEP(axis_udp_slice_to_merge_keep),
                .S01_AXIS_TLAST(axis_udp_slice_to_merge_last),

                .S02_AXIS_TVALID(axis_toe_slice_to_merge_valid),
                .S02_AXIS_TREADY(axis_toe_slice_to_merge_ready),
                .S02_AXIS_TDATA(axis_toe_slice_to_merge_data),
                .S02_AXIS_TKEEP(axis_toe_slice_to_merge_keep),
                .S02_AXIS_TLAST(axis_toe_slice_to_merge_last),

                .S03_AXIS_TVALID(1'b0),
                .S03_AXIS_TREADY(),
                .S03_AXIS_TDATA(0),
                .S03_AXIS_TKEEP(0),
                .S03_AXIS_TLAST(0),

                .M00_AXIS_ACLK(clk),
                .M00_AXIS_ARESETN(rst_n),
                .M00_AXIS_TVALID(axis_intercon_to_mie_valid),
                .M00_AXIS_TREADY(axis_intercon_to_mie_ready),
                .M00_AXIS_TDATA(axis_intercon_to_mie_data),
                .M00_AXIS_TKEEP(axis_intercon_to_mie_keep),
                .M00_AXIS_TLAST(axis_intercon_to_mie_last),
                .S00_ARB_REQ_SUPPRESS(1'b0),
                .S01_ARB_REQ_SUPPRESS(1'b0),
                .S02_ARB_REQ_SUPPRESS(1'b0),
                .S03_ARB_REQ_SUPPRESS(1'b0)
            );

            // merges ip and arp
            axis_interconnect_512_2to1 mac_merger (
                .ACLK(clk),
                .ARESETN(rst_n),
                .S00_AXIS_ACLK(clk),
                .S01_AXIS_ACLK(clk),
                //.S02_AXIS_ACLK(clk),
                .S00_AXIS_ARESETN(rst_n),
                .S01_AXIS_ARESETN(rst_n),
                //.S02_AXIS_ARESETN(rst_n),
                .S00_AXIS_TVALID(axis_arp_to_arp_slice_valid),
                .S00_AXIS_TREADY(axis_arp_to_arp_slice_ready),
                .S00_AXIS_TDATA(axis_arp_to_arp_slice_data),
                .S00_AXIS_TKEEP(axis_arp_to_arp_slice_keep),
                .S00_AXIS_TLAST(axis_arp_to_arp_slice_last),
                
                .S01_AXIS_TVALID(axis_mie_to_intercon_valid),
                .S01_AXIS_TREADY(axis_mie_to_intercon_ready),
                .S01_AXIS_TDATA(axis_mie_to_intercon_data),
                .S01_AXIS_TKEEP(axis_mie_to_intercon_keep),
                .S01_AXIS_TLAST(axis_mie_to_intercon_last),

                .M00_AXIS_ACLK(clk),
                .M00_AXIS_ARESETN(rst_n),
                .M00_AXIS_TVALID(m_axis_net_valid),
                .M00_AXIS_TREADY(m_axis_net_ready),
                .M00_AXIS_TDATA(m_axis_net_data),
                .M00_AXIS_TKEEP(m_axis_net_keep),
                .M00_AXIS_TLAST(m_axis_net_last),
                .S00_ARB_REQ_SUPPRESS(1'b0),
                .S01_ARB_REQ_SUPPRESS(1'b0)
            );
        end
    endgenerate

    arp_server_subnet_ip arp_server_inst(
        .m_axis_TVALID(axis_arp_to_arp_slice_valid),
        .m_axis_TREADY(axis_arp_to_arp_slice_ready),
        .m_axis_TDATA(axis_arp_to_arp_slice_data),
        .m_axis_TKEEP(axis_arp_to_arp_slice_keep),
        .m_axis_TLAST(axis_arp_to_arp_slice_last),
        .m_axis_arp_lookup_reply_V_TVALID(axis_arp_lookup_reply_TVALID),
        .m_axis_arp_lookup_reply_V_TREADY(axis_arp_lookup_reply_TREADY),
        .m_axis_arp_lookup_reply_V_TDATA(axis_arp_lookup_reply_TDATA),
        .m_axis_host_arp_lookup_reply_V_TVALID(axis_host_arp_lookup_reply_TVALID),
        .m_axis_host_arp_lookup_reply_V_TREADY(1'b1),
        .m_axis_host_arp_lookup_reply_V_TDATA(axis_host_arp_lookup_reply_TDATA),
        .s_axis_TVALID(axis_arp_slice_to_arp_valid),
        .s_axis_TREADY(axis_arp_slice_to_arp_ready),
        .s_axis_TDATA(axis_arp_slice_to_arp_data),
        .s_axis_TKEEP(axis_arp_slice_to_arp_keep),
        .s_axis_TLAST(axis_arp_slice_to_arp_last),
        .s_axis_arp_lookup_request_V_V_TVALID(axis_arp_lookup_request_TVALID),
        .s_axis_arp_lookup_request_V_V_TREADY(axis_arp_lookup_request_TREADY),
        .s_axis_arp_lookup_request_V_V_TDATA(axis_arp_lookup_request_TDATA),
        .s_axis_host_arp_lookup_request_V_V_TVALID(1'b0),
        .s_axis_host_arp_lookup_request_V_V_TREADY(axis_host_arp_lookup_request_TREADY),
        .s_axis_host_arp_lookup_request_V_V_TDATA(0),

        .myMacAddress_V(arp_mac_address),
        .myIpAddress_V(arp_ip_address),
        .regRequestCount_V(),
        .regRequestCount_V_ap_vld(),
        .regReplyCount_V(),
        .regReplyCount_V_ap_vld(),

        .ap_clk(clk),
        .ap_rst_n(rst_n)
    );

    icmp_server_ip icmp_server_inst (
        .s_axis_TVALID(axis_icmp_slice_to_icmp_valid),
        .s_axis_TREADY(axis_icmp_slice_to_icmp_ready),
        .s_axis_TDATA(axis_icmp_slice_to_icmp_data),
        .s_axis_TKEEP(axis_icmp_slice_to_icmp_keep),
        .s_axis_TLAST(axis_icmp_slice_to_icmp_last),
        .udpIn_TVALID(1'b0),
        .udpIn_TREADY(),
        .udpIn_TDATA(0),
        .udpIn_TKEEP(0),
        .udpIn_TLAST(0),
        .ttlIn_TVALID(1'b0),
        .ttlIn_TREADY(),
        .ttlIn_TDATA(0),
        .ttlIn_TKEEP(0),
        .ttlIn_TLAST(0),
        .m_axis_TVALID(axis_icmp_to_icmp_slice_valid),
        .m_axis_TREADY(axis_icmp_to_icmp_slice_ready),
        .m_axis_TDATA(axis_icmp_to_icmp_slice_data),
        .m_axis_TKEEP(axis_icmp_to_icmp_slice_keep),
        .m_axis_TLAST(axis_icmp_to_icmp_slice_last),
        .ap_clk(clk),
        .ap_rst_n(rst_n)
    );

    /*
    * Slices
    */
    // ARP Input Slice
    data_register_slice #(.WIDTH(WIDTH)) arp_in_slice(
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(axis_iph_to_arp_slice_valid),
        .s_axis_ready(axis_iph_to_arp_slice_ready),
        .s_axis_data(axis_iph_to_arp_slice_data),
        .s_axis_keep(axis_iph_to_arp_slice_keep),
        .s_axis_last(axis_iph_to_arp_slice_last),
        .m_axis_valid(axis_arp_slice_to_arp_valid),
        .m_axis_ready(axis_arp_slice_to_arp_ready),
        .m_axis_data(axis_arp_slice_to_arp_data),
        .m_axis_keep(axis_arp_slice_to_arp_keep),
        .m_axis_last(axis_arp_slice_to_arp_last)
    );

    // UDP Input Slice
    data_register_slice #(.WIDTH(WIDTH)) upd_in_slice(
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(axis_iph_to_udp_slice_valid),
        .s_axis_ready(axis_iph_to_udp_slice_ready),
        .s_axis_data(axis_iph_to_udp_slice_data),
        .s_axis_keep(axis_iph_to_udp_slice_keep),
        .s_axis_last(axis_iph_to_udp_slice_last),
        .m_axis_valid(axis_udp_slice_to_udp_valid),
        .m_axis_ready(axis_udp_slice_to_udp_ready),
        .m_axis_data(axis_udp_slice_to_udp_data),
        .m_axis_keep(axis_udp_slice_to_udp_keep),
        .m_axis_last(axis_udp_slice_to_udp_last)
    );
    // assign axis_udp_slice_to_udp_valid = axis_iph_to_udp_slice_valid;
    // assign axis_udp_slice_to_udp_ready = axis_iph_to_udp_slice_ready;
    // assign axis_udp_slice_to_udp_data  = axis_iph_to_udp_slice_data;
    // assign axis_udp_slice_to_udp_keep  = axis_iph_to_udp_slice_keep;
    // assign axis_udp_slice_to_udp_last  = axis_iph_to_udp_slice_last;

    // UDP Output Slice
    data_register_slice #(.WIDTH(WIDTH)) upd_out_slice(
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(axis_udp_to_udp_slice_valid),
        .s_axis_ready(axis_udp_to_udp_slice_ready),
        .s_axis_data(axis_udp_to_udp_slice_data),
        .s_axis_keep(axis_udp_to_udp_slice_keep),
        .s_axis_last(axis_udp_to_udp_slice_last),
        .m_axis_valid(axis_udp_slice_to_merge_valid),
        .m_axis_ready(axis_udp_slice_to_merge_ready),
        .m_axis_data(axis_udp_slice_to_merge_data),
        .m_axis_keep(axis_udp_slice_to_merge_keep),
        .m_axis_last(axis_udp_slice_to_merge_last)
    );
    // assign axis_udp_slice_to_merge_valid = axis_udp_to_udp_slice_valid;
    // assign axis_udp_to_udp_slice_ready   = axis_udp_slice_to_merge_ready;
    // assign axis_udp_slice_to_merge_data  = axis_udp_to_udp_slice_data;
    // assign axis_udp_slice_to_merge_keep  = axis_udp_to_udp_slice_keep;
    // assign axis_udp_slice_to_merge_last  = axis_udp_to_udp_slice_last;

    // UDP RX DATA Slice
    // data_register_slice #(.WIDTH(WIDTH)) upd_rx_data_slice(
    //     .aclk(clk),
    //     .aresetn(rst_n),
    //     .s_axis_valid(axis_udp_rx_data_valid),
    //     .s_axis_ready(axis_udp_rx_data_ready),
    //     .s_axis_data(axis_udp_rx_data_data),
    //     .s_axis_keep(axis_udp_rx_data_keep),
    //     .s_axis_last(axis_udp_rx_data_last),
    //     .m_axis_valid(m_axis_udp_rx_data_valid),
    //     .m_axis_ready(m_axis_udp_rx_data_ready),
    //     .m_axis_data(m_axis_udp_rx_data_data),
    //     .m_axis_keep(m_axis_udp_rx_data_keep),
    //     .m_axis_last(m_axis_udp_rx_data_last)
    // );
    assign m_axis_udp_rx_data_valid = axis_udp_rx_data_valid;
    assign axis_udp_rx_data_ready   = m_axis_udp_rx_data_ready;
    assign m_axis_udp_rx_data_data  = axis_udp_rx_data_data;
    assign m_axis_udp_rx_data_keep  = axis_udp_rx_data_keep;
    assign m_axis_udp_rx_data_last  = axis_udp_rx_data_last;

    // UDP TX DATA Slice
    data_register_slice #(.WIDTH(WIDTH)) upd_tx_slice(
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(s_axis_udp_tx_data_valid),
        .s_axis_ready(s_axis_udp_tx_data_ready),
        .s_axis_data(s_axis_udp_tx_data_data),
        .s_axis_keep(s_axis_udp_tx_data_keep),
        .s_axis_last(s_axis_udp_tx_data_last),
        .m_axis_valid(axis_udp_tx_data_valid),
        .m_axis_ready(axis_udp_tx_data_ready),
        .m_axis_data(axis_udp_tx_data_data),
        .m_axis_keep(axis_udp_tx_data_keep),
        .m_axis_last(axis_udp_tx_data_last)
    );
    // assign axis_udp_tx_data_valid   = s_axis_udp_tx_data_valid;
    // assign s_axis_udp_tx_data_ready = axis_udp_tx_data_ready;
    // assign axis_udp_tx_data_data    = s_axis_udp_tx_data_data;

    // TOE Input Slice
    data_register_slice #(.WIDTH(WIDTH)) toe_in_slice(
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(axis_iph_to_toe_slice_valid),
        .s_axis_ready(axis_iph_to_toe_slice_ready),
        .s_axis_data(axis_iph_to_toe_slice_data),
        .s_axis_keep(axis_iph_to_toe_slice_keep),
        .s_axis_last(axis_iph_to_toe_slice_last),
        .m_axis_valid(axis_toe_slice_to_toe_valid),
        .m_axis_ready(axis_toe_slice_to_toe_ready),
        .m_axis_data(axis_toe_slice_to_toe_data),
        .m_axis_keep(axis_toe_slice_to_toe_keep),
        .m_axis_last(axis_toe_slice_to_toe_last)
    );

    // TOE Output Slice
    data_register_slice #(.WIDTH(WIDTH)) toe_out_slice(
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(axis_toe_to_toe_slice_valid),
        .s_axis_ready(axis_toe_to_toe_slice_ready),
        .s_axis_data(axis_toe_to_toe_slice_data),
        .s_axis_keep(axis_toe_to_toe_slice_keep),
        .s_axis_last(axis_toe_to_toe_slice_last),
        .m_axis_valid(axis_toe_slice_to_merge_valid),
        .m_axis_ready(axis_toe_slice_to_merge_ready),
        .m_axis_data(axis_toe_slice_to_merge_data),
        .m_axis_keep(axis_toe_slice_to_merge_keep),
        .m_axis_last(axis_toe_slice_to_merge_last)
    );

    // TOE TX DATA Slice
    data_register_slice #(.WIDTH(WIDTH)) toe_tx_data_slice(
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(s_axis_tx_data_valid),
        .s_axis_ready(s_axis_tx_data_ready),
        .s_axis_data(s_axis_tx_data_data),
        .s_axis_keep(s_axis_tx_data_keep),
        .s_axis_last(s_axis_tx_data_last),
        .m_axis_valid(axis_tx_data_valid),
        .m_axis_ready(axis_tx_data_ready),
        .m_axis_data(axis_tx_data_data),
        .m_axis_keep(axis_tx_data_keep),
        .m_axis_last(axis_tx_data_last)
    );

    // TOE MEM READ STS Slice
    meta_register_slice #(.WIDTH(8)) toe_mem_read_sts_slice(
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(s_axis_mem_read_sts_valid),
        .s_axis_ready(s_axis_mem_read_sts_ready),
        .s_axis_data(s_axis_mem_read_sts_data),
        .m_axis_valid(axis_mem_read_sts_valid),
        .m_axis_ready(axis_mem_read_sts_ready),
        .m_axis_data(axis_mem_read_sts_data)
    );

    // TOE MEM WRITE STS Slice
    meta_register_slice #(.WIDTH(8)) toe_mem_write_sts_slice(
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(s_axis_mem_write_sts_valid),
        .s_axis_ready(s_axis_mem_write_sts_ready),
        .s_axis_data(s_axis_mem_write_sts_data),
        .m_axis_valid(axis_mem_write_sts_valid),
        .m_axis_ready(axis_mem_write_sts_ready),
        .m_axis_data(axis_mem_write_sts_data)
    );

    // TOE MEM READ DATA Slice
    data_register_slice #(.WIDTH(512)) toe_mem_read_data_slice(
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(s_axis_mem_read_data_valid),
        .s_axis_ready(s_axis_mem_read_data_ready),
        .s_axis_data(s_axis_mem_read_data_data),
        .s_axis_keep(s_axis_mem_read_data_keep),
        .s_axis_last(s_axis_mem_read_data_last),
        .m_axis_valid(axis_mem_read_data_valid),
        .m_axis_ready(axis_mem_read_data_ready),
        .m_axis_data(axis_mem_read_data_data),
        .m_axis_keep(axis_mem_read_data_keep),
        .m_axis_last(axis_mem_read_data_last)
    );
    // assign _valid = _valid;
    // assign _ready = _ready;
    // assign _data  = _data;


    generate // ICMP Input Slice
        if (WIDTH==64) begin
            data_register_slice #(.WIDTH(WIDTH)) axis_register_icmp_in_slice(
                .aclk(clk),
                .aresetn(rst_n),
                .s_axis_valid(axis_iph_to_icmp_slice_valid),
                .s_axis_ready(axis_iph_to_icmp_slice_ready),
                .s_axis_data(axis_iph_to_icmp_slice_data),
                .s_axis_keep(axis_iph_to_icmp_slice_keep),
                .s_axis_last(axis_iph_to_icmp_slice_last),
                .m_axis_valid(axis_icmp_slice_to_icmp_valid),
                .m_axis_ready(axis_icmp_slice_to_icmp_ready),
                .m_axis_data(axis_icmp_slice_to_icmp_data),
                .m_axis_keep(axis_icmp_slice_to_icmp_keep),
                .m_axis_last(axis_icmp_slice_to_icmp_last)
            );
        end
        if (WIDTH==128) begin
            axis_128_to_64_converter icmp_in_data_converter (
                .aclk(clk),
                .aresetn(rst_n),
                .s_axis_tvalid(axis_iph_to_icmp_slice_valid),
                .s_axis_tready(axis_iph_to_icmp_slice_ready),
                .s_axis_tdata(axis_iph_to_icmp_slice_data),
                .s_axis_tkeep(axis_iph_to_icmp_slice_keep),
                .s_axis_tlast(axis_iph_to_icmp_slice_last),
                .m_axis_tvalid(axis_icmp_slice_to_icmp_valid),
                .m_axis_tready(axis_icmp_slice_to_icmp_ready),
                .m_axis_tdata(axis_icmp_slice_to_icmp_data),
                .m_axis_tkeep(axis_icmp_slice_to_icmp_keep),
                .m_axis_tlast(axis_icmp_slice_to_icmp_last)
            );
        end
        if (WIDTH==256) begin
            axis_256_to_64_converter icmp_in_data_converter (
                .aclk(clk),
                .aresetn(rst_n),
                .s_axis_tvalid(axis_iph_to_icmp_slice_valid),
                .s_axis_tready(axis_iph_to_icmp_slice_ready),
                .s_axis_tdata(axis_iph_to_icmp_slice_data),
                .s_axis_tkeep(axis_iph_to_icmp_slice_keep),
                .s_axis_tlast(axis_iph_to_icmp_slice_last),
                .m_axis_tvalid(axis_icmp_slice_to_icmp_valid),
                .m_axis_tready(axis_icmp_slice_to_icmp_ready),
                .m_axis_tdata(axis_icmp_slice_to_icmp_data),
                .m_axis_tkeep(axis_icmp_slice_to_icmp_keep),
                .m_axis_tlast(axis_icmp_slice_to_icmp_last)
            );
        end
        if (WIDTH==512) begin
            axis_512_to_64_converter icmp_in_data_converter (
                .aclk(clk),
                .aresetn(rst_n),
                .s_axis_tvalid(axis_iph_to_icmp_slice_valid),
                .s_axis_tready(axis_iph_to_icmp_slice_ready),
                .s_axis_tdata(axis_iph_to_icmp_slice_data),
                .s_axis_tkeep(axis_iph_to_icmp_slice_keep),
                .s_axis_tlast(axis_iph_to_icmp_slice_last),
                .m_axis_tvalid(axis_icmp_slice_to_icmp_valid),
                .m_axis_tready(axis_icmp_slice_to_icmp_ready),
                .m_axis_tdata(axis_icmp_slice_to_icmp_data),
                .m_axis_tkeep(axis_icmp_slice_to_icmp_keep),
                .m_axis_tlast(axis_icmp_slice_to_icmp_last)
            );
        end
    endgenerate

endmodule


