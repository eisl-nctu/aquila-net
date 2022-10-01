// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2019.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module drop_optional_header (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        rxEng_dataBuffer3b_V_dout,
        rxEng_dataBuffer3b_V_empty_n,
        rxEng_dataBuffer3b_V_read,
        rxEng_optionalFields_2_dout,
        rxEng_optionalFields_2_empty_n,
        rxEng_optionalFields_2_read,
        rxEng_optionalFields_3_dout,
        rxEng_optionalFields_3_empty_n,
        rxEng_optionalFields_3_read,
        rxEng_dataBuffer3_V_din,
        rxEng_dataBuffer3_V_full_n,
        rxEng_dataBuffer3_V_write
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [72:0] rxEng_dataBuffer3b_V_dout;
input   rxEng_dataBuffer3b_V_empty_n;
output   rxEng_dataBuffer3b_V_read;
input  [3:0] rxEng_optionalFields_2_dout;
input   rxEng_optionalFields_2_empty_n;
output   rxEng_optionalFields_2_read;
input  [0:0] rxEng_optionalFields_3_dout;
input   rxEng_optionalFields_3_empty_n;
output   rxEng_optionalFields_3_read;
output  [72:0] rxEng_dataBuffer3_V_din;
input   rxEng_dataBuffer3_V_full_n;
output   rxEng_dataBuffer3_V_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg rxEng_dataBuffer3b_V_read;
reg rxEng_optionalFields_2_read;
reg rxEng_optionalFields_3_read;
reg[72:0] rxEng_dataBuffer3_V_din;
reg rxEng_dataBuffer3_V_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_idle_pp0;
wire   [1:0] state_V_load_load_fu_312_p1;
wire   [0:0] grp_nbreadreq_fu_158_p3;
reg    ap_predicate_op64_read_state1;
wire    io_acc_block_signal_op96;
wire   [0:0] tmp_nbreadreq_fu_172_p4;
reg    ap_predicate_op96_read_state1;
reg    ap_predicate_op98_read_state1;
reg    ap_block_state1_pp0_stage0_iter0;
reg   [1:0] state_V_load_reg_1091;
reg   [0:0] tmp_282_reg_1142;
reg   [0:0] icmp_ln891_reg_1149;
reg   [0:0] icmp_ln879_18_reg_1153;
reg    ap_predicate_op167_write_state2;
reg    ap_predicate_op169_write_state2;
reg   [0:0] tmp_reg_1167;
reg   [0:0] tmp_291_reg_1171;
reg   [0:0] icmp_ln879_reg_1175;
reg    ap_predicate_op171_write_state2;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_pp0_stage0_11001;
reg   [1:0] state_V;
reg   [3:0] dataOffset_V;
reg   [63:0] prevWord_data_V;
reg   [7:0] prevWord_keep_V;
reg   [319:0] optionalHeader_heade;
reg    rxEng_optionalFields_2_blk_n;
wire    ap_block_pp0_stage0;
reg    rxEng_optionalFields_3_blk_n;
reg    rxEng_dataBuffer3b_V_blk_n;
reg    rxEng_dataBuffer3_V_blk_n;
reg   [72:0] reg_307;
reg   [3:0] dataOffset_V_load_reg_1095;
wire   [6:0] sub_ln647_38_fu_416_p2;
reg   [6:0] sub_ln647_38_reg_1101;
wire   [63:0] lshr_ln647_fu_426_p2;
reg   [63:0] lshr_ln647_reg_1106;
wire   [3:0] sub_ln647_41_fu_522_p2;
reg   [3:0] sub_ln647_41_reg_1111;
wire   [7:0] lshr_ln647_34_fu_532_p2;
reg   [7:0] lshr_ln647_34_reg_1116;
wire   [63:0] xor_ln391_fu_616_p2;
reg   [63:0] xor_ln391_reg_1121;
wire   [0:0] icmp_ln391_1_fu_642_p2;
reg   [0:0] icmp_ln391_1_reg_1126;
wire   [3:0] trunc_ln391_1_fu_648_p1;
reg   [3:0] trunc_ln391_1_reg_1132;
wire   [3:0] sub_ln391_1_fu_652_p2;
reg   [3:0] sub_ln391_1_reg_1137;
wire   [0:0] icmp_ln891_fu_662_p2;
wire   [0:0] icmp_ln879_18_fu_681_p2;
reg   [31:0] p_Result_s_381_reg_1157;
reg   [3:0] p_Result_1_reg_1162;
wire   [0:0] icmp_ln879_fu_810_p2;
reg    ap_block_pp0_stage0_subdone;
reg   [3:0] ap_phi_mux_dataOffset_V_load_4_s_phi_fu_200_p4;
wire   [3:0] add_ln701_fu_668_p2;
wire   [3:0] ap_phi_reg_pp0_iter0_dataOffset_V_load_4_s_reg_197;
reg   [0:0] ap_phi_mux_state_V_flag_5_i_phi_fu_209_p20;
wire   [0:0] ap_phi_reg_pp0_iter0_state_V_flag_5_i_reg_206;
wire   [0:0] or_ln563_fu_828_p2;
wire   [0:0] icmp_ln887_fu_861_p2;
wire   [0:0] grp_fu_293_p3;
reg   [1:0] ap_phi_mux_state_V_new_5_i_phi_fu_245_p20;
wire   [1:0] ap_phi_reg_pp0_iter0_state_V_new_5_i_reg_242;
wire   [1:0] select_ln566_fu_885_p3;
wire   [1:0] zext_ln563_fu_834_p1;
wire   [1:0] select_ln611_fu_755_p3;
wire   [63:0] tmp_data_V_25_fu_658_p1;
wire   [63:0] tmp_data_V_23_fu_768_p1;
wire   [7:0] grp_fu_283_p4;
wire   [319:0] p_Result_s_fu_792_p5;
wire   [72:0] tmp_5_fu_1031_p4;
reg    ap_block_pp0_stage0_01001;
wire   [72:0] tmp_4_fu_1078_p6;
wire   [8:0] Lo_assign_s_fu_334_p3;
wire   [2:0] grp_fu_274_p4;
wire   [25:0] zext_ln647_fu_346_p1;
wire   [1:0] trunc_ln621_fu_330_p1;
wire   [6:0] tmp_285_fu_356_p3;
wire   [0:0] icmp_ln647_fu_350_p2;
wire   [6:0] add_ln647_fu_374_p2;
wire   [6:0] sub_ln647_37_fu_386_p2;
reg   [63:0] tmp_286_fu_364_p4;
wire   [6:0] sub_ln647_fu_380_p2;
wire   [6:0] select_ln647_fu_392_p3;
wire   [6:0] select_ln647_29_fu_408_p3;
wire   [63:0] select_ln647_28_fu_400_p3;
wire   [63:0] zext_ln647_37_fu_422_p1;
wire   [5:0] Lo_assign_1_fu_432_p3;
wire   [2:0] tmp_287_fu_444_p4;
wire   [28:0] zext_ln647_39_fu_454_p1;
wire   [3:0] shl_ln647_fu_464_p2;
wire   [0:0] icmp_ln647_8_fu_458_p2;
wire   [3:0] add_ln647_4_fu_480_p2;
wire   [3:0] sub_ln647_40_fu_492_p2;
reg   [7:0] tmp_288_fu_470_p4;
wire   [3:0] sub_ln647_39_fu_486_p2;
wire   [3:0] select_ln647_30_fu_498_p3;
wire   [3:0] select_ln647_32_fu_514_p3;
wire   [7:0] select_ln647_31_fu_506_p3;
wire   [7:0] zext_ln647_40_fu_528_p1;
wire   [9:0] zext_ln621_fu_342_p1;
wire   [9:0] sub_ln623_fu_538_p2;
wire   [3:0] tmp_289_fu_544_p4;
wire  signed [25:0] sext_ln391_fu_554_p1;
wire   [0:0] icmp_ln391_fu_558_p2;
wire   [6:0] trunc_ln391_fu_564_p1;
wire   [6:0] sub_ln391_fu_576_p2;
wire   [6:0] select_ln391_fu_568_p3;
wire   [6:0] select_ln391_2_fu_582_p3;
wire   [63:0] zext_ln391_fu_590_p1;
wire   [63:0] zext_ln391_3_fu_594_p1;
wire   [63:0] shl_ln391_fu_598_p2;
wire   [63:0] lshr_ln391_fu_604_p2;
wire   [63:0] and_ln391_fu_610_p2;
wire   [6:0] zext_ln622_fu_440_p1;
wire   [6:0] sub_ln624_fu_622_p2;
wire   [3:0] tmp_290_fu_628_p4;
wire  signed [28:0] sext_ln391_1_fu_638_p1;
wire   [5:0] shl_ln791_2_fu_713_p3;
wire   [7:0] zext_ln791_fu_721_p1;
wire   [7:0] shl_ln791_1_fu_725_p2;
wire   [7:0] and_ln791_1_fu_731_p2;
wire   [0:0] p_Result_116_fu_737_p2;
wire   [0:0] icmp_ln883_fu_743_p2;
wire   [0:0] or_ln611_fu_749_p2;
wire   [0:0] xor_ln563_fu_822_p2;
wire   [2:0] trunc_ln791_fu_839_p1;
wire   [2:0] tmp_296_fu_851_p4;
wire   [4:0] shl_ln791_4_fu_843_p3;
wire   [4:0] shl_ln791_fu_867_p2;
wire   [4:0] tmp_keep_V_48_cast_fu_772_p4;
wire   [4:0] and_ln791_fu_873_p2;
wire   [0:0] p_Result_115_fu_879_p2;
wire   [1:0] trunc_ln621_1_fu_900_p1;
wire   [63:0] zext_ln647_38_fu_911_p1;
wire   [63:0] lshr_ln647_33_fu_914_p2;
wire   [6:0] tmp_283_fu_903_p3;
wire   [63:0] zext_ln414_fu_925_p1;
wire   [63:0] p_Result_117_fu_920_p2;
wire   [63:0] lshr_ln414_fu_929_p2;
wire   [7:0] zext_ln647_41_fu_946_p1;
wire   [7:0] lshr_ln647_35_fu_949_p2;
wire   [3:0] shl_ln622_fu_941_p2;
wire   [7:0] zext_ln414_29_fu_960_p1;
wire   [7:0] p_Result_119_fu_955_p2;
wire   [7:0] lshr_ln414_13_fu_964_p2;
wire   [63:0] p_Result_118_fu_935_p2;
wire   [3:0] select_ln391_3_fu_981_p3;
wire   [3:0] select_ln391_4_fu_987_p3;
wire   [7:0] zext_ln391_4_fu_993_p1;
wire   [7:0] zext_ln391_5_fu_997_p1;
wire   [7:0] shl_ln391_1_fu_1001_p2;
wire   [7:0] lshr_ln391_1_fu_1007_p2;
wire   [7:0] and_ln391_3_fu_1013_p2;
wire   [7:0] p_Result_120_fu_970_p2;
wire   [7:0] xor_ln391_1_fu_1019_p2;
wire   [7:0] p_Result_122_fu_1025_p2;
wire   [63:0] p_Result_121_fu_976_p2;
wire   [0:0] tmp_295_fu_1056_p3;
wire   [4:0] and_ln_fu_1064_p3;
wire   [0:0] tmp_last_V_16_fu_1072_p2;
wire   [3:0] p_Result_168_trunc_fu_1046_p4;
wire   [31:0] trunc_ln647_fu_1042_p1;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to0;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_342;
reg    ap_condition_849;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 state_V = 2'd0;
#0 dataOffset_V = 4'd0;
#0 prevWord_data_V = 64'd0;
#0 prevWord_keep_V = 8'd0;
#0 optionalHeader_heade = 320'd0;
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
        end else if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
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
    if ((1'b1 == ap_condition_849)) begin
        if (((tmp_nbreadreq_fu_172_p4 == 1'd1) & (state_V == 2'd0))) begin
            dataOffset_V <= rxEng_optionalFields_2_dout;
        end else if (((icmp_ln891_fu_662_p2 == 1'd0) & (state_V == 2'd1))) begin
            dataOffset_V <= add_ln701_fu_668_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_849)) begin
        if (((tmp_nbreadreq_fu_172_p4 == 1'd1) & (state_V == 2'd0))) begin
            prevWord_data_V <= tmp_data_V_23_fu_768_p1;
        end else if ((state_V == 2'd1)) begin
            prevWord_data_V <= tmp_data_V_25_fu_658_p1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        dataOffset_V_load_reg_1095 <= dataOffset_V;
        state_V_load_reg_1091 <= state_V;
    end
end

always @ (posedge ap_clk) begin
    if (((state_V_load_load_fu_312_p1 == 2'd2) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln391_1_reg_1126 <= icmp_ln391_1_fu_642_p2;
        lshr_ln647_34_reg_1116 <= lshr_ln647_34_fu_532_p2;
        lshr_ln647_reg_1106 <= lshr_ln647_fu_426_p2;
        sub_ln391_1_reg_1137[3 : 2] <= sub_ln391_1_fu_652_p2[3 : 2];
        sub_ln647_38_reg_1101[6 : 1] <= sub_ln647_38_fu_416_p2[6 : 1];
        sub_ln647_41_reg_1111[3 : 1] <= sub_ln647_41_fu_522_p2[3 : 1];
        trunc_ln391_1_reg_1132[3 : 2] <= trunc_ln391_1_fu_648_p1[3 : 2];
        xor_ln391_reg_1121 <= xor_ln391_fu_616_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln891_fu_662_p2 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln879_18_reg_1153 <= icmp_ln879_18_fu_681_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_nbreadreq_fu_172_p4 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln879_reg_1175 <= icmp_ln879_fu_810_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln891_reg_1149 <= icmp_ln891_fu_662_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_nbreadreq_fu_172_p4 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        optionalHeader_heade <= p_Result_s_fu_792_p5;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln879_18_fu_681_p2 == 1'd0) & (icmp_ln891_fu_662_p2 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        p_Result_1_reg_1162 <= {{prevWord_keep_V[7:4]}};
        p_Result_s_381_reg_1157 <= {{prevWord_data_V[63:32]}};
    end
end

always @ (posedge ap_clk) begin
    if ((((tmp_nbreadreq_fu_172_p4 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        prevWord_keep_V <= {{rxEng_dataBuffer3b_V_dout[71:64]}};
    end
end

always @ (posedge ap_clk) begin
    if ((((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op98_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op64_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        reg_307 <= rxEng_dataBuffer3b_V_dout;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_phi_mux_state_V_flag_5_i_phi_fu_209_p20 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        state_V <= ap_phi_mux_state_V_new_5_i_phi_fu_245_p20;
    end
end

always @ (posedge ap_clk) begin
    if (((state_V == 2'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_282_reg_1142 <= grp_nbreadreq_fu_158_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_nbreadreq_fu_172_p4 == 1'd1) & (state_V == 2'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_291_reg_1171 <= grp_nbreadreq_fu_158_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((state_V == 2'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_reg_1167 <= tmp_nbreadreq_fu_172_p4;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
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
    if ((1'b1 == ap_condition_342)) begin
        if ((icmp_ln891_fu_662_p2 == 1'd1)) begin
            ap_phi_mux_dataOffset_V_load_4_s_phi_fu_200_p4 = dataOffset_V;
        end else if ((icmp_ln891_fu_662_p2 == 1'd0)) begin
            ap_phi_mux_dataOffset_V_load_4_s_phi_fu_200_p4 = add_ln701_fu_668_p2;
        end else begin
            ap_phi_mux_dataOffset_V_load_4_s_phi_fu_200_p4 = ap_phi_reg_pp0_iter0_dataOffset_V_load_4_s_reg_197;
        end
    end else begin
        ap_phi_mux_dataOffset_V_load_4_s_phi_fu_200_p4 = ap_phi_reg_pp0_iter0_dataOffset_V_load_4_s_reg_197;
    end
end

always @ (*) begin
    if ((((tmp_nbreadreq_fu_172_p4 == 1'd1) & (or_ln563_fu_828_p2 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((or_ln563_fu_828_p2 == 1'd0) & (tmp_nbreadreq_fu_172_p4 == 1'd1) & (icmp_ln887_fu_861_p2 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((icmp_ln887_fu_861_p2 == 1'd0) & (or_ln563_fu_828_p2 == 1'd0) & (tmp_nbreadreq_fu_172_p4 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((grp_fu_293_p3 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((state_V_load_load_fu_312_p1 == 2'd2) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)))) begin
        ap_phi_mux_state_V_flag_5_i_phi_fu_209_p20 = 1'd1;
    end else if ((((tmp_nbreadreq_fu_172_p4 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd0) & (state_V == 2'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((tmp_nbreadreq_fu_172_p4 == 1'd0) & (state_V == 2'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((grp_fu_293_p3 == 1'd0) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((grp_nbreadreq_fu_158_p3 == 1'd0) & (state_V == 2'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((state_V_load_load_fu_312_p1 == 2'd3) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)))) begin
        ap_phi_mux_state_V_flag_5_i_phi_fu_209_p20 = 1'd0;
    end else begin
        ap_phi_mux_state_V_flag_5_i_phi_fu_209_p20 = ap_phi_reg_pp0_iter0_state_V_flag_5_i_reg_206;
    end
end

always @ (*) begin
    if (((grp_fu_293_p3 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_phi_mux_state_V_new_5_i_phi_fu_245_p20 = select_ln611_fu_755_p3;
    end else if (((tmp_nbreadreq_fu_172_p4 == 1'd1) & (or_ln563_fu_828_p2 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_phi_mux_state_V_new_5_i_phi_fu_245_p20 = zext_ln563_fu_834_p1;
    end else if (((or_ln563_fu_828_p2 == 1'd0) & (tmp_nbreadreq_fu_172_p4 == 1'd1) & (icmp_ln887_fu_861_p2 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_phi_mux_state_V_new_5_i_phi_fu_245_p20 = select_ln566_fu_885_p3;
    end else if ((((icmp_ln887_fu_861_p2 == 1'd0) & (or_ln563_fu_828_p2 == 1'd0) & (tmp_nbreadreq_fu_172_p4 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((state_V_load_load_fu_312_p1 == 2'd2) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)))) begin
        ap_phi_mux_state_V_new_5_i_phi_fu_245_p20 = 2'd0;
    end else begin
        ap_phi_mux_state_V_new_5_i_phi_fu_245_p20 = ap_phi_reg_pp0_iter0_state_V_new_5_i_reg_242;
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
    if (((ap_start == 1'b0) & (ap_idle_pp0_0to0 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op167_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)) | ((state_V_load_reg_1091 == 2'd2) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op171_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op169_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)))) begin
        rxEng_dataBuffer3_V_blk_n = rxEng_dataBuffer3_V_full_n;
    end else begin
        rxEng_dataBuffer3_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_01001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op171_write_state2 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0_01001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op169_write_state2 == 1'b1)))) begin
        rxEng_dataBuffer3_V_din = reg_307;
    end else if (((1'b0 == ap_block_pp0_stage0_01001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op167_write_state2 == 1'b1))) begin
        rxEng_dataBuffer3_V_din = tmp_4_fu_1078_p6;
    end else if (((state_V_load_reg_1091 == 2'd2) & (1'b0 == ap_block_pp0_stage0_01001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        rxEng_dataBuffer3_V_din = tmp_5_fu_1031_p4;
    end else begin
        rxEng_dataBuffer3_V_din = 'bx;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op167_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((state_V_load_reg_1091 == 2'd2) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op171_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op169_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        rxEng_dataBuffer3_V_write = 1'b1;
    end else begin
        rxEng_dataBuffer3_V_write = 1'b0;
    end
end

always @ (*) begin
    if (((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op98_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0)) | (~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op64_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0)))) begin
        rxEng_dataBuffer3b_V_blk_n = rxEng_dataBuffer3b_V_empty_n;
    end else begin
        rxEng_dataBuffer3b_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op98_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op64_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        rxEng_dataBuffer3b_V_read = 1'b1;
    end else begin
        rxEng_dataBuffer3b_V_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op96_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        rxEng_optionalFields_2_blk_n = rxEng_optionalFields_2_empty_n;
    end else begin
        rxEng_optionalFields_2_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op96_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rxEng_optionalFields_2_read = 1'b1;
    end else begin
        rxEng_optionalFields_2_read = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op96_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        rxEng_optionalFields_3_blk_n = rxEng_optionalFields_3_empty_n;
    end else begin
        rxEng_optionalFields_3_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op96_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rxEng_optionalFields_3_read = 1'b1;
    end else begin
        rxEng_optionalFields_3_read = 1'b0;
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

assign Lo_assign_1_fu_432_p3 = {{dataOffset_V}, {2'd0}};

assign Lo_assign_s_fu_334_p3 = {{dataOffset_V}, {5'd0}};

assign add_ln647_4_fu_480_p2 = ($signed(4'd9) + $signed(shl_ln647_fu_464_p2));

assign add_ln647_fu_374_p2 = ($signed(7'd65) + $signed(tmp_285_fu_356_p3));

assign add_ln701_fu_668_p2 = ($signed(dataOffset_V) + $signed(4'd14));

assign and_ln391_3_fu_1013_p2 = (shl_ln391_1_fu_1001_p2 & lshr_ln391_1_fu_1007_p2);

assign and_ln391_fu_610_p2 = (shl_ln391_fu_598_p2 & lshr_ln391_fu_604_p2);

assign and_ln791_1_fu_731_p2 = (shl_ln791_1_fu_725_p2 & grp_fu_283_p4);

assign and_ln791_fu_873_p2 = (tmp_keep_V_48_cast_fu_772_p4 & shl_ln791_fu_867_p2);

assign and_ln_fu_1064_p3 = {{tmp_295_fu_1056_p3}, {4'd0}};

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((io_acc_block_signal_op96 == 1'b0) & (ap_predicate_op96_read_state1 == 1'b1)) | ((rxEng_dataBuffer3b_V_empty_n == 1'b0) & (ap_predicate_op98_read_state1 == 1'b1)) | ((rxEng_dataBuffer3b_V_empty_n == 1'b0) & (ap_predicate_op64_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((rxEng_dataBuffer3_V_full_n == 1'b0) & (ap_predicate_op167_write_state2 == 1'b1)) | ((state_V_load_reg_1091 == 2'd2) & (rxEng_dataBuffer3_V_full_n == 1'b0)) | ((rxEng_dataBuffer3_V_full_n == 1'b0) & (ap_predicate_op171_write_state2 == 1'b1)) | ((rxEng_dataBuffer3_V_full_n == 1'b0) & (ap_predicate_op169_write_state2 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((io_acc_block_signal_op96 == 1'b0) & (ap_predicate_op96_read_state1 == 1'b1)) | ((rxEng_dataBuffer3b_V_empty_n == 1'b0) & (ap_predicate_op98_read_state1 == 1'b1)) | ((rxEng_dataBuffer3b_V_empty_n == 1'b0) & (ap_predicate_op64_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((rxEng_dataBuffer3_V_full_n == 1'b0) & (ap_predicate_op167_write_state2 == 1'b1)) | ((state_V_load_reg_1091 == 2'd2) & (rxEng_dataBuffer3_V_full_n == 1'b0)) | ((rxEng_dataBuffer3_V_full_n == 1'b0) & (ap_predicate_op171_write_state2 == 1'b1)) | ((rxEng_dataBuffer3_V_full_n == 1'b0) & (ap_predicate_op169_write_state2 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((io_acc_block_signal_op96 == 1'b0) & (ap_predicate_op96_read_state1 == 1'b1)) | ((rxEng_dataBuffer3b_V_empty_n == 1'b0) & (ap_predicate_op98_read_state1 == 1'b1)) | ((rxEng_dataBuffer3b_V_empty_n == 1'b0) & (ap_predicate_op64_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((rxEng_dataBuffer3_V_full_n == 1'b0) & (ap_predicate_op167_write_state2 == 1'b1)) | ((state_V_load_reg_1091 == 2'd2) & (rxEng_dataBuffer3_V_full_n == 1'b0)) | ((rxEng_dataBuffer3_V_full_n == 1'b0) & (ap_predicate_op171_write_state2 == 1'b1)) | ((rxEng_dataBuffer3_V_full_n == 1'b0) & (ap_predicate_op169_write_state2 == 1'b1)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((io_acc_block_signal_op96 == 1'b0) & (ap_predicate_op96_read_state1 == 1'b1)) | ((rxEng_dataBuffer3b_V_empty_n == 1'b0) & (ap_predicate_op98_read_state1 == 1'b1)) | ((rxEng_dataBuffer3b_V_empty_n == 1'b0) & (ap_predicate_op64_read_state1 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = (((rxEng_dataBuffer3_V_full_n == 1'b0) & (ap_predicate_op167_write_state2 == 1'b1)) | ((state_V_load_reg_1091 == 2'd2) & (rxEng_dataBuffer3_V_full_n == 1'b0)) | ((rxEng_dataBuffer3_V_full_n == 1'b0) & (ap_predicate_op171_write_state2 == 1'b1)) | ((rxEng_dataBuffer3_V_full_n == 1'b0) & (ap_predicate_op169_write_state2 == 1'b1)));
end

always @ (*) begin
    ap_condition_342 = ((grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0));
end

always @ (*) begin
    ap_condition_849 = ((grp_nbreadreq_fu_158_p3 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

assign ap_phi_reg_pp0_iter0_dataOffset_V_load_4_s_reg_197 = 'bx;

assign ap_phi_reg_pp0_iter0_state_V_flag_5_i_reg_206 = 'bx;

assign ap_phi_reg_pp0_iter0_state_V_new_5_i_reg_242 = 'bx;

always @ (*) begin
    ap_predicate_op167_write_state2 = ((icmp_ln879_18_reg_1153 == 1'd0) & (icmp_ln891_reg_1149 == 1'd1) & (tmp_282_reg_1142 == 1'd1) & (state_V_load_reg_1091 == 2'd1));
end

always @ (*) begin
    ap_predicate_op169_write_state2 = ((icmp_ln879_18_reg_1153 == 1'd1) & (icmp_ln891_reg_1149 == 1'd1) & (tmp_282_reg_1142 == 1'd1) & (state_V_load_reg_1091 == 2'd1));
end

always @ (*) begin
    ap_predicate_op171_write_state2 = ((state_V_load_reg_1091 == 2'd0) & (icmp_ln879_reg_1175 == 1'd1) & (tmp_291_reg_1171 == 1'd1) & (tmp_reg_1167 == 1'd1));
end

always @ (*) begin
    ap_predicate_op64_read_state1 = ((grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd1));
end

always @ (*) begin
    ap_predicate_op96_read_state1 = ((tmp_nbreadreq_fu_172_p4 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd0));
end

always @ (*) begin
    ap_predicate_op98_read_state1 = ((tmp_nbreadreq_fu_172_p4 == 1'd1) & (grp_nbreadreq_fu_158_p3 == 1'd1) & (state_V == 2'd0));
end

assign grp_fu_274_p4 = {{dataOffset_V[3:1]}};

assign grp_fu_283_p4 = {{rxEng_dataBuffer3b_V_dout[71:64]}};

assign grp_fu_293_p3 = rxEng_dataBuffer3b_V_dout[32'd72];

assign grp_nbreadreq_fu_158_p3 = rxEng_dataBuffer3b_V_empty_n;

assign icmp_ln391_1_fu_642_p2 = ((sext_ln391_1_fu_638_p1 != 29'd0) ? 1'b1 : 1'b0);

assign icmp_ln391_fu_558_p2 = ((sext_ln391_fu_554_p1 != 26'd0) ? 1'b1 : 1'b0);

assign icmp_ln647_8_fu_458_p2 = ((zext_ln647_39_fu_454_p1 != 29'd0) ? 1'b1 : 1'b0);

assign icmp_ln647_fu_350_p2 = ((zext_ln647_fu_346_p1 != 26'd0) ? 1'b1 : 1'b0);

assign icmp_ln879_18_fu_681_p2 = ((dataOffset_V == 4'd0) ? 1'b1 : 1'b0);

assign icmp_ln879_fu_810_p2 = ((rxEng_optionalFields_2_dout == 4'd0) ? 1'b1 : 1'b0);

assign icmp_ln883_fu_743_p2 = ((ap_phi_mux_dataOffset_V_load_4_s_phi_fu_200_p4 == 4'd0) ? 1'b1 : 1'b0);

assign icmp_ln887_fu_861_p2 = ((tmp_296_fu_851_p4 == 3'd0) ? 1'b1 : 1'b0);

assign icmp_ln891_fu_662_p2 = ((grp_fu_274_p4 == 3'd0) ? 1'b1 : 1'b0);

assign io_acc_block_signal_op96 = (rxEng_optionalFields_3_empty_n & rxEng_optionalFields_2_empty_n);

assign lshr_ln391_1_fu_1007_p2 = 8'd255 >> zext_ln391_5_fu_997_p1;

assign lshr_ln391_fu_604_p2 = 64'd18446744073709551615 >> zext_ln391_3_fu_594_p1;

assign lshr_ln414_13_fu_964_p2 = 8'd255 >> zext_ln414_29_fu_960_p1;

assign lshr_ln414_fu_929_p2 = 64'd18446744073709551615 >> zext_ln414_fu_925_p1;

assign lshr_ln647_33_fu_914_p2 = 64'd18446744073709551615 >> zext_ln647_38_fu_911_p1;

assign lshr_ln647_34_fu_532_p2 = select_ln647_31_fu_506_p3 >> zext_ln647_40_fu_528_p1;

assign lshr_ln647_35_fu_949_p2 = 8'd255 >> zext_ln647_41_fu_946_p1;

assign lshr_ln647_fu_426_p2 = select_ln647_28_fu_400_p3 >> zext_ln647_37_fu_422_p1;

assign or_ln563_fu_828_p2 = (xor_ln563_fu_822_p2 | icmp_ln879_fu_810_p2);

assign or_ln611_fu_749_p2 = (p_Result_116_fu_737_p2 | icmp_ln883_fu_743_p2);

assign p_Result_115_fu_879_p2 = ((and_ln791_fu_873_p2 == 5'd0) ? 1'b1 : 1'b0);

assign p_Result_116_fu_737_p2 = ((and_ln791_1_fu_731_p2 == 8'd0) ? 1'b1 : 1'b0);

assign p_Result_117_fu_920_p2 = (lshr_ln647_reg_1106 & lshr_ln647_33_fu_914_p2);

assign p_Result_118_fu_935_p2 = (p_Result_117_fu_920_p2 & lshr_ln414_fu_929_p2);

assign p_Result_119_fu_955_p2 = (lshr_ln647_35_fu_949_p2 & lshr_ln647_34_reg_1116);

assign p_Result_120_fu_970_p2 = (p_Result_119_fu_955_p2 & lshr_ln414_13_fu_964_p2);

assign p_Result_121_fu_976_p2 = (xor_ln391_reg_1121 & p_Result_118_fu_935_p2);

assign p_Result_122_fu_1025_p2 = (xor_ln391_1_fu_1019_p2 & p_Result_120_fu_970_p2);

assign p_Result_168_trunc_fu_1046_p4 = {{reg_307[67:64]}};

assign p_Result_s_fu_792_p5 = {{optionalHeader_heade[319:64]}, {tmp_data_V_23_fu_768_p1}};

assign select_ln391_2_fu_582_p3 = ((icmp_ln391_fu_558_p2[0:0] === 1'b1) ? sub_ln391_fu_576_p2 : 7'd0);

assign select_ln391_3_fu_981_p3 = ((icmp_ln391_1_reg_1126[0:0] === 1'b1) ? 4'd7 : trunc_ln391_1_reg_1132);

assign select_ln391_4_fu_987_p3 = ((icmp_ln391_1_reg_1126[0:0] === 1'b1) ? sub_ln391_1_reg_1137 : 4'd0);

assign select_ln391_fu_568_p3 = ((icmp_ln391_fu_558_p2[0:0] === 1'b1) ? 7'd63 : trunc_ln391_fu_564_p1);

assign select_ln566_fu_885_p3 = ((p_Result_115_fu_879_p2[0:0] === 1'b1) ? 2'd0 : 2'd2);

assign select_ln611_fu_755_p3 = ((or_ln611_fu_749_p2[0:0] === 1'b1) ? 2'd0 : 2'd2);

assign select_ln647_28_fu_400_p3 = ((icmp_ln647_fu_350_p2[0:0] === 1'b1) ? tmp_286_fu_364_p4 : prevWord_data_V);

assign select_ln647_29_fu_408_p3 = ((icmp_ln647_fu_350_p2[0:0] === 1'b1) ? sub_ln647_fu_380_p2 : tmp_285_fu_356_p3);

assign select_ln647_30_fu_498_p3 = ((icmp_ln647_8_fu_458_p2[0:0] === 1'b1) ? add_ln647_4_fu_480_p2 : sub_ln647_40_fu_492_p2);

assign select_ln647_31_fu_506_p3 = ((icmp_ln647_8_fu_458_p2[0:0] === 1'b1) ? tmp_288_fu_470_p4 : prevWord_keep_V);

assign select_ln647_32_fu_514_p3 = ((icmp_ln647_8_fu_458_p2[0:0] === 1'b1) ? sub_ln647_39_fu_486_p2 : shl_ln647_fu_464_p2);

assign select_ln647_fu_392_p3 = ((icmp_ln647_fu_350_p2[0:0] === 1'b1) ? add_ln647_fu_374_p2 : sub_ln647_37_fu_386_p2);

assign sext_ln391_1_fu_638_p1 = $signed(tmp_290_fu_628_p4);

assign sext_ln391_fu_554_p1 = $signed(tmp_289_fu_544_p4);

assign shl_ln391_1_fu_1001_p2 = 8'd255 << zext_ln391_4_fu_993_p1;

assign shl_ln391_fu_598_p2 = 64'd18446744073709551615 << zext_ln391_fu_590_p1;

assign shl_ln622_fu_941_p2 = dataOffset_V_load_reg_1095 << 4'd2;

assign shl_ln647_fu_464_p2 = dataOffset_V << 4'd2;

assign shl_ln791_1_fu_725_p2 = 8'd1 << zext_ln791_fu_721_p1;

assign shl_ln791_2_fu_713_p3 = {{ap_phi_mux_dataOffset_V_load_4_s_phi_fu_200_p4}, {2'd0}};

assign shl_ln791_4_fu_843_p3 = {{trunc_ln791_fu_839_p1}, {2'd0}};

assign shl_ln791_fu_867_p2 = 5'd1 << shl_ln791_4_fu_843_p3;

assign state_V_load_load_fu_312_p1 = state_V;

assign sub_ln391_1_fu_652_p2 = (4'd7 - trunc_ln391_1_fu_648_p1);

assign sub_ln391_fu_576_p2 = (7'd63 - trunc_ln391_fu_564_p1);

assign sub_ln623_fu_538_p2 = (10'd64 - zext_ln621_fu_342_p1);

assign sub_ln624_fu_622_p2 = (7'd8 - zext_ln622_fu_440_p1);

assign sub_ln647_37_fu_386_p2 = (7'd63 - tmp_285_fu_356_p3);

assign sub_ln647_38_fu_416_p2 = (7'd63 - select_ln647_fu_392_p3);

assign sub_ln647_39_fu_486_p2 = (4'd7 - shl_ln647_fu_464_p2);

assign sub_ln647_40_fu_492_p2 = (4'd7 - shl_ln647_fu_464_p2);

assign sub_ln647_41_fu_522_p2 = (4'd7 - select_ln647_30_fu_498_p3);

assign sub_ln647_fu_380_p2 = (7'd63 - tmp_285_fu_356_p3);

assign tmp_283_fu_903_p3 = {{trunc_ln621_1_fu_900_p1}, {5'd0}};

assign tmp_285_fu_356_p3 = {{trunc_ln621_fu_330_p1}, {5'd0}};

integer ap_tvar_int_0;

always @ (prevWord_data_V) begin
    for (ap_tvar_int_0 = 64 - 1; ap_tvar_int_0 >= 0; ap_tvar_int_0 = ap_tvar_int_0 - 1) begin
        if (ap_tvar_int_0 > 63 - 0) begin
            tmp_286_fu_364_p4[ap_tvar_int_0] = 1'b0;
        end else begin
            tmp_286_fu_364_p4[ap_tvar_int_0] = prevWord_data_V[63 - ap_tvar_int_0];
        end
    end
end

assign tmp_287_fu_444_p4 = {{dataOffset_V[3:1]}};

integer ap_tvar_int_1;

always @ (prevWord_keep_V) begin
    for (ap_tvar_int_1 = 8 - 1; ap_tvar_int_1 >= 0; ap_tvar_int_1 = ap_tvar_int_1 - 1) begin
        if (ap_tvar_int_1 > 7 - 0) begin
            tmp_288_fu_470_p4[ap_tvar_int_1] = 1'b0;
        end else begin
            tmp_288_fu_470_p4[ap_tvar_int_1] = prevWord_keep_V[7 - ap_tvar_int_1];
        end
    end
end

assign tmp_289_fu_544_p4 = {{sub_ln623_fu_538_p2[9:6]}};

assign tmp_290_fu_628_p4 = {{sub_ln624_fu_622_p2[6:3]}};

assign tmp_295_fu_1056_p3 = reg_307[32'd68];

assign tmp_296_fu_851_p4 = {{rxEng_optionalFields_2_dout[3:1]}};

assign tmp_4_fu_1078_p6 = {{{{{tmp_last_V_16_fu_1072_p2}, {p_Result_168_trunc_fu_1046_p4}}, {p_Result_1_reg_1162}}, {trunc_ln647_fu_1042_p1}}, {p_Result_s_381_reg_1157}};

assign tmp_5_fu_1031_p4 = {{{{1'd1}, {p_Result_122_fu_1025_p2}}}, {p_Result_121_fu_976_p2}};

assign tmp_data_V_23_fu_768_p1 = rxEng_dataBuffer3b_V_dout[63:0];

assign tmp_data_V_25_fu_658_p1 = rxEng_dataBuffer3b_V_dout[63:0];

assign tmp_keep_V_48_cast_fu_772_p4 = {{rxEng_dataBuffer3b_V_dout[68:64]}};

assign tmp_last_V_16_fu_1072_p2 = ((and_ln_fu_1064_p3 == 5'd0) ? 1'b1 : 1'b0);

assign tmp_nbreadreq_fu_172_p4 = (rxEng_optionalFields_3_empty_n & rxEng_optionalFields_2_empty_n);

assign trunc_ln391_1_fu_648_p1 = sub_ln624_fu_622_p2[3:0];

assign trunc_ln391_fu_564_p1 = sub_ln623_fu_538_p2[6:0];

assign trunc_ln621_1_fu_900_p1 = dataOffset_V_load_reg_1095[1:0];

assign trunc_ln621_fu_330_p1 = dataOffset_V[1:0];

assign trunc_ln647_fu_1042_p1 = reg_307[31:0];

assign trunc_ln791_fu_839_p1 = rxEng_optionalFields_2_dout[2:0];

assign xor_ln391_1_fu_1019_p2 = (8'd255 ^ and_ln391_3_fu_1013_p2);

assign xor_ln391_fu_616_p2 = (64'd18446744073709551615 ^ and_ln391_fu_610_p2);

assign xor_ln563_fu_822_p2 = (grp_fu_293_p3 ^ 1'd1);

assign zext_ln391_3_fu_594_p1 = select_ln391_2_fu_582_p3;

assign zext_ln391_4_fu_993_p1 = select_ln391_3_fu_981_p3;

assign zext_ln391_5_fu_997_p1 = select_ln391_4_fu_987_p3;

assign zext_ln391_fu_590_p1 = select_ln391_fu_568_p3;

assign zext_ln414_29_fu_960_p1 = shl_ln622_fu_941_p2;

assign zext_ln414_fu_925_p1 = tmp_283_fu_903_p3;

assign zext_ln563_fu_834_p1 = xor_ln563_fu_822_p2;

assign zext_ln621_fu_342_p1 = Lo_assign_s_fu_334_p3;

assign zext_ln622_fu_440_p1 = Lo_assign_1_fu_432_p3;

assign zext_ln647_37_fu_422_p1 = select_ln647_29_fu_408_p3;

assign zext_ln647_38_fu_911_p1 = sub_ln647_38_reg_1101;

assign zext_ln647_39_fu_454_p1 = tmp_287_fu_444_p4;

assign zext_ln647_40_fu_528_p1 = select_ln647_32_fu_514_p3;

assign zext_ln647_41_fu_946_p1 = sub_ln647_41_reg_1111;

assign zext_ln647_fu_346_p1 = grp_fu_274_p4;

assign zext_ln791_fu_721_p1 = shl_ln791_2_fu_713_p3;

always @ (posedge ap_clk) begin
    sub_ln647_38_reg_1101[0] <= 1'b0;
    sub_ln647_41_reg_1111[0] <= 1'b0;
    trunc_ln391_1_reg_1132[1:0] <= 2'b00;
    sub_ln391_1_reg_1137[1:0] <= 2'b11;
end

endmodule //drop_optional_header
