// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2019.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module arp_table (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        hostIpEncode_req_V_V_TVALID,
        macIpEncode_req_V_V_TVALID,
        arpTableInsertFifo_V_dout,
        arpTableInsertFifo_V_empty_n,
        arpTableInsertFifo_V_read,
        hostIpEncode_rsp_V_TREADY,
        macIpEncode_rsp_V_TREADY,
        arpRequestMetaFifo_V_din,
        arpRequestMetaFifo_V_full_n,
        arpRequestMetaFifo_V_write,
        macIpEncode_req_V_V_TDATA,
        macIpEncode_req_V_V_TREADY,
        hostIpEncode_req_V_V_TDATA,
        hostIpEncode_req_V_V_TREADY,
        macIpEncode_rsp_V_TDATA,
        macIpEncode_rsp_V_TVALID,
        hostIpEncode_rsp_V_TDATA,
        hostIpEncode_rsp_V_TVALID
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input   hostIpEncode_req_V_V_TVALID;
input   macIpEncode_req_V_V_TVALID;
input  [80:0] arpTableInsertFifo_V_dout;
input   arpTableInsertFifo_V_empty_n;
output   arpTableInsertFifo_V_read;
input   hostIpEncode_rsp_V_TREADY;
input   macIpEncode_rsp_V_TREADY;
output  [31:0] arpRequestMetaFifo_V_din;
input   arpRequestMetaFifo_V_full_n;
output   arpRequestMetaFifo_V_write;
input  [31:0] macIpEncode_req_V_V_TDATA;
output   macIpEncode_req_V_V_TREADY;
input  [31:0] hostIpEncode_req_V_V_TDATA;
output   hostIpEncode_req_V_V_TREADY;
output  [55:0] macIpEncode_rsp_V_TDATA;
output   macIpEncode_rsp_V_TVALID;
output  [55:0] hostIpEncode_rsp_V_TDATA;
output   hostIpEncode_rsp_V_TVALID;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg arpTableInsertFifo_V_read;
reg[31:0] arpRequestMetaFifo_V_din;
reg arpRequestMetaFifo_V_write;
reg macIpEncode_req_V_V_TREADY;
reg hostIpEncode_req_V_V_TREADY;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire   [0:0] tmp_nbreadreq_fu_86_p3;
wire   [0:0] tmp_4_nbreadreq_fu_94_p3;
wire   [0:0] tmp_5_nbreadreq_fu_102_p3;
reg    ap_predicate_op10_read_state1;
reg    ap_predicate_op17_read_state1;
reg    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    hostIpEncode_rsp_V_1_ack_in;
reg   [0:0] tmp_reg_320;
reg   [0:0] tmp_4_reg_324;
reg   [0:0] tmp_5_reg_328;
reg    ap_predicate_op41_write_state2;
wire    macIpEncode_rsp_V_1_ack_in;
reg    ap_predicate_op47_write_state2;
reg    ap_block_state2_io;
reg   [0:0] tmp_reg_320_pp0_iter1_reg;
reg   [0:0] tmp_4_reg_324_pp0_iter1_reg;
reg   [0:0] tmp_5_reg_328_pp0_iter1_reg;
reg   [0:0] tmp_hit_1_reg_362;
reg    ap_predicate_op56_write_state3;
reg   [0:0] tmp_hit_reg_371;
reg    ap_predicate_op61_write_state3;
wire    macIpEncode_rsp_V_1_ack_out;
reg   [1:0] macIpEncode_rsp_V_1_state;
wire    hostIpEncode_rsp_V_1_ack_out;
reg   [1:0] hostIpEncode_rsp_V_1_state;
reg    ap_block_state3_pp0_stage0_iter2;
reg    ap_predicate_op58_write_state3;
reg    ap_predicate_op63_write_state3;
reg    ap_block_state3_io;
reg    ap_block_pp0_stage0_11001;
reg   [55:0] macIpEncode_rsp_V_1_data_out;
reg    macIpEncode_rsp_V_1_vld_in;
wire    macIpEncode_rsp_V_1_vld_out;
reg   [55:0] macIpEncode_rsp_V_1_payload_A;
reg   [55:0] macIpEncode_rsp_V_1_payload_B;
reg    macIpEncode_rsp_V_1_sel_rd;
reg    macIpEncode_rsp_V_1_sel_wr;
wire    macIpEncode_rsp_V_1_sel;
wire    macIpEncode_rsp_V_1_load_A;
wire    macIpEncode_rsp_V_1_load_B;
wire    macIpEncode_rsp_V_1_state_cmp_full;
reg   [55:0] hostIpEncode_rsp_V_1_data_out;
reg    hostIpEncode_rsp_V_1_vld_in;
wire    hostIpEncode_rsp_V_1_vld_out;
reg   [55:0] hostIpEncode_rsp_V_1_payload_A;
reg   [55:0] hostIpEncode_rsp_V_1_payload_B;
reg    hostIpEncode_rsp_V_1_sel_rd;
reg    hostIpEncode_rsp_V_1_sel_wr;
wire    hostIpEncode_rsp_V_1_sel;
wire    hostIpEncode_rsp_V_1_load_A;
wire    hostIpEncode_rsp_V_1_load_B;
wire    hostIpEncode_rsp_V_1_state_cmp_full;
wire   [7:0] arpTable_ipAddress_V_address0;
reg    arpTable_ipAddress_V_ce0;
reg    arpTable_ipAddress_V_we0;
wire   [31:0] arpTable_ipAddress_V_d0;
reg   [7:0] arpTable_macAddress_s_address0;
reg    arpTable_macAddress_s_ce0;
reg    arpTable_macAddress_s_we0;
wire   [47:0] arpTable_macAddress_s_d0;
wire   [47:0] arpTable_macAddress_s_q0;
reg   [7:0] arpTable_valid_address0;
reg    arpTable_valid_ce0;
reg    arpTable_valid_we0;
wire   [0:0] arpTable_valid_d0;
wire   [0:0] arpTable_valid_q0;
reg    macIpEncode_req_V_V_TDATA_blk_n;
wire    ap_block_pp0_stage0;
reg    hostIpEncode_req_V_V_TDATA_blk_n;
reg    macIpEncode_rsp_V_TDATA_blk_n;
reg    hostIpEncode_rsp_V_TDATA_blk_n;
reg    arpTableInsertFifo_V_blk_n;
reg    arpRequestMetaFifo_V_blk_n;
reg   [31:0] tmp_V_2_reg_332;
reg   [31:0] tmp_V_2_reg_332_pp0_iter1_reg;
reg   [31:0] tmp_V_reg_347;
reg   [31:0] tmp_V_reg_347_pp0_iter1_reg;
wire  signed [55:0] sext_ln163_1_fu_302_p1;
wire  signed [55:0] sext_ln163_fu_315_p1;
reg    ap_block_pp0_stage0_subdone;
wire   [63:0] zext_ln681_2_fu_230_p1;
wire   [63:0] zext_ln681_1_fu_246_p1;
wire   [63:0] zext_ln681_fu_287_p1;
reg    ap_block_pp0_stage0_01001;
wire   [7:0] p_Result_5_i_fu_220_p4;
wire   [7:0] p_Result_4_i_fu_236_p4;
wire   [7:0] p_Result_i_fu_277_p4;
wire   [48:0] tmp_2_fu_294_p3;
wire   [48:0] tmp_1_fu_307_p3;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to1;
reg    ap_reset_idle_pp0;
reg    ap_block_pp0;
reg    ap_enable_operation_33;
reg    ap_enable_state1_pp0_iter0_stage0;
reg    ap_predicate_op14_load_state1;
reg    ap_enable_operation_14;
reg    ap_predicate_op36_load_state2;
reg    ap_enable_operation_36;
reg    ap_enable_state2_pp0_iter1_stage0;
reg    ap_predicate_op21_load_state1;
reg    ap_enable_operation_21;
reg    ap_predicate_op42_load_state2;
reg    ap_enable_operation_42;
reg    ap_enable_operation_35;
reg    ap_predicate_op16_load_state1;
reg    ap_enable_operation_16;
reg    ap_predicate_op37_load_state2;
reg    ap_enable_operation_37;
reg    ap_predicate_op23_load_state1;
reg    ap_enable_operation_23;
reg    ap_predicate_op43_load_state2;
reg    ap_enable_operation_43;
wire    ap_enable_pp0;
reg    ap_condition_47;
reg    ap_condition_309;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 macIpEncode_rsp_V_1_state = 2'd0;
#0 hostIpEncode_rsp_V_1_state = 2'd0;
#0 macIpEncode_rsp_V_1_sel_rd = 1'b0;
#0 macIpEncode_rsp_V_1_sel_wr = 1'b0;
#0 hostIpEncode_rsp_V_1_sel_rd = 1'b0;
#0 hostIpEncode_rsp_V_1_sel_wr = 1'b0;
end

arp_table_arpTable_ipAddress_V #(
    .DataWidth( 32 ),
    .AddressRange( 256 ),
    .AddressWidth( 8 ))
arpTable_ipAddress_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(arpTable_ipAddress_V_address0),
    .ce0(arpTable_ipAddress_V_ce0),
    .we0(arpTable_ipAddress_V_we0),
    .d0(arpTable_ipAddress_V_d0)
);

arp_table_arpTable_macAddress_s #(
    .DataWidth( 48 ),
    .AddressRange( 256 ),
    .AddressWidth( 8 ))
arpTable_macAddress_s_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(arpTable_macAddress_s_address0),
    .ce0(arpTable_macAddress_s_ce0),
    .we0(arpTable_macAddress_s_we0),
    .d0(arpTable_macAddress_s_d0),
    .q0(arpTable_macAddress_s_q0)
);

arp_table_arpTable_valid #(
    .DataWidth( 1 ),
    .AddressRange( 256 ),
    .AddressWidth( 8 ))
arpTable_valid_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(arpTable_valid_address0),
    .ce0(arpTable_valid_ce0),
    .we0(arpTable_valid_we0),
    .d0(arpTable_valid_d0),
    .q0(arpTable_valid_q0)
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
        hostIpEncode_rsp_V_1_sel_rd <= 1'b0;
    end else begin
        if (((hostIpEncode_rsp_V_1_vld_out == 1'b1) & (hostIpEncode_rsp_V_1_ack_out == 1'b1))) begin
            hostIpEncode_rsp_V_1_sel_rd <= ~hostIpEncode_rsp_V_1_sel_rd;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        hostIpEncode_rsp_V_1_sel_wr <= 1'b0;
    end else begin
        if (((hostIpEncode_rsp_V_1_ack_in == 1'b1) & (hostIpEncode_rsp_V_1_vld_in == 1'b1))) begin
            hostIpEncode_rsp_V_1_sel_wr <= ~hostIpEncode_rsp_V_1_sel_wr;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        hostIpEncode_rsp_V_1_state <= 2'd0;
    end else begin
        if ((((hostIpEncode_rsp_V_1_vld_in == 1'b0) & (hostIpEncode_rsp_V_1_ack_out == 1'b1) & (hostIpEncode_rsp_V_1_state == 2'd3)) | ((hostIpEncode_rsp_V_1_vld_in == 1'b0) & (hostIpEncode_rsp_V_1_state == 2'd2)))) begin
            hostIpEncode_rsp_V_1_state <= 2'd2;
        end else if ((((hostIpEncode_rsp_V_TREADY == 1'b0) & (hostIpEncode_rsp_V_1_state == 2'd1)) | ((hostIpEncode_rsp_V_TREADY == 1'b0) & (hostIpEncode_rsp_V_1_vld_in == 1'b1) & (hostIpEncode_rsp_V_1_state == 2'd3)))) begin
            hostIpEncode_rsp_V_1_state <= 2'd1;
        end else if ((((hostIpEncode_rsp_V_1_ack_out == 1'b1) & (hostIpEncode_rsp_V_1_state == 2'd1)) | (~((hostIpEncode_rsp_V_1_vld_in == 1'b0) & (hostIpEncode_rsp_V_1_ack_out == 1'b1)) & ~((hostIpEncode_rsp_V_TREADY == 1'b0) & (hostIpEncode_rsp_V_1_vld_in == 1'b1)) & (hostIpEncode_rsp_V_1_state == 2'd3)) | ((hostIpEncode_rsp_V_1_vld_in == 1'b1) & (hostIpEncode_rsp_V_1_state == 2'd2)))) begin
            hostIpEncode_rsp_V_1_state <= 2'd3;
        end else begin
            hostIpEncode_rsp_V_1_state <= 2'd2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        macIpEncode_rsp_V_1_sel_rd <= 1'b0;
    end else begin
        if (((macIpEncode_rsp_V_1_vld_out == 1'b1) & (macIpEncode_rsp_V_1_ack_out == 1'b1))) begin
            macIpEncode_rsp_V_1_sel_rd <= ~macIpEncode_rsp_V_1_sel_rd;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        macIpEncode_rsp_V_1_sel_wr <= 1'b0;
    end else begin
        if (((macIpEncode_rsp_V_1_ack_in == 1'b1) & (macIpEncode_rsp_V_1_vld_in == 1'b1))) begin
            macIpEncode_rsp_V_1_sel_wr <= ~macIpEncode_rsp_V_1_sel_wr;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        macIpEncode_rsp_V_1_state <= 2'd0;
    end else begin
        if ((((macIpEncode_rsp_V_1_vld_in == 1'b0) & (macIpEncode_rsp_V_1_ack_out == 1'b1) & (macIpEncode_rsp_V_1_state == 2'd3)) | ((macIpEncode_rsp_V_1_vld_in == 1'b0) & (macIpEncode_rsp_V_1_state == 2'd2)))) begin
            macIpEncode_rsp_V_1_state <= 2'd2;
        end else if ((((macIpEncode_rsp_V_TREADY == 1'b0) & (macIpEncode_rsp_V_1_state == 2'd1)) | ((macIpEncode_rsp_V_TREADY == 1'b0) & (macIpEncode_rsp_V_1_vld_in == 1'b1) & (macIpEncode_rsp_V_1_state == 2'd3)))) begin
            macIpEncode_rsp_V_1_state <= 2'd1;
        end else if ((((macIpEncode_rsp_V_1_ack_out == 1'b1) & (macIpEncode_rsp_V_1_state == 2'd1)) | (~((macIpEncode_rsp_V_1_vld_in == 1'b0) & (macIpEncode_rsp_V_1_ack_out == 1'b1)) & ~((macIpEncode_rsp_V_TREADY == 1'b0) & (macIpEncode_rsp_V_1_vld_in == 1'b1)) & (macIpEncode_rsp_V_1_state == 2'd3)) | ((macIpEncode_rsp_V_1_vld_in == 1'b1) & (macIpEncode_rsp_V_1_state == 2'd2)))) begin
            macIpEncode_rsp_V_1_state <= 2'd3;
        end else begin
            macIpEncode_rsp_V_1_state <= 2'd2;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((hostIpEncode_rsp_V_1_load_A == 1'b1)) begin
        hostIpEncode_rsp_V_1_payload_A <= sext_ln163_1_fu_302_p1;
    end
end

always @ (posedge ap_clk) begin
    if ((hostIpEncode_rsp_V_1_load_B == 1'b1)) begin
        hostIpEncode_rsp_V_1_payload_B <= sext_ln163_1_fu_302_p1;
    end
end

always @ (posedge ap_clk) begin
    if ((macIpEncode_rsp_V_1_load_A == 1'b1)) begin
        macIpEncode_rsp_V_1_payload_A <= sext_ln163_fu_315_p1;
    end
end

always @ (posedge ap_clk) begin
    if ((macIpEncode_rsp_V_1_load_B == 1'b1)) begin
        macIpEncode_rsp_V_1_payload_B <= sext_ln163_fu_315_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_nbreadreq_fu_86_p3 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_4_reg_324 <= tmp_4_nbreadreq_fu_94_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_4_reg_324_pp0_iter1_reg <= tmp_4_reg_324;
        tmp_5_reg_328_pp0_iter1_reg <= tmp_5_reg_328;
        tmp_V_2_reg_332_pp0_iter1_reg <= tmp_V_2_reg_332;
        tmp_V_reg_347_pp0_iter1_reg <= tmp_V_reg_347;
        tmp_reg_320 <= tmp_nbreadreq_fu_86_p3;
        tmp_reg_320_pp0_iter1_reg <= tmp_reg_320;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_4_nbreadreq_fu_94_p3 == 1'd0) & (tmp_nbreadreq_fu_86_p3 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_5_reg_328 <= tmp_5_nbreadreq_fu_102_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op10_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_2_reg_332 <= hostIpEncode_req_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op17_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_V_reg_347 <= macIpEncode_req_V_V_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_5_reg_328 == 1'd1) & (tmp_4_reg_324 == 1'd0) & (tmp_reg_320 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_hit_1_reg_362 <= arpTable_valid_q0;
    end
end

always @ (posedge ap_clk) begin
    if (((tmp_4_reg_324 == 1'd1) & (tmp_reg_320 == 1'd0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        tmp_hit_reg_371 <= arpTable_valid_q0;
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
    if ((((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op61_write_state3 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op56_write_state3 == 1'b1)))) begin
        arpRequestMetaFifo_V_blk_n = arpRequestMetaFifo_V_full_n;
    end else begin
        arpRequestMetaFifo_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_01001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        if ((ap_predicate_op61_write_state3 == 1'b1)) begin
            arpRequestMetaFifo_V_din = tmp_V_reg_347_pp0_iter1_reg;
        end else if ((ap_predicate_op56_write_state3 == 1'b1)) begin
            arpRequestMetaFifo_V_din = tmp_V_2_reg_332_pp0_iter1_reg;
        end else begin
            arpRequestMetaFifo_V_din = 'bx;
        end
    end else begin
        arpRequestMetaFifo_V_din = 'bx;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op61_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)) | ((ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op56_write_state3 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        arpRequestMetaFifo_V_write = 1'b1;
    end else begin
        arpRequestMetaFifo_V_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (tmp_nbreadreq_fu_86_p3 == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        arpTableInsertFifo_V_blk_n = arpTableInsertFifo_V_empty_n;
    end else begin
        arpTableInsertFifo_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((tmp_nbreadreq_fu_86_p3 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        arpTableInsertFifo_V_read = 1'b1;
    end else begin
        arpTableInsertFifo_V_read = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        arpTable_ipAddress_V_ce0 = 1'b1;
    end else begin
        arpTable_ipAddress_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((tmp_nbreadreq_fu_86_p3 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        arpTable_ipAddress_V_we0 = 1'b1;
    end else begin
        arpTable_ipAddress_V_we0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_309)) begin
        if ((tmp_nbreadreq_fu_86_p3 == 1'd1)) begin
            arpTable_macAddress_s_address0 = zext_ln681_fu_287_p1;
        end else if (((tmp_4_nbreadreq_fu_94_p3 == 1'd1) & (tmp_nbreadreq_fu_86_p3 == 1'd0))) begin
            arpTable_macAddress_s_address0 = zext_ln681_1_fu_246_p1;
        end else if ((1'b1 == ap_condition_47)) begin
            arpTable_macAddress_s_address0 = zext_ln681_2_fu_230_p1;
        end else begin
            arpTable_macAddress_s_address0 = 'bx;
        end
    end else begin
        arpTable_macAddress_s_address0 = 'bx;
    end
end

always @ (*) begin
    if ((((tmp_nbreadreq_fu_86_p3 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((tmp_4_nbreadreq_fu_94_p3 == 1'd1) & (tmp_nbreadreq_fu_86_p3 == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((tmp_5_nbreadreq_fu_102_p3 == 1'd1) & (tmp_4_nbreadreq_fu_94_p3 == 1'd0) & (tmp_nbreadreq_fu_86_p3 == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        arpTable_macAddress_s_ce0 = 1'b1;
    end else begin
        arpTable_macAddress_s_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((tmp_nbreadreq_fu_86_p3 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        arpTable_macAddress_s_we0 = 1'b1;
    end else begin
        arpTable_macAddress_s_we0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_condition_309)) begin
        if ((tmp_nbreadreq_fu_86_p3 == 1'd1)) begin
            arpTable_valid_address0 = zext_ln681_fu_287_p1;
        end else if (((tmp_4_nbreadreq_fu_94_p3 == 1'd1) & (tmp_nbreadreq_fu_86_p3 == 1'd0))) begin
            arpTable_valid_address0 = zext_ln681_1_fu_246_p1;
        end else if ((1'b1 == ap_condition_47)) begin
            arpTable_valid_address0 = zext_ln681_2_fu_230_p1;
        end else begin
            arpTable_valid_address0 = 'bx;
        end
    end else begin
        arpTable_valid_address0 = 'bx;
    end
end

always @ (*) begin
    if ((((tmp_nbreadreq_fu_86_p3 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((tmp_4_nbreadreq_fu_94_p3 == 1'd1) & (tmp_nbreadreq_fu_86_p3 == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)) | ((tmp_5_nbreadreq_fu_102_p3 == 1'd1) & (tmp_4_nbreadreq_fu_94_p3 == 1'd0) & (tmp_nbreadreq_fu_86_p3 == 1'd0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001)))) begin
        arpTable_valid_ce0 = 1'b1;
    end else begin
        arpTable_valid_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((tmp_nbreadreq_fu_86_p3 == 1'd1) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        arpTable_valid_we0 = 1'b1;
    end else begin
        arpTable_valid_we0 = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op10_read_state1 == 1'b1))) begin
        hostIpEncode_req_V_V_TDATA_blk_n = hostIpEncode_req_V_V_TVALID;
    end else begin
        hostIpEncode_req_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op10_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        hostIpEncode_req_V_V_TREADY = 1'b1;
    end else begin
        hostIpEncode_req_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((hostIpEncode_rsp_V_1_sel == 1'b1)) begin
        hostIpEncode_rsp_V_1_data_out = hostIpEncode_rsp_V_1_payload_B;
    end else begin
        hostIpEncode_rsp_V_1_data_out = hostIpEncode_rsp_V_1_payload_A;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op41_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        hostIpEncode_rsp_V_1_vld_in = 1'b1;
    end else begin
        hostIpEncode_rsp_V_1_vld_in = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op41_write_state2 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op58_write_state3 == 1'b1)))) begin
        hostIpEncode_rsp_V_TDATA_blk_n = hostIpEncode_rsp_V_1_state[1'd1];
    end else begin
        hostIpEncode_rsp_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op17_read_state1 == 1'b1))) begin
        macIpEncode_req_V_V_TDATA_blk_n = macIpEncode_req_V_V_TVALID;
    end else begin
        macIpEncode_req_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op17_read_state1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        macIpEncode_req_V_V_TREADY = 1'b1;
    end else begin
        macIpEncode_req_V_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((macIpEncode_rsp_V_1_sel == 1'b1)) begin
        macIpEncode_rsp_V_1_data_out = macIpEncode_rsp_V_1_payload_B;
    end else begin
        macIpEncode_rsp_V_1_data_out = macIpEncode_rsp_V_1_payload_A;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op47_write_state2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        macIpEncode_rsp_V_1_vld_in = 1'b1;
    end else begin
        macIpEncode_rsp_V_1_vld_in = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_predicate_op47_write_state2 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (ap_predicate_op63_write_state3 == 1'b1)))) begin
        macIpEncode_rsp_V_TDATA_blk_n = macIpEncode_rsp_V_1_state[1'd1];
    end else begin
        macIpEncode_rsp_V_TDATA_blk_n = 1'b1;
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
    ap_block_pp0_stage0_01001 = ((ap_done_reg == 1'b1) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_86_p3 == 1'd1) & (arpTableInsertFifo_V_empty_n == 1'b0)) | ((macIpEncode_req_V_V_TVALID == 1'b0) & (ap_predicate_op17_read_state1 == 1'b1)) | ((hostIpEncode_req_V_V_TVALID == 1'b0) & (ap_predicate_op10_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((hostIpEncode_rsp_V_1_state == 2'd1) | (macIpEncode_rsp_V_1_state == 2'd1) | ((hostIpEncode_rsp_V_TREADY == 1'b0) & (hostIpEncode_rsp_V_1_state == 2'd3)) | ((macIpEncode_rsp_V_TREADY == 1'b0) & (macIpEncode_rsp_V_1_state == 2'd3)) | ((arpRequestMetaFifo_V_full_n == 1'b0) & (ap_predicate_op61_write_state3 == 1'b1)) | ((arpRequestMetaFifo_V_full_n == 1'b0) & (ap_predicate_op56_write_state3 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state2_io)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_86_p3 == 1'd1) & (arpTableInsertFifo_V_empty_n == 1'b0)) | ((macIpEncode_req_V_V_TVALID == 1'b0) & (ap_predicate_op17_read_state1 == 1'b1)) | ((hostIpEncode_req_V_V_TVALID == 1'b0) & (ap_predicate_op10_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((1'b1 == ap_block_state3_io) | (hostIpEncode_rsp_V_1_state == 2'd1) | (macIpEncode_rsp_V_1_state == 2'd1) | ((hostIpEncode_rsp_V_TREADY == 1'b0) & (hostIpEncode_rsp_V_1_state == 2'd3)) | ((macIpEncode_rsp_V_TREADY == 1'b0) & (macIpEncode_rsp_V_1_state == 2'd3)) | ((arpRequestMetaFifo_V_full_n == 1'b0) & (ap_predicate_op61_write_state3 == 1'b1)) | ((arpRequestMetaFifo_V_full_n == 1'b0) & (ap_predicate_op56_write_state3 == 1'b1)))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state2_io)) | ((ap_start == 1'b1) & ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_86_p3 == 1'd1) & (arpTableInsertFifo_V_empty_n == 1'b0)) | ((macIpEncode_req_V_V_TVALID == 1'b0) & (ap_predicate_op17_read_state1 == 1'b1)) | ((hostIpEncode_req_V_V_TVALID == 1'b0) & (ap_predicate_op10_read_state1 == 1'b1)))) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((1'b1 == ap_block_state3_io) | (hostIpEncode_rsp_V_1_state == 2'd1) | (macIpEncode_rsp_V_1_state == 2'd1) | ((hostIpEncode_rsp_V_TREADY == 1'b0) & (hostIpEncode_rsp_V_1_state == 2'd3)) | ((macIpEncode_rsp_V_TREADY == 1'b0) & (macIpEncode_rsp_V_1_state == 2'd3)) | ((arpRequestMetaFifo_V_full_n == 1'b0) & (ap_predicate_op61_write_state3 == 1'b1)) | ((arpRequestMetaFifo_V_full_n == 1'b0) & (ap_predicate_op56_write_state3 == 1'b1)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1) | ((tmp_nbreadreq_fu_86_p3 == 1'd1) & (arpTableInsertFifo_V_empty_n == 1'b0)) | ((macIpEncode_req_V_V_TVALID == 1'b0) & (ap_predicate_op17_read_state1 == 1'b1)) | ((hostIpEncode_req_V_V_TVALID == 1'b0) & (ap_predicate_op10_read_state1 == 1'b1)));
end

always @ (*) begin
    ap_block_state2_io = (((macIpEncode_rsp_V_1_ack_in == 1'b0) & (ap_predicate_op47_write_state2 == 1'b1)) | ((hostIpEncode_rsp_V_1_ack_in == 1'b0) & (ap_predicate_op41_write_state2 == 1'b1)));
end

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state3_io = (((macIpEncode_rsp_V_1_ack_in == 1'b0) & (ap_predicate_op63_write_state3 == 1'b1)) | ((hostIpEncode_rsp_V_1_ack_in == 1'b0) & (ap_predicate_op58_write_state3 == 1'b1)));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter2 = ((hostIpEncode_rsp_V_1_state == 2'd1) | (macIpEncode_rsp_V_1_state == 2'd1) | ((hostIpEncode_rsp_V_TREADY == 1'b0) & (hostIpEncode_rsp_V_1_state == 2'd3)) | ((macIpEncode_rsp_V_TREADY == 1'b0) & (macIpEncode_rsp_V_1_state == 2'd3)) | ((arpRequestMetaFifo_V_full_n == 1'b0) & (ap_predicate_op61_write_state3 == 1'b1)) | ((arpRequestMetaFifo_V_full_n == 1'b0) & (ap_predicate_op56_write_state3 == 1'b1)));
end

always @ (*) begin
    ap_condition_309 = ((1'b0 == ap_block_pp0_stage0) & (ap_start == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0));
end

always @ (*) begin
    ap_condition_47 = ((tmp_5_nbreadreq_fu_102_p3 == 1'd1) & (tmp_4_nbreadreq_fu_94_p3 == 1'd0) & (tmp_nbreadreq_fu_86_p3 == 1'd0));
end

always @ (*) begin
    ap_enable_operation_14 = (ap_predicate_op14_load_state1 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_16 = (ap_predicate_op16_load_state1 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_21 = (ap_predicate_op21_load_state1 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_23 = (ap_predicate_op23_load_state1 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_33 = (tmp_nbreadreq_fu_86_p3 == 1'd1);
end

always @ (*) begin
    ap_enable_operation_35 = (tmp_nbreadreq_fu_86_p3 == 1'd1);
end

always @ (*) begin
    ap_enable_operation_36 = (ap_predicate_op36_load_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_37 = (ap_predicate_op37_load_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_42 = (ap_predicate_op42_load_state2 == 1'b1);
end

always @ (*) begin
    ap_enable_operation_43 = (ap_predicate_op43_load_state2 == 1'b1);
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
    ap_predicate_op10_read_state1 = ((tmp_5_nbreadreq_fu_102_p3 == 1'd1) & (tmp_4_nbreadreq_fu_94_p3 == 1'd0) & (tmp_nbreadreq_fu_86_p3 == 1'd0));
end

always @ (*) begin
    ap_predicate_op14_load_state1 = ((tmp_5_nbreadreq_fu_102_p3 == 1'd1) & (tmp_4_nbreadreq_fu_94_p3 == 1'd0) & (tmp_nbreadreq_fu_86_p3 == 1'd0));
end

always @ (*) begin
    ap_predicate_op16_load_state1 = ((tmp_5_nbreadreq_fu_102_p3 == 1'd1) & (tmp_4_nbreadreq_fu_94_p3 == 1'd0) & (tmp_nbreadreq_fu_86_p3 == 1'd0));
end

always @ (*) begin
    ap_predicate_op17_read_state1 = ((tmp_4_nbreadreq_fu_94_p3 == 1'd1) & (tmp_nbreadreq_fu_86_p3 == 1'd0));
end

always @ (*) begin
    ap_predicate_op21_load_state1 = ((tmp_4_nbreadreq_fu_94_p3 == 1'd1) & (tmp_nbreadreq_fu_86_p3 == 1'd0));
end

always @ (*) begin
    ap_predicate_op23_load_state1 = ((tmp_4_nbreadreq_fu_94_p3 == 1'd1) & (tmp_nbreadreq_fu_86_p3 == 1'd0));
end

always @ (*) begin
    ap_predicate_op36_load_state2 = ((tmp_5_reg_328 == 1'd1) & (tmp_4_reg_324 == 1'd0) & (tmp_reg_320 == 1'd0));
end

always @ (*) begin
    ap_predicate_op37_load_state2 = ((tmp_5_reg_328 == 1'd1) & (tmp_4_reg_324 == 1'd0) & (tmp_reg_320 == 1'd0));
end

always @ (*) begin
    ap_predicate_op41_write_state2 = ((tmp_5_reg_328 == 1'd1) & (tmp_4_reg_324 == 1'd0) & (tmp_reg_320 == 1'd0));
end

always @ (*) begin
    ap_predicate_op42_load_state2 = ((tmp_4_reg_324 == 1'd1) & (tmp_reg_320 == 1'd0));
end

always @ (*) begin
    ap_predicate_op43_load_state2 = ((tmp_4_reg_324 == 1'd1) & (tmp_reg_320 == 1'd0));
end

always @ (*) begin
    ap_predicate_op47_write_state2 = ((tmp_4_reg_324 == 1'd1) & (tmp_reg_320 == 1'd0));
end

always @ (*) begin
    ap_predicate_op56_write_state3 = ((tmp_5_reg_328_pp0_iter1_reg == 1'd1) & (tmp_hit_1_reg_362 == 1'd0) & (tmp_4_reg_324_pp0_iter1_reg == 1'd0) & (tmp_reg_320_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op58_write_state3 = ((tmp_5_reg_328_pp0_iter1_reg == 1'd1) & (tmp_4_reg_324_pp0_iter1_reg == 1'd0) & (tmp_reg_320_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op61_write_state3 = ((tmp_4_reg_324_pp0_iter1_reg == 1'd1) & (tmp_hit_reg_371 == 1'd0) & (tmp_reg_320_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op63_write_state3 = ((tmp_4_reg_324_pp0_iter1_reg == 1'd1) & (tmp_reg_320_pp0_iter1_reg == 1'd0));
end

assign arpTable_ipAddress_V_address0 = zext_ln681_fu_287_p1;

assign arpTable_ipAddress_V_d0 = arpTableInsertFifo_V_dout[31:0];

assign arpTable_macAddress_s_d0 = {{arpTableInsertFifo_V_dout[79:32]}};

assign arpTable_valid_d0 = arpTableInsertFifo_V_dout[32'd80];

assign hostIpEncode_rsp_V_1_ack_in = hostIpEncode_rsp_V_1_state[1'd1];

assign hostIpEncode_rsp_V_1_ack_out = hostIpEncode_rsp_V_TREADY;

assign hostIpEncode_rsp_V_1_load_A = (hostIpEncode_rsp_V_1_state_cmp_full & ~hostIpEncode_rsp_V_1_sel_wr);

assign hostIpEncode_rsp_V_1_load_B = (hostIpEncode_rsp_V_1_state_cmp_full & hostIpEncode_rsp_V_1_sel_wr);

assign hostIpEncode_rsp_V_1_sel = hostIpEncode_rsp_V_1_sel_rd;

assign hostIpEncode_rsp_V_1_state_cmp_full = ((hostIpEncode_rsp_V_1_state != 2'd1) ? 1'b1 : 1'b0);

assign hostIpEncode_rsp_V_1_vld_out = hostIpEncode_rsp_V_1_state[1'd0];

assign hostIpEncode_rsp_V_TDATA = hostIpEncode_rsp_V_1_data_out;

assign hostIpEncode_rsp_V_TVALID = hostIpEncode_rsp_V_1_state[1'd0];

assign macIpEncode_rsp_V_1_ack_in = macIpEncode_rsp_V_1_state[1'd1];

assign macIpEncode_rsp_V_1_ack_out = macIpEncode_rsp_V_TREADY;

assign macIpEncode_rsp_V_1_load_A = (macIpEncode_rsp_V_1_state_cmp_full & ~macIpEncode_rsp_V_1_sel_wr);

assign macIpEncode_rsp_V_1_load_B = (macIpEncode_rsp_V_1_state_cmp_full & macIpEncode_rsp_V_1_sel_wr);

assign macIpEncode_rsp_V_1_sel = macIpEncode_rsp_V_1_sel_rd;

assign macIpEncode_rsp_V_1_state_cmp_full = ((macIpEncode_rsp_V_1_state != 2'd1) ? 1'b1 : 1'b0);

assign macIpEncode_rsp_V_1_vld_out = macIpEncode_rsp_V_1_state[1'd0];

assign macIpEncode_rsp_V_TDATA = macIpEncode_rsp_V_1_data_out;

assign macIpEncode_rsp_V_TVALID = macIpEncode_rsp_V_1_state[1'd0];

assign p_Result_4_i_fu_236_p4 = {{macIpEncode_req_V_V_TDATA[31:24]}};

assign p_Result_5_i_fu_220_p4 = {{hostIpEncode_req_V_V_TDATA[31:24]}};

assign p_Result_i_fu_277_p4 = {{arpTableInsertFifo_V_dout[31:24]}};

assign sext_ln163_1_fu_302_p1 = $signed(tmp_2_fu_294_p3);

assign sext_ln163_fu_315_p1 = $signed(tmp_1_fu_307_p3);

assign tmp_1_fu_307_p3 = {{arpTable_valid_q0}, {arpTable_macAddress_s_q0}};

assign tmp_2_fu_294_p3 = {{arpTable_valid_q0}, {arpTable_macAddress_s_q0}};

assign tmp_4_nbreadreq_fu_94_p3 = macIpEncode_req_V_V_TVALID;

assign tmp_5_nbreadreq_fu_102_p3 = hostIpEncode_req_V_V_TVALID;

assign tmp_nbreadreq_fu_86_p3 = arpTableInsertFifo_V_empty_n;

assign zext_ln681_1_fu_246_p1 = p_Result_4_i_fu_236_p4;

assign zext_ln681_2_fu_230_p1 = p_Result_5_i_fu_220_p4;

assign zext_ln681_fu_287_p1 = p_Result_i_fu_277_p4;

endmodule //arp_table
