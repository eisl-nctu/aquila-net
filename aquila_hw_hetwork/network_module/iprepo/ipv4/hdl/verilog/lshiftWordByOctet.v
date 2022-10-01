// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2019.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module lshiftWordByOctet (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        s_axis_tx_data_TVALID,
        tx_shift2ipv4Fifo_V_1_din,
        tx_shift2ipv4Fifo_V_1_full_n,
        tx_shift2ipv4Fifo_V_1_write,
        tx_shift2ipv4Fifo_V_2_din,
        tx_shift2ipv4Fifo_V_2_full_n,
        tx_shift2ipv4Fifo_V_2_write,
        tx_shift2ipv4Fifo_V_s_din,
        tx_shift2ipv4Fifo_V_s_full_n,
        tx_shift2ipv4Fifo_V_s_write,
        s_axis_tx_data_TDATA,
        s_axis_tx_data_TREADY,
        s_axis_tx_data_TKEEP,
        s_axis_tx_data_TLAST
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input   s_axis_tx_data_TVALID;
output  [63:0] tx_shift2ipv4Fifo_V_1_din;
input   tx_shift2ipv4Fifo_V_1_full_n;
output   tx_shift2ipv4Fifo_V_1_write;
output  [7:0] tx_shift2ipv4Fifo_V_2_din;
input   tx_shift2ipv4Fifo_V_2_full_n;
output   tx_shift2ipv4Fifo_V_2_write;
output  [0:0] tx_shift2ipv4Fifo_V_s_din;
input   tx_shift2ipv4Fifo_V_s_full_n;
output   tx_shift2ipv4Fifo_V_s_write;
input  [63:0] s_axis_tx_data_TDATA;
output   s_axis_tx_data_TREADY;
input  [7:0] s_axis_tx_data_TKEEP;
input  [0:0] s_axis_tx_data_TLAST;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg[63:0] tx_shift2ipv4Fifo_V_1_din;
reg tx_shift2ipv4Fifo_V_1_write;
reg[7:0] tx_shift2ipv4Fifo_V_2_din;
reg tx_shift2ipv4Fifo_V_2_write;
reg[0:0] tx_shift2ipv4Fifo_V_s_din;
reg tx_shift2ipv4Fifo_V_s_write;
reg s_axis_tx_data_TREADY;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_idle_pp0;
wire   [0:0] ls_writeRemainder_lo_load_fu_128_p1;
wire   [0:0] tmp_nbreadreq_fu_72_p5;
reg    ap_predicate_op9_read_state1;
reg    ap_block_state1_pp0_stage0_iter0;
wire    io_acc_block_signal_op42;
reg   [0:0] ls_writeRemainder_lo_reg_299;
reg   [0:0] tmp_reg_303;
reg    ap_predicate_op42_write_state2;
wire    io_acc_block_signal_op47;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_pp0_stage0_11001;
reg   [0:0] ls_writeRemainder;
reg   [63:0] prevWord_data_V_1;
reg   [7:0] prevWord_keep_V;
reg   [0:0] ls_firstWord;
reg    s_axis_tx_data_TDATA_blk_n;
wire    ap_block_pp0_stage0;
reg    tx_shift2ipv4Fifo_V_1_blk_n;
reg    tx_shift2ipv4Fifo_V_2_blk_n;
reg    tx_shift2ipv4Fifo_V_s_blk_n;
wire   [7:0] sendWord_keep_V_fu_215_p3;
reg   [7:0] sendWord_keep_V_reg_310;
wire   [63:0] sendWord_data_V_fu_223_p3;
reg   [63:0] sendWord_data_V_reg_315;
wire   [0:0] sendWord_last_V_fu_231_p2;
reg   [0:0] sendWord_last_V_reg_320;
reg   [31:0] p_Result_i_reg_325;
wire   [3:0] grp_fu_119_p4;
reg   [3:0] p_Result_9_i_reg_330;
reg    ap_block_pp0_stage0_subdone;
reg   [0:0] ap_phi_mux_ls_firstWord_new_0_i_phi_fu_111_p4;
wire   [0:0] ap_phi_reg_pp0_iter0_ls_firstWord_new_0_i_reg_108;
wire   [0:0] tmp_last_V_fu_149_p1;
wire   [0:0] xor_ln761_fu_249_p2;
reg    ap_block_pp0_stage0_01001;
wire   [63:0] p_Result_s_fu_283_p3;
wire   [7:0] p_Result_1_fu_291_p3;
wire   [3:0] trunc_ln647_1_fu_167_p1;
wire   [31:0] trunc_ln647_fu_157_p1;
wire   [31:0] p_Result_5_i_fu_189_p4;
wire   [7:0] p_Result_3_fu_171_p3;
wire   [7:0] p_Result_5_fu_207_p3;
wire   [63:0] p_Result_2_fu_161_p2;
wire   [63:0] p_Result_4_fu_199_p3;
wire   [3:0] p_Result_4_i_fu_179_p4;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to0;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_158;
reg    ap_condition_140;
reg    ap_condition_87;
reg    ap_condition_168;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ls_writeRemainder = 1'd0;
#0 prevWord_data_V_1 = 64'd0;
#0 prevWord_keep_V = 8'd0;
#0 ls_firstWord = 1'd1;
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
        end else if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter1 <= ap_start;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_87)) begin
        if ((ls_writeRemainder_lo_load_fu_128_p1 == 1'd1)) begin
            ls_writeRemainder <= 1'd0;
        end else if ((1'b1 == ap_condition_140)) begin
            ls_writeRemainder <= xor_ln761_fu_249_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_72_p5 == 1'd1) & (ls_writeRemainder == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ls_firstWord <= ap_phi_mux_ls_firstWord_new_0_i_phi_fu_111_p4;
        prevWord_data_V_1 <= s_axis_tx_data_TDATA;
        prevWord_keep_V <= s_axis_tx_data_TKEEP;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ls_writeRemainder_lo_reg_299 <= ls_writeRemainder;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ls_writeRemainder_lo_load_fu_128_p1 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        p_Result_9_i_reg_330 <= {{prevWord_keep_V[7:4]}};
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ls_writeRemainder_lo_load_fu_128_p1 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        p_Result_i_reg_325 <= {{prevWord_data_V_1[63:32]}};
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_72_p5 == 1'd1) & (ls_writeRemainder == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        sendWord_data_V_reg_315 <= sendWord_data_V_fu_223_p3;
        sendWord_keep_V_reg_310 <= sendWord_keep_V_fu_215_p3;
        sendWord_last_V_reg_320 <= sendWord_last_V_fu_231_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ls_writeRemainder == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_reg_303 <= tmp_nbreadreq_fu_72_p5;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
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
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((ap_enable_reg_pp0_iter0 == 1'b0)) begin
        ap_idle_pp0_0to0 = 1'b1;
    end else begin
        ap_idle_pp0_0to0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_158)) begin
        if ((tmp_last_V_fu_149_p1 == 1'd0)) begin
            ap_phi_mux_ls_firstWord_new_0_i_phi_fu_111_p4 = 1'd0;
        end else if ((tmp_last_V_fu_149_p1 == 1'd1)) begin
            ap_phi_mux_ls_firstWord_new_0_i_phi_fu_111_p4 = 1'd1;
        end else begin
            ap_phi_mux_ls_firstWord_new_0_i_phi_fu_111_p4 = ap_phi_reg_pp0_iter0_ls_firstWord_new_0_i_reg_108;
        end
    end else begin
        ap_phi_mux_ls_firstWord_new_0_i_phi_fu_111_p4 = ap_phi_reg_pp0_iter0_ls_firstWord_new_0_i_reg_108;
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
    if (((ap_start == 1'b0) & (ap_idle_pp0_0to0 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op9_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        s_axis_tx_data_TDATA_blk_n = s_axis_tx_data_TVALID;
    end else begin
        s_axis_tx_data_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op9_read_state1 == 1'b1))) begin
        s_axis_tx_data_TREADY = 1'b1;
    end else begin
        s_axis_tx_data_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((((ls_writeRemainder_lo_reg_299 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op42_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)))) begin
        tx_shift2ipv4Fifo_V_1_blk_n = tx_shift2ipv4Fifo_V_1_full_n;
    end else begin
        tx_shift2ipv4Fifo_V_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_168)) begin
        if ((ls_writeRemainder_lo_reg_299 == 1'd1)) begin
            tx_shift2ipv4Fifo_V_1_din = p_Result_s_fu_283_p3;
        end else if ((ap_predicate_op42_write_state2 == 1'b1)) begin
            tx_shift2ipv4Fifo_V_1_din = sendWord_data_V_reg_315;
        end else begin
            tx_shift2ipv4Fifo_V_1_din = 'bx;
        end
    end else begin
        tx_shift2ipv4Fifo_V_1_din = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (ls_writeRemainder_lo_reg_299 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op42_write_state2 == 1'b1)))) begin
        tx_shift2ipv4Fifo_V_1_write = 1'b1;
    end else begin
        tx_shift2ipv4Fifo_V_1_write = 1'b0;
    end
end

always @ (*) begin
    if ((((ls_writeRemainder_lo_reg_299 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op42_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)))) begin
        tx_shift2ipv4Fifo_V_2_blk_n = tx_shift2ipv4Fifo_V_2_full_n;
    end else begin
        tx_shift2ipv4Fifo_V_2_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_168)) begin
        if ((ls_writeRemainder_lo_reg_299 == 1'd1)) begin
            tx_shift2ipv4Fifo_V_2_din = p_Result_1_fu_291_p3;
        end else if ((ap_predicate_op42_write_state2 == 1'b1)) begin
            tx_shift2ipv4Fifo_V_2_din = sendWord_keep_V_reg_310;
        end else begin
            tx_shift2ipv4Fifo_V_2_din = 'bx;
        end
    end else begin
        tx_shift2ipv4Fifo_V_2_din = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (ls_writeRemainder_lo_reg_299 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op42_write_state2 == 1'b1)))) begin
        tx_shift2ipv4Fifo_V_2_write = 1'b1;
    end else begin
        tx_shift2ipv4Fifo_V_2_write = 1'b0;
    end
end

always @ (*) begin
    if ((((ls_writeRemainder_lo_reg_299 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op42_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)))) begin
        tx_shift2ipv4Fifo_V_s_blk_n = tx_shift2ipv4Fifo_V_s_full_n;
    end else begin
        tx_shift2ipv4Fifo_V_s_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_168)) begin
        if ((ls_writeRemainder_lo_reg_299 == 1'd1)) begin
            tx_shift2ipv4Fifo_V_s_din = 1'd1;
        end else if ((ap_predicate_op42_write_state2 == 1'b1)) begin
            tx_shift2ipv4Fifo_V_s_din = sendWord_last_V_reg_320;
        end else begin
            tx_shift2ipv4Fifo_V_s_din = 'bx;
        end
    end else begin
        tx_shift2ipv4Fifo_V_s_din = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (ls_writeRemainder_lo_reg_299 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op42_write_state2 == 1'b1)))) begin
        tx_shift2ipv4Fifo_V_s_write = 1'b1;
    end else begin
        tx_shift2ipv4Fifo_V_s_write = 1'b0;
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
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((ls_writeRemainder_lo_reg_299 == 1'd1) & (io_acc_block_signal_op47 == 1'b0)) | ((io_acc_block_signal_op42 == 1'b0) & (ap_predicate_op42_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((s_axis_tx_data_TVALID == 1'b0) & (ap_predicate_op9_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((ls_writeRemainder_lo_reg_299 == 1'd1) & (io_acc_block_signal_op47 == 1'b0)) | ((io_acc_block_signal_op42 == 1'b0) & (ap_predicate_op42_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((s_axis_tx_data_TVALID == 1'b0) & (ap_predicate_op9_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((ls_writeRemainder_lo_reg_299 == 1'd1) & (io_acc_block_signal_op47 == 1'b0)) | ((io_acc_block_signal_op42 == 1'b0) & (ap_predicate_op42_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((s_axis_tx_data_TVALID == 1'b0) & (ap_predicate_op9_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((s_axis_tx_data_TVALID == 1'b0) & (ap_predicate_op9_read_state1 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = (((ls_writeRemainder_lo_reg_299 == 1'd1) & (io_acc_block_signal_op47 == 1'b0)) | ((io_acc_block_signal_op42 == 1'b0) & (ap_predicate_op42_write_state2 == 1'b1)));
end

always @ (*) begin
    ap_condition_140 = ((tmp_last_V_fu_149_p1 == 1'd1) & (tmp_nbreadreq_fu_72_p5 == 1'd1) & (ls_writeRemainder == 1'd0));
end

always @ (*) begin
    ap_condition_158 = ((tmp_nbreadreq_fu_72_p5 == 1'd1) & (ls_writeRemainder == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0));
end

always @ (*) begin
    ap_condition_168 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_01001));
end

always @ (*) begin
    ap_condition_87 = ((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

assign ap_phi_reg_pp0_iter0_ls_firstWord_new_0_i_reg_108 = 'bx;

always @ (*) begin
    ap_predicate_op42_write_state2 = ((tmp_reg_303 == 1'd1) & (ls_writeRemainder_lo_reg_299 == 1'd0));
end

always @ (*) begin
    ap_predicate_op9_read_state1 = ((tmp_nbreadreq_fu_72_p5 == 1'd1) & (ls_writeRemainder == 1'd0));
end

assign grp_fu_119_p4 = {{prevWord_keep_V[7:4]}};

assign io_acc_block_signal_op42 = (tx_shift2ipv4Fifo_V_s_full_n & tx_shift2ipv4Fifo_V_2_full_n & tx_shift2ipv4Fifo_V_1_full_n);

assign io_acc_block_signal_op47 = (tx_shift2ipv4Fifo_V_s_full_n & tx_shift2ipv4Fifo_V_2_full_n & tx_shift2ipv4Fifo_V_1_full_n);

assign ls_writeRemainder_lo_load_fu_128_p1 = ls_writeRemainder;

assign p_Result_1_fu_291_p3 = {{4'd0}, {p_Result_9_i_reg_330}};

assign p_Result_2_fu_161_p2 = s_axis_tx_data_TDATA << 64'd32;

assign p_Result_3_fu_171_p3 = {{trunc_ln647_1_fu_167_p1}, {4'd15}};

assign p_Result_4_fu_199_p3 = {{trunc_ln647_fu_157_p1}, {p_Result_5_i_fu_189_p4}};

assign p_Result_4_i_fu_179_p4 = {{s_axis_tx_data_TKEEP[7:4]}};

assign p_Result_5_fu_207_p3 = {{trunc_ln647_1_fu_167_p1}, {grp_fu_119_p4}};

assign p_Result_5_i_fu_189_p4 = {{prevWord_data_V_1[63:32]}};

assign p_Result_s_fu_283_p3 = {{32'd0}, {p_Result_i_reg_325}};

assign sendWord_data_V_fu_223_p3 = ((ls_firstWord[0:0] === 1'b1) ? p_Result_2_fu_161_p2 : p_Result_4_fu_199_p3);

assign sendWord_keep_V_fu_215_p3 = ((ls_firstWord[0:0] === 1'b1) ? p_Result_3_fu_171_p3 : p_Result_5_fu_207_p3);

assign sendWord_last_V_fu_231_p2 = ((p_Result_4_i_fu_179_p4 == 4'd0) ? 1'b1 : 1'b0);

assign tmp_last_V_fu_149_p1 = s_axis_tx_data_TLAST;

assign tmp_nbreadreq_fu_72_p5 = s_axis_tx_data_TVALID;

assign trunc_ln647_1_fu_167_p1 = s_axis_tx_data_TKEEP[3:0];

assign trunc_ln647_fu_157_p1 = s_axis_tx_data_TDATA[31:0];

assign xor_ln761_fu_249_p2 = (sendWord_last_V_fu_231_p2 ^ 1'd1);

endmodule //lshiftWordByOctet