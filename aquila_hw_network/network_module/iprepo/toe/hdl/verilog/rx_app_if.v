// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2019.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module rx_app_if (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        appListenPortReq_V_V_TVALID,
        portTable2rxApp_list_1_dout,
        portTable2rxApp_list_1_empty_n,
        portTable2rxApp_list_1_read,
        rxApp2portTable_list_1_din,
        rxApp2portTable_list_1_full_n,
        rxApp2portTable_list_1_write,
        appListenPortRsp_V_TREADY,
        appListenPortReq_V_V_TDATA,
        appListenPortReq_V_V_TREADY,
        appListenPortRsp_V_TDATA,
        appListenPortRsp_V_TVALID
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input   appListenPortReq_V_V_TVALID;
input  [0:0] portTable2rxApp_list_1_dout;
input   portTable2rxApp_list_1_empty_n;
output   portTable2rxApp_list_1_read;
output  [15:0] rxApp2portTable_list_1_din;
input   rxApp2portTable_list_1_full_n;
output   rxApp2portTable_list_1_write;
input   appListenPortRsp_V_TREADY;
input  [15:0] appListenPortReq_V_V_TDATA;
output   appListenPortReq_V_V_TREADY;
output  [7:0] appListenPortRsp_V_TDATA;
output   appListenPortRsp_V_TVALID;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg portTable2rxApp_list_1_read;
reg rxApp2portTable_list_1_write;
reg appListenPortReq_V_V_TREADY;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire   [0:0] or_ln63_fu_104_p2;
wire   [0:0] and_ln71_fu_116_p2;
reg    ap_predicate_op14_read_state1;
reg    ap_block_state1_pp0_stage0_iter0;
reg   [0:0] or_ln63_reg_132;
reg    ap_block_state2_pp0_stage0_iter1;
wire    appListenPortRsp_V_1_ack_in;
reg   [0:0] and_ln71_reg_141;
reg    ap_predicate_op18_write_state2;
reg    ap_block_state2_io;
wire    appListenPortRsp_V_1_ack_out;
reg   [1:0] appListenPortRsp_V_1_state;
reg    ap_block_state3_pp0_stage0_iter2;
reg   [0:0] or_ln63_reg_132_pp0_iter1_reg;
reg   [0:0] and_ln71_reg_141_pp0_iter1_reg;
reg    ap_predicate_op25_write_state3;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
reg   [7:0] appListenPortRsp_V_1_data_out;
reg    appListenPortRsp_V_1_vld_in;
wire    appListenPortRsp_V_1_vld_out;
reg   [7:0] appListenPortRsp_V_1_payload_A;
reg   [7:0] appListenPortRsp_V_1_payload_B;
reg    appListenPortRsp_V_1_sel_rd;
reg    appListenPortRsp_V_1_sel_wr;
wire    appListenPortRsp_V_1_sel;
wire    appListenPortRsp_V_1_load_A;
wire    appListenPortRsp_V_1_load_B;
wire    appListenPortRsp_V_1_state_cmp_full;
reg   [0:0] rai_wait;
reg    appListenPortReq_V_V_TDATA_blk_n;
wire    ap_block_pp0_stage0;
reg    appListenPortRsp_V_TDATA_blk_n;
reg    rxApp2portTable_list_1_blk_n;
reg    portTable2rxApp_list_1_blk_n;
reg   [15:0] tmp_V_reg_136;
reg   [0:0] tmp_94_reg_145;
wire   [7:0] zext_ln163_fu_128_p1;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] tmp_nbreadreq_fu_52_p3;
wire   [0:0] tmp_92_nbreadreq_fu_66_p3;
reg    ap_block_pp0_stage0_01001;
wire   [0:0] xor_ln63_fu_98_p2;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to1;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_119;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 appListenPortRsp_V_1_state = 2'd0;
#0 appListenPortRsp_V_1_sel_rd = 1'b0;
#0 appListenPortRsp_V_1_sel_wr = 1'b0;
#0 rai_wait = 1'd0;
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
        end else if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
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
        appListenPortRsp_V_1_sel_rd <= 1'b0;
    end else begin
        if (((appListenPortRsp_V_1_ack_out == 1'b1) & (appListenPortRsp_V_1_vld_out == 1'b1))) begin
            appListenPortRsp_V_1_sel_rd <= ~appListenPortRsp_V_1_sel_rd;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        appListenPortRsp_V_1_sel_wr <= 1'b0;
    end else begin
        if (((appListenPortRsp_V_1_ack_in == 1'b1) & (appListenPortRsp_V_1_vld_in == 1'b1))) begin
            appListenPortRsp_V_1_sel_wr <= ~appListenPortRsp_V_1_sel_wr;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        appListenPortRsp_V_1_state <= 2'd0;
    end else begin
        if ((((appListenPortRsp_V_1_state == 2'd3) & (appListenPortRsp_V_1_vld_in == 1'b0) & (appListenPortRsp_V_1_ack_out == 1'b1)) | ((appListenPortRsp_V_1_state == 2'd2) & (appListenPortRsp_V_1_vld_in == 1'b0)))) begin
            appListenPortRsp_V_1_state <= 2'd2;
        end else if ((((appListenPortRsp_V_1_state == 2'd1) & (appListenPortRsp_V_TREADY == 1'b0)) | ((appListenPortRsp_V_1_state == 2'd3) & (appListenPortRsp_V_TREADY == 1'b0) & (appListenPortRsp_V_1_vld_in == 1'b1)))) begin
            appListenPortRsp_V_1_state <= 2'd1;
        end else if ((((appListenPortRsp_V_1_state == 2'd1) & (appListenPortRsp_V_1_ack_out == 1'b1)) | (~((appListenPortRsp_V_1_vld_in == 1'b0) & (appListenPortRsp_V_1_ack_out == 1'b1)) & ~((appListenPortRsp_V_TREADY == 1'b0) & (appListenPortRsp_V_1_vld_in == 1'b1)) & (appListenPortRsp_V_1_state == 2'd3)) | ((appListenPortRsp_V_1_state == 2'd2) & (appListenPortRsp_V_1_vld_in == 1'b1)))) begin
            appListenPortRsp_V_1_state <= 2'd3;
        end else begin
            appListenPortRsp_V_1_state <= 2'd2;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_119)) begin
        if (((1'd1 == and_ln71_fu_116_p2) & (or_ln63_fu_104_p2 == 1'd1))) begin
            rai_wait <= 1'd0;
        end else if ((or_ln63_fu_104_p2 == 1'd0)) begin
            rai_wait <= 1'd1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((or_ln63_fu_104_p2 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        and_ln71_reg_141 <= and_ln71_fu_116_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        and_ln71_reg_141_pp0_iter1_reg <= and_ln71_reg_141;
        or_ln63_reg_132 <= or_ln63_fu_104_p2;
        or_ln63_reg_132_pp0_iter1_reg <= or_ln63_reg_132;
    end
end

always @ (posedge ap_clk) begin
    if ((appListenPortRsp_V_1_load_A == 1'b1)) begin
        appListenPortRsp_V_1_payload_A <= zext_ln163_fu_128_p1;
    end
end

always @ (posedge ap_clk) begin
    if ((appListenPortRsp_V_1_load_B == 1'b1)) begin
        appListenPortRsp_V_1_payload_B <= zext_ln163_fu_128_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op14_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_94_reg_145 <= portTable2rxApp_list_1_dout;
    end
end

always @ (posedge ap_clk) begin
    if (((or_ln63_fu_104_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_reg_136 <= appListenPortReq_V_V_TDATA;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
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
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0_0to1 = 1'b1;
    end else begin
        ap_idle_pp0_0to1 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (ap_idle_pp0_0to1 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (or_ln63_fu_104_p2 == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        appListenPortReq_V_V_TDATA_blk_n = appListenPortReq_V_V_TVALID;
    end else begin
        appListenPortReq_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((or_ln63_fu_104_p2 == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        appListenPortReq_V_V_TREADY = 1'b1;
    end else begin
        appListenPortReq_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((appListenPortRsp_V_1_sel == 1'b1)) begin
        appListenPortRsp_V_1_data_out = appListenPortRsp_V_1_payload_B;
    end else begin
        appListenPortRsp_V_1_data_out = appListenPortRsp_V_1_payload_A;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op18_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        appListenPortRsp_V_1_vld_in = 1'b1;
    end else begin
        appListenPortRsp_V_1_vld_in = 1'b0;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op18_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)) | ((ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op25_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0)))) begin
        appListenPortRsp_V_TDATA_blk_n = appListenPortRsp_V_1_state[1'd1];
    end else begin
        appListenPortRsp_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op14_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        portTable2rxApp_list_1_blk_n = portTable2rxApp_list_1_empty_n;
    end else begin
        portTable2rxApp_list_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op14_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        portTable2rxApp_list_1_read = 1'b1;
    end else begin
        portTable2rxApp_list_1_read = 1'b0;
    end
end

always @ (*) begin
    if (((or_ln63_reg_132 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        rxApp2portTable_list_1_blk_n = rxApp2portTable_list_1_full_n;
    end else begin
        rxApp2portTable_list_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((or_ln63_reg_132 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rxApp2portTable_list_1_write = 1'b1;
    end else begin
        rxApp2portTable_list_1_write = 1'b0;
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

assign and_ln71_fu_116_p2 = (tmp_92_nbreadreq_fu_66_p3 & rai_wait);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((appListenPortRsp_V_1_state == 2'd1) | ((appListenPortRsp_V_1_state == 2'd3) & (appListenPortRsp_V_TREADY == 1'b0)))) | ((or_ln63_reg_132 == 1'd0) & (rxApp2portTable_list_1_full_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((portTable2rxApp_list_1_empty_n == 1'b0) & (ap_predicate_op14_read_state1 == 1'b1)) | ((or_ln63_fu_104_p2 == 1'd0) & (appListenPortReq_V_V_TVALID == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & ((1'b1 == ap_block_state2_io) | ((or_ln63_reg_132 == 1'd0) & (rxApp2portTable_list_1_full_n == 1'b0)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((portTable2rxApp_list_1_empty_n == 1'b0) & (ap_predicate_op14_read_state1 == 1'b1)) | ((or_ln63_fu_104_p2 == 1'd0) & (appListenPortReq_V_V_TVALID == 1'b0)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((appListenPortRsp_V_1_state == 2'd1) | (1'b1 == ap_block_state3_io) | ((appListenPortRsp_V_1_state == 2'd3) & (appListenPortRsp_V_TREADY == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & ((1'b1 == ap_block_state2_io) | ((or_ln63_reg_132 == 1'd0) & (rxApp2portTable_list_1_full_n == 1'b0)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((portTable2rxApp_list_1_empty_n == 1'b0) & (ap_predicate_op14_read_state1 == 1'b1)) | ((or_ln63_fu_104_p2 == 1'd0) & (appListenPortReq_V_V_TVALID == 1'b0)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((appListenPortRsp_V_1_state == 2'd1) | (1'b1 == ap_block_state3_io) | ((appListenPortRsp_V_1_state == 2'd3) & (appListenPortRsp_V_TREADY == 1'b0)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((portTable2rxApp_list_1_empty_n == 1'b0) & (ap_predicate_op14_read_state1 == 1'b1)) | ((or_ln63_fu_104_p2 == 1'd0) & (appListenPortReq_V_V_TVALID == 1'b0)));
end

always @ (*) begin
    ap_block_state2_io = ((appListenPortRsp_V_1_ack_in == 1'b0) & (ap_predicate_op18_write_state2 == 1'b1));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = ((or_ln63_reg_132 == 1'd0) & (rxApp2portTable_list_1_full_n == 1'b0));
end

always @ (*) begin
    ap_block_state3_io = ((appListenPortRsp_V_1_ack_in == 1'b0) & (ap_predicate_op25_write_state3 == 1'b1));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = ((appListenPortRsp_V_1_state == 2'd1) | ((appListenPortRsp_V_1_state == 2'd3) & (appListenPortRsp_V_TREADY == 1'b0)));
end

always @ (*) begin
    ap_condition_119 = ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

always @ (*) begin
    ap_predicate_op14_read_state1 = ((1'd1 == and_ln71_fu_116_p2) & (or_ln63_fu_104_p2 == 1'd1));
end

always @ (*) begin
    ap_predicate_op18_write_state2 = ((1'd1 == and_ln71_reg_141) & (or_ln63_reg_132 == 1'd1));
end

always @ (*) begin
    ap_predicate_op25_write_state3 = ((1'd1 == and_ln71_reg_141_pp0_iter1_reg) & (or_ln63_reg_132_pp0_iter1_reg == 1'd1));
end

assign appListenPortRsp_V_1_ack_in = appListenPortRsp_V_1_state[1'd1];

assign appListenPortRsp_V_1_ack_out = appListenPortRsp_V_TREADY;

assign appListenPortRsp_V_1_load_A = (~appListenPortRsp_V_1_sel_wr & appListenPortRsp_V_1_state_cmp_full);

assign appListenPortRsp_V_1_load_B = (appListenPortRsp_V_1_state_cmp_full & appListenPortRsp_V_1_sel_wr);

assign appListenPortRsp_V_1_sel = appListenPortRsp_V_1_sel_rd;

assign appListenPortRsp_V_1_state_cmp_full = ((appListenPortRsp_V_1_state != 2'd1) ? 1'b1 : 1'b0);

assign appListenPortRsp_V_1_vld_out = appListenPortRsp_V_1_state[1'd0];

assign appListenPortRsp_V_TDATA = appListenPortRsp_V_1_data_out;

assign appListenPortRsp_V_TVALID = appListenPortRsp_V_1_state[1'd0];

assign or_ln63_fu_104_p2 = (xor_ln63_fu_98_p2 | rai_wait);

assign rxApp2portTable_list_1_din = tmp_V_reg_136;

assign tmp_92_nbreadreq_fu_66_p3 = portTable2rxApp_list_1_empty_n;

assign tmp_nbreadreq_fu_52_p3 = appListenPortReq_V_V_TVALID;

assign xor_ln63_fu_98_p2 = (tmp_nbreadreq_fu_52_p3 ^ 1'd1);

assign zext_ln163_fu_128_p1 = tmp_94_reg_145;

endmodule //rx_app_if