// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2019.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module txEngMemAccessBreakd (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        txMetaloader2memAcce_1_dout,
        txMetaloader2memAcce_1_empty_n,
        txMetaloader2memAcce_1_read,
        memAccessBreakdown2t_1_din,
        memAccessBreakdown2t_1_full_n,
        memAccessBreakdown2t_1_write,
        outputMemAccess_V_TREADY,
        outputMemAccess_V_TDATA,
        outputMemAccess_V_TVALID
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [71:0] txMetaloader2memAcce_1_dout;
input   txMetaloader2memAcce_1_empty_n;
output   txMetaloader2memAcce_1_read;
output  [0:0] memAccessBreakdown2t_1_din;
input   memAccessBreakdown2t_1_full_n;
output   memAccessBreakdown2t_1_write;
input   outputMemAccess_V_TREADY;
output  [71:0] outputMemAccess_V_TDATA;
output   outputMemAccess_V_TVALID;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg txMetaloader2memAcce_1_read;
reg[0:0] memAccessBreakdown2t_1_din;
reg memAccessBreakdown2t_1_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire   [0:0] txEngBreakdownState_1_load_fu_102_p1;
wire   [0:0] tmp_nbreadreq_fu_72_p3;
reg    ap_predicate_op8_read_state1;
reg    ap_block_state1_pp0_stage0_iter0;
reg   [0:0] txEngBreakdownState_1_reg_226;
reg   [0:0] tmp_reg_230;
reg   [0:0] icmp_ln895_reg_244;
reg    ap_predicate_op22_write_state2;
reg    ap_predicate_op24_write_state2;
reg    ap_block_state2_pp0_stage0_iter1;
wire    outputMemAccess_V_1_ack_in;
reg    ap_predicate_op23_write_state2;
reg    ap_predicate_op27_write_state2;
reg    ap_block_state2_io;
wire    outputMemAccess_V_1_ack_out;
reg   [1:0] outputMemAccess_V_1_state;
reg    ap_block_state3_pp0_stage0_iter2;
reg   [0:0] txEngBreakdownState_1_reg_226_pp0_iter1_reg;
reg   [0:0] tmp_reg_230_pp0_iter1_reg;
reg   [0:0] icmp_ln895_reg_244_pp0_iter1_reg;
reg    ap_predicate_op39_write_state3;
reg    ap_predicate_op41_write_state3;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
reg   [71:0] outputMemAccess_V_1_data_in;
reg   [71:0] outputMemAccess_V_1_data_out;
reg    outputMemAccess_V_1_vld_in;
wire    outputMemAccess_V_1_vld_out;
reg   [71:0] outputMemAccess_V_1_payload_A;
reg   [71:0] outputMemAccess_V_1_payload_B;
reg    outputMemAccess_V_1_sel_rd;
reg    outputMemAccess_V_1_sel_wr;
wire    outputMemAccess_V_1_sel;
wire    outputMemAccess_V_1_load_A;
wire    outputMemAccess_V_1_load_B;
wire    outputMemAccess_V_1_state_cmp_full;
reg   [0:0] txEngBreakdownState_s;
reg   [22:0] cmd_bbt_V;
reg   [15:0] lengthFirstAccess_V;
reg    outputMemAccess_V_TDATA_blk_n;
wire    ap_block_pp0_stage0;
reg    txMetaloader2memAcce_1_blk_n;
reg    memAccessBreakdown2t_1_blk_n;
reg   [71:0] tmp21_reg_234;
reg   [31:0] p_Val2_s_reg_239;
wire   [0:0] icmp_ln895_fu_150_p2;
wire   [15:0] sub_ln214_1_fu_156_p2;
reg   [15:0] sub_ln214_1_reg_248;
wire   [71:0] tmp_1_fu_183_p5;
wire   [71:0] tmp_3_fu_217_p3;
reg    ap_block_pp0_stage0_subdone;
wire   [22:0] tmp_bbt_V_2_fu_106_p1;
reg    ap_block_pp0_stage0_01001;
wire   [15:0] p_Result_i_fu_126_p4;
wire   [23:0] zext_ln215_fu_136_p1;
wire   [23:0] zext_ln215_1_fu_140_p1;
wire   [23:0] ret_V_fu_144_p2;
wire   [22:0] tmp_bbt_V_1_fu_180_p1;
wire   [15:0] trunc_ln214_fu_199_p1;
wire   [15:0] sub_ln214_fu_207_p2;
wire   [22:0] tmp_bbt_V_fu_213_p1;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to1;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_276;
reg    ap_condition_244;
reg    ap_condition_143;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 outputMemAccess_V_1_state = 2'd0;
#0 outputMemAccess_V_1_sel_rd = 1'b0;
#0 outputMemAccess_V_1_sel_wr = 1'b0;
#0 txEngBreakdownState_s = 1'd0;
#0 cmd_bbt_V = 23'd0;
#0 lengthFirstAccess_V = 16'd0;
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
        outputMemAccess_V_1_sel_rd <= 1'b0;
    end else begin
        if (((outputMemAccess_V_1_ack_out == 1'b1) & (outputMemAccess_V_1_vld_out == 1'b1))) begin
            outputMemAccess_V_1_sel_rd <= ~outputMemAccess_V_1_sel_rd;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        outputMemAccess_V_1_sel_wr <= 1'b0;
    end else begin
        if (((outputMemAccess_V_1_ack_in == 1'b1) & (outputMemAccess_V_1_vld_in == 1'b1))) begin
            outputMemAccess_V_1_sel_wr <= ~outputMemAccess_V_1_sel_wr;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        outputMemAccess_V_1_state <= 2'd0;
    end else begin
        if ((((outputMemAccess_V_1_vld_in == 1'b0) & (outputMemAccess_V_1_ack_out == 1'b1) & (outputMemAccess_V_1_state == 2'd3)) | ((outputMemAccess_V_1_vld_in == 1'b0) & (outputMemAccess_V_1_state == 2'd2)))) begin
            outputMemAccess_V_1_state <= 2'd2;
        end else if ((((outputMemAccess_V_TREADY == 1'b0) & (outputMemAccess_V_1_state == 2'd1)) | ((outputMemAccess_V_TREADY == 1'b0) & (outputMemAccess_V_1_vld_in == 1'b1) & (outputMemAccess_V_1_state == 2'd3)))) begin
            outputMemAccess_V_1_state <= 2'd1;
        end else if ((((outputMemAccess_V_1_ack_out == 1'b1) & (outputMemAccess_V_1_state == 2'd1)) | (~((outputMemAccess_V_1_vld_in == 1'b0) & (outputMemAccess_V_1_ack_out == 1'b1)) & ~((outputMemAccess_V_TREADY == 1'b0) & (outputMemAccess_V_1_vld_in == 1'b1)) & (outputMemAccess_V_1_state == 2'd3)) | ((outputMemAccess_V_1_vld_in == 1'b1) & (outputMemAccess_V_1_state == 2'd2)))) begin
            outputMemAccess_V_1_state <= 2'd3;
        end else begin
            outputMemAccess_V_1_state <= 2'd2;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_143)) begin
        if ((txEngBreakdownState_1_load_fu_102_p1 == 1'd1)) begin
            txEngBreakdownState_s <= 1'd0;
        end else if ((1'b1 == ap_condition_244)) begin
            txEngBreakdownState_s <= 1'd1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_nbreadreq_fu_72_p3 == 1'd1) & (txEngBreakdownState_s == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        cmd_bbt_V <= tmp_bbt_V_2_fu_106_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_nbreadreq_fu_72_p3 == 1'd1) & (txEngBreakdownState_s == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln895_reg_244 <= icmp_ln895_fu_150_p2;
        p_Val2_s_reg_239 <= {{txMetaloader2memAcce_1_dout[63:32]}};
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln895_reg_244_pp0_iter1_reg <= icmp_ln895_reg_244;
        tmp_reg_230_pp0_iter1_reg <= tmp_reg_230;
        txEngBreakdownState_1_reg_226 <= txEngBreakdownState_s;
        txEngBreakdownState_1_reg_226_pp0_iter1_reg <= txEngBreakdownState_1_reg_226;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln895_fu_150_p2 == 1'd1) & (tmp_nbreadreq_fu_72_p3 == 1'd1) & (txEngBreakdownState_s == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        lengthFirstAccess_V <= sub_ln214_1_fu_156_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((outputMemAccess_V_1_load_A == 1'b1)) begin
        outputMemAccess_V_1_payload_A <= outputMemAccess_V_1_data_in;
    end
end

always @ (posedge ap_clk) begin
    if ((outputMemAccess_V_1_load_B == 1'b1)) begin
        outputMemAccess_V_1_payload_B <= outputMemAccess_V_1_data_in;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln895_fu_150_p2 == 1'd1) & (tmp_nbreadreq_fu_72_p3 == 1'd1) & (txEngBreakdownState_s == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        sub_ln214_1_reg_248 <= sub_ln214_1_fu_156_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op8_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp21_reg_234 <= txMetaloader2memAcce_1_dout;
    end
end

always @ (posedge ap_clk) begin
    if (((txEngBreakdownState_s == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_reg_230 <= tmp_nbreadreq_fu_72_p3;
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
    if ((((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op24_write_state2 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op22_write_state2 == 1'b1)))) begin
        memAccessBreakdown2t_1_blk_n = memAccessBreakdown2t_1_full_n;
    end else begin
        memAccessBreakdown2t_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_276)) begin
        if ((ap_predicate_op24_write_state2 == 1'b1)) begin
            memAccessBreakdown2t_1_din = 1'd1;
        end else if ((ap_predicate_op22_write_state2 == 1'b1)) begin
            memAccessBreakdown2t_1_din = 1'd0;
        end else begin
            memAccessBreakdown2t_1_din = 'bx;
        end
    end else begin
        memAccessBreakdown2t_1_din = 'bx;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op24_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op22_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        memAccessBreakdown2t_1_write = 1'b1;
    end else begin
        memAccessBreakdown2t_1_write = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_276)) begin
        if ((txEngBreakdownState_1_reg_226 == 1'd1)) begin
            outputMemAccess_V_1_data_in = tmp_3_fu_217_p3;
        end else if ((ap_predicate_op27_write_state2 == 1'b1)) begin
            outputMemAccess_V_1_data_in = tmp_1_fu_183_p5;
        end else if ((ap_predicate_op23_write_state2 == 1'b1)) begin
            outputMemAccess_V_1_data_in = tmp21_reg_234;
        end else begin
            outputMemAccess_V_1_data_in = 'bx;
        end
    end else begin
        outputMemAccess_V_1_data_in = 'bx;
    end
end

always @ (*) begin
    if ((outputMemAccess_V_1_sel == 1'b1)) begin
        outputMemAccess_V_1_data_out = outputMemAccess_V_1_payload_B;
    end else begin
        outputMemAccess_V_1_data_out = outputMemAccess_V_1_payload_A;
    end
end

always @ (*) begin
    if ((((txEngBreakdownState_1_reg_226 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op27_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op23_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        outputMemAccess_V_1_vld_in = 1'b1;
    end else begin
        outputMemAccess_V_1_vld_in = 1'b0;
    end
end

always @ (*) begin
    if ((((txEngBreakdownState_1_reg_226 == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op27_write_state2 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op23_write_state2 == 1'b1)) | ((txEngBreakdownState_1_reg_226_pp0_iter1_reg == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op41_write_state3 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op39_write_state3 == 1'b1)))) begin
        outputMemAccess_V_TDATA_blk_n = outputMemAccess_V_1_state[1'd1];
    end else begin
        outputMemAccess_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op8_read_state1 == 1'b1))) begin
        txMetaloader2memAcce_1_blk_n = txMetaloader2memAcce_1_empty_n;
    end else begin
        txMetaloader2memAcce_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op8_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        txMetaloader2memAcce_1_read = 1'b1;
    end else begin
        txMetaloader2memAcce_1_read = 1'b0;
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
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((memAccessBreakdown2t_1_full_n == 1'b0) & (ap_predicate_op24_write_state2 == 1'b1)) | ((memAccessBreakdown2t_1_full_n == 1'b0) & (ap_predicate_op22_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txMetaloader2memAcce_1_empty_n == 1'b0) & (ap_predicate_op8_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((outputMemAccess_V_1_state == 2'd1) | ((outputMemAccess_V_TREADY == 1'b0) & (outputMemAccess_V_1_state == 2'd3)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & ((1'b1 == ap_block_state2_io) | ((memAccessBreakdown2t_1_full_n == 1'b0) & (ap_predicate_op24_write_state2 == 1'b1)) | ((memAccessBreakdown2t_1_full_n == 1'b0) & (ap_predicate_op22_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txMetaloader2memAcce_1_empty_n == 1'b0) & (ap_predicate_op8_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((1'b1 == ap_block_state3_io) | (outputMemAccess_V_1_state == 2'd1) | ((outputMemAccess_V_TREADY == 1'b0) & (outputMemAccess_V_1_state == 2'd3)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & ((1'b1 == ap_block_state2_io) | ((memAccessBreakdown2t_1_full_n == 1'b0) & (ap_predicate_op24_write_state2 == 1'b1)) | ((memAccessBreakdown2t_1_full_n == 1'b0) & (ap_predicate_op22_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txMetaloader2memAcce_1_empty_n == 1'b0) & (ap_predicate_op8_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((1'b1 == ap_block_state3_io) | (outputMemAccess_V_1_state == 2'd1) | ((outputMemAccess_V_TREADY == 1'b0) & (outputMemAccess_V_1_state == 2'd3)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txMetaloader2memAcce_1_empty_n == 1'b0) & (ap_predicate_op8_read_state1 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_io = (((txEngBreakdownState_1_reg_226 == 1'd1) & (outputMemAccess_V_1_ack_in == 1'b0)) | ((outputMemAccess_V_1_ack_in == 1'b0) & (ap_predicate_op27_write_state2 == 1'b1)) | ((outputMemAccess_V_1_ack_in == 1'b0) & (ap_predicate_op23_write_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = (((memAccessBreakdown2t_1_full_n == 1'b0) & (ap_predicate_op24_write_state2 == 1'b1)) | ((memAccessBreakdown2t_1_full_n == 1'b0) & (ap_predicate_op22_write_state2 == 1'b1)));
end

always @ (*) begin
    ap_block_state3_io = (((txEngBreakdownState_1_reg_226_pp0_iter1_reg == 1'd1) & (outputMemAccess_V_1_ack_in == 1'b0)) | ((outputMemAccess_V_1_ack_in == 1'b0) & (ap_predicate_op41_write_state3 == 1'b1)) | ((outputMemAccess_V_1_ack_in == 1'b0) & (ap_predicate_op39_write_state3 == 1'b1)));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = ((outputMemAccess_V_1_state == 2'd1) | ((outputMemAccess_V_TREADY == 1'b0) & (outputMemAccess_V_1_state == 2'd3)));
end

always @ (*) begin
    ap_condition_143 = ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001));
end

always @ (*) begin
    ap_condition_244 = ((icmp_ln895_fu_150_p2 == 1'd1) & (tmp_nbreadreq_fu_72_p3 == 1'd1) & (txEngBreakdownState_s == 1'd0));
end

always @ (*) begin
    ap_condition_276 = ((1'b0 == ap_block_pp0_stage0_01001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

always @ (*) begin
    ap_predicate_op22_write_state2 = ((tmp_reg_230 == 1'd1) & (icmp_ln895_reg_244 == 1'd0) & (txEngBreakdownState_1_reg_226 == 1'd0));
end

always @ (*) begin
    ap_predicate_op23_write_state2 = ((tmp_reg_230 == 1'd1) & (icmp_ln895_reg_244 == 1'd0) & (txEngBreakdownState_1_reg_226 == 1'd0));
end

always @ (*) begin
    ap_predicate_op24_write_state2 = ((icmp_ln895_reg_244 == 1'd1) & (tmp_reg_230 == 1'd1) & (txEngBreakdownState_1_reg_226 == 1'd0));
end

always @ (*) begin
    ap_predicate_op27_write_state2 = ((icmp_ln895_reg_244 == 1'd1) & (tmp_reg_230 == 1'd1) & (txEngBreakdownState_1_reg_226 == 1'd0));
end

always @ (*) begin
    ap_predicate_op39_write_state3 = ((tmp_reg_230_pp0_iter1_reg == 1'd1) & (icmp_ln895_reg_244_pp0_iter1_reg == 1'd0) & (txEngBreakdownState_1_reg_226_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op41_write_state3 = ((icmp_ln895_reg_244_pp0_iter1_reg == 1'd1) & (tmp_reg_230_pp0_iter1_reg == 1'd1) & (txEngBreakdownState_1_reg_226_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op8_read_state1 = ((tmp_nbreadreq_fu_72_p3 == 1'd1) & (txEngBreakdownState_s == 1'd0));
end

assign icmp_ln895_fu_150_p2 = ((ret_V_fu_144_p2 > 24'd65536) ? 1'b1 : 1'b0);

assign outputMemAccess_V_1_ack_in = outputMemAccess_V_1_state[1'd1];

assign outputMemAccess_V_1_ack_out = outputMemAccess_V_TREADY;

assign outputMemAccess_V_1_load_A = (outputMemAccess_V_1_state_cmp_full & ~outputMemAccess_V_1_sel_wr);

assign outputMemAccess_V_1_load_B = (outputMemAccess_V_1_state_cmp_full & outputMemAccess_V_1_sel_wr);

assign outputMemAccess_V_1_sel = outputMemAccess_V_1_sel_rd;

assign outputMemAccess_V_1_state_cmp_full = ((outputMemAccess_V_1_state != 2'd1) ? 1'b1 : 1'b0);

assign outputMemAccess_V_1_vld_out = outputMemAccess_V_1_state[1'd0];

assign outputMemAccess_V_TDATA = outputMemAccess_V_1_data_out;

assign outputMemAccess_V_TVALID = outputMemAccess_V_1_state[1'd0];

assign p_Result_i_fu_126_p4 = {{txMetaloader2memAcce_1_dout[47:32]}};

assign ret_V_fu_144_p2 = (zext_ln215_fu_136_p1 + zext_ln215_1_fu_140_p1);

assign sub_ln214_1_fu_156_p2 = (16'd0 - p_Result_i_fu_126_p4);

assign sub_ln214_fu_207_p2 = (trunc_ln214_fu_199_p1 - lengthFirstAccess_V);

assign tmp_1_fu_183_p5 = {{{{{{8'd0}, {p_Val2_s_reg_239}}}, {9'd385}}}, {tmp_bbt_V_1_fu_180_p1}};

assign tmp_3_fu_217_p3 = {{49'd385}, {tmp_bbt_V_fu_213_p1}};

assign tmp_bbt_V_1_fu_180_p1 = sub_ln214_1_reg_248;

assign tmp_bbt_V_2_fu_106_p1 = txMetaloader2memAcce_1_dout[22:0];

assign tmp_bbt_V_fu_213_p1 = sub_ln214_fu_207_p2;

assign tmp_nbreadreq_fu_72_p3 = txMetaloader2memAcce_1_empty_n;

assign trunc_ln214_fu_199_p1 = cmd_bbt_V[15:0];

assign txEngBreakdownState_1_load_fu_102_p1 = txEngBreakdownState_s;

assign zext_ln215_1_fu_140_p1 = tmp_bbt_V_2_fu_106_p1;

assign zext_ln215_fu_136_p1 = p_Result_i_fu_126_p4;

endmodule //txEngMemAccessBreakd
