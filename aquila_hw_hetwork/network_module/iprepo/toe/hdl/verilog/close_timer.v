// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2019.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module close_timer (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        rxEng2timer_setClose_1_dout,
        rxEng2timer_setClose_1_empty_n,
        rxEng2timer_setClose_1_read,
        closeTimer2stateTabl_1_din,
        closeTimer2stateTabl_1_full_n,
        closeTimer2stateTabl_1_write
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [15:0] rxEng2timer_setClose_1_dout;
input   rxEng2timer_setClose_1_empty_n;
output   rxEng2timer_setClose_1_read;
output  [15:0] closeTimer2stateTabl_1_din;
input   closeTimer2stateTabl_1_full_n;
output   closeTimer2stateTabl_1_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg rxEng2timer_setClose_1_read;
reg closeTimer2stateTabl_1_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire   [0:0] tmp_nbreadreq_fu_70_p3;
reg    ap_predicate_op19_read_state1;
reg    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
reg   [0:0] ct_waitForWrite_load_reg_248;
reg   [0:0] ct_waitForWrite_load_reg_248_pp0_iter1_reg;
reg   [0:0] tmp_reg_252;
reg   [0:0] tmp_reg_252_pp0_iter1_reg;
reg   [0:0] tmp_302_reg_271;
reg   [0:0] icmp_ln895_reg_275;
reg    ap_predicate_op45_write_state3;
reg    ap_block_state3_pp0_stage0_iter2;
reg    ap_block_pp0_stage0_11001;
reg   [0:0] ct_waitForWrite;
reg   [15:0] ct_setSessionID_V;
reg   [15:0] ct_prevSessionID_V;
reg   [9:0] closeTimerTable_address0;
reg    closeTimerTable_ce0;
reg    closeTimerTable_we0;
wire   [32:0] closeTimerTable_q0;
wire   [9:0] closeTimerTable_address1;
reg    closeTimerTable_ce1;
reg    closeTimerTable_we1;
reg   [32:0] closeTimerTable_d1;
reg   [15:0] ct_currSessionID_V;
reg    rxEng2timer_setClose_1_blk_n;
wire    ap_block_pp0_stage0;
reg    closeTimer2stateTabl_1_blk_n;
reg   [15:0] tmp_V_22_reg_256;
reg   [15:0] tmp_V_22_reg_256_pp0_iter1_reg;
reg   [9:0] closeTimerTable_addr_1_reg_261;
reg   [9:0] closeTimerTable_addr_1_reg_261_pp0_iter1_reg;
wire   [0:0] icmp_ln883_fu_183_p2;
wire   [0:0] tmp_302_fu_212_p3;
wire   [0:0] icmp_ln895_fu_224_p2;
wire   [32:0] closeTimerTable_time_1_fu_236_p5;
reg   [32:0] closeTimerTable_time_1_reg_279;
reg    ap_block_pp0_stage0_subdone;
wire   [63:0] zext_ln544_21_fu_140_p1;
wire   [63:0] zext_ln544_fu_189_p1;
wire   [15:0] add_ln701_fu_200_p2;
wire   [15:0] select_ln93_fu_157_p3;
reg    ap_block_pp0_stage0_01001;
wire   [15:0] add_ln700_fu_145_p2;
wire   [0:0] icmp_ln879_fu_151_p2;
wire   [31:0] trunc_ln895_fu_220_p1;
wire   [31:0] add_ln701_2_fu_230_p2;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to1;
reg    ap_reset_idle_pp0;
reg    ap_block_pp0;
reg    ap_predicate_op26_store_state1;
reg    ap_enable_operation_26;
reg    ap_enable_state1_pp0_iter0_stage0;
reg    ap_predicate_op14_load_state1;
reg    ap_enable_operation_14;
reg    ap_predicate_op30_load_state2;
reg    ap_enable_operation_30;
reg    ap_enable_state2_pp0_iter1_stage0;
reg    ap_predicate_op42_store_state3;
reg    ap_enable_operation_42;
reg    ap_enable_state3_pp0_iter2_stage0;
reg    ap_predicate_op44_store_state3;
reg    ap_enable_operation_44;
wire    ap_enable_pp0;
reg    ap_condition_112;
reg    ap_condition_304;
reg    ap_condition_87;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ct_waitForWrite = 1'd0;
#0 ct_setSessionID_V = 16'd0;
#0 ct_prevSessionID_V = 16'd0;
#0 ct_currSessionID_V = 16'd0;
end

probe_timer_probeTimerTable #(
    .DataWidth( 33 ),
    .AddressRange( 1000 ),
    .AddressWidth( 10 ))
closeTimerTable_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(closeTimerTable_address0),
    .ce0(closeTimerTable_ce0),
    .we0(closeTimerTable_we0),
    .d0(33'd4304342297),
    .q0(closeTimerTable_q0),
    .address1(closeTimerTable_address1),
    .ce1(closeTimerTable_ce1),
    .we1(closeTimerTable_we1),
    .d1(closeTimerTable_d1)
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
    if ((1'b1 == ap_condition_87)) begin
        if ((ct_waitForWrite == 1'd1)) begin
            ct_prevSessionID_V <= add_ln701_fu_200_p2;
        end else if (((tmp_nbreadreq_fu_70_p3 == 1'd0) & (ct_waitForWrite == 1'd0))) begin
            ct_prevSessionID_V <= ct_currSessionID_V;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_87)) begin
        if (((icmp_ln883_fu_183_p2 == 1'd0) & (ct_waitForWrite == 1'd1))) begin
            ct_waitForWrite <= 1'd0;
        end else if (((tmp_nbreadreq_fu_70_p3 == 1'd1) & (ct_waitForWrite == 1'd0))) begin
            ct_waitForWrite <= 1'd1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_70_p3 == 1'd0) & (ct_waitForWrite == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        closeTimerTable_addr_1_reg_261 <= zext_ln544_21_fu_140_p1;
        tmp_V_22_reg_256 <= ct_currSessionID_V;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        closeTimerTable_addr_1_reg_261_pp0_iter1_reg <= closeTimerTable_addr_1_reg_261;
        ct_waitForWrite_load_reg_248 <= ct_waitForWrite;
        ct_waitForWrite_load_reg_248_pp0_iter1_reg <= ct_waitForWrite_load_reg_248;
        tmp_V_22_reg_256_pp0_iter1_reg <= tmp_V_22_reg_256;
        tmp_reg_252_pp0_iter1_reg <= tmp_reg_252;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_302_fu_212_p3 == 1'd1) & (tmp_reg_252 == 1'd0) & (ct_waitForWrite_load_reg_248 == 1'd0) & (icmp_ln895_fu_224_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        closeTimerTable_time_1_reg_279 <= closeTimerTable_time_1_fu_236_p5;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_70_p3 == 1'd0) & (ct_waitForWrite == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ct_currSessionID_V <= select_ln93_fu_157_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_70_p3 == 1'd1) & (ct_waitForWrite == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ct_setSessionID_V <= rxEng2timer_setClose_1_dout;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_302_fu_212_p3 == 1'd1) & (tmp_reg_252 == 1'd0) & (ct_waitForWrite_load_reg_248 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln895_reg_275 <= icmp_ln895_fu_224_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_reg_252 == 1'd0) & (ct_waitForWrite_load_reg_248 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_302_reg_271 <= closeTimerTable_q0[32'd32];
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ct_waitForWrite == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_reg_252 <= tmp_nbreadreq_fu_70_p3;
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
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op45_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        closeTimer2stateTabl_1_blk_n = closeTimer2stateTabl_1_full_n;
    end else begin
        closeTimer2stateTabl_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op45_write_state3 == 1'b1))) begin
        closeTimer2stateTabl_1_write = 1'b1;
    end else begin
        closeTimer2stateTabl_1_write = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_112)) begin
        if (((icmp_ln883_fu_183_p2 == 1'd0) & (ct_waitForWrite == 1'd1))) begin
            closeTimerTable_address0 = zext_ln544_fu_189_p1;
        end else if (((tmp_nbreadreq_fu_70_p3 == 1'd0) & (ct_waitForWrite == 1'd0))) begin
            closeTimerTable_address0 = zext_ln544_21_fu_140_p1;
        end else begin
            closeTimerTable_address0 = 'bx;
        end
    end else begin
        closeTimerTable_address0 = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln883_fu_183_p2 == 1'd0) & (ct_waitForWrite == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_70_p3 == 1'd0) & (ct_waitForWrite == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        closeTimerTable_ce0 = 1'b1;
    end else begin
        closeTimerTable_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (tmp_302_reg_271 == 1'd1) & (icmp_ln895_reg_275 == 1'd0) & (tmp_reg_252_pp0_iter1_reg == 1'd0) & (ct_waitForWrite_load_reg_248_pp0_iter1_reg == 1'd0) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln895_reg_275 == 1'd1) & (tmp_302_reg_271 == 1'd1) & (tmp_reg_252_pp0_iter1_reg == 1'd0) & (ct_waitForWrite_load_reg_248_pp0_iter1_reg == 1'd0) & (ap_enable_reg_pp0_iter2 == 1'b1)))) begin
        closeTimerTable_ce1 = 1'b1;
    end else begin
        closeTimerTable_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_304)) begin
        if ((icmp_ln895_reg_275 == 1'd1)) begin
            closeTimerTable_d1 = 33'd0;
        end else if ((icmp_ln895_reg_275 == 1'd0)) begin
            closeTimerTable_d1 = closeTimerTable_time_1_reg_279;
        end else begin
            closeTimerTable_d1 = 'bx;
        end
    end else begin
        closeTimerTable_d1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln883_fu_183_p2 == 1'd0) & (ct_waitForWrite == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        closeTimerTable_we0 = 1'b1;
    end else begin
        closeTimerTable_we0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (tmp_302_reg_271 == 1'd1) & (icmp_ln895_reg_275 == 1'd0) & (tmp_reg_252_pp0_iter1_reg == 1'd0) & (ct_waitForWrite_load_reg_248_pp0_iter1_reg == 1'd0) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln895_reg_275 == 1'd1) & (tmp_302_reg_271 == 1'd1) & (tmp_reg_252_pp0_iter1_reg == 1'd0) & (ct_waitForWrite_load_reg_248_pp0_iter1_reg == 1'd0) & (ap_enable_reg_pp0_iter2 == 1'b1)))) begin
        closeTimerTable_we1 = 1'b1;
    end else begin
        closeTimerTable_we1 = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op19_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        rxEng2timer_setClose_1_blk_n = rxEng2timer_setClose_1_empty_n;
    end else begin
        rxEng2timer_setClose_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op19_read_state1 == 1'b1))) begin
        rxEng2timer_setClose_1_read = 1'b1;
    end else begin
        rxEng2timer_setClose_1_read = 1'b0;
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

assign add_ln700_fu_145_p2 = (ct_currSessionID_V + 16'd1);

assign add_ln701_2_fu_230_p2 = ($signed(trunc_ln895_fu_220_p1) + $signed(32'd4294967295));

assign add_ln701_fu_200_p2 = ($signed(ct_prevSessionID_V) + $signed(16'd65535));

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

always @ (*) begin
    ap_block_pp0 = ((ap_ST_fsm_pp0_stage0 == ap_CS_fsm) & (1'b1 == ap_block_pp0_stage0_subdone));
end

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((closeTimer2stateTabl_1_full_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op45_write_state3 == 1'b1)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((rxEng2timer_setClose_1_empty_n == 1'b0) & (ap_predicate_op19_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((closeTimer2stateTabl_1_full_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op45_write_state3 == 1'b1)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((rxEng2timer_setClose_1_empty_n == 1'b0) & (ap_predicate_op19_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((closeTimer2stateTabl_1_full_n == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op45_write_state3 == 1'b1)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((rxEng2timer_setClose_1_empty_n == 1'b0) & (ap_predicate_op19_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((rxEng2timer_setClose_1_empty_n == 1'b0) & (ap_predicate_op19_read_state1 == 1'b1)));
end

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = ((closeTimer2stateTabl_1_full_n == 1'b0) & (ap_predicate_op45_write_state3 == 1'b1));
end

always @ (*) begin
    ap_condition_112 = ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0));
end

always @ (*) begin
    ap_condition_304 = ((tmp_302_reg_271 == 1'd1) & (tmp_reg_252_pp0_iter1_reg == 1'd0) & (ct_waitForWrite_load_reg_248_pp0_iter1_reg == 1'd0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0));
end

always @ (*) begin
    ap_condition_87 = ((1'b0 == ap_block_pp0_stage0_11001) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_enable_operation_14 = (ap_predicate_op14_load_state1 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_26 = (ap_predicate_op26_store_state1 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_30 = (ap_predicate_op30_load_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_42 = (ap_predicate_op42_store_state3 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_44 = (ap_predicate_op44_store_state3 == 1'b1);
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

always @ (*) begin
    ap_enable_state1_pp0_iter0_stage0 = ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_enable_state2_pp0_iter1_stage0 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_enable_state3_pp0_iter2_stage0 = ((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_predicate_op14_load_state1 = ((tmp_nbreadreq_fu_70_p3 == 1'd0) & (ct_waitForWrite == 1'd0));
end

always @ (*) begin
    ap_predicate_op19_read_state1 = ((tmp_nbreadreq_fu_70_p3 == 1'd1) & (ct_waitForWrite == 1'd0));
end

always @ (*) begin
    ap_predicate_op26_store_state1 = ((icmp_ln883_fu_183_p2 == 1'd0) & (ct_waitForWrite == 1'd1));
end

always @ (*) begin
    ap_predicate_op30_load_state2 = ((tmp_reg_252 == 1'd0) & (ct_waitForWrite_load_reg_248 == 1'd0));
end

always @ (*) begin
    ap_predicate_op42_store_state3 = ((tmp_302_reg_271 == 1'd1) & (icmp_ln895_reg_275 == 1'd0) & (tmp_reg_252_pp0_iter1_reg == 1'd0) & (ct_waitForWrite_load_reg_248_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op44_store_state3 = ((icmp_ln895_reg_275 == 1'd1) & (tmp_302_reg_271 == 1'd1) & (tmp_reg_252_pp0_iter1_reg == 1'd0) & (ct_waitForWrite_load_reg_248_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op45_write_state3 = ((icmp_ln895_reg_275 == 1'd1) & (tmp_302_reg_271 == 1'd1) & (tmp_reg_252_pp0_iter1_reg == 1'd0) & (ct_waitForWrite_load_reg_248_pp0_iter1_reg == 1'd0));
end

assign closeTimer2stateTabl_1_din = tmp_V_22_reg_256_pp0_iter1_reg;

assign closeTimerTable_address1 = closeTimerTable_addr_1_reg_261_pp0_iter1_reg;

assign closeTimerTable_time_1_fu_236_p5 = {{closeTimerTable_q0[32:32]}, {add_ln701_2_fu_230_p2}};

assign icmp_ln879_fu_151_p2 = ((add_ln700_fu_145_p2 == 16'd1000) ? 1'b1 : 1'b0);

assign icmp_ln883_fu_183_p2 = ((ct_setSessionID_V == ct_prevSessionID_V) ? 1'b1 : 1'b0);

assign icmp_ln895_fu_224_p2 = ((trunc_ln895_fu_220_p1 == 32'd0) ? 1'b1 : 1'b0);

assign select_ln93_fu_157_p3 = ((icmp_ln879_fu_151_p2[0:0] === 1'b1) ? 16'd0 : add_ln700_fu_145_p2);

assign tmp_302_fu_212_p3 = closeTimerTable_q0[32'd32];

assign tmp_nbreadreq_fu_70_p3 = rxEng2timer_setClose_1_empty_n;

assign trunc_ln895_fu_220_p1 = closeTimerTable_q0[31:0];

assign zext_ln544_21_fu_140_p1 = ct_currSessionID_V;

assign zext_ln544_fu_189_p1 = ct_setSessionID_V;

endmodule //close_timer
