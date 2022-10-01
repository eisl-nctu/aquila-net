`timescale 1ns / 1ps
// =============================================================================
//  Program : mmio_inf.v
//  Author  : YI-DE, LEE
//  Date    : Apr/9/2022
// -----------------------------------------------------------------------------
//  Description:
//      The Memory-Mapped I/O Interface of the HW network module.
//      This interface provides a control signaling to the HW
//      TCP/IP stack.
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

module mmio_inf (
    input  wire                          clk_core,
    input  wire                          rst_i,
    output wire [  0 : 7]                usr_led,
    // Round-Trip latency measurement
    output wire                          read_ticks,
    input  wire [ 31 : 0]                tx_ticks,
    input  wire [ 31 : 0]                rx_ticks,
    input  wire                          ticks_valid,
    // Network stack configuration
    output reg  [ 47 : 0]                mac_address,
    output reg  [ 31 : 0]                ip_address,
    output reg  [ 31 : 0]                ip_subnet_mask,
    output reg  [ 31 : 0]                ip_default_gateway,
    // TCP signals
    output reg                           listen_port_valid,
    input  wire                          listen_port_ready,
    output reg  [ 15 : 0]                listen_port_data,
    input  wire                          listen_port_status_valid,
    output wire                          listen_port_status_ready,
    input  wire [  7 : 0]                listen_port_status_data,
    input  wire                          accept_status_valid,
    output wire                          accept_status_ready,
    input  wire [ 63 : 0]                accept_status_data,
    output reg                           open_connection_valid,
    input  wire                          open_connection_ready,
    output reg  [ 47 : 0]                open_connection_data,
    input  wire                          open_status_valid,
    output wire                          open_status_ready,
    input  wire [ 23 : 0]                open_status_data,
    output reg                           close_connection_valid,
    input  wire                          close_connection_ready,
    output reg  [ 15 : 0]                close_connection_data,
    input  wire                          notifications_valid,
    output wire                          notifications_ready,
    input  wire [ 87 : 0]                notifications_data,
    output reg                           read_package_valid,
    input  wire                          read_package_ready,
    output reg  [ 31 : 0]                read_package_data,
    input  wire                          rx_metadata_valid,
    output wire                          rx_metadata_ready,
    input  wire [ 15 : 0]                rx_metadata_data,
    input  wire                          rx_data_valid,
    output wire                          rx_data_ready,
    input  wire [255 : 0]                rx_data_data,
    input  wire [ 31 : 0]                rx_data_keep,
    input  wire                          rx_data_last,
    output reg                           tx_metadata_valid,
    input  wire                          tx_metadata_ready,
    output reg  [ 31 : 0]                tx_metadata_data,
    output reg                           tx_data_valid,
    input  wire                          tx_data_ready,
    output reg  [255 : 0]                tx_data_data,
    output wire [ 31 : 0]                tx_data_keep,
    output wire                          tx_data_last,
    input  wire                          tx_status_valid,
    output wire                          tx_status_ready,
    input  wire [ 63 : 0]                tx_status_data, //TO DO check width
    // UDP signals
    output reg                           udp_port_cmd_valid,
    input  wire                          udp_port_cmd_ready,
    output reg  [ 31 : 0]                udp_port_cmd_data,
    input  wire                          udp_rx_data_valid,
    output wire                          udp_rx_data_ready,
    input  wire [255 : 0]                udp_rx_data_data,
    input  wire [ 31 : 0]                udp_rx_data_keep,
    input  wire                          udp_rx_data_last,
    output reg                           udp_tx_data_valid,
    input  wire                          udp_tx_data_ready,
    output reg  [255 : 0]                udp_tx_data_data,
    output wire [ 31 : 0]                udp_tx_data_keep,
    output wire                          udp_tx_data_last,
    input  wire                          udp_rx_metadata_valid,
    output wire                          udp_rx_metadata_ready,
    input  wire [175 : 0]                udp_rx_metadata_data,
    output reg                           udp_tx_metadata_valid,
    input  wire                          udp_tx_metadata_ready,
    output reg  [175 : 0]                udp_tx_metadata_data,
    // From core (load/store)
    input  wire                          strobe_i,
    input  wire [  7 : 0]                addr_i,
    input  wire                          we_i,
    input  wire [ 31 : 0]                data_i,
    output wire [ 31 : 0]                data_o,
    output wire                          ready_o,
    // To core (external interrupt)
    output wire                          ext_irq_o
);

    // Read
    localparam
        TCP_INF_STA_ADDR         = 8'h00, 
        TCP_OPEN_STA_ADDR        = 8'h04,
        TCP_LISTEN_PORT_STA_ADDR = 8'h08,
        TCP_ACCEPT_CONN_0_ADDR   = 8'h0C,
        TCP_ACCEPT_CONN_1_ADDR   = 8'h10,
        TCP_RX_DATA_0_ADDR       = 8'h14,
        TCP_RX_DATA_1_ADDR       = 8'h18,
        TCP_RX_DATA_2_ADDR       = 8'h1C,
        TCP_RX_DATA_3_ADDR       = 8'h20,
        TCP_RX_DATA_4_ADDR       = 8'h24,
        TCP_RX_DATA_5_ADDR       = 8'h28,
        TCP_RX_DATA_6_ADDR       = 8'h2C,
        TCP_RX_DATA_7_ADDR       = 8'h30,
        TCP_RX_META_ADDR         = 8'h34,
        TCP_TX_STA_ADDR          = 8'h38,
        TCP_NOTI_0_ADDR          = 8'h3C,
        TCP_NOTI_1_ADDR          = 8'h40,
        TCP_NOTI_2_ADDR          = 8'h44,
        UDP_INF_STA_ADDR         = 8'h48,
        UDP_RX_DATA_0_ADDR       = 8'h4C,
        UDP_RX_DATA_1_ADDR       = 8'h50,
        UDP_RX_DATA_2_ADDR       = 8'h54,
        UDP_RX_DATA_3_ADDR       = 8'h58,
        UDP_RX_DATA_4_ADDR       = 8'h5C,
        UDP_RX_DATA_5_ADDR       = 8'h60,
        UDP_RX_DATA_6_ADDR       = 8'h64,
        UDP_RX_DATA_7_ADDR       = 8'h68,
        UDP_RX_META_0_ADDR       = 8'h6C,
        UDP_RX_META_1_ADDR       = 8'h70,
        UDP_RX_META_2_ADDR       = 8'h74,
        UDP_RX_META_3_ADDR       = 8'h78,
        UDP_RX_META_4_ADDR       = 8'h7C,
        UDP_RX_META_5_ADDR       = 8'h80,
        NET_RX_TICKS_ADDR        = 8'h84,
        NET_TX_TICKS_ADDR        = 8'h88;

    // Write
    localparam 
        TCP_CLOSE_CONN_ADDR      = 8'h00,
        TCP_OPEN_CONN_0_ADDR     = 8'h04,
        TCP_OPEN_CONN_1_ADDR     = 8'h08,
        TCP_LISTEN_PORT_ADDR     = 8'h0C,
        TCP_TX_DATA_KEEP_ADDR    = 8'h10,
        TCP_TX_DATA_LAST_ADDR    = 8'h14,
        TCP_TX_DATA_0_ADDR       = 8'h18,
        TCP_TX_DATA_1_ADDR       = 8'h1C,
        TCP_TX_DATA_2_ADDR       = 8'h20,
        TCP_TX_DATA_3_ADDR       = 8'h24,
        TCP_TX_DATA_4_ADDR       = 8'h28,
        TCP_TX_DATA_5_ADDR       = 8'h2C,
        TCP_TX_DATA_6_ADDR       = 8'h30,
        TCP_TX_DATA_7_ADDR       = 8'h34,
        TCP_TX_META_ADDR         = 8'h38,
        TCP_READ_PACK_ADDR       = 8'h3C,
        UDP_TX_DATA_KEEP_ADDR    = 8'h40,
        UDP_TX_DATA_LAST_ADDR    = 8'h44,
        UDP_TX_DATA_0_ADDR       = 8'h48,
        UDP_TX_DATA_1_ADDR       = 8'h4C,
        UDP_TX_DATA_2_ADDR       = 8'h50,
        UDP_TX_DATA_3_ADDR       = 8'h54,
        UDP_TX_DATA_4_ADDR       = 8'h58,
        UDP_TX_DATA_5_ADDR       = 8'h5C,
        UDP_TX_DATA_6_ADDR       = 8'h60,
        UDP_TX_DATA_7_ADDR       = 8'h64,
        UDP_TX_META_0_ADDR       = 8'h68,
        UDP_TX_META_1_ADDR       = 8'h6C,
        UDP_TX_META_2_ADDR       = 8'h70,
        UDP_TX_META_3_ADDR       = 8'h74,
        UDP_TX_META_4_ADDR       = 8'h78,
        UDP_TX_META_5_ADDR       = 8'h7C,
        UDP_PORT_CMD_ADDR        = 8'h80,
        NET_IP_ADDR              = 8'h84,
        NET_IP_SUBNET_MASK_ADDR  = 8'h88,
        NET_IP_GATWAY_ADDR       = 8'h8C,
        NET_INT_ENABLE_ADDR      = 8'h90;


    wire       reading, writing;
    reg        reading_reg, writing_reg;
    reg        ready_reg, write_ready, read_valid;
    reg [31:0] data_o_reg;
    reg [31:0] tcp_inf_status, udp_inf_status;
    reg        interrupt_enable;

    reg                          strobe_r;
    reg [  7 : 0]                addr_r;
    reg                          we_r;
    reg [ 31 : 0]                data_r;

    // Control Logic

    always @(posedge clk_core) begin
        if (rst_i) 
            strobe_r <= 0;
        else 
            strobe_r <= strobe_i;
    end

    always @(posedge clk_core) begin
        if (rst_i) 
            addr_r <= 0;
        else 
            addr_r <= addr_i;
    end

    always @(posedge clk_core) begin
        if (rst_i) 
            we_r <= 0;
        else 
            we_r <= we_i;
    end

    always @(posedge clk_core) begin
        if (rst_i) 
            data_r <= 0;
        else 
            data_r <= data_i;
    end

    always @(posedge clk_core) begin
        if (rst_i) reading_reg <= 0;
        else if (read_valid) reading_reg <= 0; // if read transaction occur, don't do again
        else if (strobe_r && !we_r) reading_reg <= 1;
    end

    always @(posedge clk_core) begin
        if (rst_i) writing_reg <= 0;
        else if (write_ready) writing_reg <= 0;
        else if (strobe_r && we_r) writing_reg <= 1;
    end

    always @(posedge clk_core) begin // output ready, if read/write transaction occur 
        if (rst_i) ready_reg <= 0;
        else if (reading) ready_reg <= read_valid;
        else if (writing) ready_reg <= write_ready;
        else ready_reg <= 0;
    end

    assign reading = (strobe_r && !we_r) || reading_reg; // Doing read
    assign writing = (strobe_r &&  we_r) || writing_reg; // Doing write
    assign data_o  = data_o_reg;
    assign ready_o = ready_reg;

    // Read logic

    always @(posedge clk_core) begin
        if (rst_i)
            data_o_reg <= 32'h00000000;
        else if (reading) begin
            case (addr_r)
                TCP_INF_STA_ADDR:         data_o_reg <= tcp_inf_status;
                TCP_OPEN_STA_ADDR:        data_o_reg <= {8'h00, open_status_data};
                TCP_LISTEN_PORT_STA_ADDR: data_o_reg <= {24'h000000, listen_port_status_data};
                TCP_ACCEPT_CONN_0_ADDR:   data_o_reg <= accept_status_data[31:0];
                TCP_ACCEPT_CONN_1_ADDR:   data_o_reg <= accept_status_data[63:32];
                TCP_RX_DATA_0_ADDR:       data_o_reg <= rx_data_data[31:0];
                TCP_RX_DATA_1_ADDR:       data_o_reg <= rx_data_data[63:32];
                TCP_RX_DATA_2_ADDR:       data_o_reg <= rx_data_data[95:64];
                TCP_RX_DATA_3_ADDR:       data_o_reg <= rx_data_data[127:96];
                TCP_RX_DATA_4_ADDR:       data_o_reg <= rx_data_data[159:128];
                TCP_RX_DATA_5_ADDR:       data_o_reg <= rx_data_data[191:160];
                TCP_RX_DATA_6_ADDR:       data_o_reg <= rx_data_data[223:192];
                TCP_RX_DATA_7_ADDR:       data_o_reg <= rx_data_data[255:224];
                TCP_RX_META_ADDR:         data_o_reg <= {16'h0000, rx_metadata_data};
                TCP_TX_STA_ADDR:          data_o_reg <= tx_status_data;
                TCP_NOTI_0_ADDR:          data_o_reg <= notifications_data[31:0];
                TCP_NOTI_1_ADDR:          data_o_reg <= notifications_data[63:32];
                TCP_NOTI_2_ADDR:          data_o_reg <= {8'h00, notifications_data[87:64]};
                UDP_INF_STA_ADDR:         data_o_reg <= udp_inf_status;
                UDP_RX_DATA_0_ADDR:       data_o_reg <= udp_rx_data_data[31:0];
                UDP_RX_DATA_1_ADDR:       data_o_reg <= udp_rx_data_data[63:32];
                UDP_RX_DATA_2_ADDR:       data_o_reg <= udp_rx_data_data[95:64];
                UDP_RX_DATA_3_ADDR:       data_o_reg <= udp_rx_data_data[127:96];
                UDP_RX_DATA_4_ADDR:       data_o_reg <= udp_rx_data_data[159:128];
                UDP_RX_DATA_5_ADDR:       data_o_reg <= udp_rx_data_data[191:160];
                UDP_RX_DATA_6_ADDR:       data_o_reg <= udp_rx_data_data[223:192];
                UDP_RX_DATA_7_ADDR:       data_o_reg <= udp_rx_data_data[255:224];
                UDP_RX_META_0_ADDR:       data_o_reg <= udp_rx_metadata_data[31:0];
                UDP_RX_META_1_ADDR:       data_o_reg <= udp_rx_metadata_data[63:32];
                UDP_RX_META_2_ADDR:       data_o_reg <= udp_rx_metadata_data[95:64];
                UDP_RX_META_3_ADDR:       data_o_reg <= udp_rx_metadata_data[127:96];
                UDP_RX_META_4_ADDR:       data_o_reg <= udp_rx_metadata_data[159:128];
                UDP_RX_META_5_ADDR:       data_o_reg <= {16'h0000, udp_rx_metadata_data[175:160]};
                NET_RX_TICKS_ADDR:        data_o_reg <= rx_ticks;
                NET_TX_TICKS_ADDR:        data_o_reg <= tx_ticks;
                default:                  data_o_reg <= 32'h00000000;
            endcase
        end
    end

    // Check valid when reading first word
    always @(*) begin
        case (addr_r) 
            TCP_OPEN_STA_ADDR:        read_valid = open_status_valid;
            TCP_LISTEN_PORT_STA_ADDR: read_valid = listen_port_status_valid;
            TCP_ACCEPT_CONN_0_ADDR:   read_valid = accept_status_valid;
            TCP_RX_DATA_0_ADDR:       read_valid = rx_data_valid;
            TCP_RX_META_ADDR:         read_valid = rx_metadata_valid;
            TCP_TX_STA_ADDR:          read_valid = tx_status_valid;
            TCP_NOTI_0_ADDR:          read_valid = notifications_valid;
            UDP_RX_DATA_0_ADDR:       read_valid = udp_rx_data_valid;
            UDP_RX_META_0_ADDR:       read_valid = udp_rx_metadata_valid;
            default:                  read_valid = 1;
        endcase
    end

    // Output ready when reading last word
    assign open_status_ready        = reading && (addr_r == TCP_OPEN_STA_ADDR);
    assign accept_status_ready      = reading && (addr_r == TCP_ACCEPT_CONN_1_ADDR);
    assign listen_port_status_ready = reading && (addr_r == TCP_LISTEN_PORT_STA_ADDR);
    assign rx_data_ready            = reading && (addr_r == TCP_RX_DATA_7_ADDR);
    assign rx_metadata_ready        = reading && (addr_r == TCP_RX_META_ADDR);
    assign tx_status_ready          = reading && (addr_r == TCP_TX_STA_ADDR);
    assign notifications_ready      = reading && (addr_r == TCP_NOTI_2_ADDR);
    assign udp_rx_data_ready        = reading && (addr_r == UDP_RX_DATA_7_ADDR);
    assign udp_rx_metadata_ready    = reading && (addr_r == UDP_RX_META_5_ADDR);
    assign read_ticks               = reading && (addr_r == NET_TX_TICKS_ADDR);

    // Write logic

    reg [31:0] tcp_tx_data_keep_reg;
    reg        tcp_tx_data_last_reg;
    reg [31:0] udp_tx_data_keep_reg;
    reg        udp_tx_data_last_reg;

    // Check ready when writing last word
    always @(*) begin
        case (addr_r) 
            TCP_CLOSE_CONN_ADDR  : write_ready = close_connection_ready;
            TCP_OPEN_CONN_1_ADDR : write_ready = open_connection_ready;
            TCP_LISTEN_PORT_ADDR : write_ready = listen_port_ready;
            TCP_TX_DATA_7_ADDR   : write_ready = tx_data_ready;
            TCP_TX_META_ADDR     : write_ready = tx_metadata_ready;
            TCP_READ_PACK_ADDR   : write_ready = read_package_ready;
            UDP_TX_DATA_7_ADDR   : write_ready = udp_tx_data_ready;
            UDP_TX_META_5_ADDR   : write_ready = udp_tx_metadata_ready;
            UDP_PORT_CMD_ADDR    : write_ready = udp_port_cmd_ready;
            default              : write_ready = 1;
        endcase
    end

    // Send valid when writing last word
    assign tx_data_keep     = tcp_tx_data_keep_reg;
    assign tx_data_last     = tcp_tx_data_last_reg;
    assign udp_tx_data_keep = udp_tx_data_keep_reg;
    assign udp_tx_data_last = udp_tx_data_last_reg;

    always @(posedge clk_core) begin
        if (rst_i)
            tx_data_valid <= 0;
        else
            tx_data_valid <= writing && (addr_r == TCP_TX_DATA_7_ADDR);
    end

    always @(posedge clk_core) begin
        if (rst_i)
            tx_metadata_valid <= 0;
        else
            tx_metadata_valid <= writing && (addr_r == TCP_TX_META_ADDR);
    end

    always @(posedge clk_core) begin
        if (rst_i)
            close_connection_valid <= 0;
        else
            close_connection_valid <= writing && (addr_r == TCP_CLOSE_CONN_ADDR);
    end

    always @(posedge clk_core) begin
        if (rst_i)
            open_connection_valid <= 0;
        else
            open_connection_valid <= writing && (addr_r == TCP_OPEN_CONN_1_ADDR);
    end
    always @(posedge clk_core) begin
        if (rst_i)
            listen_port_valid <= 0;
        else
            listen_port_valid <= writing && (addr_r == TCP_LISTEN_PORT_ADDR);
    end

    always @(posedge clk_core) begin
        if (rst_i)
            read_package_valid <= 0;
        else
            read_package_valid <= writing && (addr_r == TCP_READ_PACK_ADDR);
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_data_valid <= 0;
        else
            udp_tx_data_valid <= writing && (addr_r == UDP_TX_DATA_7_ADDR);
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_metadata_valid <= 0;
        else
            udp_tx_metadata_valid <= writing && (addr_r == UDP_TX_META_5_ADDR);
    end
    
    always @(posedge clk_core) begin
        if (rst_i)
            udp_port_cmd_valid <= 0;
        else
            udp_port_cmd_valid <= writing && (addr_r == UDP_PORT_CMD_ADDR);
    end

    // Interface status
    always @(*) begin
        tcp_inf_status[0]  = listen_port_ready;
        tcp_inf_status[1]  = listen_port_status_valid;
        tcp_inf_status[2]  = accept_status_valid;
        tcp_inf_status[3]  = open_connection_ready;
        tcp_inf_status[4]  = open_status_valid;
        tcp_inf_status[5]  = close_connection_ready;
        tcp_inf_status[6]  = notifications_valid;
        tcp_inf_status[7]  = read_package_ready;
        tcp_inf_status[8]  = rx_metadata_valid;
        tcp_inf_status[9]  = rx_data_valid;
        tcp_inf_status[10] = tx_metadata_ready;
        tcp_inf_status[11] = tx_data_ready;
        tcp_inf_status[12] = tx_status_valid;

        tcp_inf_status[31:13] = 0;
    end

    always @(*) begin
        udp_inf_status[0]  = udp_port_cmd_ready;
        udp_inf_status[1]  = udp_rx_data_valid;
        udp_inf_status[2]  = udp_tx_data_ready;
        udp_inf_status[3]  = udp_rx_metadata_valid;
        udp_inf_status[4]  = udp_tx_metadata_ready;

        udp_inf_status[31:5] = 0;
    end

    // Regs
    always @(posedge clk_core) begin
        if (rst_i)
            tcp_tx_data_keep_reg <= 0;
        else if (writing && addr_r == TCP_TX_DATA_KEEP_ADDR)
            tcp_tx_data_keep_reg <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            tcp_tx_data_last_reg <= 0;
        else if (writing && addr_r == TCP_TX_DATA_LAST_ADDR)
            tcp_tx_data_last_reg <= data_r[0];
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_data_keep_reg <= 0;
        else if (writing && addr_r == UDP_TX_DATA_KEEP_ADDR)
            udp_tx_data_keep_reg <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_data_last_reg <= 0;
        else if (writing && addr_r == UDP_TX_DATA_LAST_ADDR)
            udp_tx_data_last_reg <= data_r[0];
    end

    always @(posedge clk_core) begin
        if (rst_i)
            close_connection_data <= 0;
        else if (writing && addr_r == TCP_CLOSE_CONN_ADDR)
            close_connection_data <= data_r[15:0];
    end

    always @(posedge clk_core) begin
        if (rst_i)
            open_connection_data[31:0] <= 0;
        else if (writing && addr_r == TCP_OPEN_CONN_0_ADDR)
            open_connection_data[31:0] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            open_connection_data[47:32] <= 0;
        else if (writing && addr_r == TCP_OPEN_CONN_1_ADDR)
            open_connection_data[47:32] <= data_r[15:0];
    end

    always @(posedge clk_core) begin
        if (rst_i)
            listen_port_data <= 0;
        else if (writing && addr_r == TCP_LISTEN_PORT_ADDR)
            listen_port_data <= data_r[15:0];
    end

    always @(posedge clk_core) begin
        if (rst_i)
            tx_data_data[31:0] <= 0;
        else if (writing && addr_r == TCP_TX_DATA_0_ADDR)
            tx_data_data[31:0] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            tx_data_data[63:32] <= 0;
        else if (writing && addr_r == TCP_TX_DATA_1_ADDR)
            tx_data_data[63:32] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            tx_data_data[95:64] <= 0;
        else if (writing && addr_r == TCP_TX_DATA_2_ADDR)
            tx_data_data[95:64] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            tx_data_data[127:96] <= 0;
        else if (writing && addr_r == TCP_TX_DATA_3_ADDR)
            tx_data_data[127:96] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            tx_data_data[159:128] <= 0;
        else if (writing && addr_r == TCP_TX_DATA_4_ADDR)
            tx_data_data[159:128] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            tx_data_data[191:160] <= 0;
        else if (writing && addr_r == TCP_TX_DATA_5_ADDR)
            tx_data_data[191:160] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            tx_data_data[223:192] <= 0;
        else if (writing && addr_r == TCP_TX_DATA_6_ADDR)
            tx_data_data[223:192] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            tx_data_data[255:224] <= 0;
        else if (writing && addr_r == TCP_TX_DATA_7_ADDR)
            tx_data_data[255:224] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            tx_metadata_data <= 0;
        else if (writing && addr_r == TCP_TX_META_ADDR)
            tx_metadata_data <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            read_package_data <= 0;
        else if (writing && addr_r == TCP_READ_PACK_ADDR)
            read_package_data <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_data_data[31:0] <= 0;
        else if (writing && addr_r == UDP_TX_DATA_0_ADDR)
            udp_tx_data_data[31:0] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_data_data[63:32] <= 0;
        else if (writing && addr_r == UDP_TX_DATA_1_ADDR)
            udp_tx_data_data[63:32] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_data_data[95:64] <= 0;
        else if (writing && addr_r == UDP_TX_DATA_2_ADDR)
            udp_tx_data_data[95:64] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_data_data[127:96] <= 0;
        else if (writing && addr_r == UDP_TX_DATA_3_ADDR)
            udp_tx_data_data[127:96] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_data_data[159:128] <= 0;
        else if (writing && addr_r == UDP_TX_DATA_4_ADDR)
            udp_tx_data_data[159:128] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_data_data[191:160] <= 0;
        else if (writing && addr_r == UDP_TX_DATA_5_ADDR)
            udp_tx_data_data[191:160] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_data_data[223:192] <= 0;
        else if (writing && addr_r == UDP_TX_DATA_6_ADDR)
            udp_tx_data_data[223:192] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_data_data[255:224] <= 0;
        else if (writing && addr_r == UDP_TX_DATA_7_ADDR)
            udp_tx_data_data[255:224] <= data_r;
    end


    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_metadata_data[31:0] <= 0;
        else if (writing && addr_r == UDP_TX_META_0_ADDR)
            udp_tx_metadata_data[31:0] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_metadata_data[63:32] <= 0;
        else if (writing && addr_r == UDP_TX_META_1_ADDR)
            udp_tx_metadata_data[63:32] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_metadata_data[95:64] <= 0;
        else if (writing && addr_r == UDP_TX_META_2_ADDR)
            udp_tx_metadata_data[95:64] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_metadata_data[127:96] <= 0;
        else if (writing && addr_r == UDP_TX_META_3_ADDR)
            udp_tx_metadata_data[127:96] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_metadata_data[159:128] <= 0;
        else if (writing && addr_r == UDP_TX_META_4_ADDR)
            udp_tx_metadata_data[159:128] <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_tx_metadata_data[175:160] <= 0;
        else if (writing && addr_r == UDP_TX_META_5_ADDR)
            udp_tx_metadata_data[175:160] <= data_r[15:0];
    end

    always @(posedge clk_core) begin
        if (rst_i)
            ip_address <= 32'hD1D4010A; // 10.1.212.209
        else if (writing && addr_r == NET_IP_ADDR)
            ip_address <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            ip_subnet_mask <= 32'h00FFFFFF; // 255.255.255.0
        else if (writing && addr_r == NET_IP_SUBNET_MASK_ADDR)
            ip_subnet_mask <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            ip_default_gateway <= 32'h01D4010A;
        else if (writing && addr_r == NET_IP_GATWAY_ADDR)
            ip_default_gateway <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            udp_port_cmd_data <= 0;
        else if (writing && addr_r == UDP_PORT_CMD_ADDR)
            udp_port_cmd_data <= data_r;
    end

    always @(posedge clk_core) begin
        if (rst_i)
            interrupt_enable <= 0;
        else if (writing && addr_r == NET_INT_ENABLE_ADDR)
            interrupt_enable <= data_r[0];
    end

    // External Interrupt
    assign ext_irq_o = interrupt_enable & (notifications_valid | accept_status_valid | udp_rx_metadata_valid);

    // LED Control
    assign usr_led[0] = notifications_valid;
    assign usr_led[1] = rx_data_valid;
    assign usr_led[2] = tx_data_valid;
    assign usr_led[3] = udp_rx_metadata_valid;
    assign usr_led[4] = udp_tx_metadata_valid;
    assign usr_led[5] = ext_irq_o;
    assign usr_led[6] = strobe_r;
    assign usr_led[7] = ready_o;

endmodule
