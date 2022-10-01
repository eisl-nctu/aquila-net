// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2019.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module merge_rx_meta (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        ipMetaIn_V_TVALID,
        rx_udpMetaFifo_V_dout,
        rx_udpMetaFifo_V_empty_n,
        rx_udpMetaFifo_V_read,
        metaOut_V_TREADY,
        ipMetaIn_V_TDATA,
        ipMetaIn_V_TREADY,
        metaOut_V_TDATA,
        metaOut_V_TVALID
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input   ipMetaIn_V_TVALID;
input  [48:0] rx_udpMetaFifo_V_dout;
input   rx_udpMetaFifo_V_empty_n;
output   rx_udpMetaFifo_V_read;
input   metaOut_V_TREADY;
input  [47:0] ipMetaIn_V_TDATA;
output   ipMetaIn_V_TREADY;
output  [175:0] metaOut_V_TDATA;
output   metaOut_V_TVALID;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg rx_udpMetaFifo_V_read;
reg ipMetaIn_V_TREADY;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire   [0:0] tmp_nbreadreq_fu_42_p3;
wire   [0:0] tmp_8_nbreadreq_fu_50_p3;
reg    ap_predicate_op8_read_state1;
reg    ap_predicate_op10_read_state1;
reg    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    metaOut_V_1_ack_in;
reg   [0:0] tmp_reg_104;
reg   [0:0] tmp_8_reg_108;
reg   [0:0] tmp_9_reg_117;
reg    ap_predicate_op16_write_state2;
reg    ap_block_state2_io;
wire    metaOut_V_1_ack_out;
reg   [1:0] metaOut_V_1_state;
reg    ap_block_state3_pp0_stage0_iter2;
reg   [0:0] tmp_reg_104_pp0_iter1_reg;
reg   [0:0] tmp_8_reg_108_pp0_iter1_reg;
reg   [0:0] tmp_9_reg_117_pp0_iter1_reg;
reg    ap_predicate_op21_write_state3;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
reg   [175:0] metaOut_V_1_data_out;
reg    metaOut_V_1_vld_in;
wire    metaOut_V_1_vld_out;
reg   [175:0] metaOut_V_1_payload_A;
reg   [175:0] metaOut_V_1_payload_B;
reg    metaOut_V_1_sel_rd;
reg    metaOut_V_1_sel_wr;
wire    metaOut_V_1_sel;
wire    metaOut_V_1_load_A;
wire    metaOut_V_1_load_B;
wire    metaOut_V_1_state_cmp_full;
reg    ipMetaIn_V_TDATA_blk_n;
wire    ap_block_pp0_stage0;
reg    metaOut_V_TDATA_blk_n;
reg    rx_udpMetaFifo_V_blk_n;
wire   [31:0] trunc_ln321_fu_77_p1;
reg   [31:0] trunc_ln321_reg_112;
wire   [0:0] tmp_9_fu_81_p3;
wire   [47:0] trunc_ln162_fu_89_p1;
reg   [47:0] trunc_ln162_reg_121;
wire   [175:0] tmp_2_fu_96_p3;
reg    ap_block_pp0_stage0_subdone;
reg    ap_block_pp0_stage0_01001;
wire   [127:0] tmp_their_address_V_fu_93_p1;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to1;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 metaOut_V_1_state = 2'd0;
#0 metaOut_V_1_sel_rd = 1'b0;
#0 metaOut_V_1_sel_wr = 1'b0;
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
        end else if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
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
        metaOut_V_1_sel_rd <= 1'b0;
    end else begin
        if (((metaOut_V_1_ack_out == 1'b1) & (metaOut_V_1_vld_out == 1'b1))) begin
            metaOut_V_1_sel_rd <= ~metaOut_V_1_sel_rd;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        metaOut_V_1_sel_wr <= 1'b0;
    end else begin
        if (((metaOut_V_1_ack_in == 1'b1) & (metaOut_V_1_vld_in == 1'b1))) begin
            metaOut_V_1_sel_wr <= ~metaOut_V_1_sel_wr;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        metaOut_V_1_state <= 2'd0;
    end else begin
        if ((((metaOut_V_1_state == 2'd3) & (metaOut_V_1_vld_in == 1'b0) & (metaOut_V_1_ack_out == 1'b1)) | ((metaOut_V_1_state == 2'd2) & (metaOut_V_1_vld_in == 1'b0)))) begin
            metaOut_V_1_state <= 2'd2;
        end else if ((((metaOut_V_1_state == 2'd1) & (metaOut_V_TREADY == 1'b0)) | ((metaOut_V_1_state == 2'd3) & (metaOut_V_TREADY == 1'b0) & (metaOut_V_1_vld_in == 1'b1)))) begin
            metaOut_V_1_state <= 2'd1;
        end else if ((((metaOut_V_1_state == 2'd1) & (metaOut_V_1_ack_out == 1'b1)) | (~((metaOut_V_1_vld_in == 1'b0) & (metaOut_V_1_ack_out == 1'b1)) & ~((metaOut_V_TREADY == 1'b0) & (metaOut_V_1_vld_in == 1'b1)) & (metaOut_V_1_state == 2'd3)) | ((metaOut_V_1_state == 2'd2) & (metaOut_V_1_vld_in == 1'b1)))) begin
            metaOut_V_1_state <= 2'd3;
        end else begin
            metaOut_V_1_state <= 2'd2;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((metaOut_V_1_load_A == 1'b1)) begin
        metaOut_V_1_payload_A <= tmp_2_fu_96_p3;
    end
end

always @ (posedge ap_clk) begin
    if ((metaOut_V_1_load_B == 1'b1)) begin
        metaOut_V_1_payload_B <= tmp_2_fu_96_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_nbreadreq_fu_42_p3 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_8_reg_108 <= tmp_8_nbreadreq_fu_50_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_8_reg_108_pp0_iter1_reg <= tmp_8_reg_108;
        tmp_9_reg_117_pp0_iter1_reg <= tmp_9_reg_117;
        tmp_reg_104 <= tmp_nbreadreq_fu_42_p3;
        tmp_reg_104_pp0_iter1_reg <= tmp_reg_104;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_8_nbreadreq_fu_50_p3 == 1'd1) & (tmp_nbreadreq_fu_42_p3 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_9_reg_117 <= rx_udpMetaFifo_V_dout[32'd48];
        trunc_ln321_reg_112 <= trunc_ln321_fu_77_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_8_nbreadreq_fu_50_p3 == 1'd1) & (tmp_9_fu_81_p3 == 1'd1) & (tmp_nbreadreq_fu_42_p3 == 1'd1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        trunc_ln162_reg_121 <= trunc_ln162_fu_89_p1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
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
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
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
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op8_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        ipMetaIn_V_TDATA_blk_n = ipMetaIn_V_TVALID;
    end else begin
        ipMetaIn_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op8_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        ipMetaIn_V_TREADY = 1'b1;
    end else begin
        ipMetaIn_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((metaOut_V_1_sel == 1'b1)) begin
        metaOut_V_1_data_out = metaOut_V_1_payload_B;
    end else begin
        metaOut_V_1_data_out = metaOut_V_1_payload_A;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op16_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        metaOut_V_1_vld_in = 1'b1;
    end else begin
        metaOut_V_1_vld_in = 1'b0;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op16_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0)) | ((ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op21_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0)))) begin
        metaOut_V_TDATA_blk_n = metaOut_V_1_state[1'd1];
    end else begin
        metaOut_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op10_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        rx_udpMetaFifo_V_blk_n = rx_udpMetaFifo_V_empty_n;
    end else begin
        rx_udpMetaFifo_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op10_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        rx_udpMetaFifo_V_read = 1'b1;
    end else begin
        rx_udpMetaFifo_V_read = 1'b0;
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
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((metaOut_V_1_state == 2'd1) | ((metaOut_V_1_state == 2'd3) & (metaOut_V_TREADY == 1'b0)))) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((rx_udpMetaFifo_V_empty_n == 1'b0) & (ap_predicate_op10_read_state1 == 1'b1)) | ((ipMetaIn_V_TVALID == 1'b0) & (ap_predicate_op8_read_state1 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state2_io)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((rx_udpMetaFifo_V_empty_n == 1'b0) & (ap_predicate_op10_read_state1 == 1'b1)) | ((ipMetaIn_V_TVALID == 1'b0) & (ap_predicate_op8_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((metaOut_V_1_state == 2'd1) | (1'b1 == ap_block_state3_io) | ((metaOut_V_1_state == 2'd3) & (metaOut_V_TREADY == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state2_io)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((rx_udpMetaFifo_V_empty_n == 1'b0) & (ap_predicate_op10_read_state1 == 1'b1)) | ((ipMetaIn_V_TVALID == 1'b0) & (ap_predicate_op8_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((metaOut_V_1_state == 2'd1) | (1'b1 == ap_block_state3_io) | ((metaOut_V_1_state == 2'd3) & (metaOut_V_TREADY == 1'b0)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((rx_udpMetaFifo_V_empty_n == 1'b0) & (ap_predicate_op10_read_state1 == 1'b1)) | ((ipMetaIn_V_TVALID == 1'b0) & (ap_predicate_op8_read_state1 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_io = ((metaOut_V_1_ack_in == 1'b0) & (ap_predicate_op16_write_state2 == 1'b1));
end

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state3_io = ((metaOut_V_1_ack_in == 1'b0) & (ap_predicate_op21_write_state3 == 1'b1));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = ((metaOut_V_1_state == 2'd1) | ((metaOut_V_1_state == 2'd3) & (metaOut_V_TREADY == 1'b0)));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

always @ (*) begin
    ap_predicate_op10_read_state1 = ((tmp_8_nbreadreq_fu_50_p3 == 1'd1) & (tmp_nbreadreq_fu_42_p3 == 1'd1));
end

always @ (*) begin
    ap_predicate_op16_write_state2 = ((tmp_9_reg_117 == 1'd1) & (tmp_8_reg_108 == 1'd1) & (tmp_reg_104 == 1'd1));
end

always @ (*) begin
    ap_predicate_op21_write_state3 = ((tmp_8_reg_108_pp0_iter1_reg == 1'd1) & (tmp_reg_104_pp0_iter1_reg == 1'd1) & (tmp_9_reg_117_pp0_iter1_reg == 1'd1));
end

always @ (*) begin
    ap_predicate_op8_read_state1 = ((tmp_8_nbreadreq_fu_50_p3 == 1'd1) & (tmp_nbreadreq_fu_42_p3 == 1'd1));
end

assign metaOut_V_1_ack_in = metaOut_V_1_state[1'd1];

assign metaOut_V_1_ack_out = metaOut_V_TREADY;

assign metaOut_V_1_load_A = (metaOut_V_1_state_cmp_full & ~metaOut_V_1_sel_wr);

assign metaOut_V_1_load_B = (metaOut_V_1_state_cmp_full & metaOut_V_1_sel_wr);

assign metaOut_V_1_sel = metaOut_V_1_sel_rd;

assign metaOut_V_1_state_cmp_full = ((metaOut_V_1_state != 2'd1) ? 1'b1 : 1'b0);

assign metaOut_V_1_vld_out = metaOut_V_1_state[1'd0];

assign metaOut_V_TDATA = metaOut_V_1_data_out;

assign metaOut_V_TVALID = metaOut_V_1_state[1'd0];

assign tmp_2_fu_96_p3 = {{trunc_ln162_reg_121}, {tmp_their_address_V_fu_93_p1}};

assign tmp_8_nbreadreq_fu_50_p3 = rx_udpMetaFifo_V_empty_n;

assign tmp_9_fu_81_p3 = rx_udpMetaFifo_V_dout[32'd48];

assign tmp_nbreadreq_fu_42_p3 = ipMetaIn_V_TVALID;

assign tmp_their_address_V_fu_93_p1 = trunc_ln321_reg_112;

assign trunc_ln162_fu_89_p1 = rx_udpMetaFifo_V_dout[47:0];

assign trunc_ln321_fu_77_p1 = ipMetaIn_V_TDATA[31:0];

endmodule //merge_rx_meta
