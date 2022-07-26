// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2019.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module rx_sar_table (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        txEng2rxSar_req_V_V_dout,
        txEng2rxSar_req_V_V_empty_n,
        txEng2rxSar_req_V_V_read,
        rxApp2rxSar_upd_req_s_19_dout,
        rxApp2rxSar_upd_req_s_19_empty_n,
        rxApp2rxSar_upd_req_s_19_read,
        rxEng2rxSar_upd_req_s_18_dout,
        rxEng2rxSar_upd_req_s_18_empty_n,
        rxEng2rxSar_upd_req_s_18_read,
        rxSar2rxEng_upd_rsp_s_15_din,
        rxSar2rxEng_upd_rsp_s_15_full_n,
        rxSar2rxEng_upd_rsp_s_15_write,
        rxSar2rxApp_upd_rsp_s_16_din,
        rxSar2rxApp_upd_rsp_s_16_full_n,
        rxSar2rxApp_upd_rsp_s_16_write,
        rxSar2txEng_rsp_V_din,
        rxSar2txEng_rsp_V_full_n,
        rxSar2txEng_rsp_V_write
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;
parameter    ap_const_lv64_0 = 64'd0;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [15:0] txEng2rxSar_req_V_V_dout;
input   txEng2rxSar_req_V_V_empty_n;
output   txEng2rxSar_req_V_V_read;
input  [32:0] rxApp2rxSar_upd_req_s_19_dout;
input   rxApp2rxSar_upd_req_s_19_empty_n;
output   rxApp2rxSar_upd_req_s_19_read;
input  [118:0] rxEng2rxSar_upd_req_s_18_dout;
input   rxEng2rxSar_upd_req_s_18_empty_n;
output   rxEng2rxSar_upd_req_s_18_read;
output  [112:0] rxSar2rxEng_upd_rsp_s_15_din;
input   rxSar2rxEng_upd_rsp_s_15_full_n;
output   rxSar2rxEng_upd_rsp_s_15_write;
output  [32:0] rxSar2rxApp_upd_rsp_s_16_din;
input   rxSar2rxApp_upd_rsp_s_16_full_n;
output   rxSar2rxApp_upd_rsp_s_16_write;
output  [63:0] rxSar2txEng_rsp_V_din;
input   rxSar2txEng_rsp_V_full_n;
output   rxSar2txEng_rsp_V_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg txEng2rxSar_req_V_V_read;
reg rxApp2rxSar_upd_req_s_19_read;
reg rxEng2rxSar_upd_req_s_18_read;
reg rxSar2rxEng_upd_rsp_s_15_write;
reg rxSar2rxApp_upd_rsp_s_16_write;
reg rxSar2txEng_rsp_V_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
reg    ap_enable_reg_pp0_iter4;
reg    ap_idle_pp0;
wire   [0:0] tmp_nbreadreq_fu_110_p3;
reg    ap_block_state1_pp0_stage0_iter0;
reg   [0:0] tmp_reg_471;
wire   [0:0] tmp_85_nbreadreq_fu_124_p3;
reg    ap_predicate_op11_read_state2;
reg    ap_block_state2_pp0_stage0_iter1;
reg   [0:0] tmp_reg_471_pp0_iter1_reg;
reg   [0:0] tmp_85_reg_480;
wire   [0:0] tmp_87_nbreadreq_fu_138_p3;
reg    ap_predicate_op18_read_state3;
reg    ap_block_state3_pp0_stage0_iter2;
reg   [0:0] tmp_reg_471_pp0_iter2_reg;
reg   [0:0] tmp_85_reg_480_pp0_iter2_reg;
reg   [0:0] tmp_87_reg_499;
reg   [0:0] tmp_88_reg_503;
reg    ap_predicate_op64_write_state4;
reg   [0:0] tmp_86_reg_495;
reg   [0:0] tmp_86_reg_495_pp0_iter2_reg;
reg    ap_predicate_op67_write_state4;
reg    ap_block_state4_pp0_stage0_iter3;
reg   [0:0] tmp_reg_471_pp0_iter3_reg;
reg    ap_block_state5_pp0_stage0_iter4;
reg    ap_block_pp0_stage0_11001;
reg   [9:0] rx_table_recvd_V_address0;
reg    rx_table_recvd_V_ce0;
reg    rx_table_recvd_V_we0;
wire   [31:0] rx_table_recvd_V_d0;
wire   [31:0] rx_table_recvd_V_q0;
reg   [9:0] rx_table_appd_V_address0;
reg    rx_table_appd_V_ce0;
reg    rx_table_appd_V_we0;
reg   [15:0] rx_table_appd_V_d0;
wire   [15:0] rx_table_appd_V_q0;
reg   [9:0] rx_table_head_V_address0;
reg    rx_table_head_V_ce0;
reg    rx_table_head_V_we0;
wire   [31:0] rx_table_head_V_d0;
wire   [31:0] rx_table_head_V_q0;
reg   [9:0] rx_table_offset_V_address0;
reg    rx_table_offset_V_ce0;
reg    rx_table_offset_V_we0;
wire   [31:0] rx_table_offset_V_d0;
wire   [31:0] rx_table_offset_V_q0;
reg   [9:0] rx_table_gap_address0;
reg    rx_table_gap_ce0;
reg    rx_table_gap_we0;
wire   [0:0] rx_table_gap_d0;
wire   [0:0] rx_table_gap_q0;
reg    txEng2rxSar_req_V_V_blk_n;
wire    ap_block_pp0_stage0;
reg    rxSar2txEng_rsp_V_blk_n;
reg    rxApp2rxSar_upd_req_s_19_blk_n;
reg    rxSar2rxApp_upd_rsp_s_16_blk_n;
reg    rxEng2rxSar_upd_req_s_18_blk_n;
reg    rxSar2rxEng_upd_rsp_s_15_blk_n;
reg   [15:0] tmp_V_reg_475;
reg   [15:0] tmp_V_reg_475_pp0_iter1_reg;
wire   [15:0] tmp_sessionID_V_fu_294_p1;
reg   [15:0] tmp_sessionID_V_reg_484;
reg   [15:0] tmp_sessionID_V_reg_484_pp0_iter2_reg;
reg   [15:0] tmp_appd_V_load_new_s_reg_490;
wire   [0:0] tmp_88_fu_331_p3;
wire   [0:0] tmp_89_fu_339_p3;
reg   [31:0] entry_recvd_V_reg_551;
wire   [15:0] tmp_windowSize_V_fu_446_p2;
reg   [15:0] tmp_windowSize_V_reg_556;
reg    ap_block_pp0_stage0_subdone;
wire   [63:0] zext_ln544_14_fu_378_p1;
wire   [9:0] rx_table_head_V_addr_gep_fu_238_p3;
wire   [9:0] rx_table_offset_V_ad_gep_fu_246_p3;
wire   [9:0] rx_table_gap_addr_gep_fu_254_p3;
wire   [9:0] rx_table_appd_V_addr_3_gep_fu_262_p3;
wire   [63:0] zext_ln544_13_fu_402_p1;
wire   [63:0] zext_ln544_fu_406_p1;
reg    ap_block_pp0_stage0_01001;
wire   [15:0] trunc_ln321_fu_316_p1;
wire   [15:0] trunc_ln209_fu_436_p1;
wire   [15:0] xor_ln214_fu_440_p2;
wire   [47:0] tmp_52_i_fu_452_p3;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to3;
reg    ap_reset_idle_pp0;
reg    ap_block_pp0;
reg    ap_predicate_op38_store_state3;
reg    ap_enable_operation_38;
reg    ap_enable_state3_pp0_iter2_stage0;
reg    ap_predicate_op29_load_state3;
reg    ap_enable_operation_29;
reg    ap_predicate_op58_load_state4;
reg    ap_enable_operation_58;
reg    ap_enable_state4_pp0_iter3_stage0;
reg    ap_enable_operation_55;
reg    ap_enable_operation_68;
reg    ap_predicate_op40_store_state3;
reg    ap_enable_operation_40;
reg    ap_predicate_op33_load_state3;
reg    ap_enable_operation_33;
reg    ap_predicate_op60_load_state4;
reg    ap_enable_operation_60;
reg    ap_predicate_op42_store_state3;
reg    ap_enable_operation_42;
reg    ap_predicate_op35_load_state3;
reg    ap_enable_operation_35;
reg    ap_predicate_op61_load_state4;
reg    ap_enable_operation_61;
reg    ap_predicate_op44_store_state3;
reg    ap_enable_operation_44;
reg    ap_predicate_op37_load_state3;
reg    ap_enable_operation_37;
reg    ap_predicate_op62_load_state4;
reg    ap_enable_operation_62;
reg    ap_predicate_op48_store_state3;
reg    ap_enable_operation_48;
reg    ap_predicate_op31_load_state3;
reg    ap_enable_operation_31;
reg    ap_predicate_op59_load_state4;
reg    ap_enable_operation_59;
reg    ap_predicate_op51_load_state3;
reg    ap_enable_operation_51;
reg    ap_predicate_op65_load_state4;
reg    ap_enable_operation_65;
reg    ap_predicate_op52_store_state3;
reg    ap_enable_operation_52;
reg    ap_enable_operation_57;
reg    ap_enable_operation_69;
wire    ap_enable_pp0;
reg    ap_condition_536;
reg    ap_condition_533;
reg    ap_condition_283;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
#0 ap_enable_reg_pp0_iter4 = 1'b0;
end

rx_sar_table_rx_table_recvd_V #(
    .DataWidth( 32 ),
    .AddressRange( 1000 ),
    .AddressWidth( 10 ))
rx_table_recvd_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(rx_table_recvd_V_address0),
    .ce0(rx_table_recvd_V_ce0),
    .we0(rx_table_recvd_V_we0),
    .d0(rx_table_recvd_V_d0),
    .q0(rx_table_recvd_V_q0)
);

rx_sar_table_rx_table_appd_V #(
    .DataWidth( 16 ),
    .AddressRange( 1000 ),
    .AddressWidth( 10 ))
rx_table_appd_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(rx_table_appd_V_address0),
    .ce0(rx_table_appd_V_ce0),
    .we0(rx_table_appd_V_we0),
    .d0(rx_table_appd_V_d0),
    .q0(rx_table_appd_V_q0)
);

rx_sar_table_rx_table_recvd_V #(
    .DataWidth( 32 ),
    .AddressRange( 1000 ),
    .AddressWidth( 10 ))
rx_table_head_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(rx_table_head_V_address0),
    .ce0(rx_table_head_V_ce0),
    .we0(rx_table_head_V_we0),
    .d0(rx_table_head_V_d0),
    .q0(rx_table_head_V_q0)
);

rx_sar_table_rx_table_recvd_V #(
    .DataWidth( 32 ),
    .AddressRange( 1000 ),
    .AddressWidth( 10 ))
rx_table_offset_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(rx_table_offset_V_address0),
    .ce0(rx_table_offset_V_ce0),
    .we0(rx_table_offset_V_we0),
    .d0(rx_table_offset_V_d0),
    .q0(rx_table_offset_V_q0)
);

rx_sar_table_rx_table_gap #(
    .DataWidth( 1 ),
    .AddressRange( 1000 ),
    .AddressWidth( 10 ))
rx_table_gap_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(rx_table_gap_address0),
    .ce0(rx_table_gap_ce0),
    .we0(rx_table_gap_we0),
    .d0(rx_table_gap_d0),
    .q0(rx_table_gap_q0)
);

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
        end else if (((ap_enable_reg_pp0_iter4 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
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
        ap_enable_reg_pp0_iter4 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_reg_471_pp0_iter2_reg == 1'd1) & (ap_enable_reg_pp0_iter3 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        entry_recvd_V_reg_551 <= rx_table_recvd_V_q0;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_reg_471 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_85_reg_480 <= tmp_85_nbreadreq_fu_124_p3;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        tmp_85_reg_480_pp0_iter2_reg <= tmp_85_reg_480;
        tmp_86_reg_495_pp0_iter2_reg <= tmp_86_reg_495;
        tmp_reg_471_pp0_iter2_reg <= tmp_reg_471_pp0_iter1_reg;
        tmp_reg_471_pp0_iter3_reg <= tmp_reg_471_pp0_iter2_reg;
        tmp_sessionID_V_reg_484_pp0_iter2_reg <= tmp_sessionID_V_reg_484;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_reg_471 == 1'd0) & (tmp_85_nbreadreq_fu_124_p3 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_86_reg_495 <= rxApp2rxSar_upd_req_s_19_dout[32'd32];
        tmp_appd_V_load_new_s_reg_490 <= {{rxApp2rxSar_upd_req_s_19_dout[31:16]}};
        tmp_sessionID_V_reg_484 <= tmp_sessionID_V_fu_294_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_87_reg_499 <= tmp_87_nbreadreq_fu_138_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_88_reg_503 <= rxEng2rxSar_upd_req_s_18_dout[32'd52];
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_nbreadreq_fu_110_p3 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_reg_475 <= txEng2rxSar_req_V_V_dout;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_reg_475_pp0_iter1_reg <= tmp_V_reg_475;
        tmp_reg_471 <= tmp_nbreadreq_fu_110_p3;
        tmp_reg_471_pp0_iter1_reg <= tmp_reg_471;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_reg_471_pp0_iter2_reg == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_windowSize_V_reg_556 <= tmp_windowSize_V_fu_446_p2;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter4 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
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
    if (((ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0_0to3 = 1'b1;
    end else begin
        ap_idle_pp0_0to3 = 1'b0;
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
    if (((ap_start == 1'b0) & (ap_idle_pp0_0to3 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0) & (ap_predicate_op11_read_state2 == 1'b1))) begin
        rxApp2rxSar_upd_req_s_19_blk_n = rxApp2rxSar_upd_req_s_19_empty_n;
    end else begin
        rxApp2rxSar_upd_req_s_19_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op11_read_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rxApp2rxSar_upd_req_s_19_read = 1'b1;
    end else begin
        rxApp2rxSar_upd_req_s_19_read = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (ap_predicate_op18_read_state3 == 1'b1))) begin
        rxEng2rxSar_upd_req_s_18_blk_n = rxEng2rxSar_upd_req_s_18_empty_n;
    end else begin
        rxEng2rxSar_upd_req_s_18_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op18_read_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rxEng2rxSar_upd_req_s_18_read = 1'b1;
    end else begin
        rxEng2rxSar_upd_req_s_18_read = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (ap_predicate_op67_write_state4 == 1'b1))) begin
        rxSar2rxApp_upd_rsp_s_16_blk_n = rxSar2rxApp_upd_rsp_s_16_full_n;
    end else begin
        rxSar2rxApp_upd_rsp_s_16_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b1) & (ap_predicate_op67_write_state4 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rxSar2rxApp_upd_rsp_s_16_write = 1'b1;
    end else begin
        rxSar2rxApp_upd_rsp_s_16_write = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (ap_predicate_op64_write_state4 == 1'b1))) begin
        rxSar2rxEng_upd_rsp_s_15_blk_n = rxSar2rxEng_upd_rsp_s_15_full_n;
    end else begin
        rxSar2rxEng_upd_rsp_s_15_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b1) & (ap_predicate_op64_write_state4 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rxSar2rxEng_upd_rsp_s_15_write = 1'b1;
    end else begin
        rxSar2rxEng_upd_rsp_s_15_write = 1'b0;
    end
end

always @ (*) begin
    if (((tmp_reg_471_pp0_iter3_reg == 1'd1) & (ap_enable_reg_pp0_iter4 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        rxSar2txEng_rsp_V_blk_n = rxSar2txEng_rsp_V_full_n;
    end else begin
        rxSar2txEng_rsp_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((tmp_reg_471_pp0_iter3_reg == 1'd1) & (ap_enable_reg_pp0_iter4 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rxSar2txEng_rsp_V_write = 1'b1;
    end else begin
        rxSar2txEng_rsp_V_write = 1'b0;
    end
end

always @ (*) begin
    if (((tmp_reg_471_pp0_iter1_reg == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        rx_table_appd_V_address0 = zext_ln544_fu_406_p1;
    end else if ((((tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_85_reg_480 == 1'd1) & (tmp_86_reg_495 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)) | ((tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_86_reg_495 == 1'd0) & (tmp_85_reg_480 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)))) begin
        rx_table_appd_V_address0 = zext_ln544_13_fu_402_p1;
    end else if (((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_89_fu_339_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        rx_table_appd_V_address0 = rx_table_appd_V_addr_3_gep_fu_262_p3;
    end else if (((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_88_fu_331_p3 == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        rx_table_appd_V_address0 = zext_ln544_14_fu_378_p1;
    end else begin
        rx_table_appd_V_address0 = 'bx;
    end
end

always @ (*) begin
    if ((((tmp_reg_471_pp0_iter1_reg == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_85_reg_480 == 1'd1) & (tmp_86_reg_495 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_86_reg_495 == 1'd0) & (tmp_85_reg_480 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_89_fu_339_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_88_fu_331_p3 == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        rx_table_appd_V_ce0 = 1'b1;
    end else begin
        rx_table_appd_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_533)) begin
        if (((tmp_85_reg_480 == 1'd1) & (tmp_86_reg_495 == 1'd1))) begin
            rx_table_appd_V_d0 = tmp_appd_V_load_new_s_reg_490;
        end else if ((1'b1 == ap_condition_536)) begin
            rx_table_appd_V_d0 = {{rxEng2rxSar_upd_req_s_18_dout[31:16]}};
        end else begin
            rx_table_appd_V_d0 = 'bx;
        end
    end else begin
        rx_table_appd_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_85_reg_480 == 1'd1) & (tmp_86_reg_495 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_89_fu_339_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        rx_table_appd_V_we0 = 1'b1;
    end else begin
        rx_table_appd_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_283)) begin
        if ((tmp_88_fu_331_p3 == 1'd1)) begin
            rx_table_gap_address0 = rx_table_gap_addr_gep_fu_254_p3;
        end else if ((tmp_88_fu_331_p3 == 1'd0)) begin
            rx_table_gap_address0 = zext_ln544_14_fu_378_p1;
        end else begin
            rx_table_gap_address0 = 'bx;
        end
    end else begin
        rx_table_gap_address0 = 'bx;
    end
end

always @ (*) begin
    if ((((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_88_fu_331_p3 == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        rx_table_gap_ce0 = 1'b1;
    end else begin
        rx_table_gap_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rx_table_gap_we0 = 1'b1;
    end else begin
        rx_table_gap_we0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_283)) begin
        if ((tmp_88_fu_331_p3 == 1'd1)) begin
            rx_table_head_V_address0 = rx_table_head_V_addr_gep_fu_238_p3;
        end else if ((tmp_88_fu_331_p3 == 1'd0)) begin
            rx_table_head_V_address0 = zext_ln544_14_fu_378_p1;
        end else begin
            rx_table_head_V_address0 = 'bx;
        end
    end else begin
        rx_table_head_V_address0 = 'bx;
    end
end

always @ (*) begin
    if ((((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_88_fu_331_p3 == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        rx_table_head_V_ce0 = 1'b1;
    end else begin
        rx_table_head_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rx_table_head_V_we0 = 1'b1;
    end else begin
        rx_table_head_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_283)) begin
        if ((tmp_88_fu_331_p3 == 1'd1)) begin
            rx_table_offset_V_address0 = rx_table_offset_V_ad_gep_fu_246_p3;
        end else if ((tmp_88_fu_331_p3 == 1'd0)) begin
            rx_table_offset_V_address0 = zext_ln544_14_fu_378_p1;
        end else begin
            rx_table_offset_V_address0 = 'bx;
        end
    end else begin
        rx_table_offset_V_address0 = 'bx;
    end
end

always @ (*) begin
    if ((((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_88_fu_331_p3 == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        rx_table_offset_V_ce0 = 1'b1;
    end else begin
        rx_table_offset_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rx_table_offset_V_we0 = 1'b1;
    end else begin
        rx_table_offset_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((tmp_reg_471_pp0_iter1_reg == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        rx_table_recvd_V_address0 = zext_ln544_fu_406_p1;
    end else if ((((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)) | ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_88_fu_331_p3 == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)))) begin
        rx_table_recvd_V_address0 = zext_ln544_14_fu_378_p1;
    end else begin
        rx_table_recvd_V_address0 = 'bx;
    end
end

always @ (*) begin
    if ((((tmp_reg_471_pp0_iter1_reg == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_88_fu_331_p3 == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        rx_table_recvd_V_ce0 = 1'b1;
    end else begin
        rx_table_recvd_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rx_table_recvd_V_we0 = 1'b1;
    end else begin
        rx_table_recvd_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (tmp_nbreadreq_fu_110_p3 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        txEng2rxSar_req_V_V_blk_n = txEng2rxSar_req_V_V_empty_n;
    end else begin
        txEng2rxSar_req_V_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((tmp_nbreadreq_fu_110_p3 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        txEng2rxSar_req_V_V_read = 1'b1;
    end else begin
        txEng2rxSar_req_V_V_read = 1'b0;
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

always @ (*) begin
    ap_block_pp0 = ((ap_ST_fsm_pp0_stage0 == ap_CS_fsm) & (1'b1 == ap_block_pp0_stage0_subdone));
end

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((rxEng2rxSar_upd_req_s_18_empty_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op18_read_state3 == 1'b1)) | ((rxApp2rxSar_upd_req_s_19_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (ap_predicate_op11_read_state2 == 1'b1)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_110_p3 == 1'd1) & (txEng2rxSar_req_V_V_empty_n == 1'b0)))) | ((tmp_reg_471_pp0_iter3_reg == 1'd1) & (rxSar2txEng_rsp_V_full_n == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b1)) | ((ap_enable_reg_pp0_iter3 == 1'b1) & (((rxSar2rxEng_upd_rsp_s_15_full_n == 1'b0) & (ap_predicate_op64_write_state4 == 1'b1)) | ((rxSar2rxApp_upd_rsp_s_16_full_n == 1'b0) & (ap_predicate_op67_write_state4 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((rxEng2rxSar_upd_req_s_18_empty_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op18_read_state3 == 1'b1)) | ((rxApp2rxSar_upd_req_s_19_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (ap_predicate_op11_read_state2 == 1'b1)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_110_p3 == 1'd1) & (txEng2rxSar_req_V_V_empty_n == 1'b0)))) | ((tmp_reg_471_pp0_iter3_reg == 1'd1) & (rxSar2txEng_rsp_V_full_n == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b1)) | ((ap_enable_reg_pp0_iter3 == 1'b1) & (((rxSar2rxEng_upd_rsp_s_15_full_n == 1'b0) & (ap_predicate_op64_write_state4 == 1'b1)) | ((rxSar2rxApp_upd_rsp_s_16_full_n == 1'b0) & (ap_predicate_op67_write_state4 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((rxEng2rxSar_upd_req_s_18_empty_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op18_read_state3 == 1'b1)) | ((rxApp2rxSar_upd_req_s_19_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (ap_predicate_op11_read_state2 == 1'b1)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_110_p3 == 1'd1) & (txEng2rxSar_req_V_V_empty_n == 1'b0)))) | ((tmp_reg_471_pp0_iter3_reg == 1'd1) & (rxSar2txEng_rsp_V_full_n == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b1)) | ((ap_enable_reg_pp0_iter3 == 1'b1) & (((rxSar2rxEng_upd_rsp_s_15_full_n == 1'b0) & (ap_predicate_op64_write_state4 == 1'b1)) | ((rxSar2rxApp_upd_rsp_s_16_full_n == 1'b0) & (ap_predicate_op67_write_state4 == 1'b1)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_110_p3 == 1'd1) & (txEng2rxSar_req_V_V_empty_n == 1'b0)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = ((rxApp2rxSar_upd_req_s_19_empty_n == 1'b0) & (ap_predicate_op11_read_state2 == 1'b1));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = ((rxEng2rxSar_upd_req_s_18_empty_n == 1'b0) & (ap_predicate_op18_read_state3 == 1'b1));
end

always @ (*) begin
    ap_block_state4_pp0_stage0_iter3 = (((rxSar2rxEng_upd_rsp_s_15_full_n == 1'b0) & (ap_predicate_op64_write_state4 == 1'b1)) | ((rxSar2rxApp_upd_rsp_s_16_full_n == 1'b0) & (ap_predicate_op67_write_state4 == 1'b1)));
end

always @ (*) begin
    ap_block_state5_pp0_stage0_iter4 = ((tmp_reg_471_pp0_iter3_reg == 1'd1) & (rxSar2txEng_rsp_V_full_n == 1'b0));
end

always @ (*) begin
    ap_condition_283 = ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0));
end

always @ (*) begin
    ap_condition_533 = ((tmp_reg_471_pp0_iter1_reg == 1'd0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0));
end

always @ (*) begin
    ap_condition_536 = ((tmp_85_reg_480 == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_89_fu_339_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1));
end

always @ (*) begin
    ap_enable_operation_29 = (ap_predicate_op29_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_31 = (ap_predicate_op31_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_33 = (ap_predicate_op33_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_35 = (ap_predicate_op35_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_37 = (ap_predicate_op37_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_38 = (ap_predicate_op38_store_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_40 = (ap_predicate_op40_store_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_42 = (ap_predicate_op42_store_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_44 = (ap_predicate_op44_store_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_48 = (ap_predicate_op48_store_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_51 = (ap_predicate_op51_load_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_52 = (ap_predicate_op52_store_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_55 = (tmp_reg_471_pp0_iter1_reg == 1'd1);
end

always @ (*) begin
    ap_enable_operation_57 = (tmp_reg_471_pp0_iter1_reg == 1'd1);
end

always @ (*) begin
    ap_enable_operation_58 = (ap_predicate_op58_load_state4 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_59 = (ap_predicate_op59_load_state4 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_60 = (ap_predicate_op60_load_state4 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_61 = (ap_predicate_op61_load_state4 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_62 = (ap_predicate_op62_load_state4 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_65 = (ap_predicate_op65_load_state4 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_68 = (tmp_reg_471_pp0_iter2_reg == 1'd1);
end

always @ (*) begin
    ap_enable_operation_69 = (tmp_reg_471_pp0_iter2_reg == 1'd1);
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

always @ (*) begin
    ap_enable_state3_pp0_iter2_stage0 = ((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_enable_state4_pp0_iter3_stage0 = ((ap_enable_reg_pp0_iter3 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_predicate_op11_read_state2 = ((tmp_reg_471 == 1'd0) & (tmp_85_nbreadreq_fu_124_p3 == 1'd1));
end

always @ (*) begin
    ap_predicate_op18_read_state3 = ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1));
end

always @ (*) begin
    ap_predicate_op29_load_state3 = ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_88_fu_331_p3 == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1));
end

always @ (*) begin
    ap_predicate_op31_load_state3 = ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_88_fu_331_p3 == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1));
end

always @ (*) begin
    ap_predicate_op33_load_state3 = ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_88_fu_331_p3 == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1));
end

always @ (*) begin
    ap_predicate_op35_load_state3 = ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_88_fu_331_p3 == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1));
end

always @ (*) begin
    ap_predicate_op37_load_state3 = ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_88_fu_331_p3 == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1));
end

always @ (*) begin
    ap_predicate_op38_store_state3 = ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1));
end

always @ (*) begin
    ap_predicate_op40_store_state3 = ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1));
end

always @ (*) begin
    ap_predicate_op42_store_state3 = ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1));
end

always @ (*) begin
    ap_predicate_op44_store_state3 = ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1));
end

always @ (*) begin
    ap_predicate_op48_store_state3 = ((tmp_85_reg_480 == 1'd0) & (tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_87_nbreadreq_fu_138_p3 == 1'd1) & (tmp_89_fu_339_p3 == 1'd1) & (tmp_88_fu_331_p3 == 1'd1));
end

always @ (*) begin
    ap_predicate_op51_load_state3 = ((tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_86_reg_495 == 1'd0) & (tmp_85_reg_480 == 1'd1));
end

always @ (*) begin
    ap_predicate_op52_store_state3 = ((tmp_reg_471_pp0_iter1_reg == 1'd0) & (tmp_85_reg_480 == 1'd1) & (tmp_86_reg_495 == 1'd1));
end

always @ (*) begin
    ap_predicate_op58_load_state4 = ((tmp_reg_471_pp0_iter2_reg == 1'd0) & (tmp_88_reg_503 == 1'd0) & (tmp_85_reg_480_pp0_iter2_reg == 1'd0) & (tmp_87_reg_499 == 1'd1));
end

always @ (*) begin
    ap_predicate_op59_load_state4 = ((tmp_reg_471_pp0_iter2_reg == 1'd0) & (tmp_88_reg_503 == 1'd0) & (tmp_85_reg_480_pp0_iter2_reg == 1'd0) & (tmp_87_reg_499 == 1'd1));
end

always @ (*) begin
    ap_predicate_op60_load_state4 = ((tmp_reg_471_pp0_iter2_reg == 1'd0) & (tmp_88_reg_503 == 1'd0) & (tmp_85_reg_480_pp0_iter2_reg == 1'd0) & (tmp_87_reg_499 == 1'd1));
end

always @ (*) begin
    ap_predicate_op61_load_state4 = ((tmp_reg_471_pp0_iter2_reg == 1'd0) & (tmp_88_reg_503 == 1'd0) & (tmp_85_reg_480_pp0_iter2_reg == 1'd0) & (tmp_87_reg_499 == 1'd1));
end

always @ (*) begin
    ap_predicate_op62_load_state4 = ((tmp_reg_471_pp0_iter2_reg == 1'd0) & (tmp_88_reg_503 == 1'd0) & (tmp_85_reg_480_pp0_iter2_reg == 1'd0) & (tmp_87_reg_499 == 1'd1));
end

always @ (*) begin
    ap_predicate_op64_write_state4 = ((tmp_reg_471_pp0_iter2_reg == 1'd0) & (tmp_88_reg_503 == 1'd0) & (tmp_85_reg_480_pp0_iter2_reg == 1'd0) & (tmp_87_reg_499 == 1'd1));
end

always @ (*) begin
    ap_predicate_op65_load_state4 = ((tmp_reg_471_pp0_iter2_reg == 1'd0) & (tmp_86_reg_495_pp0_iter2_reg == 1'd0) & (tmp_85_reg_480_pp0_iter2_reg == 1'd1));
end

always @ (*) begin
    ap_predicate_op67_write_state4 = ((tmp_reg_471_pp0_iter2_reg == 1'd0) & (tmp_86_reg_495_pp0_iter2_reg == 1'd0) & (tmp_85_reg_480_pp0_iter2_reg == 1'd1));
end

assign rxSar2rxApp_upd_rsp_s_16_din = {{{{1'd1}, {rx_table_appd_V_q0}}}, {tmp_sessionID_V_reg_484_pp0_iter2_reg}};

assign rxSar2rxEng_upd_rsp_s_15_din = {{{{{rx_table_gap_q0}, {rx_table_offset_V_q0}}, {rx_table_head_V_q0}}, {rx_table_appd_V_q0}}, {rx_table_recvd_V_q0}};

assign rxSar2txEng_rsp_V_din = {{ap_const_lv64_0[63:48]}, {tmp_52_i_fu_452_p3}};

assign rx_table_appd_V_addr_3_gep_fu_262_p3 = zext_ln544_14_fu_378_p1;

assign rx_table_gap_addr_gep_fu_254_p3 = zext_ln544_14_fu_378_p1;

assign rx_table_gap_d0 = rxEng2rxSar_upd_req_s_18_dout[32'd118];

assign rx_table_head_V_addr_gep_fu_238_p3 = zext_ln544_14_fu_378_p1;

assign rx_table_head_V_d0 = {{rxEng2rxSar_upd_req_s_18_dout[85:54]}};

assign rx_table_offset_V_ad_gep_fu_246_p3 = zext_ln544_14_fu_378_p1;

assign rx_table_offset_V_d0 = {{rxEng2rxSar_upd_req_s_18_dout[117:86]}};

assign rx_table_recvd_V_d0 = {{rxEng2rxSar_upd_req_s_18_dout[47:16]}};

assign tmp_52_i_fu_452_p3 = {{tmp_windowSize_V_reg_556}, {entry_recvd_V_reg_551}};

assign tmp_85_nbreadreq_fu_124_p3 = rxApp2rxSar_upd_req_s_19_empty_n;

assign tmp_87_nbreadreq_fu_138_p3 = rxEng2rxSar_upd_req_s_18_empty_n;

assign tmp_88_fu_331_p3 = rxEng2rxSar_upd_req_s_18_dout[32'd52];

assign tmp_89_fu_339_p3 = rxEng2rxSar_upd_req_s_18_dout[32'd53];

assign tmp_nbreadreq_fu_110_p3 = txEng2rxSar_req_V_V_empty_n;

assign tmp_sessionID_V_fu_294_p1 = rxApp2rxSar_upd_req_s_19_dout[15:0];

assign tmp_windowSize_V_fu_446_p2 = (xor_ln214_fu_440_p2 + rx_table_appd_V_q0);

assign trunc_ln209_fu_436_p1 = rx_table_recvd_V_q0[15:0];

assign trunc_ln321_fu_316_p1 = rxEng2rxSar_upd_req_s_18_dout[15:0];

assign xor_ln214_fu_440_p2 = (trunc_ln209_fu_436_p1 ^ 16'd65535);

assign zext_ln544_13_fu_402_p1 = tmp_sessionID_V_reg_484;

assign zext_ln544_14_fu_378_p1 = trunc_ln321_fu_316_p1;

assign zext_ln544_fu_406_p1 = tmp_V_reg_475_pp0_iter1_reg;

endmodule //rx_sar_table
