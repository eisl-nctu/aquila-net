// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2019.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="udp_top,hls_ip_2019_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xc7k325t-ffg900-2,HLS_INPUT_CLOCK=6.400000,HLS_INPUT_ARCH=dataflow,HLS_SYN_CLOCK=6.897500,HLS_SYN_LAT=4,HLS_SYN_TPT=1,HLS_SYN_MEM=4,HLS_SYN_DSP=0,HLS_SYN_FF=1790,HLS_SYN_LUT=5033,HLS_VERSION=2019_1}" *)

module udp_top (
        s_axis_rx_meta_V_TDATA,
        s_axis_rx_data_TDATA,
        s_axis_rx_data_TKEEP,
        s_axis_rx_data_TLAST,
        m_axis_rx_meta_V_TDATA,
        m_axis_rx_data_TDATA,
        m_axis_rx_data_TKEEP,
        m_axis_rx_data_TLAST,
        s_axis_tx_meta_V_TDATA,
        s_axis_tx_data_TDATA,
        s_axis_tx_data_TKEEP,
        s_axis_tx_data_TLAST,
        m_axis_tx_meta_V_TDATA,
        m_axis_tx_data_TDATA,
        m_axis_tx_data_TKEEP,
        m_axis_tx_data_TLAST,
        s_axis_port_cmd_V_TDATA,
        reg_ip_address_V,
        ap_clk,
        ap_rst_n,
        s_axis_rx_data_TVALID,
        s_axis_rx_data_TREADY,
        m_axis_rx_data_TVALID,
        m_axis_rx_data_TREADY,
        s_axis_rx_meta_V_TVALID,
        s_axis_rx_meta_V_TREADY,
        m_axis_rx_meta_V_TVALID,
        m_axis_rx_meta_V_TREADY,
        s_axis_tx_meta_V_TVALID,
        s_axis_tx_meta_V_TREADY,
        m_axis_tx_meta_V_TVALID,
        m_axis_tx_meta_V_TREADY,
        s_axis_tx_data_TVALID,
        s_axis_tx_data_TREADY,
        m_axis_tx_data_TVALID,
        m_axis_tx_data_TREADY,
        s_axis_port_cmd_V_TVALID,
        s_axis_port_cmd_V_TREADY
);


input  [47:0] s_axis_rx_meta_V_TDATA;
input  [63:0] s_axis_rx_data_TDATA;
input  [7:0] s_axis_rx_data_TKEEP;
input  [0:0] s_axis_rx_data_TLAST;
output  [175:0] m_axis_rx_meta_V_TDATA;
output  [63:0] m_axis_rx_data_TDATA;
output  [7:0] m_axis_rx_data_TKEEP;
output  [0:0] m_axis_rx_data_TLAST;
input  [175:0] s_axis_tx_meta_V_TDATA;
input  [63:0] s_axis_tx_data_TDATA;
input  [7:0] s_axis_tx_data_TKEEP;
input  [0:0] s_axis_tx_data_TLAST;
output  [47:0] m_axis_tx_meta_V_TDATA;
output  [63:0] m_axis_tx_data_TDATA;
output  [7:0] m_axis_tx_data_TKEEP;
output  [0:0] m_axis_tx_data_TLAST;
input  [31:0] s_axis_port_cmd_V_TDATA;
input  [127:0] reg_ip_address_V;
input   ap_clk;
input   ap_rst_n;
input   s_axis_rx_data_TVALID;
output   s_axis_rx_data_TREADY;
output   m_axis_rx_data_TVALID;
input   m_axis_rx_data_TREADY;
input   s_axis_rx_meta_V_TVALID;
output   s_axis_rx_meta_V_TREADY;
output   m_axis_rx_meta_V_TVALID;
input   m_axis_rx_meta_V_TREADY;
input   s_axis_tx_meta_V_TVALID;
output   s_axis_tx_meta_V_TREADY;
output   m_axis_tx_meta_V_TVALID;
input   m_axis_tx_meta_V_TREADY;
input   s_axis_tx_data_TVALID;
output   s_axis_tx_data_TREADY;
output   m_axis_tx_data_TVALID;
input   m_axis_tx_data_TREADY;
input   s_axis_port_cmd_V_TVALID;
output   s_axis_port_cmd_V_TREADY;

 reg    ap_rst_n_inv;
wire    process_udp_64_U0_ap_start;
wire    process_udp_64_U0_ap_done;
wire    process_udp_64_U0_ap_continue;
wire    process_udp_64_U0_ap_idle;
wire    process_udp_64_U0_ap_ready;
wire    process_udp_64_U0_portStatusFifo_V_read;
wire   [63:0] process_udp_64_U0_rx_udp2shiftFifo_V_d_din;
wire    process_udp_64_U0_rx_udp2shiftFifo_V_d_write;
wire   [7:0] process_udp_64_U0_rx_udp2shiftFifo_V_k_din;
wire    process_udp_64_U0_rx_udp2shiftFifo_V_k_write;
wire   [0:0] process_udp_64_U0_rx_udp2shiftFifo_V_l_din;
wire    process_udp_64_U0_rx_udp2shiftFifo_V_l_write;
wire   [15:0] process_udp_64_U0_portLookupReqFifo_V_s_din;
wire    process_udp_64_U0_portLookupReqFifo_V_s_write;
wire   [48:0] process_udp_64_U0_rx_udpMetaFifo_V_din;
wire    process_udp_64_U0_rx_udpMetaFifo_V_write;
wire    process_udp_64_U0_s_axis_rx_data_TREADY;
wire    rshiftWordByOctet_U0_ap_start;
wire    rshiftWordByOctet_U0_ap_done;
wire    rshiftWordByOctet_U0_ap_continue;
wire    rshiftWordByOctet_U0_ap_idle;
wire    rshiftWordByOctet_U0_ap_ready;
wire    rshiftWordByOctet_U0_rx_udp2shiftFifo_V_d_read;
wire    rshiftWordByOctet_U0_rx_udp2shiftFifo_V_k_read;
wire    rshiftWordByOctet_U0_rx_udp2shiftFifo_V_l_read;
wire   [63:0] rshiftWordByOctet_U0_m_axis_rx_data_TDATA;
wire    rshiftWordByOctet_U0_m_axis_rx_data_TVALID;
wire   [7:0] rshiftWordByOctet_U0_m_axis_rx_data_TKEEP;
wire   [0:0] rshiftWordByOctet_U0_m_axis_rx_data_TLAST;
wire    ap_sync_continue;
wire    merge_rx_meta_U0_ap_start;
wire    merge_rx_meta_U0_ap_done;
wire    merge_rx_meta_U0_ap_continue;
wire    merge_rx_meta_U0_ap_idle;
wire    merge_rx_meta_U0_ap_ready;
wire    merge_rx_meta_U0_rx_udpMetaFifo_V_read;
wire    merge_rx_meta_U0_ipMetaIn_V_TREADY;
wire   [175:0] merge_rx_meta_U0_metaOut_V_TDATA;
wire    merge_rx_meta_U0_metaOut_V_TVALID;
wire    split_tx_meta_U0_ap_start;
wire    split_tx_meta_U0_ap_done;
wire    split_tx_meta_U0_ap_continue;
wire    split_tx_meta_U0_ap_idle;
wire    split_tx_meta_U0_ap_ready;
wire   [15:0] split_tx_meta_U0_tx_udpMetaFifo_V_the_din;
wire    split_tx_meta_U0_tx_udpMetaFifo_V_the_write;
wire   [15:0] split_tx_meta_U0_tx_udpMetaFifo_V_my_s_din;
wire    split_tx_meta_U0_tx_udpMetaFifo_V_my_s_write;
wire   [15:0] split_tx_meta_U0_tx_udpMetaFifo_V_len_din;
wire    split_tx_meta_U0_tx_udpMetaFifo_V_len_write;
wire   [0:0] split_tx_meta_U0_tx_udpMetaFifo_V_val_din;
wire    split_tx_meta_U0_tx_udpMetaFifo_V_val_write;
wire    split_tx_meta_U0_metaIn_V_TREADY;
wire   [47:0] split_tx_meta_U0_metaOut0_V_TDATA;
wire    split_tx_meta_U0_metaOut0_V_TVALID;
wire    lshiftWordByOctet_U0_ap_start;
wire    lshiftWordByOctet_U0_ap_done;
wire    lshiftWordByOctet_U0_ap_continue;
wire    lshiftWordByOctet_U0_ap_idle;
wire    lshiftWordByOctet_U0_ap_ready;
wire   [63:0] lshiftWordByOctet_U0_tx_shift2udpFifo_V_d_din;
wire    lshiftWordByOctet_U0_tx_shift2udpFifo_V_d_write;
wire   [7:0] lshiftWordByOctet_U0_tx_shift2udpFifo_V_k_din;
wire    lshiftWordByOctet_U0_tx_shift2udpFifo_V_k_write;
wire   [0:0] lshiftWordByOctet_U0_tx_shift2udpFifo_V_l_din;
wire    lshiftWordByOctet_U0_tx_shift2udpFifo_V_l_write;
wire    lshiftWordByOctet_U0_s_axis_tx_data_TREADY;
wire    generate_udp_64_U0_ap_start;
wire    generate_udp_64_U0_ap_done;
wire    generate_udp_64_U0_ap_continue;
wire    generate_udp_64_U0_ap_idle;
wire    generate_udp_64_U0_ap_ready;
wire    generate_udp_64_U0_tx_shift2udpFifo_V_d_read;
wire    generate_udp_64_U0_tx_shift2udpFifo_V_k_read;
wire    generate_udp_64_U0_tx_shift2udpFifo_V_l_read;
wire    generate_udp_64_U0_tx_udpMetaFifo_V_the_read;
wire    generate_udp_64_U0_tx_udpMetaFifo_V_my_s_read;
wire    generate_udp_64_U0_tx_udpMetaFifo_V_len_read;
wire    generate_udp_64_U0_tx_udpMetaFifo_V_val_read;
wire   [63:0] generate_udp_64_U0_m_axis_tx_data_TDATA;
wire    generate_udp_64_U0_m_axis_tx_data_TVALID;
wire   [7:0] generate_udp_64_U0_m_axis_tx_data_TKEEP;
wire   [0:0] generate_udp_64_U0_m_axis_tx_data_TLAST;
wire    portFilter_U0_ap_start;
wire    portFilter_U0_ap_done;
wire    portFilter_U0_ap_continue;
wire    portFilter_U0_ap_idle;
wire    portFilter_U0_ap_ready;
wire    portFilter_U0_portLookupReqFifo_V_s_read;
wire   [0:0] portFilter_U0_portStatusFifo_V_din;
wire    portFilter_U0_portStatusFifo_V_write;
wire    portFilter_U0_port_cmd_V_TREADY;
wire    rx_udp2shiftFifo_V_d_full_n;
wire   [63:0] rx_udp2shiftFifo_V_d_dout;
wire    rx_udp2shiftFifo_V_d_empty_n;
wire    rx_udp2shiftFifo_V_k_full_n;
wire   [7:0] rx_udp2shiftFifo_V_k_dout;
wire    rx_udp2shiftFifo_V_k_empty_n;
wire    rx_udp2shiftFifo_V_l_full_n;
wire   [0:0] rx_udp2shiftFifo_V_l_dout;
wire    rx_udp2shiftFifo_V_l_empty_n;
wire    portLookupReqFifo_V_s_full_n;
wire   [15:0] portLookupReqFifo_V_s_dout;
wire    portLookupReqFifo_V_s_empty_n;
wire    rx_udpMetaFifo_V_full_n;
wire   [48:0] rx_udpMetaFifo_V_dout;
wire    rx_udpMetaFifo_V_empty_n;
wire    portStatusFifo_V_full_n;
wire   [0:0] portStatusFifo_V_dout;
wire    portStatusFifo_V_empty_n;
wire    tx_udpMetaFifo_V_the_full_n;
wire   [15:0] tx_udpMetaFifo_V_the_dout;
wire    tx_udpMetaFifo_V_the_empty_n;
wire    tx_udpMetaFifo_V_my_s_full_n;
wire   [15:0] tx_udpMetaFifo_V_my_s_dout;
wire    tx_udpMetaFifo_V_my_s_empty_n;
wire    tx_udpMetaFifo_V_len_full_n;
wire   [15:0] tx_udpMetaFifo_V_len_dout;
wire    tx_udpMetaFifo_V_len_empty_n;
wire    tx_udpMetaFifo_V_val_full_n;
wire   [0:0] tx_udpMetaFifo_V_val_dout;
wire    tx_udpMetaFifo_V_val_empty_n;
wire    tx_shift2udpFifo_V_d_full_n;
wire   [63:0] tx_shift2udpFifo_V_d_dout;
wire    tx_shift2udpFifo_V_d_empty_n;
wire    tx_shift2udpFifo_V_k_full_n;
wire   [7:0] tx_shift2udpFifo_V_k_dout;
wire    tx_shift2udpFifo_V_k_empty_n;
wire    tx_shift2udpFifo_V_l_full_n;
wire   [0:0] tx_shift2udpFifo_V_l_dout;
wire    tx_shift2udpFifo_V_l_empty_n;

process_udp_64_s process_udp_64_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(process_udp_64_U0_ap_start),
    .ap_done(process_udp_64_U0_ap_done),
    .ap_continue(process_udp_64_U0_ap_continue),
    .ap_idle(process_udp_64_U0_ap_idle),
    .ap_ready(process_udp_64_U0_ap_ready),
    .s_axis_rx_data_TVALID(s_axis_rx_data_TVALID),
    .portStatusFifo_V_dout(portStatusFifo_V_dout),
    .portStatusFifo_V_empty_n(portStatusFifo_V_empty_n),
    .portStatusFifo_V_read(process_udp_64_U0_portStatusFifo_V_read),
    .rx_udp2shiftFifo_V_d_din(process_udp_64_U0_rx_udp2shiftFifo_V_d_din),
    .rx_udp2shiftFifo_V_d_full_n(rx_udp2shiftFifo_V_d_full_n),
    .rx_udp2shiftFifo_V_d_write(process_udp_64_U0_rx_udp2shiftFifo_V_d_write),
    .rx_udp2shiftFifo_V_k_din(process_udp_64_U0_rx_udp2shiftFifo_V_k_din),
    .rx_udp2shiftFifo_V_k_full_n(rx_udp2shiftFifo_V_k_full_n),
    .rx_udp2shiftFifo_V_k_write(process_udp_64_U0_rx_udp2shiftFifo_V_k_write),
    .rx_udp2shiftFifo_V_l_din(process_udp_64_U0_rx_udp2shiftFifo_V_l_din),
    .rx_udp2shiftFifo_V_l_full_n(rx_udp2shiftFifo_V_l_full_n),
    .rx_udp2shiftFifo_V_l_write(process_udp_64_U0_rx_udp2shiftFifo_V_l_write),
    .portLookupReqFifo_V_s_din(process_udp_64_U0_portLookupReqFifo_V_s_din),
    .portLookupReqFifo_V_s_full_n(portLookupReqFifo_V_s_full_n),
    .portLookupReqFifo_V_s_write(process_udp_64_U0_portLookupReqFifo_V_s_write),
    .rx_udpMetaFifo_V_din(process_udp_64_U0_rx_udpMetaFifo_V_din),
    .rx_udpMetaFifo_V_full_n(rx_udpMetaFifo_V_full_n),
    .rx_udpMetaFifo_V_write(process_udp_64_U0_rx_udpMetaFifo_V_write),
    .s_axis_rx_data_TDATA(s_axis_rx_data_TDATA),
    .s_axis_rx_data_TREADY(process_udp_64_U0_s_axis_rx_data_TREADY),
    .s_axis_rx_data_TKEEP(s_axis_rx_data_TKEEP),
    .s_axis_rx_data_TLAST(s_axis_rx_data_TLAST)
);

rshiftWordByOctet rshiftWordByOctet_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(rshiftWordByOctet_U0_ap_start),
    .ap_done(rshiftWordByOctet_U0_ap_done),
    .ap_continue(rshiftWordByOctet_U0_ap_continue),
    .ap_idle(rshiftWordByOctet_U0_ap_idle),
    .ap_ready(rshiftWordByOctet_U0_ap_ready),
    .rx_udp2shiftFifo_V_d_dout(rx_udp2shiftFifo_V_d_dout),
    .rx_udp2shiftFifo_V_d_empty_n(rx_udp2shiftFifo_V_d_empty_n),
    .rx_udp2shiftFifo_V_d_read(rshiftWordByOctet_U0_rx_udp2shiftFifo_V_d_read),
    .rx_udp2shiftFifo_V_k_dout(rx_udp2shiftFifo_V_k_dout),
    .rx_udp2shiftFifo_V_k_empty_n(rx_udp2shiftFifo_V_k_empty_n),
    .rx_udp2shiftFifo_V_k_read(rshiftWordByOctet_U0_rx_udp2shiftFifo_V_k_read),
    .rx_udp2shiftFifo_V_l_dout(rx_udp2shiftFifo_V_l_dout),
    .rx_udp2shiftFifo_V_l_empty_n(rx_udp2shiftFifo_V_l_empty_n),
    .rx_udp2shiftFifo_V_l_read(rshiftWordByOctet_U0_rx_udp2shiftFifo_V_l_read),
    .m_axis_rx_data_TREADY(m_axis_rx_data_TREADY),
    .m_axis_rx_data_TDATA(rshiftWordByOctet_U0_m_axis_rx_data_TDATA),
    .m_axis_rx_data_TVALID(rshiftWordByOctet_U0_m_axis_rx_data_TVALID),
    .m_axis_rx_data_TKEEP(rshiftWordByOctet_U0_m_axis_rx_data_TKEEP),
    .m_axis_rx_data_TLAST(rshiftWordByOctet_U0_m_axis_rx_data_TLAST)
);

merge_rx_meta merge_rx_meta_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(merge_rx_meta_U0_ap_start),
    .ap_done(merge_rx_meta_U0_ap_done),
    .ap_continue(merge_rx_meta_U0_ap_continue),
    .ap_idle(merge_rx_meta_U0_ap_idle),
    .ap_ready(merge_rx_meta_U0_ap_ready),
    .ipMetaIn_V_TVALID(s_axis_rx_meta_V_TVALID),
    .rx_udpMetaFifo_V_dout(rx_udpMetaFifo_V_dout),
    .rx_udpMetaFifo_V_empty_n(rx_udpMetaFifo_V_empty_n),
    .rx_udpMetaFifo_V_read(merge_rx_meta_U0_rx_udpMetaFifo_V_read),
    .metaOut_V_TREADY(m_axis_rx_meta_V_TREADY),
    .ipMetaIn_V_TDATA(s_axis_rx_meta_V_TDATA),
    .ipMetaIn_V_TREADY(merge_rx_meta_U0_ipMetaIn_V_TREADY),
    .metaOut_V_TDATA(merge_rx_meta_U0_metaOut_V_TDATA),
    .metaOut_V_TVALID(merge_rx_meta_U0_metaOut_V_TVALID)
);

split_tx_meta split_tx_meta_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(split_tx_meta_U0_ap_start),
    .ap_done(split_tx_meta_U0_ap_done),
    .ap_continue(split_tx_meta_U0_ap_continue),
    .ap_idle(split_tx_meta_U0_ap_idle),
    .ap_ready(split_tx_meta_U0_ap_ready),
    .metaIn_V_TVALID(s_axis_tx_meta_V_TVALID),
    .tx_udpMetaFifo_V_the_din(split_tx_meta_U0_tx_udpMetaFifo_V_the_din),
    .tx_udpMetaFifo_V_the_full_n(tx_udpMetaFifo_V_the_full_n),
    .tx_udpMetaFifo_V_the_write(split_tx_meta_U0_tx_udpMetaFifo_V_the_write),
    .tx_udpMetaFifo_V_my_s_din(split_tx_meta_U0_tx_udpMetaFifo_V_my_s_din),
    .tx_udpMetaFifo_V_my_s_full_n(tx_udpMetaFifo_V_my_s_full_n),
    .tx_udpMetaFifo_V_my_s_write(split_tx_meta_U0_tx_udpMetaFifo_V_my_s_write),
    .tx_udpMetaFifo_V_len_din(split_tx_meta_U0_tx_udpMetaFifo_V_len_din),
    .tx_udpMetaFifo_V_len_full_n(tx_udpMetaFifo_V_len_full_n),
    .tx_udpMetaFifo_V_len_write(split_tx_meta_U0_tx_udpMetaFifo_V_len_write),
    .tx_udpMetaFifo_V_val_din(split_tx_meta_U0_tx_udpMetaFifo_V_val_din),
    .tx_udpMetaFifo_V_val_full_n(tx_udpMetaFifo_V_val_full_n),
    .tx_udpMetaFifo_V_val_write(split_tx_meta_U0_tx_udpMetaFifo_V_val_write),
    .metaOut0_V_TREADY(m_axis_tx_meta_V_TREADY),
    .metaIn_V_TDATA(s_axis_tx_meta_V_TDATA),
    .metaIn_V_TREADY(split_tx_meta_U0_metaIn_V_TREADY),
    .metaOut0_V_TDATA(split_tx_meta_U0_metaOut0_V_TDATA),
    .metaOut0_V_TVALID(split_tx_meta_U0_metaOut0_V_TVALID)
);

lshiftWordByOctet lshiftWordByOctet_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(lshiftWordByOctet_U0_ap_start),
    .ap_done(lshiftWordByOctet_U0_ap_done),
    .ap_continue(lshiftWordByOctet_U0_ap_continue),
    .ap_idle(lshiftWordByOctet_U0_ap_idle),
    .ap_ready(lshiftWordByOctet_U0_ap_ready),
    .s_axis_tx_data_TVALID(s_axis_tx_data_TVALID),
    .tx_shift2udpFifo_V_d_din(lshiftWordByOctet_U0_tx_shift2udpFifo_V_d_din),
    .tx_shift2udpFifo_V_d_full_n(tx_shift2udpFifo_V_d_full_n),
    .tx_shift2udpFifo_V_d_write(lshiftWordByOctet_U0_tx_shift2udpFifo_V_d_write),
    .tx_shift2udpFifo_V_k_din(lshiftWordByOctet_U0_tx_shift2udpFifo_V_k_din),
    .tx_shift2udpFifo_V_k_full_n(tx_shift2udpFifo_V_k_full_n),
    .tx_shift2udpFifo_V_k_write(lshiftWordByOctet_U0_tx_shift2udpFifo_V_k_write),
    .tx_shift2udpFifo_V_l_din(lshiftWordByOctet_U0_tx_shift2udpFifo_V_l_din),
    .tx_shift2udpFifo_V_l_full_n(tx_shift2udpFifo_V_l_full_n),
    .tx_shift2udpFifo_V_l_write(lshiftWordByOctet_U0_tx_shift2udpFifo_V_l_write),
    .s_axis_tx_data_TDATA(s_axis_tx_data_TDATA),
    .s_axis_tx_data_TREADY(lshiftWordByOctet_U0_s_axis_tx_data_TREADY),
    .s_axis_tx_data_TKEEP(s_axis_tx_data_TKEEP),
    .s_axis_tx_data_TLAST(s_axis_tx_data_TLAST)
);

generate_udp_64_s generate_udp_64_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(generate_udp_64_U0_ap_start),
    .ap_done(generate_udp_64_U0_ap_done),
    .ap_continue(generate_udp_64_U0_ap_continue),
    .ap_idle(generate_udp_64_U0_ap_idle),
    .ap_ready(generate_udp_64_U0_ap_ready),
    .tx_shift2udpFifo_V_d_dout(tx_shift2udpFifo_V_d_dout),
    .tx_shift2udpFifo_V_d_empty_n(tx_shift2udpFifo_V_d_empty_n),
    .tx_shift2udpFifo_V_d_read(generate_udp_64_U0_tx_shift2udpFifo_V_d_read),
    .tx_shift2udpFifo_V_k_dout(tx_shift2udpFifo_V_k_dout),
    .tx_shift2udpFifo_V_k_empty_n(tx_shift2udpFifo_V_k_empty_n),
    .tx_shift2udpFifo_V_k_read(generate_udp_64_U0_tx_shift2udpFifo_V_k_read),
    .tx_shift2udpFifo_V_l_dout(tx_shift2udpFifo_V_l_dout),
    .tx_shift2udpFifo_V_l_empty_n(tx_shift2udpFifo_V_l_empty_n),
    .tx_shift2udpFifo_V_l_read(generate_udp_64_U0_tx_shift2udpFifo_V_l_read),
    .tx_udpMetaFifo_V_the_dout(tx_udpMetaFifo_V_the_dout),
    .tx_udpMetaFifo_V_the_empty_n(tx_udpMetaFifo_V_the_empty_n),
    .tx_udpMetaFifo_V_the_read(generate_udp_64_U0_tx_udpMetaFifo_V_the_read),
    .tx_udpMetaFifo_V_my_s_dout(tx_udpMetaFifo_V_my_s_dout),
    .tx_udpMetaFifo_V_my_s_empty_n(tx_udpMetaFifo_V_my_s_empty_n),
    .tx_udpMetaFifo_V_my_s_read(generate_udp_64_U0_tx_udpMetaFifo_V_my_s_read),
    .tx_udpMetaFifo_V_len_dout(tx_udpMetaFifo_V_len_dout),
    .tx_udpMetaFifo_V_len_empty_n(tx_udpMetaFifo_V_len_empty_n),
    .tx_udpMetaFifo_V_len_read(generate_udp_64_U0_tx_udpMetaFifo_V_len_read),
    .tx_udpMetaFifo_V_val_dout(tx_udpMetaFifo_V_val_dout),
    .tx_udpMetaFifo_V_val_empty_n(tx_udpMetaFifo_V_val_empty_n),
    .tx_udpMetaFifo_V_val_read(generate_udp_64_U0_tx_udpMetaFifo_V_val_read),
    .m_axis_tx_data_TREADY(m_axis_tx_data_TREADY),
    .m_axis_tx_data_TDATA(generate_udp_64_U0_m_axis_tx_data_TDATA),
    .m_axis_tx_data_TVALID(generate_udp_64_U0_m_axis_tx_data_TVALID),
    .m_axis_tx_data_TKEEP(generate_udp_64_U0_m_axis_tx_data_TKEEP),
    .m_axis_tx_data_TLAST(generate_udp_64_U0_m_axis_tx_data_TLAST)
);

portFilter portFilter_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(portFilter_U0_ap_start),
    .ap_done(portFilter_U0_ap_done),
    .ap_continue(portFilter_U0_ap_continue),
    .ap_idle(portFilter_U0_ap_idle),
    .ap_ready(portFilter_U0_ap_ready),
    .port_cmd_V_TVALID(s_axis_port_cmd_V_TVALID),
    .portLookupReqFifo_V_s_dout(portLookupReqFifo_V_s_dout),
    .portLookupReqFifo_V_s_empty_n(portLookupReqFifo_V_s_empty_n),
    .portLookupReqFifo_V_s_read(portFilter_U0_portLookupReqFifo_V_s_read),
    .portStatusFifo_V_din(portFilter_U0_portStatusFifo_V_din),
    .portStatusFifo_V_full_n(portStatusFifo_V_full_n),
    .portStatusFifo_V_write(portFilter_U0_portStatusFifo_V_write),
    .port_cmd_V_TDATA(s_axis_port_cmd_V_TDATA),
    .port_cmd_V_TREADY(portFilter_U0_port_cmd_V_TREADY)
);

fifo_w64_d2_A rx_udp2shiftFifo_V_d_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(process_udp_64_U0_rx_udp2shiftFifo_V_d_din),
    .if_full_n(rx_udp2shiftFifo_V_d_full_n),
    .if_write(process_udp_64_U0_rx_udp2shiftFifo_V_d_write),
    .if_dout(rx_udp2shiftFifo_V_d_dout),
    .if_empty_n(rx_udp2shiftFifo_V_d_empty_n),
    .if_read(rshiftWordByOctet_U0_rx_udp2shiftFifo_V_d_read)
);

fifo_w8_d2_A rx_udp2shiftFifo_V_k_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(process_udp_64_U0_rx_udp2shiftFifo_V_k_din),
    .if_full_n(rx_udp2shiftFifo_V_k_full_n),
    .if_write(process_udp_64_U0_rx_udp2shiftFifo_V_k_write),
    .if_dout(rx_udp2shiftFifo_V_k_dout),
    .if_empty_n(rx_udp2shiftFifo_V_k_empty_n),
    .if_read(rshiftWordByOctet_U0_rx_udp2shiftFifo_V_k_read)
);

fifo_w1_d2_A rx_udp2shiftFifo_V_l_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(process_udp_64_U0_rx_udp2shiftFifo_V_l_din),
    .if_full_n(rx_udp2shiftFifo_V_l_full_n),
    .if_write(process_udp_64_U0_rx_udp2shiftFifo_V_l_write),
    .if_dout(rx_udp2shiftFifo_V_l_dout),
    .if_empty_n(rx_udp2shiftFifo_V_l_empty_n),
    .if_read(rshiftWordByOctet_U0_rx_udp2shiftFifo_V_l_read)
);

fifo_w16_d2_A portLookupReqFifo_V_s_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(process_udp_64_U0_portLookupReqFifo_V_s_din),
    .if_full_n(portLookupReqFifo_V_s_full_n),
    .if_write(process_udp_64_U0_portLookupReqFifo_V_s_write),
    .if_dout(portLookupReqFifo_V_s_dout),
    .if_empty_n(portLookupReqFifo_V_s_empty_n),
    .if_read(portFilter_U0_portLookupReqFifo_V_s_read)
);

fifo_w49_d2_A rx_udpMetaFifo_V_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(process_udp_64_U0_rx_udpMetaFifo_V_din),
    .if_full_n(rx_udpMetaFifo_V_full_n),
    .if_write(process_udp_64_U0_rx_udpMetaFifo_V_write),
    .if_dout(rx_udpMetaFifo_V_dout),
    .if_empty_n(rx_udpMetaFifo_V_empty_n),
    .if_read(merge_rx_meta_U0_rx_udpMetaFifo_V_read)
);

fifo_w1_d2_A portStatusFifo_V_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(portFilter_U0_portStatusFifo_V_din),
    .if_full_n(portStatusFifo_V_full_n),
    .if_write(portFilter_U0_portStatusFifo_V_write),
    .if_dout(portStatusFifo_V_dout),
    .if_empty_n(portStatusFifo_V_empty_n),
    .if_read(process_udp_64_U0_portStatusFifo_V_read)
);

fifo_w16_d2_A tx_udpMetaFifo_V_the_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(split_tx_meta_U0_tx_udpMetaFifo_V_the_din),
    .if_full_n(tx_udpMetaFifo_V_the_full_n),
    .if_write(split_tx_meta_U0_tx_udpMetaFifo_V_the_write),
    .if_dout(tx_udpMetaFifo_V_the_dout),
    .if_empty_n(tx_udpMetaFifo_V_the_empty_n),
    .if_read(generate_udp_64_U0_tx_udpMetaFifo_V_the_read)
);

fifo_w16_d2_A tx_udpMetaFifo_V_my_s_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(split_tx_meta_U0_tx_udpMetaFifo_V_my_s_din),
    .if_full_n(tx_udpMetaFifo_V_my_s_full_n),
    .if_write(split_tx_meta_U0_tx_udpMetaFifo_V_my_s_write),
    .if_dout(tx_udpMetaFifo_V_my_s_dout),
    .if_empty_n(tx_udpMetaFifo_V_my_s_empty_n),
    .if_read(generate_udp_64_U0_tx_udpMetaFifo_V_my_s_read)
);

fifo_w16_d2_A tx_udpMetaFifo_V_len_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(split_tx_meta_U0_tx_udpMetaFifo_V_len_din),
    .if_full_n(tx_udpMetaFifo_V_len_full_n),
    .if_write(split_tx_meta_U0_tx_udpMetaFifo_V_len_write),
    .if_dout(tx_udpMetaFifo_V_len_dout),
    .if_empty_n(tx_udpMetaFifo_V_len_empty_n),
    .if_read(generate_udp_64_U0_tx_udpMetaFifo_V_len_read)
);

fifo_w1_d2_A tx_udpMetaFifo_V_val_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(split_tx_meta_U0_tx_udpMetaFifo_V_val_din),
    .if_full_n(tx_udpMetaFifo_V_val_full_n),
    .if_write(split_tx_meta_U0_tx_udpMetaFifo_V_val_write),
    .if_dout(tx_udpMetaFifo_V_val_dout),
    .if_empty_n(tx_udpMetaFifo_V_val_empty_n),
    .if_read(generate_udp_64_U0_tx_udpMetaFifo_V_val_read)
);

fifo_w64_d2_A tx_shift2udpFifo_V_d_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(lshiftWordByOctet_U0_tx_shift2udpFifo_V_d_din),
    .if_full_n(tx_shift2udpFifo_V_d_full_n),
    .if_write(lshiftWordByOctet_U0_tx_shift2udpFifo_V_d_write),
    .if_dout(tx_shift2udpFifo_V_d_dout),
    .if_empty_n(tx_shift2udpFifo_V_d_empty_n),
    .if_read(generate_udp_64_U0_tx_shift2udpFifo_V_d_read)
);

fifo_w8_d2_A tx_shift2udpFifo_V_k_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(lshiftWordByOctet_U0_tx_shift2udpFifo_V_k_din),
    .if_full_n(tx_shift2udpFifo_V_k_full_n),
    .if_write(lshiftWordByOctet_U0_tx_shift2udpFifo_V_k_write),
    .if_dout(tx_shift2udpFifo_V_k_dout),
    .if_empty_n(tx_shift2udpFifo_V_k_empty_n),
    .if_read(generate_udp_64_U0_tx_shift2udpFifo_V_k_read)
);

fifo_w1_d2_A tx_shift2udpFifo_V_l_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(lshiftWordByOctet_U0_tx_shift2udpFifo_V_l_din),
    .if_full_n(tx_shift2udpFifo_V_l_full_n),
    .if_write(lshiftWordByOctet_U0_tx_shift2udpFifo_V_l_write),
    .if_dout(tx_shift2udpFifo_V_l_dout),
    .if_empty_n(tx_shift2udpFifo_V_l_empty_n),
    .if_read(generate_udp_64_U0_tx_shift2udpFifo_V_l_read)
);

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign ap_sync_continue = 1'b0;

assign generate_udp_64_U0_ap_continue = 1'b1;

assign generate_udp_64_U0_ap_start = 1'b1;

assign lshiftWordByOctet_U0_ap_continue = 1'b1;

assign lshiftWordByOctet_U0_ap_start = 1'b1;

assign m_axis_rx_data_TDATA = rshiftWordByOctet_U0_m_axis_rx_data_TDATA;

assign m_axis_rx_data_TKEEP = rshiftWordByOctet_U0_m_axis_rx_data_TKEEP;

assign m_axis_rx_data_TLAST = rshiftWordByOctet_U0_m_axis_rx_data_TLAST;

assign m_axis_rx_data_TVALID = rshiftWordByOctet_U0_m_axis_rx_data_TVALID;

assign m_axis_rx_meta_V_TDATA = merge_rx_meta_U0_metaOut_V_TDATA;

assign m_axis_rx_meta_V_TVALID = merge_rx_meta_U0_metaOut_V_TVALID;

assign m_axis_tx_data_TDATA = generate_udp_64_U0_m_axis_tx_data_TDATA;

assign m_axis_tx_data_TKEEP = generate_udp_64_U0_m_axis_tx_data_TKEEP;

assign m_axis_tx_data_TLAST = generate_udp_64_U0_m_axis_tx_data_TLAST;

assign m_axis_tx_data_TVALID = generate_udp_64_U0_m_axis_tx_data_TVALID;

assign m_axis_tx_meta_V_TDATA = split_tx_meta_U0_metaOut0_V_TDATA;

assign m_axis_tx_meta_V_TVALID = split_tx_meta_U0_metaOut0_V_TVALID;

assign merge_rx_meta_U0_ap_continue = 1'b1;

assign merge_rx_meta_U0_ap_start = 1'b1;

assign portFilter_U0_ap_continue = 1'b1;

assign portFilter_U0_ap_start = 1'b1;

assign process_udp_64_U0_ap_continue = 1'b1;

assign process_udp_64_U0_ap_start = 1'b1;

assign rshiftWordByOctet_U0_ap_continue = 1'b1;

assign rshiftWordByOctet_U0_ap_start = 1'b1;

assign s_axis_port_cmd_V_TREADY = portFilter_U0_port_cmd_V_TREADY;

assign s_axis_rx_data_TREADY = process_udp_64_U0_s_axis_rx_data_TREADY;

assign s_axis_rx_meta_V_TREADY = merge_rx_meta_U0_ipMetaIn_V_TREADY;

assign s_axis_tx_data_TREADY = lshiftWordByOctet_U0_s_axis_tx_data_TREADY;

assign s_axis_tx_meta_V_TREADY = split_tx_meta_U0_metaIn_V_TREADY;

assign split_tx_meta_U0_ap_continue = 1'b1;

assign split_tx_meta_U0_ap_start = 1'b1;

endmodule //udp_top
