-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2019.1
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ip_invalid_dropper is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    ipDataCheckFifo_V_dout : IN STD_LOGIC_VECTOR (72 downto 0);
    ipDataCheckFifo_V_empty_n : IN STD_LOGIC;
    ipDataCheckFifo_V_read : OUT STD_LOGIC;
    validChecksumFifo_V_dout : IN STD_LOGIC_VECTOR (0 downto 0);
    validChecksumFifo_V_empty_n : IN STD_LOGIC;
    validChecksumFifo_V_read : OUT STD_LOGIC;
    validIpAddressFifo_V_dout : IN STD_LOGIC_VECTOR (0 downto 0);
    validIpAddressFifo_V_empty_n : IN STD_LOGIC;
    validIpAddressFifo_V_read : OUT STD_LOGIC;
    ipDataDropFifo_V_din : OUT STD_LOGIC_VECTOR (72 downto 0);
    ipDataDropFifo_V_full_n : IN STD_LOGIC;
    ipDataDropFifo_V_write : OUT STD_LOGIC;
    ipv4ValidFifo_V_din : OUT STD_LOGIC_VECTOR (0 downto 0);
    ipv4ValidFifo_V_full_n : IN STD_LOGIC;
    ipv4ValidFifo_V_write : OUT STD_LOGIC );
end;


architecture behav of ip_invalid_dropper is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv2_2 : STD_LOGIC_VECTOR (1 downto 0) := "10";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv2_1 : STD_LOGIC_VECTOR (1 downto 0) := "01";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv32_48 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001001000";

    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_idle_pp0 : STD_LOGIC;
    signal grp_nbreadreq_fu_56_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_predicate_op6_read_state1 : BOOLEAN;
    signal ap_predicate_op11_read_state1 : BOOLEAN;
    signal tmp_nbreadreq_fu_70_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_5_nbreadreq_fu_78_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_predicate_op19_read_state1 : BOOLEAN;
    signal ap_predicate_op20_read_state1 : BOOLEAN;
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal iid_state_load_reg_155 : STD_LOGIC_VECTOR (1 downto 0);
    signal tmp_3_reg_167 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_predicate_op38_write_state2 : BOOLEAN;
    signal tmp_reg_180 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_5_reg_184 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln195_reg_188 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_predicate_op42_write_state2 : BOOLEAN;
    signal ap_predicate_op43_write_state2 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal iid_state : STD_LOGIC_VECTOR (1 downto 0) := "00";
    signal validChecksumFifo_V_blk_n : STD_LOGIC;
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal validIpAddressFifo_V_blk_n : STD_LOGIC;
    signal ipv4ValidFifo_V_blk_n : STD_LOGIC;
    signal ipDataCheckFifo_V_blk_n : STD_LOGIC;
    signal ipDataDropFifo_V_blk_n : STD_LOGIC;
    signal grp_fu_125_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp39_reg_171 : STD_LOGIC_VECTOR (72 downto 0);
    signal and_ln195_fu_143_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_phi_mux_storemerge_i_phi_fu_117_p4 : STD_LOGIC_VECTOR (1 downto 0);
    signal ap_phi_reg_pp0_iter0_storemerge_i_reg_114 : STD_LOGIC_VECTOR (1 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_idle_pp0_0to0 : STD_LOGIC;
    signal ap_reset_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_condition_256 : BOOLEAN;
    signal ap_condition_213 : BOOLEAN;


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
                elsif (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
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


    iid_state_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((tmp_5_nbreadreq_fu_78_p3 = ap_const_lv1_1) and (tmp_nbreadreq_fu_70_p3 = ap_const_lv1_1) and (iid_state = ap_const_lv2_0) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
                iid_state <= ap_phi_mux_storemerge_i_phi_fu_117_p4;
            elsif ((((grp_fu_125_p3 = ap_const_lv1_1) and (grp_nbreadreq_fu_56_p3 = ap_const_lv1_1) and (iid_state = ap_const_lv2_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001)) or ((grp_fu_125_p3 = ap_const_lv1_1) and (grp_nbreadreq_fu_56_p3 = ap_const_lv1_1) and (iid_state = ap_const_lv2_2) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001)))) then 
                iid_state <= ap_const_lv2_0;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((tmp_5_nbreadreq_fu_78_p3 = ap_const_lv1_1) and (tmp_nbreadreq_fu_70_p3 = ap_const_lv1_1) and (iid_state = ap_const_lv2_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                and_ln195_reg_188 <= and_ln195_fu_143_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                iid_state_load_reg_155 <= iid_state;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op11_read_state1 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                tmp39_reg_171 <= ipDataCheckFifo_V_dout;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((iid_state = ap_const_lv2_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                tmp_3_reg_167 <= grp_nbreadreq_fu_56_p3;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((tmp_nbreadreq_fu_70_p3 = ap_const_lv1_1) and (iid_state = ap_const_lv2_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                tmp_5_reg_184 <= tmp_5_nbreadreq_fu_78_p3;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((iid_state = ap_const_lv2_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                tmp_reg_180 <= tmp_nbreadreq_fu_70_p3;
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
    and_ln195_fu_143_p2 <= (validIpAddressFifo_V_dout and validChecksumFifo_V_dout);
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, ipDataCheckFifo_V_empty_n, ap_predicate_op6_read_state1, ap_predicate_op11_read_state1, validChecksumFifo_V_empty_n, ap_predicate_op19_read_state1, validIpAddressFifo_V_empty_n, ap_predicate_op20_read_state1, ipDataDropFifo_V_full_n, ap_predicate_op38_write_state2, ipv4ValidFifo_V_full_n, ap_predicate_op42_write_state2, ap_predicate_op43_write_state2)
    begin
                ap_block_pp0_stage0_01001 <= ((ap_done_reg = ap_const_logic_1) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((validIpAddressFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op20_read_state1 = ap_const_boolean_1)) or ((validChecksumFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op19_read_state1 = ap_const_boolean_1)) or ((ipDataCheckFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op11_read_state1 = ap_const_boolean_1)) or ((ipDataCheckFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op6_read_state1 = ap_const_boolean_1)))) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (((ipDataDropFifo_V_full_n = ap_const_logic_0) and (ap_predicate_op38_write_state2 = ap_const_boolean_1)) or ((ipv4ValidFifo_V_full_n = ap_const_logic_0) and (ap_predicate_op43_write_state2 = ap_const_boolean_1)) or ((ipv4ValidFifo_V_full_n = ap_const_logic_0) and (ap_predicate_op42_write_state2 = ap_const_boolean_1)))));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, ipDataCheckFifo_V_empty_n, ap_predicate_op6_read_state1, ap_predicate_op11_read_state1, validChecksumFifo_V_empty_n, ap_predicate_op19_read_state1, validIpAddressFifo_V_empty_n, ap_predicate_op20_read_state1, ipDataDropFifo_V_full_n, ap_predicate_op38_write_state2, ipv4ValidFifo_V_full_n, ap_predicate_op42_write_state2, ap_predicate_op43_write_state2)
    begin
                ap_block_pp0_stage0_11001 <= ((ap_done_reg = ap_const_logic_1) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((validIpAddressFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op20_read_state1 = ap_const_boolean_1)) or ((validChecksumFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op19_read_state1 = ap_const_boolean_1)) or ((ipDataCheckFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op11_read_state1 = ap_const_boolean_1)) or ((ipDataCheckFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op6_read_state1 = ap_const_boolean_1)))) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (((ipDataDropFifo_V_full_n = ap_const_logic_0) and (ap_predicate_op38_write_state2 = ap_const_boolean_1)) or ((ipv4ValidFifo_V_full_n = ap_const_logic_0) and (ap_predicate_op43_write_state2 = ap_const_boolean_1)) or ((ipv4ValidFifo_V_full_n = ap_const_logic_0) and (ap_predicate_op42_write_state2 = ap_const_boolean_1)))));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, ipDataCheckFifo_V_empty_n, ap_predicate_op6_read_state1, ap_predicate_op11_read_state1, validChecksumFifo_V_empty_n, ap_predicate_op19_read_state1, validIpAddressFifo_V_empty_n, ap_predicate_op20_read_state1, ipDataDropFifo_V_full_n, ap_predicate_op38_write_state2, ipv4ValidFifo_V_full_n, ap_predicate_op42_write_state2, ap_predicate_op43_write_state2)
    begin
                ap_block_pp0_stage0_subdone <= ((ap_done_reg = ap_const_logic_1) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((validIpAddressFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op20_read_state1 = ap_const_boolean_1)) or ((validChecksumFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op19_read_state1 = ap_const_boolean_1)) or ((ipDataCheckFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op11_read_state1 = ap_const_boolean_1)) or ((ipDataCheckFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op6_read_state1 = ap_const_boolean_1)))) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (((ipDataDropFifo_V_full_n = ap_const_logic_0) and (ap_predicate_op38_write_state2 = ap_const_boolean_1)) or ((ipv4ValidFifo_V_full_n = ap_const_logic_0) and (ap_predicate_op43_write_state2 = ap_const_boolean_1)) or ((ipv4ValidFifo_V_full_n = ap_const_logic_0) and (ap_predicate_op42_write_state2 = ap_const_boolean_1)))));
    end process;


    ap_block_state1_pp0_stage0_iter0_assign_proc : process(ap_start, ap_done_reg, ipDataCheckFifo_V_empty_n, ap_predicate_op6_read_state1, ap_predicate_op11_read_state1, validChecksumFifo_V_empty_n, ap_predicate_op19_read_state1, validIpAddressFifo_V_empty_n, ap_predicate_op20_read_state1)
    begin
                ap_block_state1_pp0_stage0_iter0 <= ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((validIpAddressFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op20_read_state1 = ap_const_boolean_1)) or ((validChecksumFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op19_read_state1 = ap_const_boolean_1)) or ((ipDataCheckFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op11_read_state1 = ap_const_boolean_1)) or ((ipDataCheckFifo_V_empty_n = ap_const_logic_0) and (ap_predicate_op6_read_state1 = ap_const_boolean_1)));
    end process;


    ap_block_state2_pp0_stage0_iter1_assign_proc : process(ipDataDropFifo_V_full_n, ap_predicate_op38_write_state2, ipv4ValidFifo_V_full_n, ap_predicate_op42_write_state2, ap_predicate_op43_write_state2)
    begin
                ap_block_state2_pp0_stage0_iter1 <= (((ipDataDropFifo_V_full_n = ap_const_logic_0) and (ap_predicate_op38_write_state2 = ap_const_boolean_1)) or ((ipv4ValidFifo_V_full_n = ap_const_logic_0) and (ap_predicate_op43_write_state2 = ap_const_boolean_1)) or ((ipv4ValidFifo_V_full_n = ap_const_logic_0) and (ap_predicate_op42_write_state2 = ap_const_boolean_1)));
    end process;


    ap_condition_213_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0_01001)
    begin
                ap_condition_213 <= ((ap_const_boolean_0 = ap_block_pp0_stage0_01001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0));
    end process;


    ap_condition_256_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, tmp_nbreadreq_fu_70_p3, tmp_5_nbreadreq_fu_78_p3, iid_state, ap_block_pp0_stage0)
    begin
                ap_condition_256 <= ((tmp_5_nbreadreq_fu_78_p3 = ap_const_lv1_1) and (tmp_nbreadreq_fu_70_p3 = ap_const_lv1_1) and (iid_state = ap_const_lv2_0) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0));
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0_11001)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
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


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_0to0_assign_proc : process(ap_enable_reg_pp0_iter0)
    begin
        if ((ap_enable_reg_pp0_iter0 = ap_const_logic_0)) then 
            ap_idle_pp0_0to0 <= ap_const_logic_1;
        else 
            ap_idle_pp0_0to0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_phi_mux_storemerge_i_phi_fu_117_p4_assign_proc : process(and_ln195_fu_143_p2, ap_phi_reg_pp0_iter0_storemerge_i_reg_114, ap_condition_256)
    begin
        if ((ap_const_boolean_1 = ap_condition_256)) then
            if ((ap_const_lv1_1 = and_ln195_fu_143_p2)) then 
                ap_phi_mux_storemerge_i_phi_fu_117_p4 <= ap_const_lv2_1;
            elsif ((ap_const_lv1_0 = and_ln195_fu_143_p2)) then 
                ap_phi_mux_storemerge_i_phi_fu_117_p4 <= ap_const_lv2_2;
            else 
                ap_phi_mux_storemerge_i_phi_fu_117_p4 <= ap_phi_reg_pp0_iter0_storemerge_i_reg_114;
            end if;
        else 
            ap_phi_mux_storemerge_i_phi_fu_117_p4 <= ap_phi_reg_pp0_iter0_storemerge_i_reg_114;
        end if; 
    end process;

    ap_phi_reg_pp0_iter0_storemerge_i_reg_114 <= "XX";

    ap_predicate_op11_read_state1_assign_proc : process(grp_nbreadreq_fu_56_p3, iid_state)
    begin
                ap_predicate_op11_read_state1 <= ((grp_nbreadreq_fu_56_p3 = ap_const_lv1_1) and (iid_state = ap_const_lv2_1));
    end process;


    ap_predicate_op19_read_state1_assign_proc : process(tmp_nbreadreq_fu_70_p3, tmp_5_nbreadreq_fu_78_p3, iid_state)
    begin
                ap_predicate_op19_read_state1 <= ((tmp_5_nbreadreq_fu_78_p3 = ap_const_lv1_1) and (tmp_nbreadreq_fu_70_p3 = ap_const_lv1_1) and (iid_state = ap_const_lv2_0));
    end process;


    ap_predicate_op20_read_state1_assign_proc : process(tmp_nbreadreq_fu_70_p3, tmp_5_nbreadreq_fu_78_p3, iid_state)
    begin
                ap_predicate_op20_read_state1 <= ((tmp_5_nbreadreq_fu_78_p3 = ap_const_lv1_1) and (tmp_nbreadreq_fu_70_p3 = ap_const_lv1_1) and (iid_state = ap_const_lv2_0));
    end process;


    ap_predicate_op38_write_state2_assign_proc : process(iid_state_load_reg_155, tmp_3_reg_167)
    begin
                ap_predicate_op38_write_state2 <= ((iid_state_load_reg_155 = ap_const_lv2_1) and (tmp_3_reg_167 = ap_const_lv1_1));
    end process;


    ap_predicate_op42_write_state2_assign_proc : process(iid_state_load_reg_155, tmp_reg_180, tmp_5_reg_184, and_ln195_reg_188)
    begin
                ap_predicate_op42_write_state2 <= ((iid_state_load_reg_155 = ap_const_lv2_0) and (tmp_5_reg_184 = ap_const_lv1_1) and (tmp_reg_180 = ap_const_lv1_1) and (ap_const_lv1_0 = and_ln195_reg_188));
    end process;


    ap_predicate_op43_write_state2_assign_proc : process(iid_state_load_reg_155, tmp_reg_180, tmp_5_reg_184, and_ln195_reg_188)
    begin
                ap_predicate_op43_write_state2 <= ((iid_state_load_reg_155 = ap_const_lv2_0) and (ap_const_lv1_1 = and_ln195_reg_188) and (tmp_5_reg_184 = ap_const_lv1_1) and (tmp_reg_180 = ap_const_lv1_1));
    end process;


    ap_predicate_op6_read_state1_assign_proc : process(grp_nbreadreq_fu_56_p3, iid_state)
    begin
                ap_predicate_op6_read_state1 <= ((grp_nbreadreq_fu_56_p3 = ap_const_lv1_1) and (iid_state = ap_const_lv2_2));
    end process;


    ap_ready_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001)
    begin
        if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    ap_reset_idle_pp0_assign_proc : process(ap_start, ap_idle_pp0_0to0)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_idle_pp0_0to0 = ap_const_logic_1))) then 
            ap_reset_idle_pp0 <= ap_const_logic_1;
        else 
            ap_reset_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_125_p3 <= ipDataCheckFifo_V_dout(72 downto 72);
    grp_nbreadreq_fu_56_p3 <= (0=>(ipDataCheckFifo_V_empty_n), others=>'-');

    ipDataCheckFifo_V_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_pp0_stage0, ipDataCheckFifo_V_empty_n, ap_predicate_op6_read_state1, ap_predicate_op11_read_state1, ap_block_pp0_stage0)
    begin
        if (((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op11_read_state1 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0)) or (not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op6_read_state1 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0)))) then 
            ipDataCheckFifo_V_blk_n <= ipDataCheckFifo_V_empty_n;
        else 
            ipDataCheckFifo_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    ipDataCheckFifo_V_read_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_predicate_op6_read_state1, ap_predicate_op11_read_state1, ap_block_pp0_stage0_11001)
    begin
        if ((((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op11_read_state1 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001)) or ((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op6_read_state1 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001)))) then 
            ipDataCheckFifo_V_read <= ap_const_logic_1;
        else 
            ipDataCheckFifo_V_read <= ap_const_logic_0;
        end if; 
    end process;


    ipDataDropFifo_V_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ipDataDropFifo_V_full_n, ap_predicate_op38_write_state2, ap_block_pp0_stage0)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op38_write_state2 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0))) then 
            ipDataDropFifo_V_blk_n <= ipDataDropFifo_V_full_n;
        else 
            ipDataDropFifo_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    ipDataDropFifo_V_din <= tmp39_reg_171;

    ipDataDropFifo_V_write_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_predicate_op38_write_state2, ap_block_pp0_stage0_11001)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op38_write_state2 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
            ipDataDropFifo_V_write <= ap_const_logic_1;
        else 
            ipDataDropFifo_V_write <= ap_const_logic_0;
        end if; 
    end process;


    ipv4ValidFifo_V_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ipv4ValidFifo_V_full_n, ap_predicate_op42_write_state2, ap_predicate_op43_write_state2, ap_block_pp0_stage0)
    begin
        if ((((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op43_write_state2 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0)) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op42_write_state2 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0)))) then 
            ipv4ValidFifo_V_blk_n <= ipv4ValidFifo_V_full_n;
        else 
            ipv4ValidFifo_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    ipv4ValidFifo_V_din_assign_proc : process(ap_predicate_op42_write_state2, ap_predicate_op43_write_state2, ap_condition_213)
    begin
        if ((ap_const_boolean_1 = ap_condition_213)) then
            if ((ap_predicate_op43_write_state2 = ap_const_boolean_1)) then 
                ipv4ValidFifo_V_din <= ap_const_lv1_1;
            elsif ((ap_predicate_op42_write_state2 = ap_const_boolean_1)) then 
                ipv4ValidFifo_V_din <= ap_const_lv1_0;
            else 
                ipv4ValidFifo_V_din <= "X";
            end if;
        else 
            ipv4ValidFifo_V_din <= "X";
        end if; 
    end process;


    ipv4ValidFifo_V_write_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_predicate_op42_write_state2, ap_predicate_op43_write_state2, ap_block_pp0_stage0_11001)
    begin
        if ((((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op43_write_state2 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001)) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op42_write_state2 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001)))) then 
            ipv4ValidFifo_V_write <= ap_const_logic_1;
        else 
            ipv4ValidFifo_V_write <= ap_const_logic_0;
        end if; 
    end process;

    tmp_5_nbreadreq_fu_78_p3 <= (0=>(validIpAddressFifo_V_empty_n), others=>'-');
    tmp_nbreadreq_fu_70_p3 <= (0=>(validChecksumFifo_V_empty_n), others=>'-');

    validChecksumFifo_V_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_pp0_stage0, validChecksumFifo_V_empty_n, ap_predicate_op19_read_state1, ap_block_pp0_stage0)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op19_read_state1 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0))) then 
            validChecksumFifo_V_blk_n <= validChecksumFifo_V_empty_n;
        else 
            validChecksumFifo_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    validChecksumFifo_V_read_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_predicate_op19_read_state1, ap_block_pp0_stage0_11001)
    begin
        if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op19_read_state1 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
            validChecksumFifo_V_read <= ap_const_logic_1;
        else 
            validChecksumFifo_V_read <= ap_const_logic_0;
        end if; 
    end process;


    validIpAddressFifo_V_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_pp0_stage0, validIpAddressFifo_V_empty_n, ap_predicate_op20_read_state1, ap_block_pp0_stage0)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op20_read_state1 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0))) then 
            validIpAddressFifo_V_blk_n <= validIpAddressFifo_V_empty_n;
        else 
            validIpAddressFifo_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    validIpAddressFifo_V_read_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_predicate_op20_read_state1, ap_block_pp0_stage0_11001)
    begin
        if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op20_read_state1 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
            validIpAddressFifo_V_read <= ap_const_logic_1;
        else 
            validIpAddressFifo_V_read <= ap_const_logic_0;
        end if; 
    end process;

end behav;
