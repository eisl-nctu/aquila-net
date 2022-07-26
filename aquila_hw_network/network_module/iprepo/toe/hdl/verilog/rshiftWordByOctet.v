// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2019.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module rshiftWordByOctet (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        txEng_tcpPkgBuffer3_s_6_dout,
        txEng_tcpPkgBuffer3_s_6_empty_n,
        txEng_tcpPkgBuffer3_s_6_read,
        txEng_tcpPkgBuffer4_s_5_din,
        txEng_tcpPkgBuffer4_s_5_full_n,
        txEng_tcpPkgBuffer4_s_5_write
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [72:0] txEng_tcpPkgBuffer3_s_6_dout;
input   txEng_tcpPkgBuffer3_s_6_empty_n;
output   txEng_tcpPkgBuffer3_s_6_read;
output  [72:0] txEng_tcpPkgBuffer4_s_5_din;
input   txEng_tcpPkgBuffer4_s_5_full_n;
output   txEng_tcpPkgBuffer4_s_5_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg txEng_tcpPkgBuffer3_s_6_read;
reg[72:0] txEng_tcpPkgBuffer4_s_5_din;
reg txEng_tcpPkgBuffer4_s_5_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_idle_pp0;
wire   [0:0] fsmState_load_load_fu_137_p1;
wire   [0:0] tmp_nbreadreq_fu_76_p3;
reg    ap_predicate_op7_read_state1;
reg    ap_block_state1_pp0_stage0_iter0;
reg   [0:0] fsmState_load_reg_261;
reg   [0:0] tmp_reg_265;
reg   [0:0] rs_firstWord_load_reg_283;
reg    ap_predicate_op34_write_state2;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_pp0_stage0_11001;
reg   [0:0] fsmState;
reg   [63:0] prevWord_data_V_8;
reg   [7:0] prevWord_keep_V_7;
reg   [0:0] rs_firstWord;
reg    txEng_tcpPkgBuffer3_s_6_blk_n;
wire    ap_block_pp0_stage0;
reg    txEng_tcpPkgBuffer4_s_5_blk_n;
wire   [63:0] p_Val2_20_fu_141_p1;
reg   [63:0] p_Val2_20_reg_269;
reg   [7:0] p_Val2_2_reg_274;
wire   [0:0] tmp_135_fu_155_p3;
wire   [0:0] rs_firstWord_load_load_fu_163_p1;
wire   [31:0] trunc_ln647_fu_167_p1;
reg   [31:0] trunc_ln647_reg_287;
reg   [3:0] p_Result_19_i_reg_292;
wire   [0:0] tmp_last_V_fu_191_p2;
reg   [0:0] tmp_last_V_reg_297;
reg    ap_block_pp0_stage0_subdone;
reg   [0:0] ap_phi_mux_p_0256_2_0_i_phi_fu_100_p4;
wire   [0:0] ap_phi_reg_pp0_iter0_p_0256_2_0_i_reg_97;
reg   [0:0] ap_phi_mux_rs_firstWord_new_0_i_phi_fu_111_p4;
wire   [0:0] ap_phi_reg_pp0_iter0_rs_firstWord_new_0_i_reg_108;
wire   [72:0] tmp_1_fu_226_p6;
reg    ap_block_pp0_stage0_01001;
wire   [72:0] tmp_2_fu_248_p5;
wire   [3:0] p_Result_20_i_fu_181_p4;
wire   [3:0] grp_fu_128_p4;
wire   [31:0] grp_fu_119_p4;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to0;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_161;
reg    ap_condition_148;
reg    ap_condition_81;
reg    ap_condition_169;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 fsmState = 1'd0;
#0 prevWord_data_V_8 = 64'd0;
#0 prevWord_keep_V_7 = 8'd0;
#0 rs_firstWord = 1'd1;
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
    if ((1'b1 == ap_condition_81)) begin
        if ((fsmState_load_load_fu_137_p1 == 1'd1)) begin
            fsmState <= 1'd0;
        end else if ((1'b1 == ap_condition_148)) begin
            fsmState <= 1'd1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        fsmState_load_reg_261 <= fsmState;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_76_p3 == 1'd1) & (rs_firstWord_load_load_fu_163_p1 == 1'd0) & (fsmState == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        p_Result_19_i_reg_292 <= {{txEng_tcpPkgBuffer3_s_6_dout[67:64]}};
        tmp_last_V_reg_297 <= tmp_last_V_fu_191_p2;
        trunc_ln647_reg_287 <= trunc_ln647_fu_167_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_76_p3 == 1'd1) & (fsmState == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        p_Val2_20_reg_269 <= p_Val2_20_fu_141_p1;
        p_Val2_2_reg_274 <= {{txEng_tcpPkgBuffer3_s_6_dout[71:64]}};
        rs_firstWord_load_reg_283 <= rs_firstWord;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_reg_265 == 1'd1) & (fsmState_load_reg_261 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        prevWord_data_V_8 <= p_Val2_20_reg_269;
        prevWord_keep_V_7 <= p_Val2_2_reg_274;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_76_p3 == 1'd1) & (fsmState == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        rs_firstWord <= ap_phi_mux_rs_firstWord_new_0_i_phi_fu_111_p4;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (fsmState == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_reg_265 <= tmp_nbreadreq_fu_76_p3;
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
    if ((1'b1 == ap_condition_161)) begin
        if ((rs_firstWord_load_load_fu_163_p1 == 1'd1)) begin
            ap_phi_mux_p_0256_2_0_i_phi_fu_100_p4 = 1'd0;
        end else if ((rs_firstWord_load_load_fu_163_p1 == 1'd0)) begin
            ap_phi_mux_p_0256_2_0_i_phi_fu_100_p4 = tmp_last_V_fu_191_p2;
        end else begin
            ap_phi_mux_p_0256_2_0_i_phi_fu_100_p4 = ap_phi_reg_pp0_iter0_p_0256_2_0_i_reg_97;
        end
    end else begin
        ap_phi_mux_p_0256_2_0_i_phi_fu_100_p4 = ap_phi_reg_pp0_iter0_p_0256_2_0_i_reg_97;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_161)) begin
        if ((tmp_135_fu_155_p3 == 1'd0)) begin
            ap_phi_mux_rs_firstWord_new_0_i_phi_fu_111_p4 = 1'd0;
        end else if ((tmp_135_fu_155_p3 == 1'd1)) begin
            ap_phi_mux_rs_firstWord_new_0_i_phi_fu_111_p4 = 1'd1;
        end else begin
            ap_phi_mux_rs_firstWord_new_0_i_phi_fu_111_p4 = ap_phi_reg_pp0_iter0_rs_firstWord_new_0_i_reg_108;
        end
    end else begin
        ap_phi_mux_rs_firstWord_new_0_i_phi_fu_111_p4 = ap_phi_reg_pp0_iter0_rs_firstWord_new_0_i_reg_108;
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
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op7_read_state1 == 1'b1))) begin
        txEng_tcpPkgBuffer3_s_6_blk_n = txEng_tcpPkgBuffer3_s_6_empty_n;
    end else begin
        txEng_tcpPkgBuffer3_s_6_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op7_read_state1 == 1'b1))) begin
        txEng_tcpPkgBuffer3_s_6_read = 1'b1;
    end else begin
        txEng_tcpPkgBuffer3_s_6_read = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0) & (fsmState_load_reg_261 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op34_write_state2 == 1'b1)))) begin
        txEng_tcpPkgBuffer4_s_5_blk_n = txEng_tcpPkgBuffer4_s_5_full_n;
    end else begin
        txEng_tcpPkgBuffer4_s_5_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_169)) begin
        if ((fsmState_load_reg_261 == 1'd1)) begin
            txEng_tcpPkgBuffer4_s_5_din = tmp_2_fu_248_p5;
        end else if ((ap_predicate_op34_write_state2 == 1'b1)) begin
            txEng_tcpPkgBuffer4_s_5_din = tmp_1_fu_226_p6;
        end else begin
            txEng_tcpPkgBuffer4_s_5_din = 'bx;
        end
    end else begin
        txEng_tcpPkgBuffer4_s_5_din = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (fsmState_load_reg_261 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op34_write_state2 == 1'b1)))) begin
        txEng_tcpPkgBuffer4_s_5_write = 1'b1;
    end else begin
        txEng_tcpPkgBuffer4_s_5_write = 1'b0;
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
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((fsmState_load_reg_261 == 1'd1) & (txEng_tcpPkgBuffer4_s_5_full_n == 1'b0)) | ((txEng_tcpPkgBuffer4_s_5_full_n == 1'b0) & (ap_predicate_op34_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txEng_tcpPkgBuffer3_s_6_empty_n == 1'b0) & (ap_predicate_op7_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((fsmState_load_reg_261 == 1'd1) & (txEng_tcpPkgBuffer4_s_5_full_n == 1'b0)) | ((txEng_tcpPkgBuffer4_s_5_full_n == 1'b0) & (ap_predicate_op34_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txEng_tcpPkgBuffer3_s_6_empty_n == 1'b0) & (ap_predicate_op7_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((fsmState_load_reg_261 == 1'd1) & (txEng_tcpPkgBuffer4_s_5_full_n == 1'b0)) | ((txEng_tcpPkgBuffer4_s_5_full_n == 1'b0) & (ap_predicate_op34_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txEng_tcpPkgBuffer3_s_6_empty_n == 1'b0) & (ap_predicate_op7_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txEng_tcpPkgBuffer3_s_6_empty_n == 1'b0) & (ap_predicate_op7_read_state1 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = (((fsmState_load_reg_261 == 1'd1) & (txEng_tcpPkgBuffer4_s_5_full_n == 1'b0)) | ((txEng_tcpPkgBuffer4_s_5_full_n == 1'b0) & (ap_predicate_op34_write_state2 == 1'b1)));
end

always @ (*) begin
    ap_condition_148 = ((tmp_135_fu_155_p3 == 1'd1) & (tmp_nbreadreq_fu_76_p3 == 1'd1) & (ap_phi_mux_p_0256_2_0_i_phi_fu_100_p4 == 1'd0) & (fsmState == 1'd0));
end

always @ (*) begin
    ap_condition_161 = ((1'b0 == ap_block_pp0_stage0) & (tmp_nbreadreq_fu_76_p3 == 1'd1) & (fsmState == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_condition_169 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_01001));
end

always @ (*) begin
    ap_condition_81 = ((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

assign ap_phi_reg_pp0_iter0_p_0256_2_0_i_reg_97 = 'bx;

assign ap_phi_reg_pp0_iter0_rs_firstWord_new_0_i_reg_108 = 'bx;

always @ (*) begin
    ap_predicate_op34_write_state2 = ((tmp_reg_265 == 1'd1) & (rs_firstWord_load_reg_283 == 1'd0) & (fsmState_load_reg_261 == 1'd0));
end

always @ (*) begin
    ap_predicate_op7_read_state1 = ((tmp_nbreadreq_fu_76_p3 == 1'd1) & (fsmState == 1'd0));
end

assign fsmState_load_load_fu_137_p1 = fsmState;

assign grp_fu_119_p4 = {{prevWord_data_V_8[63:32]}};

assign grp_fu_128_p4 = {{prevWord_keep_V_7[7:4]}};

assign p_Result_20_i_fu_181_p4 = {{txEng_tcpPkgBuffer3_s_6_dout[71:68]}};

assign p_Val2_20_fu_141_p1 = txEng_tcpPkgBuffer3_s_6_dout[63:0];

assign rs_firstWord_load_load_fu_163_p1 = rs_firstWord;

assign tmp_135_fu_155_p3 = txEng_tcpPkgBuffer3_s_6_dout[32'd72];

assign tmp_1_fu_226_p6 = {{{{{tmp_last_V_reg_297}, {p_Result_19_i_reg_292}}, {grp_fu_128_p4}}, {trunc_ln647_reg_287}}, {grp_fu_119_p4}};

assign tmp_2_fu_248_p5 = {{{{{{5'd16}, {grp_fu_128_p4}}}, {32'd0}}}, {grp_fu_119_p4}};

assign tmp_last_V_fu_191_p2 = ((p_Result_20_i_fu_181_p4 == 4'd0) ? 1'b1 : 1'b0);

assign tmp_nbreadreq_fu_76_p3 = txEng_tcpPkgBuffer3_s_6_empty_n;

assign trunc_ln647_fu_167_p1 = txEng_tcpPkgBuffer3_s_6_dout[31:0];

endmodule //rshiftWordByOctet
