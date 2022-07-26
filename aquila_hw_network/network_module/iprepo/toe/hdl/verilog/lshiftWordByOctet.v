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
        txEng_tcpPkgBuffer5_s_4_dout,
        txEng_tcpPkgBuffer5_s_4_empty_n,
        txEng_tcpPkgBuffer5_s_4_read,
        txEng_tcpPkgBuffer6_s_3_din,
        txEng_tcpPkgBuffer6_s_3_full_n,
        txEng_tcpPkgBuffer6_s_3_write
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [72:0] txEng_tcpPkgBuffer5_s_4_dout;
input   txEng_tcpPkgBuffer5_s_4_empty_n;
output   txEng_tcpPkgBuffer5_s_4_read;
output  [72:0] txEng_tcpPkgBuffer6_s_3_din;
input   txEng_tcpPkgBuffer6_s_3_full_n;
output   txEng_tcpPkgBuffer6_s_3_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg txEng_tcpPkgBuffer5_s_4_read;
reg[72:0] txEng_tcpPkgBuffer6_s_3_din;
reg txEng_tcpPkgBuffer6_s_3_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_idle_pp0;
wire   [0:0] ls_writeRemainder_lo_load_fu_134_p1;
wire   [0:0] tmp_nbreadreq_fu_82_p3;
reg    ap_predicate_op7_read_state1;
reg    ap_block_state1_pp0_stage0_iter0;
reg   [0:0] ls_writeRemainder_lo_reg_305;
reg   [0:0] tmp_reg_309;
reg    ap_predicate_op35_write_state2;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_pp0_stage0_11001;
reg   [0:0] ls_writeRemainder;
reg   [63:0] prevWord_data_V_11;
reg   [7:0] prevWord_keep_V_10;
reg   [0:0] ls_firstWord;
reg    txEng_tcpPkgBuffer6_s_3_blk_n;
wire    ap_block_pp0_stage0;
reg    txEng_tcpPkgBuffer5_s_4_blk_n;
wire   [63:0] p_Val2_53_fu_138_p1;
reg   [63:0] p_Val2_53_reg_313;
reg   [7:0] p_Val2_3_reg_318;
wire   [31:0] trunc_ln647_fu_160_p1;
reg   [31:0] trunc_ln647_reg_326;
reg   [3:0] p_Result_24_i_reg_332;
wire   [0:0] sendWord_last_V_fu_184_p2;
reg   [0:0] sendWord_last_V_reg_338;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] ap_phi_reg_pp0_iter0_ls_firstWord_new_0_i_reg_103;
reg   [0:0] ap_phi_reg_pp0_iter1_ls_firstWord_new_0_i_reg_103;
wire   [0:0] tmp_221_fu_152_p3;
wire   [0:0] xor_ln761_fu_190_p2;
wire   [72:0] tmp_2_fu_266_p4;
reg    ap_block_pp0_stage0_01001;
wire   [72:0] tmp39_fu_292_p5;
wire   [3:0] p_Result_26_i_fu_174_p4;
wire   [31:0] grp_fu_116_p4;
wire   [3:0] grp_fu_125_p4;
wire   [7:0] p_Result_83_fu_229_p3;
wire   [7:0] p_Result_85_fu_243_p3;
wire   [63:0] p_Result_s_fu_222_p3;
wire   [63:0] p_Result_84_fu_236_p3;
wire   [7:0] sendWord_keep_V_fu_250_p3;
wire   [63:0] sendWord_data_V_fu_258_p3;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to0;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_123;
reg    ap_condition_127;
reg    ap_condition_78;
reg    ap_condition_148;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ls_writeRemainder = 1'd0;
#0 prevWord_data_V_11 = 64'd0;
#0 prevWord_keep_V_10 = 8'd0;
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
    if ((1'b1 == ap_condition_78)) begin
        if ((1'b1 == ap_condition_127)) begin
            ap_phi_reg_pp0_iter1_ls_firstWord_new_0_i_reg_103 <= 1'd0;
        end else if ((1'b1 == ap_condition_123)) begin
            ap_phi_reg_pp0_iter1_ls_firstWord_new_0_i_reg_103 <= 1'd1;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_ls_firstWord_new_0_i_reg_103 <= ap_phi_reg_pp0_iter0_ls_firstWord_new_0_i_reg_103;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_78)) begin
        if ((ls_writeRemainder_lo_load_fu_134_p1 == 1'd1)) begin
            ls_writeRemainder <= 1'd0;
        end else if ((1'b1 == ap_condition_123)) begin
            ls_writeRemainder <= xor_ln761_fu_190_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_reg_309 == 1'd1) & (ls_writeRemainder_lo_reg_305 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ls_firstWord <= ap_phi_reg_pp0_iter1_ls_firstWord_new_0_i_reg_103;
        prevWord_data_V_11 <= p_Val2_53_reg_313;
        prevWord_keep_V_10 <= p_Val2_3_reg_318;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ls_writeRemainder_lo_reg_305 <= ls_writeRemainder;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_82_p3 == 1'd1) & (ls_writeRemainder == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        p_Result_24_i_reg_332 <= {{txEng_tcpPkgBuffer5_s_4_dout[67:64]}};
        p_Val2_3_reg_318 <= {{txEng_tcpPkgBuffer5_s_4_dout[71:64]}};
        p_Val2_53_reg_313 <= p_Val2_53_fu_138_p1;
        sendWord_last_V_reg_338 <= sendWord_last_V_fu_184_p2;
        trunc_ln647_reg_326 <= trunc_ln647_fu_160_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ls_writeRemainder == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_reg_309 <= tmp_nbreadreq_fu_82_p3;
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
        txEng_tcpPkgBuffer5_s_4_blk_n = txEng_tcpPkgBuffer5_s_4_empty_n;
    end else begin
        txEng_tcpPkgBuffer5_s_4_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op7_read_state1 == 1'b1))) begin
        txEng_tcpPkgBuffer5_s_4_read = 1'b1;
    end else begin
        txEng_tcpPkgBuffer5_s_4_read = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0) & (ls_writeRemainder_lo_reg_305 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op35_write_state2 == 1'b1)))) begin
        txEng_tcpPkgBuffer6_s_3_blk_n = txEng_tcpPkgBuffer6_s_3_full_n;
    end else begin
        txEng_tcpPkgBuffer6_s_3_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_148)) begin
        if ((ls_writeRemainder_lo_reg_305 == 1'd1)) begin
            txEng_tcpPkgBuffer6_s_3_din = tmp39_fu_292_p5;
        end else if ((ap_predicate_op35_write_state2 == 1'b1)) begin
            txEng_tcpPkgBuffer6_s_3_din = tmp_2_fu_266_p4;
        end else begin
            txEng_tcpPkgBuffer6_s_3_din = 'bx;
        end
    end else begin
        txEng_tcpPkgBuffer6_s_3_din = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (ls_writeRemainder_lo_reg_305 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op35_write_state2 == 1'b1)))) begin
        txEng_tcpPkgBuffer6_s_3_write = 1'b1;
    end else begin
        txEng_tcpPkgBuffer6_s_3_write = 1'b0;
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
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((ls_writeRemainder_lo_reg_305 == 1'd1) & (txEng_tcpPkgBuffer6_s_3_full_n == 1'b0)) | ((txEng_tcpPkgBuffer6_s_3_full_n == 1'b0) & (ap_predicate_op35_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txEng_tcpPkgBuffer5_s_4_empty_n == 1'b0) & (ap_predicate_op7_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((ls_writeRemainder_lo_reg_305 == 1'd1) & (txEng_tcpPkgBuffer6_s_3_full_n == 1'b0)) | ((txEng_tcpPkgBuffer6_s_3_full_n == 1'b0) & (ap_predicate_op35_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txEng_tcpPkgBuffer5_s_4_empty_n == 1'b0) & (ap_predicate_op7_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((ls_writeRemainder_lo_reg_305 == 1'd1) & (txEng_tcpPkgBuffer6_s_3_full_n == 1'b0)) | ((txEng_tcpPkgBuffer6_s_3_full_n == 1'b0) & (ap_predicate_op35_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txEng_tcpPkgBuffer5_s_4_empty_n == 1'b0) & (ap_predicate_op7_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((txEng_tcpPkgBuffer5_s_4_empty_n == 1'b0) & (ap_predicate_op7_read_state1 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = (((ls_writeRemainder_lo_reg_305 == 1'd1) & (txEng_tcpPkgBuffer6_s_3_full_n == 1'b0)) | ((txEng_tcpPkgBuffer6_s_3_full_n == 1'b0) & (ap_predicate_op35_write_state2 == 1'b1)));
end

always @ (*) begin
    ap_condition_123 = ((tmp_221_fu_152_p3 == 1'd1) & (tmp_nbreadreq_fu_82_p3 == 1'd1) & (ls_writeRemainder == 1'd0));
end

always @ (*) begin
    ap_condition_127 = ((tmp_nbreadreq_fu_82_p3 == 1'd1) & (tmp_221_fu_152_p3 == 1'd0) & (ls_writeRemainder == 1'd0));
end

always @ (*) begin
    ap_condition_148 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_01001));
end

always @ (*) begin
    ap_condition_78 = ((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

assign ap_phi_reg_pp0_iter0_ls_firstWord_new_0_i_reg_103 = 'bx;

always @ (*) begin
    ap_predicate_op35_write_state2 = ((tmp_reg_309 == 1'd1) & (ls_writeRemainder_lo_reg_305 == 1'd0));
end

always @ (*) begin
    ap_predicate_op7_read_state1 = ((tmp_nbreadreq_fu_82_p3 == 1'd1) & (ls_writeRemainder == 1'd0));
end

assign grp_fu_116_p4 = {{prevWord_data_V_11[63:32]}};

assign grp_fu_125_p4 = {{prevWord_keep_V_10[7:4]}};

assign ls_writeRemainder_lo_load_fu_134_p1 = ls_writeRemainder;

assign p_Result_26_i_fu_174_p4 = {{txEng_tcpPkgBuffer5_s_4_dout[71:68]}};

assign p_Result_83_fu_229_p3 = {{p_Result_24_i_reg_332}, {4'd15}};

assign p_Result_84_fu_236_p3 = {{trunc_ln647_reg_326}, {grp_fu_116_p4}};

assign p_Result_85_fu_243_p3 = {{p_Result_24_i_reg_332}, {grp_fu_125_p4}};

assign p_Result_s_fu_222_p3 = {{trunc_ln647_reg_326}, {32'd0}};

assign p_Val2_53_fu_138_p1 = txEng_tcpPkgBuffer5_s_4_dout[63:0];

assign sendWord_data_V_fu_258_p3 = ((ls_firstWord[0:0] === 1'b1) ? p_Result_s_fu_222_p3 : p_Result_84_fu_236_p3);

assign sendWord_keep_V_fu_250_p3 = ((ls_firstWord[0:0] === 1'b1) ? p_Result_83_fu_229_p3 : p_Result_85_fu_243_p3);

assign sendWord_last_V_fu_184_p2 = ((p_Result_26_i_fu_174_p4 == 4'd0) ? 1'b1 : 1'b0);

assign tmp39_fu_292_p5 = {{{{{{5'd16}, {grp_fu_125_p4}}}, {32'd0}}}, {grp_fu_116_p4}};

assign tmp_221_fu_152_p3 = txEng_tcpPkgBuffer5_s_4_dout[32'd72];

assign tmp_2_fu_266_p4 = {{{sendWord_last_V_reg_338}, {sendWord_keep_V_fu_250_p3}}, {sendWord_data_V_fu_258_p3}};

assign tmp_nbreadreq_fu_82_p3 = txEng_tcpPkgBuffer5_s_4_empty_n;

assign trunc_ln647_fu_160_p1 = txEng_tcpPkgBuffer5_s_4_dout[31:0];

assign xor_ln761_fu_190_p2 = (sendWord_last_V_fu_184_p2 ^ 1'd1);

endmodule //lshiftWordByOctet
