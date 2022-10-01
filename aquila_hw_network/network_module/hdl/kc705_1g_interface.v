`timescale 1ns / 1ps

module kc705_1g_interface #(
    parameter WIDTH = 64
)(
    input                          clk_i,
    input                          rst_i,
    /*
     * Ethernet: 1000BASE-T SGMII
     */
    input                          phy_sgmii_rx_p,
    input                          phy_sgmii_rx_n,
    output                         phy_sgmii_tx_p,
    output                         phy_sgmii_tx_n,
    input                          phy_sgmii_clk_p,
    input                          phy_sgmii_clk_n,
    output                         phy_reset_n,
    input                          phy_int_n,

    output [WIDTH-1:0]             rx_axis_tdata,
    output                         rx_axis_tvalid,
    output                         rx_axis_tlast,
    output                         rx_axis_tuser,
    output [(WIDTH/8)-1:0]         rx_axis_tkeep,
    input                          rx_axis_tready,

    input  [WIDTH-1:0]             tx_axis_tdata,
    input                          tx_axis_tvalid,
    input                          tx_axis_tlast,
    input                          tx_axis_tuser,
    input  [(WIDTH/8)-1:0]         tx_axis_tkeep,
    output                         tx_axis_tready,

    // Latency Measurement
    input                          read_ticks,
    output reg  [31:0]             rx_ticks,
    output reg  [31:0]             tx_ticks,
    output reg                     ticks_valid
);

    // SGMII interface to PHY
    wire phy_gmii_clk_int;
    wire phy_gmii_rst_int;
    wire phy_gmii_clk_en_int;
    wire [7:0] phy_gmii_txd_int;
    wire phy_gmii_tx_en_int;
    wire phy_gmii_tx_er_int;
    wire [7:0] phy_gmii_rxd_int;
    wire phy_gmii_rx_dv_int;
    wire phy_gmii_rx_er_int;

    wire phy_sgmii_userclk2;
    wire phy_sgmii_resetdone;

    assign phy_gmii_clk_int = phy_sgmii_userclk2;

    sync_reset #(
        .N(4)
    )
    sync_reset_pcspma_inst (
        .clk(phy_gmii_clk_int),
        .rst(rst_i || !phy_sgmii_resetdone),
        .out(phy_gmii_rst_int)
    );

    wire [15:0] pcspma_status_vector;

    wire pcspma_status_link_status              = pcspma_status_vector[0];
    wire pcspma_status_link_synchronization     = pcspma_status_vector[1];
    wire pcspma_status_rudi_c                   = pcspma_status_vector[2];
    wire pcspma_status_rudi_i                   = pcspma_status_vector[3];
    wire pcspma_status_rudi_invalid             = pcspma_status_vector[4];
    wire pcspma_status_rxdisperr                = pcspma_status_vector[5];
    wire pcspma_status_rxnotintable             = pcspma_status_vector[6];
    wire pcspma_status_phy_link_status          = pcspma_status_vector[7];
    wire [1:0] pcspma_status_remote_fault_encdg = pcspma_status_vector[9:8];
    wire [1:0] pcspma_status_speed              = pcspma_status_vector[11:10];
    wire pcspma_status_duplex                   = pcspma_status_vector[12];
    wire pcspma_status_remote_fault             = pcspma_status_vector[13];
    wire [1:0] pcspma_status_pause              = pcspma_status_vector[15:14];

    wire [4:0] pcspma_config_vector;

    assign pcspma_config_vector[4] = 1'b1; // autonegotiation enable
    assign pcspma_config_vector[3] = 1'b0; // isolate
    assign pcspma_config_vector[2] = 1'b0; // power down
    assign pcspma_config_vector[1] = 1'b0; // loopback enable
    assign pcspma_config_vector[0] = 1'b0; // unidirectional enable

    wire [15:0] pcspma_an_config_vector;

    assign pcspma_an_config_vector[15]    = 1'b1;    // SGMII link status
    assign pcspma_an_config_vector[14]    = 1'b1;    // SGMII Acknowledge
    assign pcspma_an_config_vector[13:12] = 2'b01;   // full duplex
    assign pcspma_an_config_vector[11:10] = 2'b10;   // SGMII speed
    assign pcspma_an_config_vector[9]     = 1'b0;    // reserved
    assign pcspma_an_config_vector[8:7]   = 2'b00;   // pause frames - SGMII reserved
    assign pcspma_an_config_vector[6]     = 1'b0;    // reserved
    assign pcspma_an_config_vector[5]     = 1'b0;    // full duplex - SGMII reserved
    assign pcspma_an_config_vector[4:1]   = 4'b0000; // reserved
    assign pcspma_an_config_vector[0]     = 1'b1;    // SGMII

    gig_ethernet_pcs_pma_0
    eth_pcspma (
        // Transceiver Interface
        .gtrefclk_p            (phy_sgmii_clk_p),
        .gtrefclk_n            (phy_sgmii_clk_n),
        .gtrefclk_out          (),
        .gtrefclk_bufg_out     (),
        .txp                   (phy_sgmii_tx_p),
        .txn                   (phy_sgmii_tx_n),
        .rxp                   (phy_sgmii_rx_p),
        .rxn                   (phy_sgmii_rx_n),
        .resetdone             (phy_sgmii_resetdone),
        .userclk_out           (),
        .userclk2_out          (phy_sgmii_userclk2),
        .rxuserclk_out         (),
        .rxuserclk2_out        (),
        .independent_clock_bufg(clk_i),
        .pma_reset_out         (),
        .mmcm_locked_out       (),
        .gt0_qplloutclk_out    (),
        .gt0_qplloutrefclk_out (),
        // GMII Interface
        .sgmii_clk_r           (),
        .sgmii_clk_f           (),
        .sgmii_clk_en          (phy_gmii_clk_en_int),
        .gmii_txd              (phy_gmii_txd_int),
        .gmii_tx_en            (phy_gmii_tx_en_int),
        .gmii_tx_er            (phy_gmii_tx_er_int),
        .gmii_rxd              (phy_gmii_rxd_int),
        .gmii_rx_dv            (phy_gmii_rx_dv_int),
        .gmii_rx_er            (phy_gmii_rx_er_int),
        .gmii_isolate          (),
        // Management: Alternative to MDIO Interface
        .configuration_vector  (pcspma_config_vector),
        .an_interrupt          (),
        .an_adv_config_vector  (pcspma_an_config_vector),
        .an_restart_config     (1'b0),
        // Speed Control
        .speed_is_10_100       (pcspma_status_speed != 2'b10),
        .speed_is_100          (pcspma_status_speed == 2'b01),
        // General IO's
        .status_vector         (pcspma_status_vector),
        .reset                 (rst_i),
        .signal_detect         (1'b1)
    );

    assign phy_reset_n = !rst_i;

    eth_mac_1g_fifo #(
        .AXIS_DATA_WIDTH(WIDTH),
        .ENABLE_PADDING(1),
        .MIN_FRAME_LENGTH(WIDTH),
        .TX_FIFO_DEPTH(4096),
        .TX_FRAME_FIFO(1),
        .RX_FIFO_DEPTH(4096),
        .RX_FRAME_FIFO(1)
    )
    eth_mac_inst (
        .rx_clk(phy_gmii_clk_int),
        .rx_rst(phy_gmii_rst_int),
        .tx_clk(phy_gmii_clk_int),
        .tx_rst(phy_gmii_rst_int),
        .logic_clk(clk_i),
        .logic_rst(rst_i),

        .tx_axis_tdata(tx_axis_tdata),
        .tx_axis_tvalid(tx_axis_tvalid),
        .tx_axis_tready(tx_axis_tready),
        .tx_axis_tkeep(tx_axis_tkeep),
        .tx_axis_tlast(tx_axis_tlast),
        .tx_axis_tuser(tx_axis_tuser),

        .rx_axis_tdata(rx_axis_tdata),
        .rx_axis_tvalid(rx_axis_tvalid),
        .rx_axis_tready(rx_axis_tready),
        .rx_axis_tkeep(rx_axis_tkeep),
        .rx_axis_tlast(rx_axis_tlast),
        .rx_axis_tuser(rx_axis_tuser),

        .gmii_rxd(phy_gmii_rxd_int),
        .gmii_rx_dv(phy_gmii_rx_dv_int),
        .gmii_rx_er(phy_gmii_rx_er_int),
        .gmii_txd(phy_gmii_txd_int),
        .gmii_tx_en(phy_gmii_tx_en_int),
        .gmii_tx_er(phy_gmii_tx_er_int),

        .rx_clk_enable(phy_gmii_clk_en_int),
        .tx_clk_enable(phy_gmii_clk_en_int),
        .rx_mii_select(1'b0),
        .tx_mii_select(1'b0),

        .tx_fifo_overflow(),
        .tx_fifo_bad_frame(),
        .tx_fifo_good_frame(),
        .rx_error_bad_frame(),
        .rx_error_bad_fcs(),
        .rx_fifo_overflow(),
        .rx_fifo_bad_frame(),
        .rx_fifo_good_frame(),

        .ifg_delay(12)
    );

    // Latency measurement

    reg  [31:0]       ticks_counter;
    reg  [31:0]       rx_ticks_tmp;
    reg               rx_first_word;

    always @(posedge clk_i) begin
        if (rst_i)
            rx_first_word <= 1;
        else if (rx_axis_tvalid && rx_axis_tready)
            rx_first_word <= rx_axis_tlast;
    end


    always @(posedge clk_i) begin
        if (rst_i)
            ticks_valid <= 0;
        else if (read_ticks)
            ticks_valid <= 0;
        else if (tx_axis_tlast && tx_axis_tvalid && tx_axis_tready)
            ticks_valid <= 1;
    end

    always @(posedge clk_i) begin
        if (rst_i)
            ticks_counter <= 0;
        else 
            ticks_counter <= ticks_counter + 1;
    end

    always @(posedge clk_i) begin
        if (rst_i)
            rx_ticks_tmp <= 0;
        else if (rx_first_word && rx_axis_tvalid && rx_axis_tready)
            rx_ticks_tmp <= ticks_counter;
    end

    always @(posedge clk_i) begin
        if (rst_i)
            rx_ticks <= 0;
        else if (tx_axis_tlast && tx_axis_tvalid && tx_axis_tready)
            rx_ticks <= rx_ticks_tmp;
    end

    always @(posedge clk_i) begin
        if (rst_i)
            tx_ticks <= 0;
        else if (tx_axis_tlast && tx_axis_tvalid && tx_axis_tready)
            tx_ticks <= ticks_counter;
    end

endmodule