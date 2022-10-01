// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================

`timescale 1ns/1ps

module hash_table_top_mux_94_1_2_1 #(
parameter
    ID                = 0,
    NUM_STAGE         = 1,
    din0_WIDTH       = 32,
    din1_WIDTH       = 32,
    din2_WIDTH       = 32,
    din3_WIDTH       = 32,
    din4_WIDTH       = 32,
    din5_WIDTH       = 32,
    din6_WIDTH       = 32,
    din7_WIDTH       = 32,
    din8_WIDTH       = 32,
    din9_WIDTH         = 32,
    dout_WIDTH            = 32
)(
    input             clk,
    input             reset,
    input             ce,
    input  [0 : 0]     din0,
    input  [0 : 0]     din1,
    input  [0 : 0]     din2,
    input  [0 : 0]     din3,
    input  [0 : 0]     din4,
    input  [0 : 0]     din5,
    input  [0 : 0]     din6,
    input  [0 : 0]     din7,
    input  [0 : 0]     din8,
    input  [3 : 0]    din9,
    output [0 : 0]   dout);

// puts internal signals
wire [3 : 0]     sel;
// level 1 signals
wire [0 : 0]         mux_1_0;
wire [0 : 0]         mux_1_1;
wire [0 : 0]         mux_1_2;
wire [0 : 0]         mux_1_3;
wire [0 : 0]         mux_1_4;
// level 2 signals
reg  [0 : 0]         mux_2_0_reg;
reg  [0 : 0]         mux_2_1_reg;
reg  [0 : 0]         mux_2_2_reg;
reg  [3 : 2]      sel2;
// level 3 signals
wire [0 : 0]         mux_3_0;
wire [0 : 0]         mux_3_1;
// level 4 signals
wire [0 : 0]         mux_4_0;

assign sel = din9;

// Generate level 1 logic
assign mux_1_0 = (sel[0] == 0)? din0 : din1;
assign mux_1_1 = (sel[0] == 0)? din2 : din3;
assign mux_1_2 = (sel[0] == 0)? din4 : din5;
assign mux_1_3 = (sel[0] == 0)? din6 : din7;
assign mux_1_4 = din8;

// Generate level 2 logic
always @(posedge clk) begin
    if (reset == 1)
        sel2 <= 0;
    else if (ce == 1)
        sel2 <= sel[3 : 2];
end

always @(posedge clk) begin
    if (reset == 1)
        mux_2_0_reg <= 0;
    else if (ce == 1) begin
        if (sel[1] == 0)
            mux_2_0_reg <= mux_1_0;
        else
            mux_2_0_reg <= mux_1_1;
    end
end

always @(posedge clk) begin
    if (reset == 1)
        mux_2_1_reg <= 0;
    else if (ce == 1) begin
        if (sel[1] == 0)
            mux_2_1_reg <= mux_1_2;
        else
            mux_2_1_reg <= mux_1_3;
    end
end

always @(posedge clk) begin
    if (reset == 1)
        mux_2_2_reg <= 0;
    else if (ce == 1) begin
        mux_2_2_reg <= mux_1_4;
    end
end


// Generate level 3 logic
assign mux_3_0 = (sel2[2] == 0)? mux_2_0_reg : mux_2_1_reg;
assign mux_3_1 = mux_2_2_reg;

// Generate level 4 logic
assign mux_4_0 = (sel2[3] == 0)? mux_3_0 : mux_3_1;

// output logic
assign dout = mux_4_0;

endmodule
