// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2019.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module sessionIdManager (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        slc_sessionIdFinFifo_1_dout,
        slc_sessionIdFinFifo_1_empty_n,
        slc_sessionIdFinFifo_1_read,
        slc_sessionIdFreeLis_1_din,
        slc_sessionIdFreeLis_1_full_n,
        slc_sessionIdFreeLis_1_write
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [13:0] slc_sessionIdFinFifo_1_dout;
input   slc_sessionIdFinFifo_1_empty_n;
output   slc_sessionIdFinFifo_1_read;
output  [13:0] slc_sessionIdFreeLis_1_din;
input   slc_sessionIdFreeLis_1_full_n;
output   slc_sessionIdFreeLis_1_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg slc_sessionIdFinFifo_1_read;
reg[13:0] slc_sessionIdFreeLis_1_din;
reg slc_sessionIdFreeLis_1_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_idle_pp0;
wire   [0:0] tmp_nbreadreq_fu_36_p3;
reg    ap_block_state1_pp0_stage0_iter0;
reg   [0:0] tmp_reg_79;
reg   [0:0] icmp_ln887_reg_88;
reg    ap_predicate_op15_write_state2;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_pp0_stage0_11001;
reg   [13:0] counter_V;
reg    slc_sessionIdFinFifo_1_blk_n;
wire    ap_block_pp0_stage0;
reg    slc_sessionIdFreeLis_1_blk_n;
reg   [13:0] tmp_V_8_reg_83;
wire   [0:0] icmp_ln887_fu_61_p2;
reg   [13:0] tmp_V_reg_92;
reg    ap_block_pp0_stage0_subdone;
wire   [13:0] add_ln700_fu_67_p2;
reg    ap_block_pp0_stage0_01001;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to0;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
reg    ap_condition_114;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 counter_V = 14'd0;
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
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        counter_V <= 14'd0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln887_fu_61_p2 == 1'd1) & (tmp_nbreadreq_fu_36_p3 == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            counter_V <= add_ln700_fu_67_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_36_p3 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln887_reg_88 <= icmp_ln887_fu_61_p2;
        tmp_V_8_reg_83 <= counter_V;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_36_p3 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_V_reg_92 <= slc_sessionIdFinFifo_1_dout;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_reg_79 <= tmp_nbreadreq_fu_36_p3;
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
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b0 == ap_block_pp0_stage0) & (tmp_nbreadreq_fu_36_p3 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        slc_sessionIdFinFifo_1_blk_n = slc_sessionIdFinFifo_1_empty_n;
    end else begin
        slc_sessionIdFinFifo_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_36_p3 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        slc_sessionIdFinFifo_1_read = 1'b1;
    end else begin
        slc_sessionIdFinFifo_1_read = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0) & (tmp_reg_79 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op15_write_state2 == 1'b1)))) begin
        slc_sessionIdFreeLis_1_blk_n = slc_sessionIdFreeLis_1_full_n;
    end else begin
        slc_sessionIdFreeLis_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_114)) begin
        if ((tmp_reg_79 == 1'd1)) begin
            slc_sessionIdFreeLis_1_din = tmp_V_reg_92;
        end else if ((ap_predicate_op15_write_state2 == 1'b1)) begin
            slc_sessionIdFreeLis_1_din = tmp_V_8_reg_83;
        end else begin
            slc_sessionIdFreeLis_1_din = 'bx;
        end
    end else begin
        slc_sessionIdFreeLis_1_din = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0_11001) & (tmp_reg_79 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op15_write_state2 == 1'b1)))) begin
        slc_sessionIdFreeLis_1_write = 1'b1;
    end else begin
        slc_sessionIdFreeLis_1_write = 1'b0;
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

assign add_ln700_fu_67_p2 = (counter_V + 14'd1);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((tmp_reg_79 == 1'd1) & (slc_sessionIdFreeLis_1_full_n == 1'b0)) | ((slc_sessionIdFreeLis_1_full_n == 1'b0) & (ap_predicate_op15_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_36_p3 == 1'd1) & (slc_sessionIdFinFifo_1_empty_n == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((tmp_reg_79 == 1'd1) & (slc_sessionIdFreeLis_1_full_n == 1'b0)) | ((slc_sessionIdFreeLis_1_full_n == 1'b0) & (ap_predicate_op15_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_36_p3 == 1'd1) & (slc_sessionIdFinFifo_1_empty_n == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (((tmp_reg_79 == 1'd1) & (slc_sessionIdFreeLis_1_full_n == 1'b0)) | ((slc_sessionIdFreeLis_1_full_n == 1'b0) & (ap_predicate_op15_write_state2 == 1'b1)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_36_p3 == 1'd1) & (slc_sessionIdFinFifo_1_empty_n == 1'b0)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_36_p3 == 1'd1) & (slc_sessionIdFinFifo_1_empty_n == 1'b0)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = (((tmp_reg_79 == 1'd1) & (slc_sessionIdFreeLis_1_full_n == 1'b0)) | ((slc_sessionIdFreeLis_1_full_n == 1'b0) & (ap_predicate_op15_write_state2 == 1'b1)));
end

always @ (*) begin
    ap_condition_114 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_01001));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

always @ (*) begin
    ap_predicate_op15_write_state2 = ((tmp_reg_79 == 1'd0) & (icmp_ln887_reg_88 == 1'd1));
end

assign icmp_ln887_fu_61_p2 = ((counter_V < 14'd1000) ? 1'b1 : 1'b0);

assign tmp_nbreadreq_fu_36_p3 = slc_sessionIdFinFifo_1_empty_n;

endmodule //sessionIdManager
