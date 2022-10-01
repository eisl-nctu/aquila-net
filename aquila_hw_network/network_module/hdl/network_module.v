`timescale 1ns / 1ps
// =============================================================================
//  Program : network_module.v
//  Author  : YI-DE, LEE
//  Date    : Apr/9/2022
// -----------------------------------------------------------------------------
//  Description:
//      Top-levle of the hardware network module.
//
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

module network_module #(
    parameter WIDTH = 64
)(
    input  wire              clk_core,
    input  wire              clk_mem,
    input  wire              rst_i,
    output wire [0:7]        usr_led,
    // Ethernet: 1000BASE-T SGMII
    input  wire              phy_sgmii_rx_p,
    input  wire              phy_sgmii_rx_n,
    output wire              phy_sgmii_tx_p,
    output wire              phy_sgmii_tx_n,
    input  wire              phy_sgmii_clk_p,
    input  wire              phy_sgmii_clk_n,
    output wire              phy_reset_n,
    input  wire              phy_int_n,
    // From core (load/store)
    input  wire              strobe_i,
    input  wire [7:0]        addr_i,
    input  wire              we_i,
    input  wire [31:0]       data_i,
    output wire [31:0]       data_o,
    output wire              ready_o,
    // To core (external interrupt)
    output wire              ext_irq_o,
    // To MEM
    input  wire              N_MEM_done_i,
    input  wire [511:0]      N_MEM_data_i,
    output wire              N_MEM_strobe_o,
    output wire [31:0]       N_MEM_addr_o,
    output wire [511:0]      N_MEM_data_o,
    output wire [63:0]       N_MEM_mask_o,
    output wire              N_MEM_rw_o,

    input  wire              N_DCA_req_i,
    output wire              N_DCA_ready_o,
    input  wire [ 1: 0]      N_DCA_cmd_i,
    input  wire [31: 0]      N_DCA_addr_i,
    input  wire [31: 0]      N_DCA_len_i,

    // Dcache signals
    output wire [ 31 : 0]    N_DCACHE_addr_o,
    input  wire [255 : 0]    N_DCACHE_data_i,
    output wire [255 : 0]    N_DCACHE_data_o,
    output wire              N_DCACHE_strobe_o,
    output wire              N_DCACHE_we_o,
    input  wire              N_DCACHE_ready_i
);
    // Network interface signals
    wire                          net_rx_valid;
    wire                          net_rx_ready;
    wire [WIDTH-1 : 0]            net_rx_data;
    wire [(WIDTH/8)-1 : 0]        net_rx_keep;
    wire                          net_rx_last;
    wire                          net_tx_valid;
    wire                          net_tx_ready;
    wire [WIDTH-1 : 0]            net_tx_data;
    wire [(WIDTH/8)-1 : 0]        net_tx_keep;
    wire                          net_tx_last;
    // Round-Trip latency measurement
    wire                          read_ticks;
    wire  [31:0]                  tx_ticks;
    wire  [31:0]                  rx_ticks;
    wire                          ticks_valid;
    // Network stack configuration
    wire [47:0]                   mac_address;
    wire [31:0]                   ip_address;
    wire [31:0]                   ip_subnet_mask;
    wire [31:0]                   ip_default_gateway;
    wire [15:0]                   udp_listen_port;

    // Memory interface signals
    wire                          mem_read_cmd_valid;
    wire                          mem_read_cmd_ready;
    wire [71:0]                   mem_read_cmd_data;
    wire                          mem_read_sts_valid;
    wire                          mem_read_sts_ready;
    wire [7:0]                    mem_read_sts_data;
    wire [511:0]                  mem_read_data;
    wire [63:0]                   mem_read_keep;
    wire                          mem_read_last;
    wire                          mem_read_valid;
    wire                          mem_read_ready;
    wire                          mem_write_cmd_valid;
    wire                          mem_write_cmd_ready;
    wire [71:0]                   mem_write_cmd_data;
    wire                          mem_write_sts_valid;
    wire                          mem_write_sts_ready;
    wire [7:0]                    mem_write_sts_data;
    wire [511:0]                  mem_write_data;
    wire [63:0]                   mem_write_keep;
    wire                          mem_write_last;
    wire                          mem_write_valid;
    wire                          mem_write_ready;
    // TCP signals
    wire                          listen_port_valid;
    wire                          listen_port_ready;
    wire [15 : 0]                 listen_port_data;
    wire                          listen_port_status_valid;
    wire                          listen_port_status_ready;
    wire [7 : 0]                  listen_port_status_data;
    wire                          accept_status_valid;
    wire                          accept_status_ready;
    wire [63 : 0]                 accept_status_data;
    wire                          open_connection_valid;
    wire                          open_connection_ready;
    wire [47 : 0]                 open_connection_data;
    wire                          open_status_valid;
    wire                          open_status_ready;
    wire [23 : 0]                 open_status_data;
    wire                          close_connection_valid;
    wire                          close_connection_ready;
    wire [15 : 0]                 close_connection_data;
    wire                          notifications_valid;
    wire                          notifications_ready;
    wire [87 : 0]                 notifications_data;
    wire                          read_package_valid;
    wire                          read_package_ready;
    wire [31 : 0]                 read_package_data;
    wire                          rx_metadata_valid;
    wire                          rx_metadata_ready;
    wire [15 : 0]                 rx_metadata_data;
    wire                          rx_data_valid;
    wire                          rx_data_ready;
    wire [WIDTH-1 : 0]            rx_data_data;
    wire [(WIDTH/8)-1 : 0]        rx_data_keep;
    wire                          rx_data_last;
    wire                          tx_metadata_valid;
    wire                          tx_metadata_ready;
    wire [31 : 0]                 tx_metadata_data;
    wire                          tx_data_valid;
    wire                          tx_data_ready;
    wire [WIDTH-1 : 0]            tx_data_data;
    wire [(WIDTH/8)-1 : 0]        tx_data_keep;
    wire                          tx_data_last;
    wire                          tx_status_valid;
    wire                          tx_status_ready;
    wire [63 : 0]                 tx_status_data;
    // UDP signals
    wire                          udp_port_cmd_valid;
    wire                          udp_port_cmd_ready;
    wire [31 : 0]                 udp_port_cmd_data;
    wire                          udp_rx_data_valid;
    wire                          udp_rx_data_ready;
    wire [WIDTH-1 : 0]            udp_rx_data_data;
    wire [(WIDTH/8)-1 : 0]        udp_rx_data_keep;
    wire                          udp_rx_data_last;
    wire                          udp_tx_data_valid;
    wire                          udp_tx_data_ready;
    wire [WIDTH-1 : 0]            udp_tx_data_data;
    wire [(WIDTH/8)-1 : 0]        udp_tx_data_keep;
    wire                          udp_tx_data_last;
    wire                          udp_rx_metadata_valid;
    wire                          udp_rx_metadata_ready;
    wire [175 : 0]                udp_rx_metadata_data;
    wire                          udp_tx_metadata_valid;
    wire                          udp_tx_metadata_ready;
    wire [175 : 0]                udp_tx_metadata_data;

    // Direct Cache Access to TCP/UDP stack
    wire                          doing_dca;
    wire                          dca_rx_data_ready;
    wire                          dca_tx_data_valid;
    wire [255 : 0]                dca_tx_data_data;
    wire [ 31 : 0]                dca_tx_data_keep;
    wire                          dca_tx_data_last;

    wire                          dca_udp_rx_data_ready;
    wire                          dca_udp_tx_data_valid;
    wire [255 : 0]                dca_udp_tx_data_data;
    wire [ 31 : 0]                dca_udp_tx_data_keep;
    wire                          dca_udp_tx_data_last;

    kc705_1g_interface #(
        .WIDTH(WIDTH)
    ) kc705_1g_interface_inst (
        .clk_i(clk_core),
        .rst_i(rst_i),

        .phy_sgmii_rx_p(phy_sgmii_rx_p),
        .phy_sgmii_rx_n(phy_sgmii_rx_n),
        .phy_sgmii_tx_p(phy_sgmii_tx_p),
        .phy_sgmii_tx_n(phy_sgmii_tx_n),
        .phy_sgmii_clk_p(phy_sgmii_clk_p),
        .phy_sgmii_clk_n(phy_sgmii_clk_n),
        .phy_reset_n(phy_reset_n),
        .phy_int_n(phy_int_n),

        // RX Master
        .rx_axis_tdata(net_rx_data),
        .rx_axis_tvalid(net_rx_valid),
        .rx_axis_tlast(net_rx_last),
        .rx_axis_tuser(),
        .rx_axis_tkeep(net_rx_keep),
        .rx_axis_tready(net_rx_ready),
            
        // TX Slave
        .tx_axis_tdata(net_tx_data),
        .tx_axis_tvalid(net_tx_valid),
        .tx_axis_tuser(0),
        .tx_axis_tlast(net_tx_last),
        .tx_axis_tkeep(net_tx_keep),
        .tx_axis_tready(net_tx_ready),

        // Latency Measurement
        .read_ticks(read_ticks),
        .rx_ticks(rx_ticks),
        .tx_ticks(tx_ticks),
        .ticks_valid(ticks_valid)
    );


    // TCP/UDP core

    // Convert data interface from 64 to 256
    wire                         rx_data_256_valid;
    wire                         rx_data_256_ready;
    wire [255 : 0]               rx_data_256_data;
    wire [31: 0]                 rx_data_256_keep;
    wire                         rx_data_256_last;

    wire                         tx_data_256_valid;
    wire                         tx_data_256_ready;
    wire [255 : 0]               tx_data_256_data;
    wire [31: 0]                 tx_data_256_keep;
    wire                         tx_data_256_last;

    wire                         udp_rx_data_256_valid;
    wire                         udp_rx_data_256_ready;
    wire [255 : 0]               udp_rx_data_256_data;
    wire [31: 0]                 udp_rx_data_256_keep;
    wire                         udp_rx_data_256_last;

    wire                         udp_tx_data_256_valid;
    wire                         udp_tx_data_256_ready;
    wire [255 : 0]               udp_tx_data_256_data;
    wire [31: 0]                 udp_tx_data_256_keep;
    wire                         udp_tx_data_256_last;

    axis_64_to_256_converter tcp_rx_data_converter (
        .aclk(clk_core),
        .aresetn(!rst_i),
        .s_axis_tvalid(rx_data_valid),
        .s_axis_tready(rx_data_ready),
        .s_axis_tdata(rx_data_data),
        .s_axis_tkeep(rx_data_keep),
        .s_axis_tlast(rx_data_last),
        .m_axis_tvalid(rx_data_256_valid),
        .m_axis_tready(doing_dca ? dca_rx_data_ready : rx_data_256_ready),
        .m_axis_tdata(rx_data_256_data),
        .m_axis_tkeep(rx_data_256_keep),
        .m_axis_tlast(rx_data_256_last)
    );

    axis_256_to_64_converter tcp_tx_data_converter (
        .aclk(clk_core),
        .aresetn(!rst_i),
        .s_axis_tvalid(doing_dca ? dca_tx_data_valid : tx_data_256_valid),
        .s_axis_tready(tx_data_256_ready),
        .s_axis_tdata(doing_dca ? dca_tx_data_data : tx_data_256_data),
        .s_axis_tkeep(doing_dca ? dca_tx_data_keep : tx_data_256_keep),
        .s_axis_tlast(doing_dca ? dca_tx_data_last : tx_data_256_last),
        .m_axis_tvalid(tx_data_valid),
        .m_axis_tready(tx_data_ready),
        .m_axis_tdata(tx_data_data),
        .m_axis_tkeep(tx_data_keep),
        .m_axis_tlast(tx_data_last)
    );

    axis_64_to_256_converter udp_rx_data_converter (
        .aclk(clk_core),
        .aresetn(!rst_i),
        .s_axis_tvalid(udp_rx_data_valid),
        .s_axis_tready(udp_rx_data_ready),
        .s_axis_tdata(udp_rx_data_data),
        .s_axis_tkeep(udp_rx_data_keep),
        .s_axis_tlast(udp_rx_data_last),
        .m_axis_tvalid(udp_rx_data_256_valid),
        .m_axis_tready(doing_dca ? dca_udp_rx_data_ready : udp_rx_data_256_ready),
        .m_axis_tdata(udp_rx_data_256_data),
        .m_axis_tkeep(udp_rx_data_256_keep),
        .m_axis_tlast(udp_rx_data_256_last)
    );

    axis_256_to_64_converter udp_tx_data_converter (
        .aclk(clk_core),
        .aresetn(!rst_i),
        .s_axis_tvalid(doing_dca ? dca_udp_tx_data_valid : udp_tx_data_256_valid),
        .s_axis_tready(udp_tx_data_256_ready),
        .s_axis_tdata(doing_dca ? dca_udp_tx_data_data : udp_tx_data_256_data),
        .s_axis_tkeep(doing_dca ? dca_udp_tx_data_keep : udp_tx_data_256_keep),
        .s_axis_tlast(doing_dca ? dca_udp_tx_data_last : udp_tx_data_256_last),
        .m_axis_tvalid(udp_tx_data_valid),
        .m_axis_tready(udp_tx_data_ready),
        .m_axis_tdata(udp_tx_data_data),
        .m_axis_tkeep(udp_tx_data_keep),
        .m_axis_tlast(udp_tx_data_last)
    );


    tcp_udp_core #(
        .WIDTH(WIDTH)
    ) tcp_udp_core_inst (
        .clk(clk_core),
        .rst_n(~rst_i),
        // Network stack configuration
        .mac_address_in(48'hE59D02350A00), // LSB first, 00:0A:35:02:9D:E5
        .ip_address_in(ip_address),
        .ip_subnet_mask_in(ip_subnet_mask),
        .ip_default_gateway_in(ip_default_gateway),
        // network interface streams
        .s_axis_net_valid(net_rx_valid),
        .s_axis_net_ready(net_rx_ready),
        .s_axis_net_data(net_rx_data),
        .s_axis_net_keep(net_rx_keep),
        .s_axis_net_last(net_rx_last),
        .m_axis_net_valid(net_tx_valid),
        .m_axis_net_ready(net_tx_ready),
        .m_axis_net_data(net_tx_data),
        .m_axis_net_keep(net_tx_keep),
        .m_axis_net_last(net_tx_last),
        //TCP Interface
        // memory cmd streams
        .m_axis_mem_read_cmd_valid(mem_read_cmd_valid),
        .m_axis_mem_read_cmd_ready(mem_read_cmd_ready),
        .m_axis_mem_read_cmd_data(mem_read_cmd_data),
        .m_axis_mem_write_cmd_valid(mem_write_cmd_valid),
        .m_axis_mem_write_cmd_ready(mem_write_cmd_ready),
        .m_axis_mem_write_cmd_data(mem_write_cmd_data),
        // memory sts streams
        .s_axis_mem_read_sts_valid(mem_read_sts_valid),
        .s_axis_mem_read_sts_ready(mem_read_sts_ready),
        .s_axis_mem_read_sts_data(mem_read_sts_data),
        .s_axis_mem_write_sts_valid(mem_write_sts_valid),
        .s_axis_mem_write_sts_ready(mem_write_sts_ready),
        .s_axis_mem_write_sts_data(mem_write_sts_data),
        // memory data streams (may need modify to datamover data width)
        .s_axis_mem_read_data_valid(mem_read_valid),
        .s_axis_mem_read_data_ready(mem_read_ready),
        .s_axis_mem_read_data_data(mem_read_data),
        .s_axis_mem_read_data_keep(mem_read_keep),
        .s_axis_mem_read_data_last(mem_read_last),
        .m_axis_mem_write_data_valid(mem_write_valid),
        .m_axis_mem_write_data_ready(mem_write_ready),
        .m_axis_mem_write_data_data(mem_write_data),
        .m_axis_mem_write_data_keep(mem_write_keep),
        .m_axis_mem_write_data_last(mem_write_last),    
        //Application interface streams
        .s_axis_listen_port_valid(listen_port_valid),
        .s_axis_listen_port_ready(listen_port_ready),
        .s_axis_listen_port_data(listen_port_data),
        .m_axis_listen_port_status_valid(listen_port_status_valid),
        .m_axis_listen_port_status_ready(listen_port_status_ready),
        .m_axis_listen_port_status_data(listen_port_status_data),
        .m_axis_accept_status_valid(accept_status_valid),
        .m_axis_accept_status_ready(accept_status_ready),
        .m_axis_accept_status_data(accept_status_data),
        .s_axis_open_connection_valid(open_connection_valid),
        .s_axis_open_connection_ready(open_connection_ready),
        .s_axis_open_connection_data(open_connection_data),
        .m_axis_open_status_valid(open_status_valid),
        .m_axis_open_status_ready(open_status_ready),
        .m_axis_open_status_data(open_status_data),
        .s_axis_close_connection_valid(close_connection_valid),
        .s_axis_close_connection_ready(close_connection_ready),
        .s_axis_close_connection_data(close_connection_data),
        .m_axis_notifications_valid(notifications_valid),
        .m_axis_notifications_ready(notifications_ready),
        .m_axis_notifications_data(notifications_data),
        .s_axis_read_package_valid(read_package_valid),
        .s_axis_read_package_ready(read_package_ready),
        .s_axis_read_package_data(read_package_data),
        .m_axis_rx_metadata_valid(rx_metadata_valid),
        .m_axis_rx_metadata_ready(rx_metadata_ready),
        .m_axis_rx_metadata_data(rx_metadata_data),
        .m_axis_rx_data_valid(rx_data_valid),
        .m_axis_rx_data_ready(rx_data_ready),
        .m_axis_rx_data_data(rx_data_data),
        .m_axis_rx_data_keep(rx_data_keep),
        .m_axis_rx_data_last(rx_data_last),
        .s_axis_tx_metadata_valid(tx_metadata_valid),
        .s_axis_tx_metadata_ready(tx_metadata_ready),
        .s_axis_tx_metadata_data(tx_metadata_data),
        .s_axis_tx_data_valid(tx_data_valid),
        .s_axis_tx_data_ready(tx_data_ready),
        .s_axis_tx_data_data(tx_data_data),
        .s_axis_tx_data_keep(tx_data_keep),
        .s_axis_tx_data_last(tx_data_last),
        .m_axis_tx_status_valid(tx_status_valid),
        .m_axis_tx_status_ready(tx_status_ready),
        .m_axis_tx_status_data(tx_status_data),
        //UDP/IP Interface
        .s_axis_udp_port_cmd_valid(udp_port_cmd_valid),
        .s_axis_udp_port_cmd_ready(udp_port_cmd_ready),
        .s_axis_udp_port_cmd_data(udp_port_cmd_data),
        .m_axis_udp_rx_data_valid(udp_rx_data_valid),
        .m_axis_udp_rx_data_ready(udp_rx_data_ready),
        .m_axis_udp_rx_data_data(udp_rx_data_data),
        .m_axis_udp_rx_data_keep(udp_rx_data_keep),
        .m_axis_udp_rx_data_last(udp_rx_data_last),
        .s_axis_udp_tx_data_valid(udp_tx_data_valid),
        .s_axis_udp_tx_data_ready(udp_tx_data_ready),
        .s_axis_udp_tx_data_data(udp_tx_data_data),
        .s_axis_udp_tx_data_keep(udp_tx_data_keep),
        .s_axis_udp_tx_data_last(udp_tx_data_last),
        .m_axis_udp_rx_metadata_valid(udp_rx_metadata_valid),
        .m_axis_udp_rx_metadata_ready(udp_rx_metadata_ready),
        .m_axis_udp_rx_metadata_data(udp_rx_metadata_data),
        .s_axis_udp_tx_metadata_valid(udp_tx_metadata_valid),
        .s_axis_udp_tx_metadata_ready(udp_tx_metadata_ready),
        .s_axis_udp_tx_metadata_data(udp_tx_metadata_data)
    );

    mem_inf mem_inf_inst (
        .clk_core(clk_core),
        .clk_mem(clk_mem),
        .rst_i(rst_i),
        // TX Read Cmd
        .s_axis_mem_read_cmd_valid(mem_read_cmd_valid),
        .s_axis_mem_read_cmd_ready(mem_read_cmd_ready),
        .s_axis_mem_read_cmd_data(mem_read_cmd_data),
        // TX Read Status
        .s_axis_mem_read_sts_valid(mem_read_sts_valid),
        .s_axis_mem_read_sts_ready(mem_read_sts_ready),
        .s_axis_mem_read_sts_data(mem_read_sts_data),
        // TX Read Stream
        .m_axis_mem_read_data(mem_read_data),
        .m_axis_mem_read_keep(mem_read_keep),
        .m_axis_mem_read_last(mem_read_last),
        .m_axis_mem_read_valid(mem_read_valid),
        .m_axis_mem_read_ready(mem_read_ready),
        // TX Write Cmd
        .s_axis_mem_write_cmd_valid(mem_write_cmd_valid),
        .s_axis_mem_write_cmd_ready(mem_write_cmd_ready),
        .s_axis_mem_write_cmd_data(mem_write_cmd_data),
        // TX Write Status
        .m_axis_mem_write_sts_valid(mem_write_sts_valid),
        .m_axis_mem_write_sts_ready(mem_write_sts_ready),
        .m_axis_mem_write_sts_data(mem_write_sts_data),
        // TX Write Stream
        .s_axis_mem_write_data(mem_write_data),
        .s_axis_mem_write_keep(mem_write_keep),
        .s_axis_mem_write_last(mem_write_last),
        .s_axis_mem_write_valid(mem_write_valid),
        .s_axis_mem_write_ready(mem_write_ready),
        // Mem interface
        .N_MEM_done_i(N_MEM_done_i),
        .N_MEM_data_i(N_MEM_data_i),
        .N_MEM_strobe_o(N_MEM_strobe_o),
        .N_MEM_addr_o(N_MEM_addr_o),
        .N_MEM_data_o(N_MEM_data_o),
        .N_MEM_mask_o(N_MEM_mask_o),
        .N_MEM_rw_o(N_MEM_rw_o)
    );

    mmio_inf mmio_inf_inst (
        .clk_core(clk_core),
        .rst_i(rst_i),
        .usr_led(usr_led),
        // Round-Trip latency measurement
        .read_ticks(read_ticks),
        .tx_ticks(tx_ticks),
        .rx_ticks(rx_ticks),
        .ticks_valid(ticks_valid),
        .mac_address(mac_address),
        .ip_address(ip_address),
        .ip_subnet_mask(ip_subnet_mask),
        .ip_default_gateway(ip_default_gateway),
        // TCP signals
        .listen_port_valid(listen_port_valid),
        .listen_port_ready(listen_port_ready),
        .listen_port_data(listen_port_data),
        .listen_port_status_valid(listen_port_status_valid),
        .listen_port_status_ready(listen_port_status_ready),
        .listen_port_status_data(listen_port_status_data),
        .accept_status_valid(accept_status_valid),
        .accept_status_ready(accept_status_ready),
        .accept_status_data(accept_status_data),
        .open_connection_valid(open_connection_valid),
        .open_connection_ready(open_connection_ready),
        .open_connection_data(open_connection_data),
        .open_status_valid(open_status_valid),
        .open_status_ready(open_status_ready),
        .open_status_data(open_status_data),
        .close_connection_valid(close_connection_valid),
        .close_connection_ready(close_connection_ready),
        .close_connection_data(close_connection_data),
        .notifications_valid(notifications_valid),
        .notifications_ready(notifications_ready),
        .notifications_data(notifications_data),
        .read_package_valid(read_package_valid),
        .read_package_ready(read_package_ready),
        .read_package_data(read_package_data),
        .rx_metadata_valid(rx_metadata_valid),
        .rx_metadata_ready(rx_metadata_ready),
        .rx_metadata_data(rx_metadata_data),
        .rx_data_valid(rx_data_256_valid),
        .rx_data_ready(rx_data_256_ready),
        .rx_data_data(rx_data_256_data),
        .rx_data_keep(rx_data_256_keep),
        .rx_data_last(rx_data_256_last),
        .tx_metadata_valid(tx_metadata_valid),
        .tx_metadata_ready(tx_metadata_ready),
        .tx_metadata_data(tx_metadata_data),
        .tx_data_valid(tx_data_256_valid),
        .tx_data_ready(tx_data_256_ready),
        .tx_data_data(tx_data_256_data),
        .tx_data_keep(tx_data_256_keep),
        .tx_data_last(tx_data_256_last),
        .tx_status_valid(tx_status_valid),
        .tx_status_ready(tx_status_ready),
        .tx_status_data(tx_status_data),
        // UDP signals
        .udp_port_cmd_valid(udp_port_cmd_valid),
        .udp_port_cmd_ready(udp_port_cmd_ready),
        .udp_port_cmd_data(udp_port_cmd_data),
        .udp_rx_data_valid(udp_rx_data_256_valid),
        .udp_rx_data_ready(udp_rx_data_256_ready),
        .udp_rx_data_data(udp_rx_data_256_data),
        .udp_rx_data_keep(udp_rx_data_256_keep),
        .udp_rx_data_last(udp_rx_data_256_last),
        .udp_tx_data_valid(udp_tx_data_256_valid),
        .udp_tx_data_ready(udp_tx_data_256_ready),
        .udp_tx_data_data(udp_tx_data_256_data),
        .udp_tx_data_keep(udp_tx_data_256_keep),
        .udp_tx_data_last(udp_tx_data_256_last),
        .udp_rx_metadata_valid(udp_rx_metadata_valid),
        .udp_rx_metadata_ready(udp_rx_metadata_ready),
        .udp_rx_metadata_data(udp_rx_metadata_data),
        .udp_tx_metadata_valid(udp_tx_metadata_valid),
        .udp_tx_metadata_ready(udp_tx_metadata_ready),
        .udp_tx_metadata_data(udp_tx_metadata_data),
        // From core (load/store)
        .strobe_i(strobe_i),
        .addr_i(addr_i),
        .we_i(we_i),
        .data_i(data_i),
        .data_o(data_o),
        .ready_o(ready_o),
        // To core (external interrupt)
        .ext_irq_o(ext_irq_o)
    );

    dca_controller dca_controller_inst
    (
        .clk(clk_core),
        .rst_i(rst_i),
        .doing_dca(doing_dca),
        // TCP signals (RX)
        .rx_data_valid(rx_data_256_valid),
        .rx_data_ready(dca_rx_data_ready),
        .rx_data_data(rx_data_256_data),
        // TCP signals (TX)
        .tx_data_valid(dca_tx_data_valid),
        .tx_data_ready(tx_data_256_ready),
        .tx_data_data(dca_tx_data_data),
        .tx_data_keep(dca_tx_data_keep),
        .tx_data_last(dca_tx_data_last),
        // UDP signals (RX)
        .udp_rx_data_valid(udp_rx_data_256_valid),
        .udp_rx_data_ready(dca_udp_rx_data_ready),
        .udp_rx_data_data(udp_rx_data_256_data),
        // UDP signals (TX)
        .udp_tx_data_valid(dca_udp_tx_data_valid),
        .udp_tx_data_ready(udp_tx_data_256_ready),
        .udp_tx_data_data(dca_udp_tx_data_data),
        .udp_tx_data_keep(dca_udp_tx_data_keep),
        .udp_tx_data_last(dca_udp_tx_data_last),
        // Core signals
        .N_DCA_req_i(N_DCA_req_i),
        .N_DCA_ready_o(N_DCA_ready_o),
        .N_DCA_cmd_i(N_DCA_cmd_i),
        .N_DCA_addr_i(N_DCA_addr_i),
        .N_DCA_len_i(N_DCA_len_i),
        // Dcache signals
        .N_DCACHE_addr_o(N_DCACHE_addr_o),
        .N_DCACHE_data_i(N_DCACHE_data_i),
        .N_DCACHE_data_o(N_DCACHE_data_o),
        .N_DCACHE_strobe_o(N_DCACHE_strobe_o),
        .N_DCACHE_we_o(N_DCACHE_we_o),
        .N_DCACHE_ready_i(N_DCACHE_ready_i)
    );

endmodule


