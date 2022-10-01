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


module tcp_stack #(
    parameter WIDTH = 64
)(
    input  wire                           clk,
    input  wire                           rst_n,
    // TCP stack configuration
    input  wire [31 : 0]                 local_ip_address,
    output wire                          session_count_valid,
    output wire [15 : 0]                 session_count_data,
    // network interface streams
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
    //TCP Interface
    // memory cmd streams
    output wire                          m_axis_mem_read_cmd_valid,  // No slice
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
    output wire                          m_axis_mem_write_data_valid, // No slice
    input  wire                          m_axis_mem_write_data_ready,
    output wire [511 : 0]                m_axis_mem_write_data_data,
    output wire [63 : 0]                 m_axis_mem_write_data_keep,
    output wire                          m_axis_mem_write_data_last,    
    //Application interface streams
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
    output wire                          m_axis_rx_data_valid,          // No slice
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
    output wire                          m_axis_tx_status_valid,       // No slice
    input  wire                          m_axis_tx_status_ready,
    output wire [63 : 0]                 m_axis_tx_status_data
 );

    // Hash Table signals
    wire                                 axis_ht_lup_req_valid;
    wire                                 axis_ht_lup_req_ready;
    wire [71 : 0]                        axis_ht_lup_req_data;

    wire                                 axis_ht_lup_rsp_valid;
    wire                                 axis_ht_lup_rsp_ready;
    wire [87 : 0]                        axis_ht_lup_rsp_data;

    wire                                 axis_ht_upd_req_valid;
    wire                                 axis_ht_upd_req_ready;
    wire [87 : 0]                        axis_ht_upd_req_data;

    wire                                 axis_ht_upd_rsp_valid;
    wire                                 axis_ht_upd_rsp_ready;
    wire [87 : 0]                        axis_ht_upd_rsp_data;


    // Signals for registering
    wire                          axis_rxwrite_data_valid;
    wire                          axis_rxwrite_data_ready;
    wire [WIDTH-1 : 0]            axis_rxwrite_data_data;
    wire [(WIDTH/8)-1 : 0]        axis_rxwrite_data_keep;
    wire                          axis_rxwrite_data_last;
    
    wire                          axis_rxread_data_valid;
    wire                          axis_rxread_data_ready;
    wire [WIDTH-1 : 0]            axis_rxread_data_data;
    wire [(WIDTH/8)-1 : 0]        axis_rxread_data_keep;
    wire                          axis_rxread_data_last;

    wire                          axis_txwrite_data_valid;
    wire                          axis_txwrite_data_ready;
    wire [WIDTH-1 : 0]            axis_txwrite_data_data;
    wire [(WIDTH/8)-1 : 0]        axis_txwrite_data_keep;
    wire                          axis_txwrite_data_last;

    wire                          axis_txread_data_valid;
    wire                          axis_txread_data_ready;
    wire [WIDTH-1 : 0]            axis_txread_data_data;
    wire [(WIDTH/8)-1 : 0]        axis_txread_data_keep;
    wire                          axis_txread_data_last;

    wire                          axis_listen_port_valid;
    wire                          axis_listen_port_ready;
    wire [15 : 0]                 axis_listen_port_data;

    wire                          axis_listen_port_status_valid;
    wire                          axis_listen_port_status_ready;
    wire [7 : 0]                  axis_listen_port_status_data;

    wire                          axis_accept_status_valid;
    wire                          axis_accept_status_ready;
    wire [63 : 0]                 axis_accept_status_data;

    wire                          axis_open_connection_valid;
    wire                          axis_open_connection_ready;
    wire [47 : 0]                 axis_open_connection_data;

    wire                          axis_open_status_valid;
    wire                          axis_open_status_ready;
    wire [23 : 0]                 axis_open_status_data;

    wire                          axis_close_connection_valid;
    wire                          axis_close_connection_ready;
    wire [15 : 0]                 axis_close_connection_data;

    wire                          axis_notifications_valid;
    wire                          axis_notifications_ready;
    wire [87 : 0]                 axis_notifications_data;

    wire                          axis_read_package_valid;
    wire                          axis_read_package_ready;
    wire [31 : 0]                 axis_read_package_data;

    wire                          axis_rx_metadata_valid;
    wire                          axis_rx_metadata_ready;
    wire [15 : 0]                 axis_rx_metadata_data;

    wire                          axis_tx_metadata_valid;
    wire                          axis_tx_metadata_ready;
    wire [31 : 0]                 axis_tx_metadata_data;

    wire [31:0]                   rx_buffer_data_count;
    reg  [15:0]                   rx_buffer_data_count_reg;
    reg  [15:0]                   rx_buffer_data_count_reg2;

    wire                          axis_rxbuffer2app_valid;
    wire                          axis_rxbuffer2app_ready;
    wire [WIDTH-1 : 0]            axis_rxbuffer2app_data;
    wire [(WIDTH/8)-1 : 0]        axis_rxbuffer2app_keep;
    wire                          axis_rxbuffer2app_last;

    wire                          axis_tcp2rxbuffer_valid;
    wire                          axis_tcp2rxbuffer_ready;
    wire [WIDTH-1 : 0]            axis_tcp2rxbuffer_data;
    wire [(WIDTH/8)-1 : 0]        axis_tcp2rxbuffer_keep;
    wire                          axis_tcp2rxbuffer_last;

    assign s_axis_mem_read_sts_ready = 1'b1;

    //TOE Module with RX_DDR_BYPASS enabled
    toe_ip toe_inst (
        // Data output
        .m_axis_tcp_data_TVALID(m_axis_tx_data_valid),
        .m_axis_tcp_data_TREADY(m_axis_tx_data_ready),
        .m_axis_tcp_data_TDATA(m_axis_tx_data_data),
        .m_axis_tcp_data_TKEEP(m_axis_tx_data_keep),
        .m_axis_tcp_data_TLAST(m_axis_tx_data_last),
        // Data input
        .s_axis_tcp_data_TVALID(s_axis_rx_data_valid),
        .s_axis_tcp_data_TREADY(s_axis_rx_data_ready),
        .s_axis_tcp_data_TDATA(s_axis_rx_data_data),
        .s_axis_tcp_data_TKEEP(s_axis_rx_data_keep),
        .s_axis_tcp_data_TLAST(s_axis_rx_data_last),

        // rx buffer read path
        .s_axis_rxread_data_TVALID(axis_rxbuffer2app_valid),
        .s_axis_rxread_data_TREADY(axis_rxbuffer2app_ready),
        .s_axis_rxread_data_TDATA(axis_rxbuffer2app_data),
        .s_axis_rxread_data_TKEEP(axis_rxbuffer2app_keep),
        .s_axis_rxread_data_TLAST(axis_rxbuffer2app_last),
        // rx buffer write path
        .m_axis_rxwrite_data_TVALID(axis_tcp2rxbuffer_valid),
        .m_axis_rxwrite_data_TREADY(axis_tcp2rxbuffer_ready),
        .m_axis_rxwrite_data_TDATA(axis_tcp2rxbuffer_data),
        .m_axis_rxwrite_data_TKEEP(axis_tcp2rxbuffer_keep),
        .m_axis_rxwrite_data_TLAST(axis_tcp2rxbuffer_last),

        // tx read commands
        .m_axis_txread_cmd_V_TVALID(m_axis_mem_read_cmd_valid),
        .m_axis_txread_cmd_V_TREADY(m_axis_mem_read_cmd_ready),
        .m_axis_txread_cmd_V_TDATA(m_axis_mem_read_cmd_data),
        //tx write commands
        .m_axis_txwrite_cmd_V_TVALID(m_axis_mem_write_cmd_valid),
        .m_axis_txwrite_cmd_V_TREADY(m_axis_mem_write_cmd_ready),
        .m_axis_txwrite_cmd_V_TDATA(m_axis_mem_write_cmd_data),
        // tx write status
        .s_axis_txwrite_sts_V_TVALID(s_axis_mem_write_sts_valid),
        .s_axis_txwrite_sts_V_TREADY(s_axis_mem_write_sts_ready),
        .s_axis_txwrite_sts_V_TDATA(s_axis_mem_write_sts_data),
        // tx read path
        .s_axis_txread_data_TVALID(axis_txread_data_valid),
        .s_axis_txread_data_TREADY(axis_txread_data_ready),
        .s_axis_txread_data_TDATA(axis_txread_data_data),
        .s_axis_txread_data_TKEEP(axis_txread_data_keep),
        .s_axis_txread_data_TLAST(axis_txread_data_last),
        // tx write path
        .m_axis_txwrite_data_TVALID(axis_txwrite_data_valid),
        .m_axis_txwrite_data_TREADY(axis_txwrite_data_ready),
        .m_axis_txwrite_data_TDATA(axis_txwrite_data_data),
        .m_axis_txwrite_data_TKEEP(axis_txwrite_data_keep),
        .m_axis_txwrite_data_TLAST(axis_txwrite_data_last),
        /// SmartCAM I/F ///
        .m_axis_session_upd_req_V_TVALID(axis_ht_upd_req_valid),
        .m_axis_session_upd_req_V_TREADY(axis_ht_upd_req_ready),
        .m_axis_session_upd_req_V_TDATA(axis_ht_upd_req_data),

        .s_axis_session_upd_rsp_V_TVALID(axis_ht_upd_rsp_valid),
        .s_axis_session_upd_rsp_V_TREADY(axis_ht_upd_rsp_ready),
        .s_axis_session_upd_rsp_V_TDATA(axis_ht_upd_rsp_data),

        .m_axis_session_lup_req_V_TVALID(axis_ht_lup_req_valid),
        .m_axis_session_lup_req_V_TREADY(axis_ht_lup_req_ready),
        .m_axis_session_lup_req_V_TDATA(axis_ht_lup_req_data),
        .s_axis_session_lup_rsp_V_TVALID(axis_ht_lup_rsp_valid),
        .s_axis_session_lup_rsp_V_TREADY(axis_ht_lup_rsp_ready),
        .s_axis_session_lup_rsp_V_TDATA(axis_ht_lup_rsp_data),

        /* Application Interface */
        // listen&close port
        .s_axis_listen_port_req_V_V_TVALID(axis_listen_port_valid),
        .s_axis_listen_port_req_V_V_TREADY(axis_listen_port_ready),
        .s_axis_listen_port_req_V_V_TDATA(axis_listen_port_data),
        .m_axis_listen_port_rsp_V_TVALID(axis_listen_port_status_valid),
        .m_axis_listen_port_rsp_V_TREADY(axis_listen_port_status_ready),
        .m_axis_listen_port_rsp_V_TDATA(axis_listen_port_status_data),

        // accept status port
        .m_axis_accept_conn_rsp_V_TVALID(axis_accept_status_valid),
        .m_axis_accept_conn_rsp_V_TREADY(axis_accept_status_ready),
        .m_axis_accept_conn_rsp_V_TDATA(axis_accept_status_data),

        // notification & read request
        .m_axis_notification_V_TVALID(axis_notifications_valid),
        .m_axis_notification_V_TREADY(axis_notifications_ready),
        .m_axis_notification_V_TDATA(axis_notifications_data),
        .s_axis_rx_data_req_V_TVALID(axis_read_package_valid),
        .s_axis_rx_data_req_V_TREADY(axis_read_package_ready),
        .s_axis_rx_data_req_V_TDATA(axis_read_package_data),

        // open&close connection
        .s_axis_open_conn_req_V_TVALID(axis_open_connection_valid),
        .s_axis_open_conn_req_V_TREADY(axis_open_connection_ready),
        .s_axis_open_conn_req_V_TDATA(axis_open_connection_data),
        .m_axis_open_conn_rsp_V_TVALID(axis_open_status_valid),
        .m_axis_open_conn_rsp_V_TREADY(axis_open_status_ready),
        .m_axis_open_conn_rsp_V_TDATA(axis_open_status_data),
        .s_axis_close_conn_req_V_V_TVALID(axis_close_connection_valid),
        .s_axis_close_conn_req_V_V_TREADY(axis_close_connection_ready),
        .s_axis_close_conn_req_V_V_TDATA(axis_close_connection_data),

        // rx data
        .m_axis_rx_data_rsp_metadata_V_V_TVALID(axis_rx_metadata_valid),
        .m_axis_rx_data_rsp_metadata_V_V_TREADY(axis_rx_metadata_ready),
        .m_axis_rx_data_rsp_metadata_V_V_TDATA(axis_rx_metadata_data),
        .m_axis_rx_data_rsp_TVALID(m_axis_rx_data_valid),
        .m_axis_rx_data_rsp_TREADY(m_axis_rx_data_ready),
        .m_axis_rx_data_rsp_TDATA(m_axis_rx_data_data),
        .m_axis_rx_data_rsp_TKEEP(m_axis_rx_data_keep),
        .m_axis_rx_data_rsp_TLAST(m_axis_rx_data_last),

        // tx data
        .s_axis_tx_data_req_metadata_V_TVALID(axis_tx_metadata_valid),
        .s_axis_tx_data_req_metadata_V_TREADY(axis_tx_metadata_ready),
        .s_axis_tx_data_req_metadata_V_TDATA(axis_tx_metadata_data),
        .s_axis_tx_data_req_TVALID(s_axis_tx_data_valid),
        .s_axis_tx_data_req_TREADY(s_axis_tx_data_ready),
        .s_axis_tx_data_req_TDATA(s_axis_tx_data_data),
        .s_axis_tx_data_req_TKEEP(s_axis_tx_data_keep),
        .s_axis_tx_data_req_TLAST(s_axis_tx_data_last),
        .m_axis_tx_data_rsp_V_TVALID(m_axis_tx_status_valid),
        .m_axis_tx_data_rsp_V_TREADY(m_axis_tx_status_ready),
        .m_axis_tx_data_rsp_V_TDATA(m_axis_tx_status_data),

        .myIpAddress_V(local_ip_address),
        .regSessionCount_V(session_count_data),
        .regSessionCount_V_ap_vld(session_count_valid),
        //for external RX Buffer
        .axis_data_count_V(rx_buffer_data_count_reg2),
        .axis_max_data_count_V(16'd4096),

        .ap_clk(clk),
        .ap_rst_n(rst_n)
    );

    generate // RX BUFFER FIFO
        if (WIDTH==64) begin
            axis_data_fifo_64_d4096 rx_buffer_fifo (
                .s_axis_aresetn(rst_n),
                .s_axis_aclk(clk),
                .s_axis_tvalid(axis_tcp2rxbuffer_valid),
                .s_axis_tready(axis_tcp2rxbuffer_ready),
                .s_axis_tdata(axis_tcp2rxbuffer_data),
                .s_axis_tkeep(axis_tcp2rxbuffer_keep),
                .s_axis_tlast(axis_tcp2rxbuffer_last),
                .m_axis_tvalid(axis_rxbuffer2app_valid),
                .m_axis_tready(axis_rxbuffer2app_ready),
                .m_axis_tdata(axis_rxbuffer2app_data),
                .m_axis_tkeep(axis_rxbuffer2app_keep),
                .m_axis_tlast(axis_rxbuffer2app_last),
                .axis_wr_data_count(rx_buffer_data_count),
                .axis_rd_data_count()
            );
        end
        if (WIDTH==128) begin
            axis_data_fifo_128_d4096 rx_buffer_fifo (
                .s_axis_aresetn(rst_n),
                .s_axis_aclk(clk),
                .s_axis_tvalid(axis_tcp2rxbuffer_valid),
                .s_axis_tready(axis_tcp2rxbuffer_ready),
                .s_axis_tdata(axis_tcp2rxbuffer_data),
                .s_axis_tkeep(axis_tcp2rxbuffer_keep),
                .s_axis_tlast(axis_tcp2rxbuffer_last),
                .m_axis_tvalid(axis_rxbuffer2app_valid),
                .m_axis_tready(axis_rxbuffer2app_ready),
                .m_axis_tdata(axis_rxbuffer2app_data),
                .m_axis_tkeep(axis_rxbuffer2app_keep),
                .m_axis_tlast(axis_rxbuffer2app_last),
                .axis_wr_data_count(rx_buffer_data_count),
                .axis_rd_data_count()
            );
        end
        if (WIDTH==256) begin
            axis_data_fifo_256_d4096 rx_buffer_fifo (
                .s_axis_aresetn(rst_n),
                .s_axis_aclk(clk),
                .s_axis_tvalid(axis_tcp2rxbuffer_valid),
                .s_axis_tready(axis_tcp2rxbuffer_ready),
                .s_axis_tdata(axis_tcp2rxbuffer_data),
                .s_axis_tkeep(axis_tcp2rxbuffer_keep),
                .s_axis_tlast(axis_tcp2rxbuffer_last),
                .m_axis_tvalid(axis_rxbuffer2app_valid),
                .m_axis_tready(axis_rxbuffer2app_ready),
                .m_axis_tdata(axis_rxbuffer2app_data),
                .m_axis_tkeep(axis_rxbuffer2app_keep),
                .m_axis_tlast(axis_rxbuffer2app_last),
                .axis_wr_data_count(rx_buffer_data_count),
                .axis_rd_data_count()
            );
        end
        if (WIDTH==512) begin
            axis_data_fifo_512_d4096 rx_buffer_fifo (
                .s_axis_aresetn(rst_n),
                .s_axis_aclk(clk),
                .s_axis_tvalid(axis_tcp2rxbuffer_valid),
                .s_axis_tready(axis_tcp2rxbuffer_ready),
                .s_axis_tdata(axis_tcp2rxbuffer_data),
                .s_axis_tkeep(axis_tcp2rxbuffer_keep),
                .s_axis_tlast(axis_tcp2rxbuffer_last),
                .m_axis_tvalid(axis_rxbuffer2app_valid),
                .m_axis_tready(axis_rxbuffer2app_ready),
                .m_axis_tdata(axis_rxbuffer2app_data),
                .m_axis_tkeep(axis_rxbuffer2app_keep),
                .m_axis_tlast(axis_rxbuffer2app_last),
                .axis_wr_data_count(rx_buffer_data_count),
                .axis_rd_data_count()
            );
        end
    endgenerate

    // register data_count
    always @(posedge clk) begin
        rx_buffer_data_count_reg <= rx_buffer_data_count[15:0];
        rx_buffer_data_count_reg2 <= rx_buffer_data_count_reg;
    end

    hash_table_ip hash_table_inst (
        .ap_clk(clk),
        .ap_rst_n(rst_n),
        .s_axis_lup_req_V_TVALID(axis_ht_lup_req_valid),
        .s_axis_lup_req_V_TREADY(axis_ht_lup_req_ready),
        .s_axis_lup_req_V_TDATA(axis_ht_lup_req_data),
        .m_axis_lup_rsp_V_TVALID(axis_ht_lup_rsp_valid),
        .m_axis_lup_rsp_V_TREADY(axis_ht_lup_rsp_ready),
        .m_axis_lup_rsp_V_TDATA(axis_ht_lup_rsp_data),
        .s_axis_upd_req_V_TVALID(axis_ht_upd_req_valid),
        .s_axis_upd_req_V_TREADY(axis_ht_upd_req_ready),
        .s_axis_upd_req_V_TDATA(axis_ht_upd_req_data),
        .m_axis_upd_rsp_V_TVALID(axis_ht_upd_rsp_valid),
        .m_axis_upd_rsp_V_TREADY(axis_ht_upd_rsp_ready),
        .m_axis_upd_rsp_V_TDATA(axis_ht_upd_rsp_data),
        .regInsertFailureCount_V_ap_vld(),
        .regInsertFailureCount_V()
    );

    
    generate // TCP Data Path
        if (WIDTH==64) begin
            axis_512_to_64_converter tcp_txread_data_converter (
                .aclk(clk),
                .aresetn(rst_n),
                .s_axis_tvalid(s_axis_mem_read_data_valid),
                .s_axis_tready(s_axis_mem_read_data_ready),
                .s_axis_tdata(s_axis_mem_read_data_data),
                .s_axis_tkeep(s_axis_mem_read_data_keep),
                .s_axis_tlast(s_axis_mem_read_data_last),
                .m_axis_tvalid(axis_txread_data_valid),
                .m_axis_tready(axis_txread_data_ready),
                .m_axis_tdata(axis_txread_data_data),
                .m_axis_tkeep(axis_txread_data_keep),
                .m_axis_tlast(axis_txread_data_last)
            );

            axis_64_to_512_converter tcp_txwrite_data_converter (
                .aclk(clk),
                .aresetn(rst_n),
                .s_axis_tvalid(axis_txwrite_data_valid),
                .s_axis_tready(axis_txwrite_data_ready),
                .s_axis_tdata(axis_txwrite_data_data),
                .s_axis_tkeep(axis_txwrite_data_keep),
                .s_axis_tlast(axis_txwrite_data_last),
                .m_axis_tvalid(m_axis_mem_write_data_valid),
                .m_axis_tready(m_axis_mem_write_data_ready),
                .m_axis_tdata(m_axis_mem_write_data_data),
                .m_axis_tkeep(m_axis_mem_write_data_keep),
                .m_axis_tlast(m_axis_mem_write_data_last)
            );
        end
        if (WIDTH==128) begin
            axis_512_to_128_converter tcp_txread_data_converter (
                .aclk(clk),
                .aresetn(rst_n),
                .s_axis_tvalid(s_axis_mem_read_data_valid),
                .s_axis_tready(s_axis_mem_read_data_ready),
                .s_axis_tdata(s_axis_mem_read_data_data),
                .s_axis_tkeep(s_axis_mem_read_data_keep),
                .s_axis_tlast(s_axis_mem_read_data_last),
                .m_axis_tvalid(axis_txread_data_valid),
                .m_axis_tready(axis_txread_data_ready),
                .m_axis_tdata(axis_txread_data_data),
                .m_axis_tkeep(axis_txread_data_keep),
                .m_axis_tlast(axis_txread_data_last)
            );

            axis_128_to_512_converter tcp_txwrite_data_converter (
                .aclk(clk),
                .aresetn(rst_n),
                .s_axis_tvalid(axis_txwrite_data_valid),
                .s_axis_tready(axis_txwrite_data_ready),
                .s_axis_tdata(axis_txwrite_data_data),
                .s_axis_tkeep(axis_txwrite_data_keep),
                .s_axis_tlast(axis_txwrite_data_last),
                .m_axis_tvalid(m_axis_mem_write_data_valid),
                .m_axis_tready(m_axis_mem_write_data_ready),
                .m_axis_tdata(m_axis_mem_write_data_data),
                .m_axis_tkeep(m_axis_mem_write_data_keep),
                .m_axis_tlast(m_axis_mem_write_data_last)
            );
        end
        if (WIDTH==256) begin
            axis_512_to_256_converter tcp_txread_data_converter (
                .aclk(clk),
                .aresetn(rst_n),
                .s_axis_tvalid(s_axis_mem_read_data_valid),
                .s_axis_tready(s_axis_mem_read_data_ready),
                .s_axis_tdata(s_axis_mem_read_data_data),
                .s_axis_tkeep(s_axis_mem_read_data_keep),
                .s_axis_tlast(s_axis_mem_read_data_last),
                .m_axis_tvalid(axis_txread_data_valid),
                .m_axis_tready(axis_txread_data_ready),
                .m_axis_tdata(axis_txread_data_data),
                .m_axis_tkeep(axis_txread_data_keep),
                .m_axis_tlast(axis_txread_data_last)
            );

            axis_256_to_512_converter tcp_txwrite_data_converter (
                .aclk(clk),
                .aresetn(rst_n),
                .s_axis_tvalid(axis_txwrite_data_valid),
                .s_axis_tready(axis_txwrite_data_ready),
                .s_axis_tdata(axis_txwrite_data_data),
                .s_axis_tkeep(axis_txwrite_data_keep),
                .s_axis_tlast(axis_txwrite_data_last),
                .m_axis_tvalid(m_axis_mem_write_data_valid),
                .m_axis_tready(m_axis_mem_write_data_ready),
                .m_axis_tdata(m_axis_mem_write_data_data),
                .m_axis_tkeep(m_axis_mem_write_data_keep),
                .m_axis_tlast(m_axis_mem_write_data_last)
            );
        end
        if (WIDTH==512) begin
            assign axis_rxread_data_valid      = s_axis_mem_read_data_valid;
            assign s_axis_mem_read_data_ready  = axis_rxread_data_ready;
            assign axis_rxread_data_data       = s_axis_mem_read_data_data;
            assign axis_rxread_data_keep       = s_axis_mem_read_data_keep;
            assign axis_rxread_data_last       = s_axis_mem_read_data_last;

            assign m_axis_mem_write_data_valid = axis_rxwrite_data_valid;
            assign axis_rxwrite_data_ready     = m_axis_mem_write_data_ready;
            assign m_axis_mem_write_data_data  = axis_rxwrite_data_data;
            assign m_axis_mem_write_data_keep  = axis_rxwrite_data_keep;
            assign m_axis_mem_write_data_last  = axis_rxwrite_data_last;

            assign axis_txread_data_valid      = s_axis_mem_read_data_valid;
            assign s_axis_mem_read_data_ready  = axis_txread_data_ready;
            assign axis_txread_data_data       = s_axis_mem_read_data_data;
            assign axis_txread_data_keep       = s_axis_mem_read_data_keep;
            assign axis_txread_data_last       = s_axis_mem_read_data_last;
            assign m_axis_mem_write_data_valid = axis_txwrite_data_valid;
            assign axis_txwrite_data_ready     = m_axis_mem_write_data_ready;
            assign m_axis_mem_write_data_data  = axis_txwrite_data_data;
            assign m_axis_mem_write_data_keep  = axis_txwrite_data_keep;
            assign m_axis_mem_write_data_last  = axis_txwrite_data_last;
        end
    endgenerate

    // Register slices to avoid combinatorial loops created by HLS due to the new axis INTERFACE (enforced since 19.1)

    meta_register_slice #(.WIDTH(16)) listen_port_slice (
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(s_axis_listen_port_valid),
        .s_axis_ready(s_axis_listen_port_ready),
        .s_axis_data(s_axis_listen_port_data),
        .m_axis_valid(axis_listen_port_valid),
        .m_axis_ready(axis_listen_port_ready),
        .m_axis_data(axis_listen_port_data)
    );

    meta_register_slice #(.WIDTH(8)) port_status_slice (
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(axis_listen_port_status_valid),
        .s_axis_ready(axis_listen_port_status_ready),
        .s_axis_data(axis_listen_port_status_data),
        .m_axis_valid(m_axis_listen_port_status_valid),
        .m_axis_ready(m_axis_listen_port_status_ready),
        .m_axis_data(m_axis_listen_port_status_data)
    );

    meta_register_slice #(.WIDTH(64)) accept_status_slice (
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(axis_accept_status_valid),
        .s_axis_ready(axis_accept_status_ready),
        .s_axis_data(axis_accept_status_data),
        .m_axis_valid(m_axis_accept_status_valid),
        .m_axis_ready(m_axis_accept_status_ready),
        .m_axis_data(m_axis_accept_status_data)
    );

    meta_register_slice #(.WIDTH(48)) open_connection_slice (
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(s_axis_open_connection_valid),
        .s_axis_ready(s_axis_open_connection_ready),
        .s_axis_data(s_axis_open_connection_data),
        .m_axis_valid(axis_open_connection_valid),
        .m_axis_ready(axis_open_connection_ready),
        .m_axis_data(axis_open_connection_data)
    );

    meta_register_slice #(.WIDTH(24)) open_status_slice (
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(axis_open_status_valid),
        .s_axis_ready(axis_open_status_ready),
        .s_axis_data(axis_open_status_data),
        .m_axis_valid(m_axis_open_status_valid),
        .m_axis_ready(m_axis_open_status_ready),
        .m_axis_data(m_axis_open_status_data)
    );

    meta_register_slice #(.WIDTH(16)) close_connection_slice (
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(s_axis_close_connection_valid),
        .s_axis_ready(s_axis_close_connection_ready),
        .s_axis_data(s_axis_close_connection_data),
        .m_axis_valid(axis_close_connection_valid),
        .m_axis_ready(axis_close_connection_ready),
        .m_axis_data(axis_close_connection_data)
    );

    meta_register_slice #(.WIDTH(88)) notification_slice (
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(axis_notifications_valid),
        .s_axis_ready(axis_notifications_ready),
        .s_axis_data(axis_notifications_data),
        .m_axis_valid(m_axis_notifications_valid),
        .m_axis_ready(m_axis_notifications_ready),
        .m_axis_data(m_axis_notifications_data)
    );

    meta_register_slice #(.WIDTH(32)) read_package_slice (
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(s_axis_read_package_valid),
        .s_axis_ready(s_axis_read_package_ready),
        .s_axis_data(s_axis_read_package_data),
        .m_axis_valid(axis_read_package_valid),
        .m_axis_ready(axis_read_package_ready),
        .m_axis_data(axis_read_package_data)
    );

    meta_register_slice #(.WIDTH(16)) axis_rx_metadata_slice (
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(axis_rx_metadata_valid),
        .s_axis_ready(axis_rx_metadata_ready),
        .s_axis_data(axis_rx_metadata_data),
        .m_axis_valid(m_axis_rx_metadata_valid),
        .m_axis_ready(m_axis_rx_metadata_ready),
        .m_axis_data(m_axis_rx_metadata_data)
    );
    meta_register_slice #(.WIDTH(32)) axis_tx_metadata_slice (
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_valid(s_axis_tx_metadata_valid),
        .s_axis_ready(s_axis_tx_metadata_ready),
        .s_axis_data(s_axis_tx_metadata_data),
        .m_axis_valid(axis_tx_metadata_valid),
        .m_axis_ready(axis_tx_metadata_ready),
        .m_axis_data(axis_tx_metadata_data)
    );

endmodule


