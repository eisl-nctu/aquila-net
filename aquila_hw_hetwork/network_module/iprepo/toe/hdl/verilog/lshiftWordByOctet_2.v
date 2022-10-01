// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2019.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module lshiftWordByOctet_2 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        rxEng_dataBuffer4_V_1_dout,
        rxEng_dataBuffer4_V_1_empty_n,
        rxEng_dataBuffer4_V_1_read,
        rxEng_dataBuffer4_V_2_dout,
        rxEng_dataBuffer4_V_2_empty_n,
        rxEng_dataBuffer4_V_2_read,
        rxEng_dataBuffer4_V_s_dout,
        rxEng_dataBuffer4_V_s_empty_n,
        rxEng_dataBuffer4_V_s_read,
        rxEng_dataBuffer5_V_1_din,
        rxEng_dataBuffer5_V_1_full_n,
        rxEng_dataBuffer5_V_1_write,
        rxEng_dataBuffer5_V_2_din,
        rxEng_dataBuffer5_V_2_full_n,
        rxEng_dataBuffer5_V_2_write,
        rxEng_dataBuffer5_V_s_din,
        rxEng_dataBuffer5_V_s_full_n,
        rxEng_dataBuffer5_V_s_write
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [63:0] rxEng_dataBuffer4_V_1_dout;
input   rxEng_dataBuffer4_V_1_empty_n;
output   rxEng_dataBuffer4_V_1_read;
input  [7:0] rxEng_dataBuffer4_V_2_dout;
input   rxEng_dataBuffer4_V_2_empty_n;
output   rxEng_dataBuffer4_V_2_read;
input  [0:0] rxEng_dataBuffer4_V_s_dout;
input   rxEng_dataBuffer4_V_s_empty_n;
output   rxEng_dataBuffer4_V_s_read;
output  [63:0] rxEng_dataBuffer5_V_1_din;
input   rxEng_dataBuffer5_V_1_full_n;
output   rxEng_dataBuffer5_V_1_write;
output  [7:0] rxEng_dataBuffer5_V_2_din;
input   rxEng_dataBuffer5_V_2_full_n;
output   rxEng_dataBuffer5_V_2_write;
output  [0:0] rxEng_dataBuffer5_V_s_din;
input   rxEng_dataBuffer5_V_s_full_n;
output   rxEng_dataBuffer5_V_s_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg rxEng_dataBuffer4_V_1_read;
reg rxEng_dataBuffer4_V_2_read;
reg rxEng_dataBuffer4_V_s_read;
reg[63:0] rxEng_dataBuffer5_V_1_din;
reg rxEng_dataBuffer5_V_1_write;
reg[7:0] rxEng_dataBuffer5_V_2_din;
reg rxEng_dataBuffer5_V_2_write;
reg[0:0] rxEng_dataBuffer5_V_s_din;
reg rxEng_dataBuffer5_V_s_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_idle_pp0;
wire    io_acc_block_signal_op9;
wire   [0:0] ls_writeRemainder_1_s_load_fu_126_p1;
wire   [0:0] tmp_nbreadreq_fu_70_p5;
reg    ap_predicate_op9_read_state1;
reg    ap_block_state1_pp0_stage0_iter0;
wire    io_acc_block_signal_op44;
reg   [0:0] ls_writeRemainder_1_s_reg_297;
reg   [0:0] tmp_reg_301;
reg    ap_predicate_op44_write_state2;
wire    io_acc_block_signal_op49;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_pp0_stage0_11001;
reg   [0:0] ls_writeRemainder_1;
reg   [63:0] prevWord_data_V_12;
reg   [7:0] prevWord_keep_V_4;
reg   [0:0] ls_firstWord_1;
reg    rxEng_dataBuffer5_V_1_blk_n;
wire    ap_block_pp0_stage0;
reg    rxEng_dataBuffer5_V_2_blk_n;
reg    rxEng_dataBuffer5_V_s_blk_n;
reg    rxEng_dataBuffer4_V_1_blk_n;
reg    rxEng_dataBuffer4_V_2_blk_n;
reg    rxEng_dataBuffer4_V_s_blk_n;
wire   [7:0] sendWord_keep_V_fu_213_p3;
reg   [7:0] sendWord_keep_V_reg_308;
wire   [63:0] sendWord_data_V_fu_221_p3;
reg   [63:0] sendWord_data_V_reg_313;
wire   [0:0] sendWord_last_V_fu_229_p2;
reg   [0:0] sendWord_last_V_reg_318;
reg   [31:0] p_Result_i_reg_323;
wire   [3:0] grp_fu_117_p4;
reg   [3:0] p_Result_i_368_reg_328;
reg    ap_block_pp0_stage0_subdone;
reg   [0:0] ap_phi_mux_ls_firstWord_1_new_0_phi_fu_109_p4;
wire   [0:0] ap_phi_reg_pp0_iter0_ls_firstWord_1_new_0_reg_106;
wire   [0:0] tmp_last_V_fu_147_p1;
wire   [0:0] xor_ln761_fu_247_p2;
reg    ap_block_pp0_stage0_01001;
wire   [63:0] p_Result_s_fu_281_p3;
wire   [7:0] p_Result_78_fu_289_p3;
wire   [3:0] trunc_ln647_8_fu_165_p1;
wire   [31:0] trunc_ln647_fu_155_p1;
wire   [31:0] p_Result_40_i_fu_187_p4;
wire   [7:0] p_Result_80_fu_169_p3;
wire   [7:0] p_Result_82_fu_205_p3;
wire   [63:0] p_Result_79_fu_159_p2;
wire   [63:0] p_Result_81_fu_197_p3;
wire   [3:0] p_Result_39_i_fu_177_p4;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to0;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_169;
reg    ap_condition_151;
reg    ap_condition_100;
reg    ap_condition_178;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ls_writeRemainder_1 = 1'd0;
#0 prevWord_data_V_12 = 64'd0;
#0 prevWord_keep_V_4 = 8'd0;
#0 ls_firstWord_1 = 1'd1;
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
    if ((1'b1 == ap_condition_100)) begin
        if ((ls_writeRemainder_1_s_load_fu_126_p1 == 1'd1)) begin
            ls_writeRemainder_1 <= 1'd0;
        end else if ((1'b1 == ap_condition_151)) begin
            ls_writeRemainder_1 <= xor_ln761_fu_247_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_70_p5 == 1'd1) & (ls_writeRemainder_1 == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ls_firstWord_1 <= ap_phi_mux_ls_firstWord_1_new_0_phi_fu_109_p4;
        prevWord_data_V_12 <= rxEng_dataBuffer4_V_1_dout;
        prevWord_keep_V_4 <= rxEng_dataBuffer4_V_2_dout;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ls_writeRemainder_1_s_reg_297 <= ls_writeRemainder_1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ls_writeRemainder_1_s_load_fu_126_p1 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        p_Result_i_368_reg_328 <= {{prevWord_keep_V_4[7:4]}};
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ls_writeRemainder_1_s_load_fu_126_p1 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        p_Result_i_reg_323 <= {{prevWord_data_V_12[63:32]}};
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_70_p5 == 1'd1) & (ls_writeRemainder_1 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        sendWord_data_V_reg_313 <= sendWord_data_V_fu_221_p3;
        sendWord_keep_V_reg_308 <= sendWord_keep_V_fu_213_p3;
        sendWord_last_V_reg_318 <= sendWord_last_V_fu_229_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ls_writeRemainder_1 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_reg_301 <= tmp_nbreadreq_fu_70_p5;
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
    if ((1'b1 == ap_condition_169)) begin
        if ((tmp_last_V_fu_147_p1 == 1'd0)) begin
            ap_phi_mux_ls_firstWord_1_new_0_phi_fu_109_p4 = 1'd0;
        end else if ((tmp_last_V_fu_147_p1 == 1'd1)) begin
            ap_phi_mux_ls_firstWord_1_new_0_phi_fu_109_p4 = 1'd1;
        end else begin
            ap_phi_mux_ls_firstWord_1_new_0_phi_fu_109_p4 = ap_phi_reg_pp0_iter0_ls_firstWord_1_new_0_reg_106;
        end
    end else begin
        ap_phi_mux_ls_firstWord_1_new_0_phi_fu_109_p4 = ap_phi_reg_pp0_iter0_ls_firstWord_1_new_0_reg_106;
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
        rxEng_dataBuffer4_V_1_blk_n = rxEng_dataBuffer4_V_1_empty_n;
    end else begin
        rxEng_dataBuffer4_V_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op9_read_state1 == 1'b1))) begin
        rxEng_dataBuffer4_V_1_read = 1'b1;
    end else begin
        rxEng_dataBuffer4_V_1_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op9_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        rxEng_dataBuffer4_V_2_blk_n = rxEng_dataBuffer4_V_2_empty_n;
    end else begin
        rxEng_dataBuffer4_V_2_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op9_read_state1 == 1'b1))) begin
        rxEng_dataBuffer4_V_2_read = 1'b1;
    end else begin
        rxEng_dataBuffer4_V_2_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op9_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        rxEng_dataBuffer4_V_s_blk_n = rxEng_dataBuffer4_V_s_empty_n;
    end else begin
        rxEng_dataBuffer4_V_s_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op9_read_state1 == 1'b1))) begin
        rxEng_dataBuffer4_V_s_read = 1'b1;
    end else begin
        rxEng_dataBuffer4_V_s_read = 1'b0;
    end
end

always @ (*) begin
    if ((((ls_writeRemainder_1_s_reg_297 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op44_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)))) begin
        rxEng_dataBuffer5_V_1_blk_n = rxEng_dataBuffer5_V_1_full_n;
    end else begin
        rxEng_dataBuffer5_V_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_178)) begin
        if ((ls_writeRemainder_1_s_reg_297 == 1'd1)) begin
            rxEng_dataBuffer5_V_1_din = p_Result_s_fu_281_p3;
        end else if ((ap_predicate_op44_write_state2 == 1'b1)) begin
            rxEng_dataBuffer5_V_1_din = sendWord_data_V_reg_313;
        end else begin
            rxEng_dataBuffer5_V_1_din = 'bx;
        end
    end else begin
        rxEng_dataBuffer5_V_1_din = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (ls_writeRemainder_1_s_reg_297 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op44_write_state2 == 1'b1)))) begin
        rxEng_dataBuffer5_V_1_write = 1'b1;
    end else begin
        rxEng_dataBuffer5_V_1_write = 1'b0;
    end
end

always @ (*) begin
    if ((((ls_writeRemainder_1_s_reg_297 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op44_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)))) begin
        rxEng_dataBuffer5_V_2_blk_n = rxEng_dataBuffer5_V_2_full_n;
    end else begin
        rxEng_dataBuffer5_V_2_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_178)) begin
        if ((ls_writeRemainder_1_s_reg_297 == 1'd1)) begin
            rxEng_dataBuffer5_V_2_din = p_Result_78_fu_289_p3;
        end else if ((ap_predicate_op44_write_state2 == 1'b1)) begin
            rxEng_dataBuffer5_V_2_din = sendWord_keep_V_reg_308;
        end else begin
            rxEng_dataBuffer5_V_2_din = 'bx;
        end
    end else begin
        rxEng_dataBuffer5_V_2_din = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (ls_writeRemainder_1_s_reg_297 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op44_write_state2 == 1'b1)))) begin
        rxEng_dataBuffer5_V_2_write = 1'b1;
    end else begin
        rxEng_dataBuffer5_V_2_write = 1'b0;
    end
end

always @ (*) begin
    if ((((ls_writeRemainder_1_s_reg_297 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op44_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)))) begin
        rxEng_dataBuffer5_V_s_blk_n = rxEng_dataBuffer5_V_s_full_n;
    end else begin
        rxEng_dataBuffer5_V_s_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_178)) begin
        if ((ls_writeRemainder_1_s_reg_297 == 1'd1)) begin
            rxEng_dataBuffer5_V_s_din = 1'd1;
        end else if ((ap_predicate_op44_write_state2 == 1'b1)) begin
            rxEng_dataBuffer5_V_s_din = sendWord_last_V_reg_318;
        end else begin
            rxEng_dataBuffer5_V_s_din = 'bx;
        end
    end else begin
        rxEng_dataBuffer5_V_s_din = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (ls_writeRemainder_1_s_reg_297 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op44_write_state2 == 1'b1)))) begin
        rxEng_dataBuffer5_V_s_write = 1'b1;
    end else begin
        rxEng_dataBuffer5_V_s_write = 1'b0;
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
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((ls_writeRemainder_1_s_reg_297 == 1'd1) & (io_acc_block_signal_op49 == 1'b0)) | ((io_acc_block_signal_op44 == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((io_acc_block_signal_op9 == 1'b0) & (ap_predicate_op9_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((ls_writeRemainder_1_s_reg_297 == 1'd1) & (io_acc_block_signal_op49 == 1'b0)) | ((io_acc_block_signal_op44 == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((io_acc_block_signal_op9 == 1'b0) & (ap_predicate_op9_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((ls_writeRemainder_1_s_reg_297 == 1'd1) & (io_acc_block_signal_op49 == 1'b0)) | ((io_acc_block_signal_op44 == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((io_acc_block_signal_op9 == 1'b0) & (ap_predicate_op9_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((io_acc_block_signal_op9 == 1'b0) & (ap_predicate_op9_read_state1 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = (((ls_writeRemainder_1_s_reg_297 == 1'd1) & (io_acc_block_signal_op49 == 1'b0)) | ((io_acc_block_signal_op44 == 1'b0) & (ap_predicate_op44_write_state2 == 1'b1)));
end

always @ (*) begin
    ap_condition_100 = ((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_condition_151 = ((tmp_last_V_fu_147_p1 == 1'd1) & (tmp_nbreadreq_fu_70_p5 == 1'd1) & (ls_writeRemainder_1 == 1'd0));
end

always @ (*) begin
    ap_condition_169 = ((tmp_nbreadreq_fu_70_p5 == 1'd1) & (ls_writeRemainder_1 == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0));
end

always @ (*) begin
    ap_condition_178 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_01001));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

assign ap_phi_reg_pp0_iter0_ls_firstWord_1_new_0_reg_106 = 'bx;

always @ (*) begin
    ap_predicate_op44_write_state2 = ((tmp_reg_301 == 1'd1) & (ls_writeRemainder_1_s_reg_297 == 1'd0));
end

always @ (*) begin
    ap_predicate_op9_read_state1 = ((tmp_nbreadreq_fu_70_p5 == 1'd1) & (ls_writeRemainder_1 == 1'd0));
end

assign grp_fu_117_p4 = {{prevWord_keep_V_4[7:4]}};

assign io_acc_block_signal_op44 = (rxEng_dataBuffer5_V_s_full_n & rxEng_dataBuffer5_V_2_full_n & rxEng_dataBuffer5_V_1_full_n);

assign io_acc_block_signal_op49 = (rxEng_dataBuffer5_V_s_full_n & rxEng_dataBuffer5_V_2_full_n & rxEng_dataBuffer5_V_1_full_n);

assign io_acc_block_signal_op9 = (rxEng_dataBuffer4_V_s_empty_n & rxEng_dataBuffer4_V_2_empty_n & rxEng_dataBuffer4_V_1_empty_n);

assign ls_writeRemainder_1_s_load_fu_126_p1 = ls_writeRemainder_1;

assign p_Result_39_i_fu_177_p4 = {{rxEng_dataBuffer4_V_2_dout[7:4]}};

assign p_Result_40_i_fu_187_p4 = {{prevWord_data_V_12[63:32]}};

assign p_Result_78_fu_289_p3 = {{4'd0}, {p_Result_i_368_reg_328}};

assign p_Result_79_fu_159_p2 = rxEng_dataBuffer4_V_1_dout << 64'd32;

assign p_Result_80_fu_169_p3 = {{trunc_ln647_8_fu_165_p1}, {4'd15}};

assign p_Result_81_fu_197_p3 = {{trunc_ln647_fu_155_p1}, {p_Result_40_i_fu_187_p4}};

assign p_Result_82_fu_205_p3 = {{trunc_ln647_8_fu_165_p1}, {grp_fu_117_p4}};

assign p_Result_s_fu_281_p3 = {{32'd0}, {p_Result_i_reg_323}};

assign sendWord_data_V_fu_221_p3 = ((ls_firstWord_1[0:0] === 1'b1) ? p_Result_79_fu_159_p2 : p_Result_81_fu_197_p3);

assign sendWord_keep_V_fu_213_p3 = ((ls_firstWord_1[0:0] === 1'b1) ? p_Result_80_fu_169_p3 : p_Result_82_fu_205_p3);

assign sendWord_last_V_fu_229_p2 = ((p_Result_39_i_fu_177_p4 == 4'd0) ? 1'b1 : 1'b0);

assign tmp_last_V_fu_147_p1 = rxEng_dataBuffer4_V_s_dout;

assign tmp_nbreadreq_fu_70_p5 = (rxEng_dataBuffer4_V_s_empty_n & rxEng_dataBuffer4_V_2_empty_n & rxEng_dataBuffer4_V_1_empty_n);

assign trunc_ln647_8_fu_165_p1 = rxEng_dataBuffer4_V_2_dout[3:0];

assign trunc_ln647_fu_155_p1 = rxEng_dataBuffer4_V_1_dout[31:0];

assign xor_ln761_fu_247_p2 = (sendWord_last_V_fu_229_p2 ^ 1'd1);

endmodule //lshiftWordByOctet_2