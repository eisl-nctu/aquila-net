/*
 * Copyright (c) 2019, Systems Group, ETH Zurich
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 * 3. Neither the name of the copyright holder nor the names of its contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

`timescale 1ns / 1ps

module data_register_slice #(
    parameter WIDTH    = 64
) (
    input  wire                          aclk,
    input  wire                          aresetn,
    input  wire                          s_axis_valid,
    output wire                          s_axis_ready,
    input  wire [WIDTH-1 : 0]            s_axis_data,
    input  wire [(WIDTH/8)-1 : 0]        s_axis_keep,
    input  wire                          s_axis_last,
    output wire                          m_axis_valid,
    input  wire                          m_axis_ready,
    output wire [WIDTH-1 : 0]            m_axis_data,
    output wire [(WIDTH/8)-1 : 0]        m_axis_keep,
    output wire                          m_axis_last
);


    generate
    
        if(WIDTH==64) begin
            axis_register_slice_64 slice_inst(
                .aclk(aclk),
                .aresetn(aresetn),
                .s_axis_tvalid(s_axis_valid),
                .s_axis_tready(s_axis_ready),
                .s_axis_tdata(s_axis_data),
                .s_axis_tkeep(s_axis_keep),
                .s_axis_tlast(s_axis_last),
                .m_axis_tvalid(m_axis_valid),
                .m_axis_tready(m_axis_ready),
                .m_axis_tdata(m_axis_data),
                .m_axis_tkeep(m_axis_keep),
                .m_axis_tlast(m_axis_last)
            );
        end
        
        if(WIDTH==128) begin
            axis_register_slice_128 slice_inst(
                .aclk(aclk),
                .aresetn(aresetn),
                .s_axis_tvalid(s_axis_valid),
                .s_axis_tready(s_axis_ready),
                .s_axis_tdata(s_axis_data),
                .s_axis_tkeep(s_axis_keep),
                .s_axis_tlast(s_axis_last),
                .m_axis_tvalid(m_axis_valid),
                .m_axis_tready(m_axis_ready),
                .m_axis_tdata(m_axis_data),
                .m_axis_tkeep(m_axis_keep),
                .m_axis_tlast(m_axis_last)
            );
        end

        if(WIDTH==256) begin
            axis_register_slice_256 slice_inst(
                .aclk(aclk),
                .aresetn(aresetn),
                .s_axis_tvalid(s_axis_valid),
                .s_axis_tready(s_axis_ready),
                .s_axis_tdata(s_axis_data),
                .s_axis_tkeep(s_axis_keep),
                .s_axis_tlast(s_axis_last),
                .m_axis_tvalid(m_axis_valid),
                .m_axis_tready(m_axis_ready),
                .m_axis_tdata(m_axis_data),
                .m_axis_tkeep(m_axis_keep),
                .m_axis_tlast(m_axis_last)
            );
        end
        
        if(WIDTH==512) begin
            axis_register_slice_512 slice_inst(
                .aclk(aclk),
                .aresetn(aresetn),
                .s_axis_tvalid(s_axis_valid),
                .s_axis_tready(s_axis_ready),
                .s_axis_tdata(s_axis_data),
                .s_axis_tkeep(s_axis_keep),
                .s_axis_tlast(s_axis_last),
                .m_axis_tvalid(m_axis_valid),
                .m_axis_tready(m_axis_ready),
                .m_axis_tdata(m_axis_data),
                .m_axis_tkeep(m_axis_keep),
                .m_axis_tlast(m_axis_last)
            );
        end

    endgenerate

endmodule