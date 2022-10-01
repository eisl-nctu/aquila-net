// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2019.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module two_complement_subch_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        rxEng_dataBuffer1_V_dout,
        rxEng_dataBuffer1_V_empty_n,
        rxEng_dataBuffer1_V_read,
        rxEng_dataBuffer2_V_din,
        rxEng_dataBuffer2_V_full_n,
        rxEng_dataBuffer2_V_write,
        subSumFifo_V_sum_V_0_din,
        subSumFifo_V_sum_V_0_full_n,
        subSumFifo_V_sum_V_0_write,
        subSumFifo_V_sum_V_1_din,
        subSumFifo_V_sum_V_1_full_n,
        subSumFifo_V_sum_V_1_write,
        subSumFifo_V_sum_V_2_din,
        subSumFifo_V_sum_V_2_full_n,
        subSumFifo_V_sum_V_2_write,
        subSumFifo_V_sum_V_3_din,
        subSumFifo_V_sum_V_3_full_n,
        subSumFifo_V_sum_V_3_write
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [72:0] rxEng_dataBuffer1_V_dout;
input   rxEng_dataBuffer1_V_empty_n;
output   rxEng_dataBuffer1_V_read;
output  [72:0] rxEng_dataBuffer2_V_din;
input   rxEng_dataBuffer2_V_full_n;
output   rxEng_dataBuffer2_V_write;
output  [16:0] subSumFifo_V_sum_V_0_din;
input   subSumFifo_V_sum_V_0_full_n;
output   subSumFifo_V_sum_V_0_write;
output  [16:0] subSumFifo_V_sum_V_1_din;
input   subSumFifo_V_sum_V_1_full_n;
output   subSumFifo_V_sum_V_1_write;
output  [16:0] subSumFifo_V_sum_V_2_din;
input   subSumFifo_V_sum_V_2_full_n;
output   subSumFifo_V_sum_V_2_write;
output  [16:0] subSumFifo_V_sum_V_3_din;
input   subSumFifo_V_sum_V_3_full_n;
output   subSumFifo_V_sum_V_3_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg rxEng_dataBuffer1_V_read;
reg rxEng_dataBuffer2_V_write;
reg subSumFifo_V_sum_V_0_write;
reg subSumFifo_V_sum_V_1_write;
reg subSumFifo_V_sum_V_2_write;
reg subSumFifo_V_sum_V_3_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire   [0:0] tmp_nbreadreq_fu_108_p3;
reg    ap_block_state1_pp0_stage0_iter0;
reg   [0:0] tmp_reg_922;
reg    ap_block_state2_pp0_stage0_iter1;
wire    io_acc_block_signal_op140;
reg   [0:0] tmp_reg_922_pp0_iter1_reg;
reg   [0:0] tmp_last_V_reg_931;
reg   [0:0] tmp_last_V_reg_931_pp0_iter1_reg;
reg    ap_predicate_op140_write_state3;
reg    ap_block_state3_pp0_stage0_iter2;
reg    ap_block_pp0_stage0_11001;
reg   [16:0] tcts_tcp_sums_sum_V_4;
reg   [16:0] tcts_tcp_sums_sum_V_1;
reg   [16:0] tcts_tcp_sums_sum_V_2;
reg   [16:0] tcts_tcp_sums_sum_V_3;
reg    rxEng_dataBuffer1_V_blk_n;
wire    ap_block_pp0_stage0;
reg    rxEng_dataBuffer2_V_blk_n;
reg    subSumFifo_V_sum_V_0_blk_n;
reg    subSumFifo_V_sum_V_1_blk_n;
reg    subSumFifo_V_sum_V_2_blk_n;
reg    subSumFifo_V_sum_V_3_blk_n;
reg   [72:0] tmp37_reg_926;
wire   [0:0] tmp_last_V_fu_245_p3;
wire   [0:0] icmp_ln879_fu_263_p2;
reg   [0:0] icmp_ln879_reg_935;
reg   [7:0] p_Result_32_i_reg_941;
wire   [7:0] trunc_ln647_fu_279_p1;
reg   [7:0] trunc_ln647_reg_946;
wire   [0:0] and_ln321_fu_289_p2;
reg   [0:0] and_ln321_reg_952;
wire   [0:0] icmp_ln879_1_fu_305_p2;
reg   [0:0] icmp_ln879_1_reg_958;
reg   [7:0] p_Result_32_1_i_reg_965;
reg   [7:0] p_Result_34_1_i_reg_970;
reg   [0:0] tmp_31_reg_976;
wire   [0:0] icmp_ln879_2_fu_349_p2;
reg   [0:0] icmp_ln879_2_reg_982;
reg   [7:0] p_Result_32_2_i_reg_989;
reg   [7:0] p_Result_34_2_i_reg_994;
reg   [0:0] tmp_34_reg_1000;
wire   [0:0] icmp_ln879_3_fu_393_p2;
reg   [0:0] icmp_ln879_3_reg_1006;
reg   [7:0] p_Result_32_3_i_reg_1013;
reg   [7:0] p_Result_34_3_i_reg_1018;
reg   [0:0] tmp_37_reg_1024;
wire   [16:0] tmp_sum_0_V_fu_536_p3;
reg   [16:0] tmp_sum_0_V_reg_1030;
wire   [16:0] tmp_sum_1_V_fu_653_p3;
reg   [16:0] tmp_sum_1_V_reg_1035;
wire   [16:0] tmp_sum_2_V_fu_771_p3;
reg   [16:0] tmp_sum_2_V_reg_1040;
wire   [16:0] tmp_sum_3_V_fu_889_p3;
reg   [16:0] tmp_sum_3_V_reg_1045;
reg    ap_block_pp0_stage0_subdone;
reg   [0:0] ap_phi_mux_tcts_tcp_sums_sum_V_9_phi_fu_149_p4;
wire   [0:0] ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_9_reg_145;
reg   [0:0] ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_9_reg_145;
wire   [0:0] or_ln321_fu_524_p2;
reg   [16:0] ap_phi_mux_tcts_tcp_sums_sum_V_10_phi_fu_161_p4;
wire   [16:0] ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_10_reg_157;
reg   [16:0] ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_10_reg_157;
reg   [0:0] ap_phi_mux_tcts_tcp_sums_sum_V_11_phi_fu_172_p4;
wire   [0:0] ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_11_reg_168;
reg   [0:0] ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_11_reg_168;
wire   [0:0] or_ln791_fu_633_p2;
reg   [16:0] ap_phi_mux_tcts_tcp_sums_sum_V_12_phi_fu_184_p4;
wire   [16:0] ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_12_reg_180;
reg   [16:0] ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_12_reg_180;
reg   [0:0] ap_phi_mux_tcts_tcp_sums_sum_V_13_phi_fu_195_p4;
wire   [0:0] ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_13_reg_191;
reg   [0:0] ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_13_reg_191;
wire   [0:0] or_ln791_1_fu_751_p2;
reg   [16:0] ap_phi_mux_tcts_tcp_sums_sum_V_14_phi_fu_207_p4;
wire   [16:0] ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_14_reg_203;
reg   [16:0] ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_14_reg_203;
reg   [0:0] ap_phi_mux_tcts_tcp_sums_sum_V_15_phi_fu_218_p4;
wire   [0:0] ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_15_reg_214;
reg   [0:0] ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_15_reg_214;
wire   [0:0] or_ln791_2_fu_869_p2;
reg   [16:0] ap_phi_mux_tcts_tcp_sums_sum_V_16_phi_fu_230_p4;
wire   [16:0] ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_16_reg_226;
reg   [16:0] ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_16_reg_226;
reg    ap_block_pp0_stage0_01001;
wire   [1:0] p_Result_31_i_fu_253_p4;
wire   [0:0] tmp_26_fu_237_p3;
wire   [0:0] xor_ln879_fu_283_p2;
wire   [1:0] p_Result_31_1_i_fu_295_p4;
wire   [1:0] p_Result_31_2_i_fu_339_p4;
wire   [1:0] p_Result_31_3_i_fu_383_p4;
wire   [15:0] p_Result_35_i_fu_431_p3;
wire   [16:0] zext_ln700_fu_437_p1;
wire   [16:0] add_ln700_fu_445_p2;
wire   [0:0] tmp_28_fu_451_p3;
wire   [15:0] zext_ln214_1_fu_459_p1;
wire   [15:0] trunc_ln700_fu_441_p1;
wire   [15:0] add_ln214_fu_463_p2;
wire   [15:0] add_ln214_1_fu_469_p2;
wire   [15:0] p_Result_38_i_fu_479_p3;
wire   [16:0] zext_ln700_1_fu_486_p1;
wire   [16:0] add_ln700_1_fu_490_p2;
wire   [0:0] tmp_29_fu_496_p3;
wire   [15:0] zext_ln214_3_fu_504_p1;
wire   [15:0] add_ln214_2_fu_508_p2;
wire   [15:0] add_ln214_3_fu_514_p2;
wire   [16:0] zext_ln214_fu_475_p1;
wire   [16:0] zext_ln214_2_fu_520_p1;
wire   [16:0] select_ln879_fu_529_p3;
wire   [15:0] p_Result_35_1_i_fu_548_p3;
wire   [16:0] zext_ln700_2_fu_554_p1;
wire   [16:0] add_ln700_2_fu_562_p2;
wire   [0:0] tmp_30_fu_568_p3;
wire   [15:0] zext_ln214_4_fu_576_p1;
wire   [15:0] trunc_ln700_1_fu_558_p1;
wire   [15:0] add_ln214_4_fu_580_p2;
wire   [15:0] p_Result_38_1_i_fu_592_p3;
wire   [16:0] zext_ln700_3_fu_599_p1;
wire   [16:0] add_ln700_3_fu_603_p2;
wire   [0:0] tmp_32_fu_609_p3;
wire   [15:0] zext_ln214_5_fu_617_p1;
wire   [15:0] add_ln214_6_fu_621_p2;
wire   [15:0] add_ln214_5_fu_586_p2;
wire   [15:0] add_ln214_7_fu_627_p2;
wire   [15:0] select_ln879_1_fu_638_p3;
wire   [0:0] or_ln791_3_fu_649_p2;
wire   [16:0] zext_ln879_fu_645_p1;
wire   [15:0] p_Result_35_2_i_fu_666_p3;
wire   [16:0] zext_ln700_4_fu_672_p1;
wire   [16:0] add_ln700_4_fu_680_p2;
wire   [0:0] tmp_33_fu_686_p3;
wire   [15:0] zext_ln214_6_fu_694_p1;
wire   [15:0] trunc_ln700_2_fu_676_p1;
wire   [15:0] add_ln214_8_fu_698_p2;
wire   [15:0] p_Result_38_2_i_fu_710_p3;
wire   [16:0] zext_ln700_5_fu_717_p1;
wire   [16:0] add_ln700_5_fu_721_p2;
wire   [0:0] tmp_35_fu_727_p3;
wire   [15:0] zext_ln214_7_fu_735_p1;
wire   [15:0] add_ln214_10_fu_739_p2;
wire   [15:0] add_ln214_9_fu_704_p2;
wire   [15:0] add_ln214_11_fu_745_p2;
wire   [15:0] select_ln879_2_fu_756_p3;
wire   [0:0] or_ln791_4_fu_767_p2;
wire   [16:0] zext_ln879_1_fu_763_p1;
wire   [15:0] p_Result_35_3_i_fu_784_p3;
wire   [16:0] zext_ln700_6_fu_790_p1;
wire   [16:0] add_ln700_6_fu_798_p2;
wire   [0:0] tmp_36_fu_804_p3;
wire   [15:0] zext_ln214_8_fu_812_p1;
wire   [15:0] trunc_ln700_3_fu_794_p1;
wire   [15:0] add_ln214_12_fu_816_p2;
wire   [15:0] p_Result_38_3_i_fu_828_p3;
wire   [16:0] zext_ln700_7_fu_835_p1;
wire   [16:0] add_ln700_7_fu_839_p2;
wire   [0:0] tmp_38_fu_845_p3;
wire   [15:0] zext_ln214_9_fu_853_p1;
wire   [15:0] add_ln214_14_fu_857_p2;
wire   [15:0] add_ln214_13_fu_822_p2;
wire   [15:0] add_ln214_15_fu_863_p2;
wire   [15:0] select_ln879_3_fu_874_p3;
wire   [0:0] or_ln791_5_fu_885_p2;
wire   [16:0] zext_ln879_2_fu_881_p1;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to1;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_99;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 tcts_tcp_sums_sum_V_4 = 17'd0;
#0 tcts_tcp_sums_sum_V_1 = 17'd0;
#0 tcts_tcp_sums_sum_V_2 = 17'd0;
#0 tcts_tcp_sums_sum_V_3 = 17'd0;
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
        end else if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
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
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_99)) begin
        if (((tmp_last_V_fu_245_p3 == 1'd1) & (tmp_nbreadreq_fu_108_p3 == 1'd1))) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_10_reg_157 <= 17'd0;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_10_reg_157 <= ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_10_reg_157;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_99)) begin
        if (((tmp_last_V_fu_245_p3 == 1'd1) & (tmp_nbreadreq_fu_108_p3 == 1'd1))) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_11_reg_168 <= 1'd1;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_11_reg_168 <= ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_11_reg_168;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_99)) begin
        if (((tmp_last_V_fu_245_p3 == 1'd1) & (tmp_nbreadreq_fu_108_p3 == 1'd1))) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_12_reg_180 <= 17'd0;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_12_reg_180 <= ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_12_reg_180;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_99)) begin
        if (((tmp_last_V_fu_245_p3 == 1'd1) & (tmp_nbreadreq_fu_108_p3 == 1'd1))) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_13_reg_191 <= 1'd1;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_13_reg_191 <= ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_13_reg_191;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_99)) begin
        if (((tmp_last_V_fu_245_p3 == 1'd1) & (tmp_nbreadreq_fu_108_p3 == 1'd1))) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_14_reg_203 <= 17'd0;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_14_reg_203 <= ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_14_reg_203;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_99)) begin
        if (((tmp_last_V_fu_245_p3 == 1'd1) & (tmp_nbreadreq_fu_108_p3 == 1'd1))) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_15_reg_214 <= 1'd1;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_15_reg_214 <= ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_15_reg_214;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_99)) begin
        if (((tmp_last_V_fu_245_p3 == 1'd1) & (tmp_nbreadreq_fu_108_p3 == 1'd1))) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_16_reg_226 <= 17'd0;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_16_reg_226 <= ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_16_reg_226;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_99)) begin
        if (((tmp_last_V_fu_245_p3 == 1'd1) & (tmp_nbreadreq_fu_108_p3 == 1'd1))) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_9_reg_145 <= 1'd1;
        end else if ((1'b1 == 1'b1)) begin
            ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_9_reg_145 <= ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_9_reg_145;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_108_p3 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        and_ln321_reg_952 <= and_ln321_fu_289_p2;
        icmp_ln879_1_reg_958 <= icmp_ln879_1_fu_305_p2;
        icmp_ln879_2_reg_982 <= icmp_ln879_2_fu_349_p2;
        icmp_ln879_3_reg_1006 <= icmp_ln879_3_fu_393_p2;
        icmp_ln879_reg_935 <= icmp_ln879_fu_263_p2;
        p_Result_32_1_i_reg_965 <= {{rxEng_dataBuffer1_V_dout[31:24]}};
        p_Result_32_2_i_reg_989 <= {{rxEng_dataBuffer1_V_dout[47:40]}};
        p_Result_32_3_i_reg_1013 <= {{rxEng_dataBuffer1_V_dout[63:56]}};
        p_Result_32_i_reg_941 <= {{rxEng_dataBuffer1_V_dout[15:8]}};
        p_Result_34_1_i_reg_970 <= {{rxEng_dataBuffer1_V_dout[23:16]}};
        p_Result_34_2_i_reg_994 <= {{rxEng_dataBuffer1_V_dout[39:32]}};
        p_Result_34_3_i_reg_1018 <= {{rxEng_dataBuffer1_V_dout[55:48]}};
        tmp37_reg_926 <= rxEng_dataBuffer1_V_dout;
        tmp_31_reg_976 <= rxEng_dataBuffer1_V_dout[32'd66];
        tmp_34_reg_1000 <= rxEng_dataBuffer1_V_dout[32'd68];
        tmp_37_reg_1024 <= rxEng_dataBuffer1_V_dout[32'd70];
        tmp_last_V_reg_931 <= rxEng_dataBuffer1_V_dout[32'd72];
        trunc_ln647_reg_946 <= trunc_ln647_fu_279_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_reg_922 == 1'd1) & (ap_phi_mux_tcts_tcp_sums_sum_V_11_phi_fu_172_p4 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tcts_tcp_sums_sum_V_1 <= ap_phi_mux_tcts_tcp_sums_sum_V_12_phi_fu_184_p4;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_reg_922 == 1'd1) & (ap_phi_mux_tcts_tcp_sums_sum_V_13_phi_fu_195_p4 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tcts_tcp_sums_sum_V_2 <= ap_phi_mux_tcts_tcp_sums_sum_V_14_phi_fu_207_p4;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_reg_922 == 1'd1) & (ap_phi_mux_tcts_tcp_sums_sum_V_15_phi_fu_218_p4 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tcts_tcp_sums_sum_V_3 <= ap_phi_mux_tcts_tcp_sums_sum_V_16_phi_fu_230_p4;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_reg_922 == 1'd1) & (ap_phi_mux_tcts_tcp_sums_sum_V_9_phi_fu_149_p4 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tcts_tcp_sums_sum_V_4 <= ap_phi_mux_tcts_tcp_sums_sum_V_10_phi_fu_161_p4;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_last_V_reg_931_pp0_iter1_reg <= tmp_last_V_reg_931;
        tmp_reg_922 <= tmp_nbreadreq_fu_108_p3;
        tmp_reg_922_pp0_iter1_reg <= tmp_reg_922;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_reg_922 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_sum_0_V_reg_1030 <= tmp_sum_0_V_fu_536_p3;
        tmp_sum_1_V_reg_1035 <= tmp_sum_1_V_fu_653_p3;
        tmp_sum_2_V_reg_1040 <= tmp_sum_2_V_fu_771_p3;
        tmp_sum_3_V_reg_1045 <= tmp_sum_3_V_fu_889_p3;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
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
    if (((tmp_last_V_reg_931 == 1'd0) & (tmp_reg_922 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_phi_mux_tcts_tcp_sums_sum_V_10_phi_fu_161_p4 = tmp_sum_0_V_fu_536_p3;
    end else begin
        ap_phi_mux_tcts_tcp_sums_sum_V_10_phi_fu_161_p4 = ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_10_reg_157;
    end
end

always @ (*) begin
    if (((tmp_last_V_reg_931 == 1'd0) & (tmp_reg_922 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_phi_mux_tcts_tcp_sums_sum_V_11_phi_fu_172_p4 = or_ln791_fu_633_p2;
    end else begin
        ap_phi_mux_tcts_tcp_sums_sum_V_11_phi_fu_172_p4 = ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_11_reg_168;
    end
end

always @ (*) begin
    if (((tmp_last_V_reg_931 == 1'd0) & (tmp_reg_922 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_phi_mux_tcts_tcp_sums_sum_V_12_phi_fu_184_p4 = tmp_sum_1_V_fu_653_p3;
    end else begin
        ap_phi_mux_tcts_tcp_sums_sum_V_12_phi_fu_184_p4 = ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_12_reg_180;
    end
end

always @ (*) begin
    if (((tmp_last_V_reg_931 == 1'd0) & (tmp_reg_922 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_phi_mux_tcts_tcp_sums_sum_V_13_phi_fu_195_p4 = or_ln791_1_fu_751_p2;
    end else begin
        ap_phi_mux_tcts_tcp_sums_sum_V_13_phi_fu_195_p4 = ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_13_reg_191;
    end
end

always @ (*) begin
    if (((tmp_last_V_reg_931 == 1'd0) & (tmp_reg_922 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_phi_mux_tcts_tcp_sums_sum_V_14_phi_fu_207_p4 = tmp_sum_2_V_fu_771_p3;
    end else begin
        ap_phi_mux_tcts_tcp_sums_sum_V_14_phi_fu_207_p4 = ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_14_reg_203;
    end
end

always @ (*) begin
    if (((tmp_last_V_reg_931 == 1'd0) & (tmp_reg_922 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_phi_mux_tcts_tcp_sums_sum_V_15_phi_fu_218_p4 = or_ln791_2_fu_869_p2;
    end else begin
        ap_phi_mux_tcts_tcp_sums_sum_V_15_phi_fu_218_p4 = ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_15_reg_214;
    end
end

always @ (*) begin
    if (((tmp_last_V_reg_931 == 1'd0) & (tmp_reg_922 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_phi_mux_tcts_tcp_sums_sum_V_16_phi_fu_230_p4 = tmp_sum_3_V_fu_889_p3;
    end else begin
        ap_phi_mux_tcts_tcp_sums_sum_V_16_phi_fu_230_p4 = ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_16_reg_226;
    end
end

always @ (*) begin
    if (((tmp_last_V_reg_931 == 1'd0) & (tmp_reg_922 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_phi_mux_tcts_tcp_sums_sum_V_9_phi_fu_149_p4 = or_ln321_fu_524_p2;
    end else begin
        ap_phi_mux_tcts_tcp_sums_sum_V_9_phi_fu_149_p4 = ap_phi_reg_pp0_iter1_tcts_tcp_sums_sum_V_9_reg_145;
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
    if (((ap_start == 1'b0) & (ap_idle_pp0_0to1 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (tmp_nbreadreq_fu_108_p3 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        rxEng_dataBuffer1_V_blk_n = rxEng_dataBuffer1_V_empty_n;
    end else begin
        rxEng_dataBuffer1_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_108_p3 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        rxEng_dataBuffer1_V_read = 1'b1;
    end else begin
        rxEng_dataBuffer1_V_read = 1'b0;
    end
end

always @ (*) begin
    if (((tmp_reg_922 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        rxEng_dataBuffer2_V_blk_n = rxEng_dataBuffer2_V_full_n;
    end else begin
        rxEng_dataBuffer2_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_reg_922 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        rxEng_dataBuffer2_V_write = 1'b1;
    end else begin
        rxEng_dataBuffer2_V_write = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op140_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        subSumFifo_V_sum_V_0_blk_n = subSumFifo_V_sum_V_0_full_n;
    end else begin
        subSumFifo_V_sum_V_0_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op140_write_state3 == 1'b1))) begin
        subSumFifo_V_sum_V_0_write = 1'b1;
    end else begin
        subSumFifo_V_sum_V_0_write = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op140_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        subSumFifo_V_sum_V_1_blk_n = subSumFifo_V_sum_V_1_full_n;
    end else begin
        subSumFifo_V_sum_V_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op140_write_state3 == 1'b1))) begin
        subSumFifo_V_sum_V_1_write = 1'b1;
    end else begin
        subSumFifo_V_sum_V_1_write = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op140_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        subSumFifo_V_sum_V_2_blk_n = subSumFifo_V_sum_V_2_full_n;
    end else begin
        subSumFifo_V_sum_V_2_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op140_write_state3 == 1'b1))) begin
        subSumFifo_V_sum_V_2_write = 1'b1;
    end else begin
        subSumFifo_V_sum_V_2_write = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op140_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        subSumFifo_V_sum_V_3_blk_n = subSumFifo_V_sum_V_3_full_n;
    end else begin
        subSumFifo_V_sum_V_3_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op140_write_state3 == 1'b1))) begin
        subSumFifo_V_sum_V_3_write = 1'b1;
    end else begin
        subSumFifo_V_sum_V_3_write = 1'b0;
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

assign add_ln214_10_fu_739_p2 = (zext_ln214_7_fu_735_p1 + trunc_ln700_2_fu_676_p1);

assign add_ln214_11_fu_745_p2 = (p_Result_38_2_i_fu_710_p3 + add_ln214_10_fu_739_p2);

assign add_ln214_12_fu_816_p2 = (zext_ln214_8_fu_812_p1 + trunc_ln700_3_fu_794_p1);

assign add_ln214_13_fu_822_p2 = (p_Result_35_3_i_fu_784_p3 + add_ln214_12_fu_816_p2);

assign add_ln214_14_fu_857_p2 = (zext_ln214_9_fu_853_p1 + trunc_ln700_3_fu_794_p1);

assign add_ln214_15_fu_863_p2 = (p_Result_38_3_i_fu_828_p3 + add_ln214_14_fu_857_p2);

assign add_ln214_1_fu_469_p2 = (p_Result_35_i_fu_431_p3 + add_ln214_fu_463_p2);

assign add_ln214_2_fu_508_p2 = (zext_ln214_3_fu_504_p1 + trunc_ln700_fu_441_p1);

assign add_ln214_3_fu_514_p2 = (p_Result_38_i_fu_479_p3 + add_ln214_2_fu_508_p2);

assign add_ln214_4_fu_580_p2 = (zext_ln214_4_fu_576_p1 + trunc_ln700_1_fu_558_p1);

assign add_ln214_5_fu_586_p2 = (p_Result_35_1_i_fu_548_p3 + add_ln214_4_fu_580_p2);

assign add_ln214_6_fu_621_p2 = (zext_ln214_5_fu_617_p1 + trunc_ln700_1_fu_558_p1);

assign add_ln214_7_fu_627_p2 = (p_Result_38_1_i_fu_592_p3 + add_ln214_6_fu_621_p2);

assign add_ln214_8_fu_698_p2 = (zext_ln214_6_fu_694_p1 + trunc_ln700_2_fu_676_p1);

assign add_ln214_9_fu_704_p2 = (p_Result_35_2_i_fu_666_p3 + add_ln214_8_fu_698_p2);

assign add_ln214_fu_463_p2 = (zext_ln214_1_fu_459_p1 + trunc_ln700_fu_441_p1);

assign add_ln700_1_fu_490_p2 = (zext_ln700_1_fu_486_p1 + tcts_tcp_sums_sum_V_4);

assign add_ln700_2_fu_562_p2 = (zext_ln700_2_fu_554_p1 + tcts_tcp_sums_sum_V_1);

assign add_ln700_3_fu_603_p2 = (zext_ln700_3_fu_599_p1 + tcts_tcp_sums_sum_V_1);

assign add_ln700_4_fu_680_p2 = (zext_ln700_4_fu_672_p1 + tcts_tcp_sums_sum_V_2);

assign add_ln700_5_fu_721_p2 = (zext_ln700_5_fu_717_p1 + tcts_tcp_sums_sum_V_2);

assign add_ln700_6_fu_798_p2 = (zext_ln700_6_fu_790_p1 + tcts_tcp_sums_sum_V_3);

assign add_ln700_7_fu_839_p2 = (zext_ln700_7_fu_835_p1 + tcts_tcp_sums_sum_V_3);

assign add_ln700_fu_445_p2 = (zext_ln700_fu_437_p1 + tcts_tcp_sums_sum_V_4);

assign and_ln321_fu_289_p2 = (xor_ln879_fu_283_p2 & tmp_26_fu_237_p3);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((io_acc_block_signal_op140 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op140_write_state3 == 1'b1)) | ((tmp_reg_922 == 1'd1) & (rxEng_dataBuffer2_V_full_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_108_p3 == 1'd1) & (rxEng_dataBuffer1_V_empty_n == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((io_acc_block_signal_op140 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op140_write_state3 == 1'b1)) | ((tmp_reg_922 == 1'd1) & (rxEng_dataBuffer2_V_full_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_108_p3 == 1'd1) & (rxEng_dataBuffer1_V_empty_n == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((io_acc_block_signal_op140 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op140_write_state3 == 1'b1)) | ((tmp_reg_922 == 1'd1) & (rxEng_dataBuffer2_V_full_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_108_p3 == 1'd1) & (rxEng_dataBuffer1_V_empty_n == 1'b0)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_108_p3 == 1'd1) & (rxEng_dataBuffer1_V_empty_n == 1'b0)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = ((tmp_reg_922 == 1'd1) & (rxEng_dataBuffer2_V_full_n == 1'b0));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = ((io_acc_block_signal_op140 == 1'b0) & (ap_predicate_op140_write_state3 == 1'b1));
end

always @ (*) begin
    ap_condition_99 = ((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

assign ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_10_reg_157 = 'bx;

assign ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_11_reg_168 = 'bx;

assign ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_12_reg_180 = 'bx;

assign ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_13_reg_191 = 'bx;

assign ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_14_reg_203 = 'bx;

assign ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_15_reg_214 = 'bx;

assign ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_16_reg_226 = 'bx;

assign ap_phi_reg_pp0_iter0_tcts_tcp_sums_sum_V_9_reg_145 = 'bx;

always @ (*) begin
    ap_predicate_op140_write_state3 = ((tmp_last_V_reg_931_pp0_iter1_reg == 1'd1) & (tmp_reg_922_pp0_iter1_reg == 1'd1));
end

assign icmp_ln879_1_fu_305_p2 = ((p_Result_31_1_i_fu_295_p4 == 2'd3) ? 1'b1 : 1'b0);

assign icmp_ln879_2_fu_349_p2 = ((p_Result_31_2_i_fu_339_p4 == 2'd3) ? 1'b1 : 1'b0);

assign icmp_ln879_3_fu_393_p2 = ((p_Result_31_3_i_fu_383_p4 == 2'd3) ? 1'b1 : 1'b0);

assign icmp_ln879_fu_263_p2 = ((p_Result_31_i_fu_253_p4 == 2'd3) ? 1'b1 : 1'b0);

assign io_acc_block_signal_op140 = (subSumFifo_V_sum_V_3_full_n & subSumFifo_V_sum_V_2_full_n & subSumFifo_V_sum_V_1_full_n & subSumFifo_V_sum_V_0_full_n);

assign or_ln321_fu_524_p2 = (icmp_ln879_reg_935 | and_ln321_reg_952);

assign or_ln791_1_fu_751_p2 = (tmp_34_reg_1000 | icmp_ln879_2_reg_982);

assign or_ln791_2_fu_869_p2 = (tmp_37_reg_1024 | icmp_ln879_3_reg_1006);

assign or_ln791_3_fu_649_p2 = (tmp_31_reg_976 | icmp_ln879_1_reg_958);

assign or_ln791_4_fu_767_p2 = (tmp_34_reg_1000 | icmp_ln879_2_reg_982);

assign or_ln791_5_fu_885_p2 = (tmp_37_reg_1024 | icmp_ln879_3_reg_1006);

assign or_ln791_fu_633_p2 = (tmp_31_reg_976 | icmp_ln879_1_reg_958);

assign p_Result_31_1_i_fu_295_p4 = {{rxEng_dataBuffer1_V_dout[67:66]}};

assign p_Result_31_2_i_fu_339_p4 = {{rxEng_dataBuffer1_V_dout[69:68]}};

assign p_Result_31_3_i_fu_383_p4 = {{rxEng_dataBuffer1_V_dout[71:70]}};

assign p_Result_31_i_fu_253_p4 = {{rxEng_dataBuffer1_V_dout[65:64]}};

assign p_Result_35_1_i_fu_548_p3 = {{p_Result_34_1_i_reg_970}, {p_Result_32_1_i_reg_965}};

assign p_Result_35_2_i_fu_666_p3 = {{p_Result_34_2_i_reg_994}, {p_Result_32_2_i_reg_989}};

assign p_Result_35_3_i_fu_784_p3 = {{p_Result_34_3_i_reg_1018}, {p_Result_32_3_i_reg_1013}};

assign p_Result_35_i_fu_431_p3 = {{trunc_ln647_reg_946}, {p_Result_32_i_reg_941}};

assign p_Result_38_1_i_fu_592_p3 = {{p_Result_34_1_i_reg_970}, {8'd0}};

assign p_Result_38_2_i_fu_710_p3 = {{p_Result_34_2_i_reg_994}, {8'd0}};

assign p_Result_38_3_i_fu_828_p3 = {{p_Result_34_3_i_reg_1018}, {8'd0}};

assign p_Result_38_i_fu_479_p3 = {{trunc_ln647_reg_946}, {8'd0}};

assign rxEng_dataBuffer2_V_din = tmp37_reg_926;

assign select_ln879_1_fu_638_p3 = ((icmp_ln879_1_reg_958[0:0] === 1'b1) ? add_ln214_5_fu_586_p2 : add_ln214_7_fu_627_p2);

assign select_ln879_2_fu_756_p3 = ((icmp_ln879_2_reg_982[0:0] === 1'b1) ? add_ln214_9_fu_704_p2 : add_ln214_11_fu_745_p2);

assign select_ln879_3_fu_874_p3 = ((icmp_ln879_3_reg_1006[0:0] === 1'b1) ? add_ln214_13_fu_822_p2 : add_ln214_15_fu_863_p2);

assign select_ln879_fu_529_p3 = ((icmp_ln879_reg_935[0:0] === 1'b1) ? zext_ln214_fu_475_p1 : tcts_tcp_sums_sum_V_4);

assign subSumFifo_V_sum_V_0_din = tmp_sum_0_V_reg_1030;

assign subSumFifo_V_sum_V_1_din = tmp_sum_1_V_reg_1035;

assign subSumFifo_V_sum_V_2_din = tmp_sum_2_V_reg_1040;

assign subSumFifo_V_sum_V_3_din = tmp_sum_3_V_reg_1045;

assign tmp_26_fu_237_p3 = rxEng_dataBuffer1_V_dout[32'd64];

assign tmp_28_fu_451_p3 = add_ln700_fu_445_p2[32'd16];

assign tmp_29_fu_496_p3 = add_ln700_1_fu_490_p2[32'd16];

assign tmp_30_fu_568_p3 = add_ln700_2_fu_562_p2[32'd16];

assign tmp_32_fu_609_p3 = add_ln700_3_fu_603_p2[32'd16];

assign tmp_33_fu_686_p3 = add_ln700_4_fu_680_p2[32'd16];

assign tmp_35_fu_727_p3 = add_ln700_5_fu_721_p2[32'd16];

assign tmp_36_fu_804_p3 = add_ln700_6_fu_798_p2[32'd16];

assign tmp_38_fu_845_p3 = add_ln700_7_fu_839_p2[32'd16];

assign tmp_last_V_fu_245_p3 = rxEng_dataBuffer1_V_dout[32'd72];

assign tmp_nbreadreq_fu_108_p3 = rxEng_dataBuffer1_V_empty_n;

assign tmp_sum_0_V_fu_536_p3 = ((and_ln321_reg_952[0:0] === 1'b1) ? zext_ln214_2_fu_520_p1 : select_ln879_fu_529_p3);

assign tmp_sum_1_V_fu_653_p3 = ((or_ln791_3_fu_649_p2[0:0] === 1'b1) ? zext_ln879_fu_645_p1 : tcts_tcp_sums_sum_V_1);

assign tmp_sum_2_V_fu_771_p3 = ((or_ln791_4_fu_767_p2[0:0] === 1'b1) ? zext_ln879_1_fu_763_p1 : tcts_tcp_sums_sum_V_2);

assign tmp_sum_3_V_fu_889_p3 = ((or_ln791_5_fu_885_p2[0:0] === 1'b1) ? zext_ln879_2_fu_881_p1 : tcts_tcp_sums_sum_V_3);

assign trunc_ln647_fu_279_p1 = rxEng_dataBuffer1_V_dout[7:0];

assign trunc_ln700_1_fu_558_p1 = tcts_tcp_sums_sum_V_1[15:0];

assign trunc_ln700_2_fu_676_p1 = tcts_tcp_sums_sum_V_2[15:0];

assign trunc_ln700_3_fu_794_p1 = tcts_tcp_sums_sum_V_3[15:0];

assign trunc_ln700_fu_441_p1 = tcts_tcp_sums_sum_V_4[15:0];

assign xor_ln879_fu_283_p2 = (icmp_ln879_fu_263_p2 ^ 1'd1);

assign zext_ln214_1_fu_459_p1 = tmp_28_fu_451_p3;

assign zext_ln214_2_fu_520_p1 = add_ln214_3_fu_514_p2;

assign zext_ln214_3_fu_504_p1 = tmp_29_fu_496_p3;

assign zext_ln214_4_fu_576_p1 = tmp_30_fu_568_p3;

assign zext_ln214_5_fu_617_p1 = tmp_32_fu_609_p3;

assign zext_ln214_6_fu_694_p1 = tmp_33_fu_686_p3;

assign zext_ln214_7_fu_735_p1 = tmp_35_fu_727_p3;

assign zext_ln214_8_fu_812_p1 = tmp_36_fu_804_p3;

assign zext_ln214_9_fu_853_p1 = tmp_38_fu_845_p3;

assign zext_ln214_fu_475_p1 = add_ln214_1_fu_469_p2;

assign zext_ln700_1_fu_486_p1 = p_Result_38_i_fu_479_p3;

assign zext_ln700_2_fu_554_p1 = p_Result_35_1_i_fu_548_p3;

assign zext_ln700_3_fu_599_p1 = p_Result_38_1_i_fu_592_p3;

assign zext_ln700_4_fu_672_p1 = p_Result_35_2_i_fu_666_p3;

assign zext_ln700_5_fu_717_p1 = p_Result_38_2_i_fu_710_p3;

assign zext_ln700_6_fu_790_p1 = p_Result_35_3_i_fu_784_p3;

assign zext_ln700_7_fu_835_p1 = p_Result_38_3_i_fu_828_p3;

assign zext_ln700_fu_437_p1 = p_Result_35_i_fu_431_p3;

assign zext_ln879_1_fu_763_p1 = select_ln879_2_fu_756_p3;

assign zext_ln879_2_fu_881_p1 = select_ln879_3_fu_874_p3;

assign zext_ln879_fu_645_p1 = select_ln879_1_fu_638_p3;

endmodule //two_complement_subch_1