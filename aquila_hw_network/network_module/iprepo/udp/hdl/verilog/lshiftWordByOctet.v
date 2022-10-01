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
        tx_shift2udpFifo_V_d_din,
        tx_shift2udpFifo_V_d_full_n,
        tx_shift2udpFifo_V_d_write,
        tx_shift2udpFifo_V_k_din,
        tx_shift2udpFifo_V_k_full_n,
        tx_shift2udpFifo_V_k_write,
        tx_shift2udpFifo_V_l_din,
        tx_shift2udpFifo_V_l_full_n,
        tx_shift2udpFifo_V_l_write,
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
output  [63:0] tx_shift2udpFifo_V_d_din;
input   tx_shift2udpFifo_V_d_full_n;
output   tx_shift2udpFifo_V_d_write;
output  [7:0] tx_shift2udpFifo_V_k_din;
input   tx_shift2udpFifo_V_k_full_n;
output   tx_shift2udpFifo_V_k_write;
output  [0:0] tx_shift2udpFifo_V_l_din;
input   tx_shift2udpFifo_V_l_full_n;
output   tx_shift2udpFifo_V_l_write;
input  [63:0] s_axis_tx_data_TDATA;
output   s_axis_tx_data_TREADY;
input  [7:0] s_axis_tx_data_TKEEP;
input  [0:0] s_axis_tx_data_TLAST;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg tx_shift2udpFifo_V_d_write;
reg tx_shift2udpFifo_V_k_write;
reg tx_shift2udpFifo_V_l_write;
reg s_axis_tx_data_TREADY;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_idle_pp0;
wire   [0:0] tmp_nbreadreq_fu_38_p5;
reg    ap_block_state1_pp0_stage0_iter0;
wire    io_acc_block_signal_op14;
reg   [0:0] tmp_reg_85;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_pp0_stage0_11001;
reg    s_axis_tx_data_TDATA_blk_n;
wire    ap_block_pp0_stage0;
reg    tx_shift2udpFifo_V_d_blk_n;
reg    tx_shift2udpFifo_V_k_blk_n;
reg    tx_shift2udpFifo_V_l_blk_n;
reg   [63:0] tmp_data_V_reg_89;
reg   [7:0] tmp_keep_V_reg_94;
reg   [0:0] tmp_last_V_reg_99;
reg    ap_block_pp0_stage0_subdone;
reg    ap_block_pp0_stage0_01001;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to0;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
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
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_38_p5 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_data_V_reg_89 <= s_axis_tx_data_TDATA;
        tmp_keep_V_reg_94 <= s_axis_tx_data_TKEEP;
        tmp_last_V_reg_99 <= s_axis_tx_data_TLAST;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_reg_85 <= tmp_nbreadreq_fu_38_p5;
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
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b0 == ap_block_pp0_stage0) & (tmp_nbreadreq_fu_38_p5 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        s_axis_tx_data_TDATA_blk_n = s_axis_tx_data_TVALID;
    end else begin
        s_axis_tx_data_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_nbreadreq_fu_38_p5 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        s_axis_tx_data_TREADY = 1'b1;
    end else begin
        s_axis_tx_data_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (tmp_reg_85 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tx_shift2udpFifo_V_d_blk_n = tx_shift2udpFifo_V_d_full_n;
    end else begin
        tx_shift2udpFifo_V_d_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_reg_85 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tx_shift2udpFifo_V_d_write = 1'b1;
    end else begin
        tx_shift2udpFifo_V_d_write = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (tmp_reg_85 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tx_shift2udpFifo_V_k_blk_n = tx_shift2udpFifo_V_k_full_n;
    end else begin
        tx_shift2udpFifo_V_k_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_reg_85 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tx_shift2udpFifo_V_k_write = 1'b1;
    end else begin
        tx_shift2udpFifo_V_k_write = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (tmp_reg_85 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tx_shift2udpFifo_V_l_blk_n = tx_shift2udpFifo_V_l_full_n;
    end else begin
        tx_shift2udpFifo_V_l_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (tmp_reg_85 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tx_shift2udpFifo_V_l_write = 1'b1;
    end else begin
        tx_shift2udpFifo_V_l_write = 1'b0;
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
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((tmp_reg_85 == 1'd1) & (io_acc_block_signal_op14 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_38_p5 == 1'd1) & (s_axis_tx_data_TVALID == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((tmp_reg_85 == 1'd1) & (io_acc_block_signal_op14 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_38_p5 == 1'd1) & (s_axis_tx_data_TVALID == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((tmp_reg_85 == 1'd1) & (io_acc_block_signal_op14 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_38_p5 == 1'd1) & (s_axis_tx_data_TVALID == 1'b0)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_38_p5 == 1'd1) & (s_axis_tx_data_TVALID == 1'b0)));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = ((tmp_reg_85 == 1'd1) & (io_acc_block_signal_op14 == 1'b0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

assign io_acc_block_signal_op14 = (tx_shift2udpFifo_V_l_full_n & tx_shift2udpFifo_V_k_full_n & tx_shift2udpFifo_V_d_full_n);

assign tmp_nbreadreq_fu_38_p5 = s_axis_tx_data_TVALID;

assign tx_shift2udpFifo_V_d_din = tmp_data_V_reg_89;

assign tx_shift2udpFifo_V_k_din = tmp_keep_V_reg_94;

assign tx_shift2udpFifo_V_l_din = tmp_last_V_reg_99;

endmodule //lshiftWordByOctet
