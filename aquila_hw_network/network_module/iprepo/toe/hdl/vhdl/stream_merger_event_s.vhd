-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2019.1
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity stream_merger_event_s is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    rtTimer2eventEng_set_1_dout : IN STD_LOGIC_VECTOR (53 downto 0);
    rtTimer2eventEng_set_1_empty_n : IN STD_LOGIC;
    rtTimer2eventEng_set_1_read : OUT STD_LOGIC;
    probeTimer2eventEng_1_dout : IN STD_LOGIC_VECTOR (53 downto 0);
    probeTimer2eventEng_1_empty_n : IN STD_LOGIC;
    probeTimer2eventEng_1_read : OUT STD_LOGIC;
    timer2eventEng_setEv_1_din : OUT STD_LOGIC_VECTOR (53 downto 0);
    timer2eventEng_setEv_1_full_n : IN STD_LOGIC;
    timer2eventEng_setEv_1_write : OUT STD_LOGIC );
end;


architecture behav of stream_merger_event_s is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
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
    signal tmp_nbreadreq_fu_28_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal tmp_reg_63 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_72_nbreadreq_fu_42_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_predicate_op9_read_state2 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal tmp_reg_63_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_72_reg_72 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_predicate_op14_write_state3 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal rtTimer2eventEng_set_1_blk_n : STD_LOGIC;
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal timer2eventEng_setEv_1_blk_n : STD_LOGIC;
    signal probeTimer2eventEng_1_blk_n : STD_LOGIC;
    signal tmp98_reg_67 : STD_LOGIC_VECTOR (53 downto 0);
    signal tmp98_reg_67_pp0_iter1_reg : STD_LOGIC_VECTOR (53 downto 0);
    signal tmp_2_reg_76 : STD_LOGIC_VECTOR (53 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_idle_pp0_0to1 : STD_LOGIC;
    signal ap_reset_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;


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
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_nbreadreq_fu_28_p3 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                tmp98_reg_67 <= rtTimer2eventEng_set_1_dout;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                tmp98_reg_67_pp0_iter1_reg <= tmp98_reg_67;
                tmp_reg_63 <= tmp_nbreadreq_fu_28_p3;
                tmp_reg_63_pp0_iter1_reg <= tmp_reg_63;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op9_read_state2 = ap_const_boolean_1))) then
                tmp_2_reg_76 <= probeTimer2eventEng_1_dout;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_reg_63 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                tmp_72_reg_72 <= tmp_72_nbreadreq_fu_42_p3;
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

    ap_block_pp0_stage0_01001_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, rtTimer2eventEng_set_1_empty_n, tmp_nbreadreq_fu_28_p3, probeTimer2eventEng_1_empty_n, ap_predicate_op9_read_state2, timer2eventEng_setEv_1_full_n, tmp_reg_63_pp0_iter1_reg, ap_predicate_op14_write_state3)
    begin
                ap_block_pp0_stage0_01001 <= ((ap_done_reg = ap_const_logic_1) or ((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (((tmp_reg_63_pp0_iter1_reg = ap_const_lv1_1) and (timer2eventEng_setEv_1_full_n = ap_const_logic_0)) or ((timer2eventEng_setEv_1_full_n = ap_const_logic_0) and (ap_predicate_op14_write_state3 = ap_const_boolean_1)))) or ((probeTimer2eventEng_1_empty_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_predicate_op9_read_state2 = ap_const_boolean_1)) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_28_p3 = ap_const_lv1_1) and (rtTimer2eventEng_set_1_empty_n = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, rtTimer2eventEng_set_1_empty_n, tmp_nbreadreq_fu_28_p3, probeTimer2eventEng_1_empty_n, ap_predicate_op9_read_state2, timer2eventEng_setEv_1_full_n, tmp_reg_63_pp0_iter1_reg, ap_predicate_op14_write_state3)
    begin
                ap_block_pp0_stage0_11001 <= ((ap_done_reg = ap_const_logic_1) or ((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (((tmp_reg_63_pp0_iter1_reg = ap_const_lv1_1) and (timer2eventEng_setEv_1_full_n = ap_const_logic_0)) or ((timer2eventEng_setEv_1_full_n = ap_const_logic_0) and (ap_predicate_op14_write_state3 = ap_const_boolean_1)))) or ((probeTimer2eventEng_1_empty_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_predicate_op9_read_state2 = ap_const_boolean_1)) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_28_p3 = ap_const_lv1_1) and (rtTimer2eventEng_set_1_empty_n = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, rtTimer2eventEng_set_1_empty_n, tmp_nbreadreq_fu_28_p3, probeTimer2eventEng_1_empty_n, ap_predicate_op9_read_state2, timer2eventEng_setEv_1_full_n, tmp_reg_63_pp0_iter1_reg, ap_predicate_op14_write_state3)
    begin
                ap_block_pp0_stage0_subdone <= ((ap_done_reg = ap_const_logic_1) or ((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (((tmp_reg_63_pp0_iter1_reg = ap_const_lv1_1) and (timer2eventEng_setEv_1_full_n = ap_const_logic_0)) or ((timer2eventEng_setEv_1_full_n = ap_const_logic_0) and (ap_predicate_op14_write_state3 = ap_const_boolean_1)))) or ((probeTimer2eventEng_1_empty_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_predicate_op9_read_state2 = ap_const_boolean_1)) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_28_p3 = ap_const_lv1_1) and (rtTimer2eventEng_set_1_empty_n = ap_const_logic_0)))));
    end process;


    ap_block_state1_pp0_stage0_iter0_assign_proc : process(ap_start, ap_done_reg, rtTimer2eventEng_set_1_empty_n, tmp_nbreadreq_fu_28_p3)
    begin
                ap_block_state1_pp0_stage0_iter0 <= ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_28_p3 = ap_const_lv1_1) and (rtTimer2eventEng_set_1_empty_n = ap_const_logic_0)));
    end process;


    ap_block_state2_pp0_stage0_iter1_assign_proc : process(probeTimer2eventEng_1_empty_n, ap_predicate_op9_read_state2)
    begin
                ap_block_state2_pp0_stage0_iter1 <= ((probeTimer2eventEng_1_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state2 = ap_const_boolean_1));
    end process;


    ap_block_state3_pp0_stage0_iter2_assign_proc : process(timer2eventEng_setEv_1_full_n, tmp_reg_63_pp0_iter1_reg, ap_predicate_op14_write_state3)
    begin
                ap_block_state3_pp0_stage0_iter2 <= (((tmp_reg_63_pp0_iter1_reg = ap_const_lv1_1) and (timer2eventEng_setEv_1_full_n = ap_const_logic_0)) or ((timer2eventEng_setEv_1_full_n = ap_const_logic_0) and (ap_predicate_op14_write_state3 = ap_const_boolean_1)));
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


    ap_predicate_op14_write_state3_assign_proc : process(tmp_reg_63_pp0_iter1_reg, tmp_72_reg_72)
    begin
                ap_predicate_op14_write_state3 <= ((tmp_reg_63_pp0_iter1_reg = ap_const_lv1_0) and (tmp_72_reg_72 = ap_const_lv1_1));
    end process;


    ap_predicate_op9_read_state2_assign_proc : process(tmp_reg_63, tmp_72_nbreadreq_fu_42_p3)
    begin
                ap_predicate_op9_read_state2 <= ((tmp_reg_63 = ap_const_lv1_0) and (tmp_72_nbreadreq_fu_42_p3 = ap_const_lv1_1));
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


    probeTimer2eventEng_1_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, probeTimer2eventEng_1_empty_n, ap_predicate_op9_read_state2, ap_block_pp0_stage0)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op9_read_state2 = ap_const_boolean_1))) then 
            probeTimer2eventEng_1_blk_n <= probeTimer2eventEng_1_empty_n;
        else 
            probeTimer2eventEng_1_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    probeTimer2eventEng_1_read_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_predicate_op9_read_state2, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op9_read_state2 = ap_const_boolean_1))) then 
            probeTimer2eventEng_1_read <= ap_const_logic_1;
        else 
            probeTimer2eventEng_1_read <= ap_const_logic_0;
        end if; 
    end process;


    rtTimer2eventEng_set_1_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_pp0_stage0, rtTimer2eventEng_set_1_empty_n, tmp_nbreadreq_fu_28_p3, ap_block_pp0_stage0)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (tmp_nbreadreq_fu_28_p3 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            rtTimer2eventEng_set_1_blk_n <= rtTimer2eventEng_set_1_empty_n;
        else 
            rtTimer2eventEng_set_1_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    rtTimer2eventEng_set_1_read_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, tmp_nbreadreq_fu_28_p3, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_nbreadreq_fu_28_p3 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            rtTimer2eventEng_set_1_read <= ap_const_logic_1;
        else 
            rtTimer2eventEng_set_1_read <= ap_const_logic_0;
        end if; 
    end process;


    timer2eventEng_setEv_1_blk_n_assign_proc : process(ap_enable_reg_pp0_iter2, timer2eventEng_setEv_1_full_n, tmp_reg_63_pp0_iter1_reg, ap_predicate_op14_write_state3, ap_block_pp0_stage0)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage0) and (tmp_reg_63_pp0_iter1_reg = ap_const_lv1_1) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)) or ((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_predicate_op14_write_state3 = ap_const_boolean_1)))) then 
            timer2eventEng_setEv_1_blk_n <= timer2eventEng_setEv_1_full_n;
        else 
            timer2eventEng_setEv_1_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    timer2eventEng_setEv_1_din_assign_proc : process(ap_enable_reg_pp0_iter2, tmp_reg_63_pp0_iter1_reg, ap_predicate_op14_write_state3, tmp98_reg_67_pp0_iter1_reg, tmp_2_reg_76, ap_block_pp0_stage0_01001)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_01001))) then
            if ((tmp_reg_63_pp0_iter1_reg = ap_const_lv1_1)) then 
                timer2eventEng_setEv_1_din <= tmp98_reg_67_pp0_iter1_reg;
            elsif ((ap_predicate_op14_write_state3 = ap_const_boolean_1)) then 
                timer2eventEng_setEv_1_din <= tmp_2_reg_76;
            else 
                timer2eventEng_setEv_1_din <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
            end if;
        else 
            timer2eventEng_setEv_1_din <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;


    timer2eventEng_setEv_1_write_assign_proc : process(ap_enable_reg_pp0_iter2, tmp_reg_63_pp0_iter1_reg, ap_predicate_op14_write_state3, ap_block_pp0_stage0_11001)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_reg_63_pp0_iter1_reg = ap_const_lv1_1) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)) or ((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_predicate_op14_write_state3 = ap_const_boolean_1)))) then 
            timer2eventEng_setEv_1_write <= ap_const_logic_1;
        else 
            timer2eventEng_setEv_1_write <= ap_const_logic_0;
        end if; 
    end process;

    tmp_72_nbreadreq_fu_42_p3 <= (0=>(probeTimer2eventEng_1_empty_n), others=>'-');
    tmp_nbreadreq_fu_28_p3 <= (0=>(rtTimer2eventEng_set_1_empty_n), others=>'-');
end behav;
