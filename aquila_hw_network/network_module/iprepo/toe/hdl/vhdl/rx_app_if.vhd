-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2019.1
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rx_app_if is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    appListenPortReq_V_V_TVALID : IN STD_LOGIC;
    portTable2rxApp_list_1_dout : IN STD_LOGIC_VECTOR (0 downto 0);
    portTable2rxApp_list_1_empty_n : IN STD_LOGIC;
    portTable2rxApp_list_1_read : OUT STD_LOGIC;
    rxApp2portTable_list_1_din : OUT STD_LOGIC_VECTOR (15 downto 0);
    rxApp2portTable_list_1_full_n : IN STD_LOGIC;
    rxApp2portTable_list_1_write : OUT STD_LOGIC;
    appListenPortRsp_V_TREADY : IN STD_LOGIC;
    appListenPortReq_V_V_TDATA : IN STD_LOGIC_VECTOR (15 downto 0);
    appListenPortReq_V_V_TREADY : OUT STD_LOGIC;
    appListenPortRsp_V_TDATA : OUT STD_LOGIC_VECTOR (7 downto 0);
    appListenPortRsp_V_TVALID : OUT STD_LOGIC );
end;


architecture behav of rx_app_if is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv2_2 : STD_LOGIC_VECTOR (1 downto 0) := "10";
    constant ap_const_lv2_3 : STD_LOGIC_VECTOR (1 downto 0) := "11";
    constant ap_const_lv2_1 : STD_LOGIC_VECTOR (1 downto 0) := "01";
    constant ap_const_boolean_0 : BOOLEAN := false;

    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal ap_idle_pp0 : STD_LOGIC;
    signal or_ln63_fu_104_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln71_fu_116_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_predicate_op14_read_state1 : BOOLEAN;
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal or_ln63_reg_132 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal appListenPortRsp_V_1_ack_in : STD_LOGIC;
    signal and_ln71_reg_141 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_predicate_op18_write_state2 : BOOLEAN;
    signal ap_block_state2_io : BOOLEAN;
    signal appListenPortRsp_V_1_ack_out : STD_LOGIC;
    signal appListenPortRsp_V_1_state : STD_LOGIC_VECTOR (1 downto 0) := "00";
    signal ap_block_state3_pp0_stage0_iter2 : BOOLEAN;
    signal or_ln63_reg_132_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln71_reg_141_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_predicate_op25_write_state3 : BOOLEAN;
    signal ap_block_state3_io : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal appListenPortRsp_V_1_data_out : STD_LOGIC_VECTOR (7 downto 0);
    signal appListenPortRsp_V_1_vld_in : STD_LOGIC;
    signal appListenPortRsp_V_1_vld_out : STD_LOGIC;
    signal appListenPortRsp_V_1_payload_A : STD_LOGIC_VECTOR (7 downto 0);
    signal appListenPortRsp_V_1_payload_B : STD_LOGIC_VECTOR (7 downto 0);
    signal appListenPortRsp_V_1_sel_rd : STD_LOGIC := '0';
    signal appListenPortRsp_V_1_sel_wr : STD_LOGIC := '0';
    signal appListenPortRsp_V_1_sel : STD_LOGIC;
    signal appListenPortRsp_V_1_load_A : STD_LOGIC;
    signal appListenPortRsp_V_1_load_B : STD_LOGIC;
    signal appListenPortRsp_V_1_state_cmp_full : STD_LOGIC;
    signal rai_wait : STD_LOGIC_VECTOR (0 downto 0) := "0";
    signal appListenPortReq_V_V_TDATA_blk_n : STD_LOGIC;
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal appListenPortRsp_V_TDATA_blk_n : STD_LOGIC;
    signal rxApp2portTable_list_1_blk_n : STD_LOGIC;
    signal portTable2rxApp_list_1_blk_n : STD_LOGIC;
    signal tmp_V_reg_136 : STD_LOGIC_VECTOR (15 downto 0);
    signal tmp_94_reg_145 : STD_LOGIC_VECTOR (0 downto 0);
    signal zext_ln163_fu_128_p1 : STD_LOGIC_VECTOR (7 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal tmp_nbreadreq_fu_52_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_92_nbreadreq_fu_66_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal xor_ln63_fu_98_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_idle_pp0_0to1 : STD_LOGIC;
    signal ap_reset_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_condition_119 : BOOLEAN;


begin




    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_done_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_done_reg <= ap_const_logic_0;
            else
                if ((ap_continue = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    ap_enable_reg_pp0_iter1 <= ap_start;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                end if; 
            end if;
        end if;
    end process;


    appListenPortRsp_V_1_sel_rd_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                appListenPortRsp_V_1_sel_rd <= ap_const_logic_0;
            else
                if (((appListenPortRsp_V_1_ack_out = ap_const_logic_1) and (appListenPortRsp_V_1_vld_out = ap_const_logic_1))) then 
                                        appListenPortRsp_V_1_sel_rd <= not(appListenPortRsp_V_1_sel_rd);
                end if; 
            end if;
        end if;
    end process;


    appListenPortRsp_V_1_sel_wr_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                appListenPortRsp_V_1_sel_wr <= ap_const_logic_0;
            else
                if (((appListenPortRsp_V_1_ack_in = ap_const_logic_1) and (appListenPortRsp_V_1_vld_in = ap_const_logic_1))) then 
                                        appListenPortRsp_V_1_sel_wr <= not(appListenPortRsp_V_1_sel_wr);
                end if; 
            end if;
        end if;
    end process;


    appListenPortRsp_V_1_state_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                appListenPortRsp_V_1_state <= ap_const_lv2_0;
            else
                if ((((appListenPortRsp_V_1_state = ap_const_lv2_3) and (appListenPortRsp_V_1_vld_in = ap_const_logic_0) and (appListenPortRsp_V_1_ack_out = ap_const_logic_1)) or ((appListenPortRsp_V_1_state = ap_const_lv2_2) and (appListenPortRsp_V_1_vld_in = ap_const_logic_0)))) then 
                    appListenPortRsp_V_1_state <= ap_const_lv2_2;
                elsif ((((appListenPortRsp_V_1_state = ap_const_lv2_1) and (appListenPortRsp_V_TREADY = ap_const_logic_0)) or ((appListenPortRsp_V_1_state = ap_const_lv2_3) and (appListenPortRsp_V_TREADY = ap_const_logic_0) and (appListenPortRsp_V_1_vld_in = ap_const_logic_1)))) then 
                    appListenPortRsp_V_1_state <= ap_const_lv2_1;
                elsif ((((appListenPortRsp_V_1_state = ap_const_lv2_1) and (appListenPortRsp_V_1_ack_out = ap_const_logic_1)) or (not(((appListenPortRsp_V_1_vld_in = ap_const_logic_0) and (appListenPortRsp_V_1_ack_out = ap_const_logic_1))) and not(((appListenPortRsp_V_TREADY = ap_const_logic_0) and (appListenPortRsp_V_1_vld_in = ap_const_logic_1))) and (appListenPortRsp_V_1_state = ap_const_lv2_3)) or ((appListenPortRsp_V_1_state = ap_const_lv2_2) and (appListenPortRsp_V_1_vld_in = ap_const_logic_1)))) then 
                    appListenPortRsp_V_1_state <= ap_const_lv2_3;
                else 
                    appListenPortRsp_V_1_state <= ap_const_lv2_2;
                end if; 
            end if;
        end if;
    end process;


    rai_wait_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_boolean_1 = ap_condition_119)) then
                if (((ap_const_lv1_1 = and_ln71_fu_116_p2) and (or_ln63_fu_104_p2 = ap_const_lv1_1))) then 
                    rai_wait <= ap_const_lv1_0;
                elsif ((or_ln63_fu_104_p2 = ap_const_lv1_0)) then 
                    rai_wait <= ap_const_lv1_1;
                end if;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((or_ln63_fu_104_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                and_ln71_reg_141 <= and_ln71_fu_116_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                and_ln71_reg_141_pp0_iter1_reg <= and_ln71_reg_141;
                or_ln63_reg_132 <= or_ln63_fu_104_p2;
                or_ln63_reg_132_pp0_iter1_reg <= or_ln63_reg_132;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((appListenPortRsp_V_1_load_A = ap_const_logic_1)) then
                appListenPortRsp_V_1_payload_A <= zext_ln163_fu_128_p1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((appListenPortRsp_V_1_load_B = ap_const_logic_1)) then
                appListenPortRsp_V_1_payload_B <= zext_ln163_fu_128_p1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op14_read_state1 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                tmp_94_reg_145 <= portTable2rxApp_list_1_dout;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((or_ln63_fu_104_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                tmp_V_reg_136 <= appListenPortReq_V_V_TDATA;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_block_pp0_stage0_subdone, ap_reset_idle_pp0)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_pp0_stage0 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    and_ln71_fu_116_p2 <= (tmp_92_nbreadreq_fu_66_p3 and rai_wait);
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, appListenPortReq_V_V_TVALID, or_ln63_fu_104_p2, portTable2rxApp_list_1_empty_n, ap_predicate_op14_read_state1, rxApp2portTable_list_1_full_n, or_ln63_reg_132, appListenPortRsp_V_TREADY, appListenPortRsp_V_1_state)
    begin
                ap_block_pp0_stage0_01001 <= ((ap_done_reg = ap_const_logic_1) or ((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and ((appListenPortRsp_V_1_state = ap_const_lv2_1) or ((appListenPortRsp_V_1_state = ap_const_lv2_3) and (appListenPortRsp_V_TREADY = ap_const_logic_0)))) or ((or_ln63_reg_132 = ap_const_lv1_0) and (rxApp2portTable_list_1_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1)) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((portTable2rxApp_list_1_empty_n = ap_const_logic_0) and (ap_predicate_op14_read_state1 = ap_const_boolean_1)) or ((or_ln63_fu_104_p2 = ap_const_lv1_0) and (appListenPortReq_V_V_TVALID = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, appListenPortReq_V_V_TVALID, or_ln63_fu_104_p2, portTable2rxApp_list_1_empty_n, ap_predicate_op14_read_state1, rxApp2portTable_list_1_full_n, or_ln63_reg_132, appListenPortRsp_V_TREADY, ap_block_state2_io, appListenPortRsp_V_1_state, ap_block_state3_io)
    begin
                ap_block_pp0_stage0_11001 <= ((ap_done_reg = ap_const_logic_1) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and ((ap_const_boolean_1 = ap_block_state2_io) or ((or_ln63_reg_132 = ap_const_lv1_0) and (rxApp2portTable_list_1_full_n = ap_const_logic_0)))) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((portTable2rxApp_list_1_empty_n = ap_const_logic_0) and (ap_predicate_op14_read_state1 = ap_const_boolean_1)) or ((or_ln63_fu_104_p2 = ap_const_lv1_0) and (appListenPortReq_V_V_TVALID = ap_const_logic_0)))) or ((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and ((appListenPortRsp_V_1_state = ap_const_lv2_1) or (ap_const_boolean_1 = ap_block_state3_io) or ((appListenPortRsp_V_1_state = ap_const_lv2_3) and (appListenPortRsp_V_TREADY = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, appListenPortReq_V_V_TVALID, or_ln63_fu_104_p2, portTable2rxApp_list_1_empty_n, ap_predicate_op14_read_state1, rxApp2portTable_list_1_full_n, or_ln63_reg_132, appListenPortRsp_V_TREADY, ap_block_state2_io, appListenPortRsp_V_1_state, ap_block_state3_io)
    begin
                ap_block_pp0_stage0_subdone <= ((ap_done_reg = ap_const_logic_1) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and ((ap_const_boolean_1 = ap_block_state2_io) or ((or_ln63_reg_132 = ap_const_lv1_0) and (rxApp2portTable_list_1_full_n = ap_const_logic_0)))) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((portTable2rxApp_list_1_empty_n = ap_const_logic_0) and (ap_predicate_op14_read_state1 = ap_const_boolean_1)) or ((or_ln63_fu_104_p2 = ap_const_lv1_0) and (appListenPortReq_V_V_TVALID = ap_const_logic_0)))) or ((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and ((appListenPortRsp_V_1_state = ap_const_lv2_1) or (ap_const_boolean_1 = ap_block_state3_io) or ((appListenPortRsp_V_1_state = ap_const_lv2_3) and (appListenPortRsp_V_TREADY = ap_const_logic_0)))));
    end process;


    ap_block_state1_pp0_stage0_iter0_assign_proc : process(ap_start, ap_done_reg, appListenPortReq_V_V_TVALID, or_ln63_fu_104_p2, portTable2rxApp_list_1_empty_n, ap_predicate_op14_read_state1)
    begin
                ap_block_state1_pp0_stage0_iter0 <= ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((portTable2rxApp_list_1_empty_n = ap_const_logic_0) and (ap_predicate_op14_read_state1 = ap_const_boolean_1)) or ((or_ln63_fu_104_p2 = ap_const_lv1_0) and (appListenPortReq_V_V_TVALID = ap_const_logic_0)));
    end process;


    ap_block_state2_io_assign_proc : process(appListenPortRsp_V_1_ack_in, ap_predicate_op18_write_state2)
    begin
                ap_block_state2_io <= ((appListenPortRsp_V_1_ack_in = ap_const_logic_0) and (ap_predicate_op18_write_state2 = ap_const_boolean_1));
    end process;


    ap_block_state2_pp0_stage0_iter1_assign_proc : process(rxApp2portTable_list_1_full_n, or_ln63_reg_132)
    begin
                ap_block_state2_pp0_stage0_iter1 <= ((or_ln63_reg_132 = ap_const_lv1_0) and (rxApp2portTable_list_1_full_n = ap_const_logic_0));
    end process;


    ap_block_state3_io_assign_proc : process(appListenPortRsp_V_1_ack_in, ap_predicate_op25_write_state3)
    begin
                ap_block_state3_io <= ((appListenPortRsp_V_1_ack_in = ap_const_logic_0) and (ap_predicate_op25_write_state3 = ap_const_boolean_1));
    end process;


    ap_block_state3_pp0_stage0_iter2_assign_proc : process(appListenPortRsp_V_TREADY, appListenPortRsp_V_1_state)
    begin
                ap_block_state3_pp0_stage0_iter2 <= ((appListenPortRsp_V_1_state = ap_const_lv2_1) or ((appListenPortRsp_V_1_state = ap_const_lv2_3) and (appListenPortRsp_V_TREADY = ap_const_logic_0)));
    end process;


    ap_condition_119_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001)
    begin
                ap_condition_119 <= ((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001));
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_enable_reg_pp0_iter2, ap_block_pp0_stage0_11001)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_done_reg;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);
    ap_enable_reg_pp0_iter0 <= ap_start;

    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_idle_pp0)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_idle_pp0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_0to1_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0_0to1 <= ap_const_logic_1;
        else 
            ap_idle_pp0_0to1 <= ap_const_logic_0;
        end if; 
    end process;


    ap_predicate_op14_read_state1_assign_proc : process(or_ln63_fu_104_p2, and_ln71_fu_116_p2)
    begin
                ap_predicate_op14_read_state1 <= ((ap_const_lv1_1 = and_ln71_fu_116_p2) and (or_ln63_fu_104_p2 = ap_const_lv1_1));
    end process;


    ap_predicate_op18_write_state2_assign_proc : process(or_ln63_reg_132, and_ln71_reg_141)
    begin
                ap_predicate_op18_write_state2 <= ((ap_const_lv1_1 = and_ln71_reg_141) and (or_ln63_reg_132 = ap_const_lv1_1));
    end process;


    ap_predicate_op25_write_state3_assign_proc : process(or_ln63_reg_132_pp0_iter1_reg, and_ln71_reg_141_pp0_iter1_reg)
    begin
                ap_predicate_op25_write_state3 <= ((ap_const_lv1_1 = and_ln71_reg_141_pp0_iter1_reg) and (or_ln63_reg_132_pp0_iter1_reg = ap_const_lv1_1));
    end process;


    ap_ready_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001)
    begin
        if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    ap_reset_idle_pp0_assign_proc : process(ap_start, ap_idle_pp0_0to1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_idle_pp0_0to1 = ap_const_logic_1))) then 
            ap_reset_idle_pp0 <= ap_const_logic_1;
        else 
            ap_reset_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    appListenPortReq_V_V_TDATA_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_pp0_stage0, appListenPortReq_V_V_TVALID, or_ln63_fu_104_p2, ap_block_pp0_stage0)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (or_ln63_fu_104_p2 = ap_const_lv1_0) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0))) then 
            appListenPortReq_V_V_TDATA_blk_n <= appListenPortReq_V_V_TVALID;
        else 
            appListenPortReq_V_V_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    appListenPortReq_V_V_TREADY_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, or_ln63_fu_104_p2, ap_block_pp0_stage0_11001)
    begin
        if (((or_ln63_fu_104_p2 = ap_const_lv1_0) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
            appListenPortReq_V_V_TREADY <= ap_const_logic_1;
        else 
            appListenPortReq_V_V_TREADY <= ap_const_logic_0;
        end if; 
    end process;

    appListenPortRsp_V_1_ack_in <= appListenPortRsp_V_1_state(1);
    appListenPortRsp_V_1_ack_out <= appListenPortRsp_V_TREADY;

    appListenPortRsp_V_1_data_out_assign_proc : process(appListenPortRsp_V_1_payload_A, appListenPortRsp_V_1_payload_B, appListenPortRsp_V_1_sel)
    begin
        if ((appListenPortRsp_V_1_sel = ap_const_logic_1)) then 
            appListenPortRsp_V_1_data_out <= appListenPortRsp_V_1_payload_B;
        else 
            appListenPortRsp_V_1_data_out <= appListenPortRsp_V_1_payload_A;
        end if; 
    end process;

    appListenPortRsp_V_1_load_A <= (not(appListenPortRsp_V_1_sel_wr) and appListenPortRsp_V_1_state_cmp_full);
    appListenPortRsp_V_1_load_B <= (appListenPortRsp_V_1_state_cmp_full and appListenPortRsp_V_1_sel_wr);
    appListenPortRsp_V_1_sel <= appListenPortRsp_V_1_sel_rd;
    appListenPortRsp_V_1_state_cmp_full <= '0' when (appListenPortRsp_V_1_state = ap_const_lv2_1) else '1';

    appListenPortRsp_V_1_vld_in_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_predicate_op18_write_state2, ap_block_pp0_stage0_11001)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op18_write_state2 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
            appListenPortRsp_V_1_vld_in <= ap_const_logic_1;
        else 
            appListenPortRsp_V_1_vld_in <= ap_const_logic_0;
        end if; 
    end process;

    appListenPortRsp_V_1_vld_out <= appListenPortRsp_V_1_state(0);
    appListenPortRsp_V_TDATA <= appListenPortRsp_V_1_data_out;

    appListenPortRsp_V_TDATA_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, ap_predicate_op18_write_state2, appListenPortRsp_V_1_state, ap_predicate_op25_write_state3, ap_block_pp0_stage0)
    begin
        if ((((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op18_write_state2 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0)) or ((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_predicate_op25_write_state3 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0)))) then 
            appListenPortRsp_V_TDATA_blk_n <= appListenPortRsp_V_1_state(1);
        else 
            appListenPortRsp_V_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    appListenPortRsp_V_TVALID <= appListenPortRsp_V_1_state(0);
    or_ln63_fu_104_p2 <= (xor_ln63_fu_98_p2 or rai_wait);

    portTable2rxApp_list_1_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_pp0_stage0, portTable2rxApp_list_1_empty_n, ap_predicate_op14_read_state1, ap_block_pp0_stage0)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op14_read_state1 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0))) then 
            portTable2rxApp_list_1_blk_n <= portTable2rxApp_list_1_empty_n;
        else 
            portTable2rxApp_list_1_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    portTable2rxApp_list_1_read_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_predicate_op14_read_state1, ap_block_pp0_stage0_11001)
    begin
        if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op14_read_state1 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
            portTable2rxApp_list_1_read <= ap_const_logic_1;
        else 
            portTable2rxApp_list_1_read <= ap_const_logic_0;
        end if; 
    end process;


    rxApp2portTable_list_1_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, rxApp2portTable_list_1_full_n, or_ln63_reg_132, ap_block_pp0_stage0)
    begin
        if (((or_ln63_reg_132 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0))) then 
            rxApp2portTable_list_1_blk_n <= rxApp2portTable_list_1_full_n;
        else 
            rxApp2portTable_list_1_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    rxApp2portTable_list_1_din <= tmp_V_reg_136;

    rxApp2portTable_list_1_write_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, or_ln63_reg_132, ap_block_pp0_stage0_11001)
    begin
        if (((or_ln63_reg_132 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
            rxApp2portTable_list_1_write <= ap_const_logic_1;
        else 
            rxApp2portTable_list_1_write <= ap_const_logic_0;
        end if; 
    end process;

    tmp_92_nbreadreq_fu_66_p3 <= (0=>(portTable2rxApp_list_1_empty_n), others=>'-');
    tmp_nbreadreq_fu_52_p3 <= (0=>(appListenPortReq_V_V_TVALID), others=>'-');
    xor_ln63_fu_98_p2 <= (tmp_nbreadreq_fu_52_p3 xor ap_const_lv1_1);
    zext_ln163_fu_128_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_94_reg_145),8));
end behav;
