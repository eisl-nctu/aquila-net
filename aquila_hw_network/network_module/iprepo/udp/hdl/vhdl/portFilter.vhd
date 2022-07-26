-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2019.1
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity portFilter is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    port_cmd_V_TVALID : IN STD_LOGIC;
    portLookupReqFifo_V_s_dout : IN STD_LOGIC_VECTOR (15 downto 0);
    portLookupReqFifo_V_s_empty_n : IN STD_LOGIC;
    portLookupReqFifo_V_s_read : OUT STD_LOGIC;
    portStatusFifo_V_din : OUT STD_LOGIC_VECTOR (0 downto 0);
    portStatusFifo_V_full_n : IN STD_LOGIC;
    portStatusFifo_V_write : OUT STD_LOGIC;
    port_cmd_V_TDATA : IN STD_LOGIC_VECTOR (31 downto 0);
    port_cmd_V_TREADY : OUT STD_LOGIC );
end;


architecture behav of portFilter is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv32_10 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000010000";
    constant ap_const_lv32_1F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000011111";
    constant ap_const_lv16_1 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000001";
    constant ap_const_lv16_0 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";

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
    signal tmp_nbreadreq_fu_52_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal tmp_reg_158 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_5_nbreadreq_fu_66_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_predicate_op15_read_state2 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal tmp_reg_158_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_5_reg_176 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_predicate_op30_write_state3 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal portList_address0 : STD_LOGIC_VECTOR (15 downto 0);
    signal portList_ce0 : STD_LOGIC;
    signal portList_we0 : STD_LOGIC;
    signal portList_d0 : STD_LOGIC_VECTOR (0 downto 0);
    signal portList_q0 : STD_LOGIC_VECTOR (0 downto 0);
    signal port_cmd_V_TDATA_blk_n : STD_LOGIC;
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal portLookupReqFifo_V_s_blk_n : STD_LOGIC;
    signal portStatusFifo_V_blk_n : STD_LOGIC;
    signal tmp_port_V_load_new6_reg_162 : STD_LOGIC_VECTOR (15 downto 0);
    signal icmp_ln879_fu_133_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln879_reg_168 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln879_1_fu_139_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln879_1_reg_172 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal zext_ln544_1_fu_145_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln544_2_fu_150_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln544_fu_154_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal trunc_ln321_fu_119_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_idle_pp0_0to1 : STD_LOGIC;
    signal ap_reset_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_condition_147 : BOOLEAN;
    signal ap_condition_110 : BOOLEAN;
    signal ap_condition_230 : BOOLEAN;

    component portFilter_portList IS
    generic (
        DataWidth : INTEGER;
        AddressRange : INTEGER;
        AddressWidth : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR (15 downto 0);
        ce0 : IN STD_LOGIC;
        we0 : IN STD_LOGIC;
        d0 : IN STD_LOGIC_VECTOR (0 downto 0);
        q0 : OUT STD_LOGIC_VECTOR (0 downto 0) );
    end component;



begin
    portList_U : component portFilter_portList
    generic map (
        DataWidth => 1,
        AddressRange => 65536,
        AddressWidth => 16)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        address0 => portList_address0,
        ce0 => portList_ce0,
        we0 => portList_we0,
        d0 => portList_d0,
        q0 => portList_q0);





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
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
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
                if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))) then 
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

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln879_fu_133_p2 = ap_const_lv1_0) and (tmp_nbreadreq_fu_52_p3 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                icmp_ln879_1_reg_172 <= icmp_ln879_1_fu_139_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_nbreadreq_fu_52_p3 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                icmp_ln879_reg_168 <= icmp_ln879_fu_133_p2;
                tmp_port_V_load_new6_reg_162 <= port_cmd_V_TDATA(31 downto 16);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_reg_158 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                tmp_5_reg_176 <= tmp_5_nbreadreq_fu_66_p3;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                tmp_reg_158 <= tmp_nbreadreq_fu_52_p3;
                tmp_reg_158_pp0_iter1_reg <= tmp_reg_158;
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
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, port_cmd_V_TVALID, tmp_nbreadreq_fu_52_p3, portLookupReqFifo_V_s_empty_n, ap_predicate_op15_read_state2, portStatusFifo_V_full_n, ap_predicate_op30_write_state3)
    begin
                ap_block_pp0_stage0_01001 <= ((ap_done_reg = ap_const_logic_1) or ((portStatusFifo_V_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_predicate_op30_write_state3 = ap_const_boolean_1)) or ((portLookupReqFifo_V_s_empty_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_predicate_op15_read_state2 = ap_const_boolean_1)) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_52_p3 = ap_const_lv1_1) and (port_cmd_V_TVALID = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, port_cmd_V_TVALID, tmp_nbreadreq_fu_52_p3, portLookupReqFifo_V_s_empty_n, ap_predicate_op15_read_state2, portStatusFifo_V_full_n, ap_predicate_op30_write_state3)
    begin
                ap_block_pp0_stage0_11001 <= ((ap_done_reg = ap_const_logic_1) or ((portStatusFifo_V_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_predicate_op30_write_state3 = ap_const_boolean_1)) or ((portLookupReqFifo_V_s_empty_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_predicate_op15_read_state2 = ap_const_boolean_1)) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_52_p3 = ap_const_lv1_1) and (port_cmd_V_TVALID = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, port_cmd_V_TVALID, tmp_nbreadreq_fu_52_p3, portLookupReqFifo_V_s_empty_n, ap_predicate_op15_read_state2, portStatusFifo_V_full_n, ap_predicate_op30_write_state3)
    begin
                ap_block_pp0_stage0_subdone <= ((ap_done_reg = ap_const_logic_1) or ((portStatusFifo_V_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_predicate_op30_write_state3 = ap_const_boolean_1)) or ((portLookupReqFifo_V_s_empty_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_predicate_op15_read_state2 = ap_const_boolean_1)) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_52_p3 = ap_const_lv1_1) and (port_cmd_V_TVALID = ap_const_logic_0)))));
    end process;


    ap_block_state1_pp0_stage0_iter0_assign_proc : process(ap_start, ap_done_reg, port_cmd_V_TVALID, tmp_nbreadreq_fu_52_p3)
    begin
                ap_block_state1_pp0_stage0_iter0 <= ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_52_p3 = ap_const_lv1_1) and (port_cmd_V_TVALID = ap_const_logic_0)));
    end process;


    ap_block_state2_pp0_stage0_iter1_assign_proc : process(portLookupReqFifo_V_s_empty_n, ap_predicate_op15_read_state2)
    begin
                ap_block_state2_pp0_stage0_iter1 <= ((portLookupReqFifo_V_s_empty_n = ap_const_logic_0) and (ap_predicate_op15_read_state2 = ap_const_boolean_1));
    end process;


    ap_block_state3_pp0_stage0_iter2_assign_proc : process(portStatusFifo_V_full_n, ap_predicate_op30_write_state3)
    begin
                ap_block_state3_pp0_stage0_iter2 <= ((portStatusFifo_V_full_n = ap_const_logic_0) and (ap_predicate_op30_write_state3 = ap_const_boolean_1));
    end process;


    ap_condition_110_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0)
    begin
                ap_condition_110 <= ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0));
    end process;


    ap_condition_147_assign_proc : process(tmp_reg_158, icmp_ln879_reg_168, icmp_ln879_1_reg_172)
    begin
                ap_condition_147 <= ((icmp_ln879_reg_168 = ap_const_lv1_0) and (tmp_reg_158 = ap_const_lv1_1) and (icmp_ln879_1_reg_172 = ap_const_lv1_1));
    end process;


    ap_condition_230_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, tmp_reg_158, ap_block_pp0_stage0)
    begin
                ap_condition_230 <= ((tmp_reg_158 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0));
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_enable_reg_pp0_iter2, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
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


    ap_predicate_op15_read_state2_assign_proc : process(tmp_reg_158, tmp_5_nbreadreq_fu_66_p3)
    begin
                ap_predicate_op15_read_state2 <= ((tmp_reg_158 = ap_const_lv1_0) and (tmp_5_nbreadreq_fu_66_p3 = ap_const_lv1_1));
    end process;


    ap_predicate_op30_write_state3_assign_proc : process(tmp_reg_158_pp0_iter1_reg, tmp_5_reg_176)
    begin
                ap_predicate_op30_write_state3 <= ((tmp_reg_158_pp0_iter1_reg = ap_const_lv1_0) and (tmp_5_reg_176 = ap_const_lv1_1));
    end process;


    ap_ready_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
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

    icmp_ln879_1_fu_139_p2 <= "1" when (trunc_ln321_fu_119_p1 = ap_const_lv16_0) else "0";
    icmp_ln879_fu_133_p2 <= "1" when (trunc_ln321_fu_119_p1 = ap_const_lv16_1) else "0";

    portList_address0_assign_proc : process(tmp_reg_158, tmp_5_nbreadreq_fu_66_p3, icmp_ln879_reg_168, zext_ln544_1_fu_145_p1, zext_ln544_2_fu_150_p1, zext_ln544_fu_154_p1, ap_condition_147, ap_condition_110)
    begin
        if ((ap_const_boolean_1 = ap_condition_110)) then
            if (((tmp_reg_158 = ap_const_lv1_1) and (icmp_ln879_reg_168 = ap_const_lv1_1))) then 
                portList_address0 <= zext_ln544_fu_154_p1(16 - 1 downto 0);
            elsif ((ap_const_boolean_1 = ap_condition_147)) then 
                portList_address0 <= zext_ln544_2_fu_150_p1(16 - 1 downto 0);
            elsif (((tmp_reg_158 = ap_const_lv1_0) and (tmp_5_nbreadreq_fu_66_p3 = ap_const_lv1_1))) then 
                portList_address0 <= zext_ln544_1_fu_145_p1(16 - 1 downto 0);
            else 
                portList_address0 <= "XXXXXXXXXXXXXXXX";
            end if;
        else 
            portList_address0 <= "XXXXXXXXXXXXXXXX";
        end if; 
    end process;


    portList_ce0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, tmp_reg_158, tmp_5_nbreadreq_fu_66_p3, ap_block_pp0_stage0_11001, icmp_ln879_reg_168, icmp_ln879_1_reg_172)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_reg_158 = ap_const_lv1_1) and (icmp_ln879_reg_168 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln879_reg_168 = ap_const_lv1_0) and (tmp_reg_158 = ap_const_lv1_1) and (icmp_ln879_1_reg_172 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_reg_158 = ap_const_lv1_0) and (tmp_5_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then 
            portList_ce0 <= ap_const_logic_1;
        else 
            portList_ce0 <= ap_const_logic_0;
        end if; 
    end process;


    portList_d0_assign_proc : process(icmp_ln879_reg_168, icmp_ln879_1_reg_172, ap_condition_230)
    begin
        if ((ap_const_boolean_1 = ap_condition_230)) then
            if ((icmp_ln879_reg_168 = ap_const_lv1_1)) then 
                portList_d0 <= ap_const_lv1_1;
            elsif (((icmp_ln879_reg_168 = ap_const_lv1_0) and (icmp_ln879_1_reg_172 = ap_const_lv1_1))) then 
                portList_d0 <= ap_const_lv1_0;
            else 
                portList_d0 <= "X";
            end if;
        else 
            portList_d0 <= "X";
        end if; 
    end process;


    portList_we0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, tmp_reg_158, ap_block_pp0_stage0_11001, icmp_ln879_reg_168, icmp_ln879_1_reg_172)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_reg_158 = ap_const_lv1_1) and (icmp_ln879_reg_168 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln879_reg_168 = ap_const_lv1_0) and (tmp_reg_158 = ap_const_lv1_1) and (icmp_ln879_1_reg_172 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then 
            portList_we0 <= ap_const_logic_1;
        else 
            portList_we0 <= ap_const_logic_0;
        end if; 
    end process;


    portLookupReqFifo_V_s_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, portLookupReqFifo_V_s_empty_n, ap_predicate_op15_read_state2, ap_block_pp0_stage0)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op15_read_state2 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0))) then 
            portLookupReqFifo_V_s_blk_n <= portLookupReqFifo_V_s_empty_n;
        else 
            portLookupReqFifo_V_s_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    portLookupReqFifo_V_s_read_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_predicate_op15_read_state2, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op15_read_state2 = ap_const_boolean_1))) then 
            portLookupReqFifo_V_s_read <= ap_const_logic_1;
        else 
            portLookupReqFifo_V_s_read <= ap_const_logic_0;
        end if; 
    end process;


    portStatusFifo_V_blk_n_assign_proc : process(ap_enable_reg_pp0_iter2, portStatusFifo_V_full_n, ap_predicate_op30_write_state3, ap_block_pp0_stage0)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_predicate_op30_write_state3 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0))) then 
            portStatusFifo_V_blk_n <= portStatusFifo_V_full_n;
        else 
            portStatusFifo_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    portStatusFifo_V_din <= portList_q0;

    portStatusFifo_V_write_assign_proc : process(ap_enable_reg_pp0_iter2, ap_predicate_op30_write_state3, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_predicate_op30_write_state3 = ap_const_boolean_1))) then 
            portStatusFifo_V_write <= ap_const_logic_1;
        else 
            portStatusFifo_V_write <= ap_const_logic_0;
        end if; 
    end process;


    port_cmd_V_TDATA_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_pp0_stage0, port_cmd_V_TVALID, tmp_nbreadreq_fu_52_p3, ap_block_pp0_stage0)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (tmp_nbreadreq_fu_52_p3 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0))) then 
            port_cmd_V_TDATA_blk_n <= port_cmd_V_TVALID;
        else 
            port_cmd_V_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    port_cmd_V_TREADY_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, tmp_nbreadreq_fu_52_p3, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_nbreadreq_fu_52_p3 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            port_cmd_V_TREADY <= ap_const_logic_1;
        else 
            port_cmd_V_TREADY <= ap_const_logic_0;
        end if; 
    end process;

    tmp_5_nbreadreq_fu_66_p3 <= (0=>(portLookupReqFifo_V_s_empty_n), others=>'-');
    tmp_nbreadreq_fu_52_p3 <= (0=>(port_cmd_V_TVALID), others=>'-');
    trunc_ln321_fu_119_p1 <= port_cmd_V_TDATA(16 - 1 downto 0);
    zext_ln544_1_fu_145_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(portLookupReqFifo_V_s_dout),64));
    zext_ln544_2_fu_150_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_port_V_load_new6_reg_162),64));
    zext_ln544_fu_154_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_port_V_load_new6_reg_162),64));
end behav;
