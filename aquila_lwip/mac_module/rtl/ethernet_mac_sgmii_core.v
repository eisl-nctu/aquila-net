module ethernet_mac_sgmii_core (

    // System clock & reset
    input  wire                       clk,
    input  wire                       rst,

    // 125MHz clock (for SGMII)
    input  wire                       clk_125,

    // Ethernet: 1000BASE-T SGMII
    input  wire                       phy_sgmii_rx_p,
    input  wire                       phy_sgmii_rx_n,
    output wire                       phy_sgmii_tx_p,
    output wire                       phy_sgmii_tx_n,
    input  wire                       phy_sgmii_clk_p,
    input  wire                       phy_sgmii_clk_n,
    output wire                       phy_reset_n,
    input  wire                       phy_int_n,

    // Ethernet status output
    output wire                       phy_sgmii_resetdone,

    // User interface
    (* mark_debug = "True" *) input  wire                       strobe_i,
    (* mark_debug = "True" *) input  wire [31 : 0]              addr_i,
    (* mark_debug = "True" *) input  wire                       we_i,
    (* mark_debug = "True" *) input  wire [31 : 0]              data_i,
    (* mark_debug = "True" *) output reg                        done_o,
    (* mark_debug = "True" *) output reg  [31 : 0]              data_o

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

    assign phy_gmii_clk_int = phy_sgmii_userclk2;    

    sync_reset #(
        .N(4)
    )
    sync_reset_pcspma_inst (
        .clk(phy_gmii_clk_int),
        .rst(rst || !phy_sgmii_resetdone),
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


    // Read address
    localparam RX_DATA_ADDR     = 8'h00,
               RX_KEEP_ADDR     = 8'h04,
               RX_VALID_ADDR    = 8'h08,
               RX_LAST_ADDR     = 8'h0C,
               TX_READY_ADDR    = 8'h10,
               RST_DONE_ADDR    = 8'h14,
               TICKS_VALID_ADDR = 8'h18,
               RX_TICKS_ADDR    = 8'h1C,
               TX_TICKS_ADDR    = 8'h20;

    // Write address
    localparam TX_DATA_ADDR     = 8'h00,
               TX_KEEP_ADDR     = 8'h04,
               TX_LAST_ADDR     = 8'h08;

    wire              eth_tx_ready;
    reg               eth_tx_last;
    reg  [ 3 : 0]     eth_tx_keep;
    wire              eth_tx_valid;

    wire              eth_rx_ready;
    wire [31 : 0]     eth_rx_data;
    wire [ 3 : 0]     eth_rx_keep;
    wire              eth_rx_valid;
    wire              eth_rx_last;

    wire              eth_read_tx_ticks_flag;
    reg               done_tap;

    reg  [31 : 0]     ticks_counter;
    reg  [31 : 0]     tx_ticks;
    reg  [31 : 0]     rx_ticks;
    reg  [31 : 0]     rx_ticks_tmp;
    reg               ticks_valid;
    reg               rx_first_word;

    // -----------------------
    //  Read Channel
    // -----------------------
    // Ready raise while tx_data been written
    assign eth_rx_ready = strobe_i && ~we_i && (addr_i[7:0] == RX_DATA_ADDR);

    always @(posedge clk) begin
        if (rst) begin
            data_o <= 0;
        end else if (strobe_i && ~we_i) begin
            case (addr_i[7:0])
                RX_DATA_ADDR     : data_o <= eth_rx_data;
                RX_KEEP_ADDR     : data_o <= eth_rx_keep;
                RX_VALID_ADDR    : data_o <= eth_rx_valid;
                RX_LAST_ADDR     : data_o <= eth_rx_last;
                TX_READY_ADDR    : data_o <= eth_tx_ready;
                RST_DONE_ADDR    : data_o <= phy_sgmii_resetdone;
                TICKS_VALID_ADDR : data_o <= ticks_valid;
                RX_TICKS_ADDR    : data_o <= rx_ticks;
                TX_TICKS_ADDR    : data_o <= tx_ticks;
                default: data_o <= 0; 
            endcase
        end
    end

    always @(posedge clk) begin
        if (rst)
            done_tap <= 0;
        else if (strobe_i)
            done_tap <= 1;
        else
            done_tap <= 0;
    end

    always @(posedge clk) begin
        done_o <= done_tap;
    end

    // -----------------------
    //  Write Channel
    // -----------------------
    // Ready raise while rx_data been readed
    assign eth_tx_valid = strobe_i && we_i && (addr_i[7:0] == TX_DATA_ADDR);

    always @(posedge clk) begin
        if (rst)
            eth_tx_last <= 0;
        else if (strobe_i && we_i && (addr_i[7:0] == TX_LAST_ADDR))
            eth_tx_last <= data_i[0];
    end

    always @(posedge clk) begin
        if (rst)
            eth_tx_keep <= 0;
        else if (strobe_i && we_i && (addr_i[7:0] == TX_KEEP_ADDR))
            eth_tx_keep <= data_i[3:0];
    end

    //---------------------------------------------------------------

    assign phy_reset_n = !rst;

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
        .independent_clock_bufg(clk_125),
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
        .reset                 (rst),
        .signal_detect         (1'b1)
    );

    eth_mac_1g_fifo #(
        .AXIS_DATA_WIDTH(32),
        .ENABLE_PADDING(1),
        .MIN_FRAME_LENGTH(64),
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
        .logic_clk(clk),
        .logic_rst(rst),

        .tx_axis_tdata(data_i),
        .tx_axis_tkeep(eth_tx_keep),
        .tx_axis_tvalid(eth_tx_valid),
        .tx_axis_tready(eth_tx_ready),
        .tx_axis_tlast(eth_tx_last),
        .tx_axis_tuser(1'b0),

        .rx_axis_tdata(eth_rx_data),
        .rx_axis_tkeep(eth_rx_keep),
        .rx_axis_tvalid(eth_rx_valid),
        .rx_axis_tready(eth_rx_ready),
        .rx_axis_tlast(eth_rx_last),
        .rx_axis_tuser(),

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

    assign eth_read_tx_ticks_flag = strobe_i && ~we_i && (addr_i[7:0] == TX_TICKS_ADDR);

    always @(posedge clk) begin
        if (rst)
            rx_first_word <= 1;
        else if (eth_rx_valid && eth_rx_ready)
            rx_first_word <= eth_rx_last;
    end


    always @(posedge clk) begin
        if (rst)
            ticks_valid <= 0;
        else if (eth_read_tx_ticks_flag)
            ticks_valid <= 0;
        else if (eth_tx_last && eth_tx_valid && eth_tx_ready)
            ticks_valid <= 1;
    end

    always @(posedge clk) begin
        if (rst)
            ticks_counter <= 0;
        else 
            ticks_counter <= ticks_counter + 1;
    end

    always @(posedge clk) begin
        if (rst)
            rx_ticks_tmp <= 0;
        else if (rx_first_word && eth_rx_valid && eth_rx_ready)
            rx_ticks_tmp <= ticks_counter;
    end

    always @(posedge clk) begin
        if (rst)
            rx_ticks <= 0;
        else if (eth_tx_last && eth_tx_valid && eth_tx_ready)
            rx_ticks <= rx_ticks_tmp;
    end

    always @(posedge clk) begin
        if (rst)
            tx_ticks <= 0;
        else if (eth_tx_last && eth_tx_valid && eth_tx_ready)
            tx_ticks <= ticks_counter;
    end


endmodule