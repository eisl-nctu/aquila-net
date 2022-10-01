// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2019.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module tasi_metaLoader (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        appTxDataReqMetaData_V_TVALID,
        stateTable2txApp_rsp_1_dout,
        stateTable2txApp_rsp_1_empty_n,
        stateTable2txApp_rsp_1_read,
        txSar2txApp_upd_rsp_s_1_dout,
        txSar2txApp_upd_rsp_s_1_empty_n,
        txSar2txApp_upd_rsp_s_1_read,
        txApp2stateTable_req_1_din,
        txApp2stateTable_req_1_full_n,
        txApp2stateTable_req_1_write,
        txApp2txSar_upd_req_s_11_din,
        txApp2txSar_upd_req_s_11_full_n,
        txApp2txSar_upd_req_s_11_write,
        tasi_meta2pkgPushCmd_1_din,
        tasi_meta2pkgPushCmd_1_full_n,
        tasi_meta2pkgPushCmd_1_write,
        txAppStream2event_me_1_din,
        txAppStream2event_me_1_full_n,
        txAppStream2event_me_1_write,
        appTxDataRsp_V_TREADY,
        appTxDataReqMetaData_V_TDATA,
        appTxDataReqMetaData_V_TREADY,
        appTxDataRsp_V_TDATA,
        appTxDataRsp_V_TVALID
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input   appTxDataReqMetaData_V_TVALID;
input  [3:0] stateTable2txApp_rsp_1_dout;
input   stateTable2txApp_rsp_1_empty_n;
output   stateTable2txApp_rsp_1_read;
input  [63:0] txSar2txApp_upd_rsp_s_1_dout;
input   txSar2txApp_upd_rsp_s_1_empty_n;
output   txSar2txApp_upd_rsp_s_1_read;
output  [15:0] txApp2stateTable_req_1_din;
input   txApp2stateTable_req_1_full_n;
output   txApp2stateTable_req_1_write;
output  [32:0] txApp2txSar_upd_req_s_11_din;
input   txApp2txSar_upd_req_s_11_full_n;
output   txApp2txSar_upd_req_s_11_write;
output  [71:0] tasi_meta2pkgPushCmd_1_din;
input   tasi_meta2pkgPushCmd_1_full_n;
output   tasi_meta2pkgPushCmd_1_write;
output  [53:0] txAppStream2event_me_1_din;
input   txAppStream2event_me_1_full_n;
output   txAppStream2event_me_1_write;
input   appTxDataRsp_V_TREADY;
input  [31:0] appTxDataReqMetaData_V_TDATA;
output   appTxDataReqMetaData_V_TREADY;
output  [63:0] appTxDataRsp_V_TDATA;
output   appTxDataRsp_V_TVALID;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg stateTable2txApp_rsp_1_read;
reg txSar2txApp_upd_rsp_s_1_read;
reg txApp2stateTable_req_1_write;
reg[32:0] txApp2txSar_upd_req_s_11_din;
reg txApp2txSar_upd_req_s_11_write;
reg tasi_meta2pkgPushCmd_1_write;
reg txAppStream2event_me_1_write;
reg appTxDataReqMetaData_V_TREADY;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
reg    ap_idle_pp0;
wire   [0:0] tmp_68_nbreadreq_fu_118_p3;
reg    ap_predicate_op9_read_state1;
wire   [0:0] tmp_nbreadreq_fu_132_p3;
wire   [0:0] tmp_69_nbreadreq_fu_140_p3;
reg    ap_predicate_op17_read_state1;
reg    ap_predicate_op18_read_state1;
reg    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
reg   [0:0] tai_state_load_reg_431;
reg   [0:0] tai_state_load_reg_431_pp0_iter1_reg;
reg   [0:0] tmp_68_reg_435;
reg   [0:0] tmp_68_reg_435_pp0_iter1_reg;
reg    ap_predicate_op39_write_state3;
reg    ap_predicate_op41_write_state3;
reg   [0:0] tmp_reg_451;
reg   [0:0] tmp_reg_451_pp0_iter1_reg;
reg   [0:0] tmp_69_reg_455;
reg   [0:0] tmp_69_reg_455_pp0_iter1_reg;
reg   [0:0] icmp_ln86_reg_480;
reg   [0:0] icmp_ln86_reg_480_pp0_iter1_reg;
reg   [0:0] or_ln98_reg_505;
reg    ap_predicate_op48_write_state3;
reg    ap_predicate_op53_write_state3;
reg    ap_predicate_op56_write_state3;
reg    ap_block_state3_pp0_stage0_iter2;
wire    appTxDataRsp_V_1_ack_in;
reg    ap_predicate_op44_write_state3;
reg    ap_predicate_op51_write_state3;
reg    ap_predicate_op59_write_state3;
reg    ap_block_state3_io;
wire    appTxDataRsp_V_1_ack_out;
reg   [1:0] appTxDataRsp_V_1_state;
reg    ap_block_state4_pp0_stage0_iter3;
reg   [0:0] tai_state_load_reg_431_pp0_iter2_reg;
reg   [0:0] tmp_reg_451_pp0_iter2_reg;
reg   [0:0] tmp_69_reg_455_pp0_iter2_reg;
reg   [0:0] icmp_ln86_reg_480_pp0_iter2_reg;
reg    ap_predicate_op71_write_state4;
reg   [0:0] or_ln98_reg_505_pp0_iter2_reg;
reg    ap_predicate_op73_write_state4;
reg    ap_predicate_op75_write_state4;
reg    ap_block_state4_io;
reg    ap_block_pp0_stage0_11001;
reg   [63:0] appTxDataRsp_V_1_data_in;
reg   [63:0] appTxDataRsp_V_1_data_out;
reg    appTxDataRsp_V_1_vld_in;
wire    appTxDataRsp_V_1_vld_out;
reg   [63:0] appTxDataRsp_V_1_payload_A;
reg   [63:0] appTxDataRsp_V_1_payload_B;
reg    appTxDataRsp_V_1_sel_rd;
reg    appTxDataRsp_V_1_sel_wr;
wire    appTxDataRsp_V_1_sel;
wire    appTxDataRsp_V_1_load_A;
wire    appTxDataRsp_V_1_load_B;
wire    appTxDataRsp_V_1_state_cmp_full;
reg   [0:0] tai_state;
reg   [15:0] tasi_writeMeta_sessi;
reg   [15:0] tasi_writeMeta_lengt;
reg    appTxDataReqMetaData_V_TDATA_blk_n;
wire    ap_block_pp0_stage0;
reg    appTxDataRsp_V_TDATA_blk_n;
reg    txApp2stateTable_req_1_blk_n;
reg    txApp2txSar_upd_req_s_11_blk_n;
reg    txSar2txApp_upd_rsp_s_1_blk_n;
reg    stateTable2txApp_rsp_1_blk_n;
reg    tasi_meta2pkgPushCmd_1_blk_n;
reg    txAppStream2event_me_1_blk_n;
wire   [15:0] tmp_V_fu_199_p1;
reg   [15:0] tmp_V_reg_439;
reg   [15:0] tmp_V_reg_439_pp0_iter1_reg;
reg   [15:0] tmp_length_V_load_ne_reg_446;
reg   [15:0] tmp_ackd_V_load_new_s_reg_459;
reg   [15:0] tmp_address_V_reg_465;
reg   [15:0] tmp_address_V_reg_465_pp0_iter1_reg;
reg   [15:0] tmp_min_window_V_loa_reg_474;
wire   [0:0] icmp_ln86_fu_249_p2;
reg   [15:0] tmp_length_V_reg_484;
wire   [15:0] maxWriteLength_V_fu_274_p2;
reg   [15:0] maxWriteLength_V_reg_494;
wire   [15:0] usableWindow_V_1_fu_294_p3;
reg   [15:0] usableWindow_V_1_reg_500;
wire   [0:0] or_ln98_fu_314_p2;
wire   [63:0] tmp_3_fu_340_p5;
wire   [63:0] tmp_6_fu_376_p5;
wire   [63:0] tmp_4_fu_419_p5;
reg    ap_block_pp0_stage0_subdone;
reg    ap_block_pp0_stage0_01001;
wire   [32:0] tmp_1_fu_329_p3;
wire   [32:0] tmp_8_fu_405_p4;
wire   [15:0] sub_ln214_fu_270_p2;
wire   [15:0] usedLength_V_fu_280_p2;
wire   [0:0] icmp_ln895_fu_284_p2;
wire   [15:0] usableWindow_V_fu_289_p2;
wire   [0:0] icmp_ln895_2_fu_302_p2;
wire   [0:0] icmp_ln887_fu_308_p2;
wire   [29:0] tmp_remaining_space_s_fu_337_p1;
wire   [13:0] trunc_ln647_fu_352_p1;
wire   [22:0] tmp_bbt_V_fu_356_p1;
wire   [29:0] tmp_remaining_space_2_fu_373_p1;
wire   [15:0] tmp_mempt_V_fu_401_p2;
wire   [29:0] tmp_remaining_space_1_fu_416_p1;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to2;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_62;
reg    ap_condition_223;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
#0 appTxDataRsp_V_1_state = 2'd0;
#0 appTxDataRsp_V_1_sel_rd = 1'b0;
#0 appTxDataRsp_V_1_sel_wr = 1'b0;
#0 tai_state = 1'd0;
#0 tasi_writeMeta_sessi = 16'd0;
#0 tasi_writeMeta_lengt = 16'd0;
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter3 == 1'b1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter3 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        appTxDataRsp_V_1_sel_rd <= 1'b0;
    end else begin
        if (((appTxDataRsp_V_1_vld_out == 1'b1) & (appTxDataRsp_V_1_ack_out == 1'b1))) begin
            appTxDataRsp_V_1_sel_rd <= ~appTxDataRsp_V_1_sel_rd;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        appTxDataRsp_V_1_sel_wr <= 1'b0;
    end else begin
        if (((appTxDataRsp_V_1_vld_in == 1'b1) & (appTxDataRsp_V_1_ack_in == 1'b1))) begin
            appTxDataRsp_V_1_sel_wr <= ~appTxDataRsp_V_1_sel_wr;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        appTxDataRsp_V_1_state <= 2'd0;
    end else begin
        if ((((appTxDataRsp_V_1_vld_in == 1'b0) & (appTxDataRsp_V_1_ack_out == 1'b1) & (appTxDataRsp_V_1_state == 2'd3)) | ((appTxDataRsp_V_1_vld_in == 1'b0) & (appTxDataRsp_V_1_state == 2'd2)))) begin
            appTxDataRsp_V_1_state <= 2'd2;
        end else if ((((appTxDataRsp_V_TREADY == 1'b0) & (appTxDataRsp_V_1_state == 2'd1)) | ((appTxDataRsp_V_TREADY == 1'b0) & (appTxDataRsp_V_1_vld_in == 1'b1) & (appTxDataRsp_V_1_state == 2'd3)))) begin
            appTxDataRsp_V_1_state <= 2'd1;
        end else if ((((appTxDataRsp_V_1_ack_out == 1'b1) & (appTxDataRsp_V_1_state == 2'd1)) | (~((appTxDataRsp_V_1_vld_in == 1'b0) & (appTxDataRsp_V_1_ack_out == 1'b1)) & ~((appTxDataRsp_V_TREADY == 1'b0) & (appTxDataRsp_V_1_vld_in == 1'b1)) & (appTxDataRsp_V_1_state == 2'd3)) | ((appTxDataRsp_V_1_vld_in == 1'b1) & (appTxDataRsp_V_1_state == 2'd2)))) begin
            appTxDataRsp_V_1_state <= 2'd3;
        end else begin
            appTxDataRsp_V_1_state <= 2'd2;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_223)) begin
        if ((1'b1 == ap_condition_62)) begin
            tai_state <= 1'd0;
        end else if (((tmp_68_nbreadreq_fu_118_p3 == 1'd1) & (tai_state == 1'd0))) begin
            tai_state <= 1'd1;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((appTxDataRsp_V_1_load_A == 1'b1)) begin
        appTxDataRsp_V_1_payload_A <= appTxDataRsp_V_1_data_in;
    end
end

always @ (posedge ap_clk) begin
    if ((appTxDataRsp_V_1_load_B == 1'b1)) begin
        appTxDataRsp_V_1_payload_B <= appTxDataRsp_V_1_data_in;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_69_nbreadreq_fu_140_p3 == 1'd1) & (tmp_nbreadreq_fu_132_p3 == 1'd1) & (tai_state == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln86_reg_480 <= icmp_ln86_fu_249_p2;
        tmp_ackd_V_load_new_s_reg_459 <= {{txSar2txApp_upd_rsp_s_1_dout[31:16]}};
        tmp_address_V_reg_465 <= {{txSar2txApp_upd_rsp_s_1_dout[47:32]}};
        tmp_min_window_V_loa_reg_474 <= {{txSar2txApp_upd_rsp_s_1_dout[63:48]}};
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln86_reg_480_pp0_iter1_reg <= icmp_ln86_reg_480;
        tai_state_load_reg_431 <= tai_state;
        tai_state_load_reg_431_pp0_iter1_reg <= tai_state_load_reg_431;
        tmp_68_reg_435_pp0_iter1_reg <= tmp_68_reg_435;
        tmp_69_reg_455_pp0_iter1_reg <= tmp_69_reg_455;
        tmp_V_reg_439_pp0_iter1_reg <= tmp_V_reg_439;
        tmp_address_V_reg_465_pp0_iter1_reg <= tmp_address_V_reg_465;
        tmp_length_V_reg_484 <= tasi_writeMeta_lengt;
        tmp_reg_451_pp0_iter1_reg <= tmp_reg_451;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        icmp_ln86_reg_480_pp0_iter2_reg <= icmp_ln86_reg_480_pp0_iter1_reg;
        or_ln98_reg_505_pp0_iter2_reg <= or_ln98_reg_505;
        tai_state_load_reg_431_pp0_iter2_reg <= tai_state_load_reg_431_pp0_iter1_reg;
        tmp_69_reg_455_pp0_iter2_reg <= tmp_69_reg_455_pp0_iter1_reg;
        tmp_reg_451_pp0_iter2_reg <= tmp_reg_451_pp0_iter1_reg;
    end
end

always @ (posedge ap_clk) begin
    if (((tai_state_load_reg_431 == 1'd1) & (tmp_69_reg_455 == 1'd1) & (tmp_reg_451 == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        maxWriteLength_V_reg_494 <= maxWriteLength_V_fu_274_p2;
        usableWindow_V_1_reg_500 <= usableWindow_V_1_fu_294_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((tai_state_load_reg_431 == 1'd1) & (icmp_ln86_reg_480 == 1'd1) & (tmp_69_reg_455 == 1'd1) & (tmp_reg_451 == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        or_ln98_reg_505 <= or_ln98_fu_314_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_68_reg_435 == 1'd1) & (tai_state_load_reg_431 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tasi_writeMeta_lengt <= tmp_length_V_load_ne_reg_446;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_68_reg_435_pp0_iter1_reg == 1'd1) & (tai_state_load_reg_431_pp0_iter1_reg == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        tasi_writeMeta_sessi <= tmp_V_reg_439_pp0_iter1_reg;
    end
end

always @ (posedge ap_clk) begin
    if (((tai_state == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_68_reg_435 <= tmp_68_nbreadreq_fu_118_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_nbreadreq_fu_132_p3 == 1'd1) & (tai_state == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_69_reg_455 <= tmp_69_nbreadreq_fu_140_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_68_nbreadreq_fu_118_p3 == 1'd1) & (tai_state == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_V_reg_439 <= tmp_V_fu_199_p1;
        tmp_length_V_load_ne_reg_446 <= {{appTxDataReqMetaData_V_TDATA[31:16]}};
    end
end

always @ (posedge ap_clk) begin
    if (((tai_state == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_reg_451 <= tmp_nbreadreq_fu_132_p3;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter3 == 1'b1))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0_0to2 = 1'b1;
    end else begin
        ap_idle_pp0_0to2 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (ap_idle_pp0_0to2 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op9_read_state1 == 1'b1))) begin
        appTxDataReqMetaData_V_TDATA_blk_n = appTxDataReqMetaData_V_TVALID;
    end else begin
        appTxDataReqMetaData_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op9_read_state1 == 1'b1))) begin
        appTxDataReqMetaData_V_TREADY = 1'b1;
    end else begin
        appTxDataReqMetaData_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_01001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        if ((ap_predicate_op59_write_state3 == 1'b1)) begin
            appTxDataRsp_V_1_data_in = tmp_4_fu_419_p5;
        end else if ((ap_predicate_op51_write_state3 == 1'b1)) begin
            appTxDataRsp_V_1_data_in = tmp_6_fu_376_p5;
        end else if ((ap_predicate_op44_write_state3 == 1'b1)) begin
            appTxDataRsp_V_1_data_in = tmp_3_fu_340_p5;
        end else begin
            appTxDataRsp_V_1_data_in = 'bx;
        end
    end else begin
        appTxDataRsp_V_1_data_in = 'bx;
    end
end

always @ (*) begin
    if ((appTxDataRsp_V_1_sel == 1'b1)) begin
        appTxDataRsp_V_1_data_out = appTxDataRsp_V_1_payload_B;
    end else begin
        appTxDataRsp_V_1_data_out = appTxDataRsp_V_1_payload_A;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op59_write_state3 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op51_write_state3 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op44_write_state3 == 1'b1)))) begin
        appTxDataRsp_V_1_vld_in = 1'b1;
    end else begin
        appTxDataRsp_V_1_vld_in = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter3 == 1'b1) & (ap_predicate_op75_write_state4 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter3 == 1'b1) & (ap_predicate_op73_write_state4 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter3 == 1'b1) & (ap_predicate_op71_write_state4 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op59_write_state3 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op51_write_state3 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op44_write_state3 == 1'b1)))) begin
        appTxDataRsp_V_TDATA_blk_n = appTxDataRsp_V_1_state[1'd1];
    end else begin
        appTxDataRsp_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op17_read_state1 == 1'b1))) begin
        stateTable2txApp_rsp_1_blk_n = stateTable2txApp_rsp_1_empty_n;
    end else begin
        stateTable2txApp_rsp_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op17_read_state1 == 1'b1))) begin
        stateTable2txApp_rsp_1_read = 1'b1;
    end else begin
        stateTable2txApp_rsp_1_read = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op48_write_state3 == 1'b1))) begin
        tasi_meta2pkgPushCmd_1_blk_n = tasi_meta2pkgPushCmd_1_full_n;
    end else begin
        tasi_meta2pkgPushCmd_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op48_write_state3 == 1'b1))) begin
        tasi_meta2pkgPushCmd_1_write = 1'b1;
    end else begin
        tasi_meta2pkgPushCmd_1_write = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op39_write_state3 == 1'b1))) begin
        txApp2stateTable_req_1_blk_n = txApp2stateTable_req_1_full_n;
    end else begin
        txApp2stateTable_req_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op39_write_state3 == 1'b1))) begin
        txApp2stateTable_req_1_write = 1'b1;
    end else begin
        txApp2stateTable_req_1_write = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op56_write_state3 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op41_write_state3 == 1'b1)))) begin
        txApp2txSar_upd_req_s_11_blk_n = txApp2txSar_upd_req_s_11_full_n;
    end else begin
        txApp2txSar_upd_req_s_11_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_01001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        if ((ap_predicate_op56_write_state3 == 1'b1)) begin
            txApp2txSar_upd_req_s_11_din = tmp_8_fu_405_p4;
        end else if ((ap_predicate_op41_write_state3 == 1'b1)) begin
            txApp2txSar_upd_req_s_11_din = tmp_1_fu_329_p3;
        end else begin
            txApp2txSar_upd_req_s_11_din = 'bx;
        end
    end else begin
        txApp2txSar_upd_req_s_11_din = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op56_write_state3 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op41_write_state3 == 1'b1)))) begin
        txApp2txSar_upd_req_s_11_write = 1'b1;
    end else begin
        txApp2txSar_upd_req_s_11_write = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op53_write_state3 == 1'b1))) begin
        txAppStream2event_me_1_blk_n = txAppStream2event_me_1_full_n;
    end else begin
        txAppStream2event_me_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op53_write_state3 == 1'b1))) begin
        txAppStream2event_me_1_write = 1'b1;
    end else begin
        txAppStream2event_me_1_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op18_read_state1 == 1'b1))) begin
        txSar2txApp_upd_rsp_s_1_blk_n = txSar2txApp_upd_rsp_s_1_empty_n;
    end else begin
        txSar2txApp_upd_rsp_s_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op18_read_state1 == 1'b1))) begin
        txSar2txApp_upd_rsp_s_1_read = 1'b1;
    end else begin
        txSar2txApp_upd_rsp_s_1_read = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txSar2txApp_upd_rsp_s_1_empty_n == 1'b0) & (ap_predicate_op18_read_state1 == 1'b1)) | ((stateTable2txApp_rsp_1_empty_n == 1'b0) & (ap_predicate_op17_read_state1 == 1'b1)) | ((appTxDataReqMetaData_V_TVALID == 1'b0) & (ap_predicate_op9_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter3 == 1'b1) & ((appTxDataRsp_V_1_state == 2'd1) | ((appTxDataRsp_V_TREADY == 1'b0) & (appTxDataRsp_V_1_state == 2'd3)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & (((txApp2stateTable_req_1_full_n == 1'b0) & (ap_predicate_op39_write_state3 == 1'b1)) | ((txAppStream2event_me_1_full_n == 1'b0) & (ap_predicate_op53_write_state3 == 1'b1)) | ((tasi_meta2pkgPushCmd_1_full_n == 1'b0) & (ap_predicate_op48_write_state3 == 1'b1)) | ((txApp2txSar_upd_req_s_11_full_n == 1'b0) & (ap_predicate_op56_write_state3 == 1'b1)) | ((txApp2txSar_upd_req_s_11_full_n == 1'b0) & (ap_predicate_op41_write_state3 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txSar2txApp_upd_rsp_s_1_empty_n == 1'b0) & (ap_predicate_op18_read_state1 == 1'b1)) | ((stateTable2txApp_rsp_1_empty_n == 1'b0) & (ap_predicate_op17_read_state1 == 1'b1)) | ((appTxDataReqMetaData_V_TVALID == 1'b0) & (ap_predicate_op9_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter3 == 1'b1) & ((1'b1 == ap_block_state4_io) | (appTxDataRsp_V_1_state == 2'd1) | ((appTxDataRsp_V_TREADY == 1'b0) & (appTxDataRsp_V_1_state == 2'd3)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((1'b1 == ap_block_state3_io) | ((txApp2stateTable_req_1_full_n == 1'b0) & (ap_predicate_op39_write_state3 == 1'b1)) | ((txAppStream2event_me_1_full_n == 1'b0) & (ap_predicate_op53_write_state3 == 1'b1)) | ((tasi_meta2pkgPushCmd_1_full_n == 1'b0) & (ap_predicate_op48_write_state3 == 1'b1)) | ((txApp2txSar_upd_req_s_11_full_n == 1'b0) & (ap_predicate_op56_write_state3 == 1'b1)) | ((txApp2txSar_upd_req_s_11_full_n == 1'b0) & (ap_predicate_op41_write_state3 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txSar2txApp_upd_rsp_s_1_empty_n == 1'b0) & (ap_predicate_op18_read_state1 == 1'b1)) | ((stateTable2txApp_rsp_1_empty_n == 1'b0) & (ap_predicate_op17_read_state1 == 1'b1)) | ((appTxDataReqMetaData_V_TVALID == 1'b0) & (ap_predicate_op9_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter3 == 1'b1) & ((1'b1 == ap_block_state4_io) | (appTxDataRsp_V_1_state == 2'd1) | ((appTxDataRsp_V_TREADY == 1'b0) & (appTxDataRsp_V_1_state == 2'd3)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((1'b1 == ap_block_state3_io) | ((txApp2stateTable_req_1_full_n == 1'b0) & (ap_predicate_op39_write_state3 == 1'b1)) | ((txAppStream2event_me_1_full_n == 1'b0) & (ap_predicate_op53_write_state3 == 1'b1)) | ((tasi_meta2pkgPushCmd_1_full_n == 1'b0) & (ap_predicate_op48_write_state3 == 1'b1)) | ((txApp2txSar_upd_req_s_11_full_n == 1'b0) & (ap_predicate_op56_write_state3 == 1'b1)) | ((txApp2txSar_upd_req_s_11_full_n == 1'b0) & (ap_predicate_op41_write_state3 == 1'b1)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txSar2txApp_upd_rsp_s_1_empty_n == 1'b0) & (ap_predicate_op18_read_state1 == 1'b1)) | ((stateTable2txApp_rsp_1_empty_n == 1'b0) & (ap_predicate_op17_read_state1 == 1'b1)) | ((appTxDataReqMetaData_V_TVALID == 1'b0) & (ap_predicate_op9_read_state1 == 1'b1)));
end

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state3_io = (((appTxDataRsp_V_1_ack_in == 1'b0) & (ap_predicate_op59_write_state3 == 1'b1)) | ((appTxDataRsp_V_1_ack_in == 1'b0) & (ap_predicate_op51_write_state3 == 1'b1)) | ((appTxDataRsp_V_1_ack_in == 1'b0) & (ap_predicate_op44_write_state3 == 1'b1)));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = (((txApp2stateTable_req_1_full_n == 1'b0) & (ap_predicate_op39_write_state3 == 1'b1)) | ((txAppStream2event_me_1_full_n == 1'b0) & (ap_predicate_op53_write_state3 == 1'b1)) | ((tasi_meta2pkgPushCmd_1_full_n == 1'b0) & (ap_predicate_op48_write_state3 == 1'b1)) | ((txApp2txSar_upd_req_s_11_full_n == 1'b0) & (ap_predicate_op56_write_state3 == 1'b1)) | ((txApp2txSar_upd_req_s_11_full_n == 1'b0) & (ap_predicate_op41_write_state3 == 1'b1)));
end

always @ (*) begin
    ap_block_state4_io = (((appTxDataRsp_V_1_ack_in == 1'b0) & (ap_predicate_op75_write_state4 == 1'b1)) | ((appTxDataRsp_V_1_ack_in == 1'b0) & (ap_predicate_op73_write_state4 == 1'b1)) | ((appTxDataRsp_V_1_ack_in == 1'b0) & (ap_predicate_op71_write_state4 == 1'b1)));
end

always @ (*) begin
    ap_block_state4_pp0_stage0_iter3 = ((appTxDataRsp_V_1_state == 2'd1) | ((appTxDataRsp_V_TREADY == 1'b0) & (appTxDataRsp_V_1_state == 2'd3)));
end

always @ (*) begin
    ap_condition_223 = ((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_condition_62 = ((tmp_69_nbreadreq_fu_140_p3 == 1'd1) & (tmp_nbreadreq_fu_132_p3 == 1'd1) & (tai_state == 1'd1));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

always @ (*) begin
    ap_predicate_op17_read_state1 = ((tmp_69_nbreadreq_fu_140_p3 == 1'd1) & (tmp_nbreadreq_fu_132_p3 == 1'd1) & (tai_state == 1'd1));
end

always @ (*) begin
    ap_predicate_op18_read_state1 = ((tmp_69_nbreadreq_fu_140_p3 == 1'd1) & (tmp_nbreadreq_fu_132_p3 == 1'd1) & (tai_state == 1'd1));
end

always @ (*) begin
    ap_predicate_op39_write_state3 = ((tmp_68_reg_435_pp0_iter1_reg == 1'd1) & (tai_state_load_reg_431_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op41_write_state3 = ((tmp_68_reg_435_pp0_iter1_reg == 1'd1) & (tai_state_load_reg_431_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op44_write_state3 = ((tai_state_load_reg_431_pp0_iter1_reg == 1'd1) & (tmp_69_reg_455_pp0_iter1_reg == 1'd1) & (tmp_reg_451_pp0_iter1_reg == 1'd1) & (icmp_ln86_reg_480_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op48_write_state3 = ((tai_state_load_reg_431_pp0_iter1_reg == 1'd1) & (icmp_ln86_reg_480_pp0_iter1_reg == 1'd1) & (tmp_69_reg_455_pp0_iter1_reg == 1'd1) & (tmp_reg_451_pp0_iter1_reg == 1'd1) & (or_ln98_reg_505 == 1'd0));
end

always @ (*) begin
    ap_predicate_op51_write_state3 = ((tai_state_load_reg_431_pp0_iter1_reg == 1'd1) & (icmp_ln86_reg_480_pp0_iter1_reg == 1'd1) & (tmp_69_reg_455_pp0_iter1_reg == 1'd1) & (tmp_reg_451_pp0_iter1_reg == 1'd1) & (or_ln98_reg_505 == 1'd0));
end

always @ (*) begin
    ap_predicate_op53_write_state3 = ((tai_state_load_reg_431_pp0_iter1_reg == 1'd1) & (icmp_ln86_reg_480_pp0_iter1_reg == 1'd1) & (tmp_69_reg_455_pp0_iter1_reg == 1'd1) & (tmp_reg_451_pp0_iter1_reg == 1'd1) & (or_ln98_reg_505 == 1'd0));
end

always @ (*) begin
    ap_predicate_op56_write_state3 = ((tai_state_load_reg_431_pp0_iter1_reg == 1'd1) & (icmp_ln86_reg_480_pp0_iter1_reg == 1'd1) & (tmp_69_reg_455_pp0_iter1_reg == 1'd1) & (tmp_reg_451_pp0_iter1_reg == 1'd1) & (or_ln98_reg_505 == 1'd0));
end

always @ (*) begin
    ap_predicate_op59_write_state3 = ((tai_state_load_reg_431_pp0_iter1_reg == 1'd1) & (or_ln98_reg_505 == 1'd1) & (icmp_ln86_reg_480_pp0_iter1_reg == 1'd1) & (tmp_69_reg_455_pp0_iter1_reg == 1'd1) & (tmp_reg_451_pp0_iter1_reg == 1'd1));
end

always @ (*) begin
    ap_predicate_op71_write_state4 = ((tmp_69_reg_455_pp0_iter2_reg == 1'd1) & (tmp_reg_451_pp0_iter2_reg == 1'd1) & (tai_state_load_reg_431_pp0_iter2_reg == 1'd1) & (icmp_ln86_reg_480_pp0_iter2_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op73_write_state4 = ((icmp_ln86_reg_480_pp0_iter2_reg == 1'd1) & (tmp_69_reg_455_pp0_iter2_reg == 1'd1) & (tmp_reg_451_pp0_iter2_reg == 1'd1) & (tai_state_load_reg_431_pp0_iter2_reg == 1'd1) & (or_ln98_reg_505_pp0_iter2_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op75_write_state4 = ((or_ln98_reg_505_pp0_iter2_reg == 1'd1) & (icmp_ln86_reg_480_pp0_iter2_reg == 1'd1) & (tmp_69_reg_455_pp0_iter2_reg == 1'd1) & (tmp_reg_451_pp0_iter2_reg == 1'd1) & (tai_state_load_reg_431_pp0_iter2_reg == 1'd1));
end

always @ (*) begin
    ap_predicate_op9_read_state1 = ((tmp_68_nbreadreq_fu_118_p3 == 1'd1) & (tai_state == 1'd0));
end

assign appTxDataRsp_V_1_ack_in = appTxDataRsp_V_1_state[1'd1];

assign appTxDataRsp_V_1_ack_out = appTxDataRsp_V_TREADY;

assign appTxDataRsp_V_1_load_A = (~appTxDataRsp_V_1_sel_wr & appTxDataRsp_V_1_state_cmp_full);

assign appTxDataRsp_V_1_load_B = (appTxDataRsp_V_1_state_cmp_full & appTxDataRsp_V_1_sel_wr);

assign appTxDataRsp_V_1_sel = appTxDataRsp_V_1_sel_rd;

assign appTxDataRsp_V_1_state_cmp_full = ((appTxDataRsp_V_1_state != 2'd1) ? 1'b1 : 1'b0);

assign appTxDataRsp_V_1_vld_out = appTxDataRsp_V_1_state[1'd0];

assign appTxDataRsp_V_TDATA = appTxDataRsp_V_1_data_out;

assign appTxDataRsp_V_TVALID = appTxDataRsp_V_1_state[1'd0];

assign icmp_ln86_fu_249_p2 = ((stateTable2txApp_rsp_1_dout == 4'd3) ? 1'b1 : 1'b0);

assign icmp_ln887_fu_308_p2 = ((usableWindow_V_1_fu_294_p3 < tasi_writeMeta_lengt) ? 1'b1 : 1'b0);

assign icmp_ln895_2_fu_302_p2 = ((tasi_writeMeta_lengt > maxWriteLength_V_fu_274_p2) ? 1'b1 : 1'b0);

assign icmp_ln895_fu_284_p2 = ((tmp_min_window_V_loa_reg_474 > usedLength_V_fu_280_p2) ? 1'b1 : 1'b0);

assign maxWriteLength_V_fu_274_p2 = ($signed(sub_ln214_fu_270_p2) + $signed(16'd65535));

assign or_ln98_fu_314_p2 = (icmp_ln895_2_fu_302_p2 | icmp_ln887_fu_308_p2);

assign sub_ln214_fu_270_p2 = (tmp_ackd_V_load_new_s_reg_459 - tmp_address_V_reg_465);

assign tasi_meta2pkgPushCmd_1_din = {{{{{{{{10'd1}, {trunc_ln647_fu_352_p1}}}, {tmp_address_V_reg_465_pp0_iter1_reg}}}, {9'd385}}}, {tmp_bbt_V_fu_356_p1}};

assign tmp_1_fu_329_p3 = {{17'd0}, {tmp_V_reg_439_pp0_iter1_reg}};

assign tmp_3_fu_340_p5 = {{{{{{2'd1}, {tmp_remaining_space_s_fu_337_p1}}}, {tmp_length_V_reg_484}}}, {tasi_writeMeta_sessi}};

assign tmp_4_fu_419_p5 = {{{{{{2'd2}, {tmp_remaining_space_1_fu_416_p1}}}, {tmp_length_V_reg_484}}}, {tasi_writeMeta_sessi}};

assign tmp_68_nbreadreq_fu_118_p3 = appTxDataReqMetaData_V_TVALID;

assign tmp_69_nbreadreq_fu_140_p3 = stateTable2txApp_rsp_1_empty_n;

assign tmp_6_fu_376_p5 = {{{{{{2'd0}, {tmp_remaining_space_2_fu_373_p1}}}, {tmp_length_V_reg_484}}}, {tasi_writeMeta_sessi}};

assign tmp_8_fu_405_p4 = {{{{1'd1}, {tmp_mempt_V_fu_401_p2}}}, {tasi_writeMeta_sessi}};

assign tmp_V_fu_199_p1 = appTxDataReqMetaData_V_TDATA[15:0];

assign tmp_bbt_V_fu_356_p1 = tmp_length_V_reg_484;

assign tmp_mempt_V_fu_401_p2 = (tmp_address_V_reg_465_pp0_iter1_reg + tmp_length_V_reg_484);

assign tmp_nbreadreq_fu_132_p3 = txSar2txApp_upd_rsp_s_1_empty_n;

assign tmp_remaining_space_1_fu_416_p1 = usableWindow_V_1_reg_500;

assign tmp_remaining_space_2_fu_373_p1 = maxWriteLength_V_reg_494;

assign tmp_remaining_space_s_fu_337_p1 = maxWriteLength_V_reg_494;

assign trunc_ln647_fu_352_p1 = tasi_writeMeta_sessi[13:0];

assign txApp2stateTable_req_1_din = tmp_V_reg_439_pp0_iter1_reg;

assign txAppStream2event_me_1_din = {{{{{{{{3'd0}, {tmp_length_V_reg_484}}}, {tmp_address_V_reg_465_pp0_iter1_reg}}}, {tasi_writeMeta_sessi}}}, {3'd0}};

assign usableWindow_V_1_fu_294_p3 = ((icmp_ln895_fu_284_p2[0:0] === 1'b1) ? usableWindow_V_fu_289_p2 : 16'd0);

assign usableWindow_V_fu_289_p2 = (tmp_min_window_V_loa_reg_474 - usedLength_V_fu_280_p2);

assign usedLength_V_fu_280_p2 = (tmp_address_V_reg_465 - tmp_ackd_V_load_new_s_reg_459);

endmodule //tasi_metaLoader