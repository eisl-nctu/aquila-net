-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2019.1
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rshiftWordByOctet is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    txEng_tcpPkgBuffer3_s_6_dout : IN STD_LOGIC_VECTOR (72 downto 0);
    txEng_tcpPkgBuffer3_s_6_empty_n : IN STD_LOGIC;
    txEng_tcpPkgBuffer3_s_6_read : OUT STD_LOGIC;
    txEng_tcpPkgBuffer4_s_5_din : OUT STD_LOGIC_VECTOR (72 downto 0);
    txEng_tcpPkgBuffer4_s_5_full_n : IN STD_LOGIC;
    txEng_tcpPkgBuffer4_s_5_write : OUT STD_LOGIC );
end;


architecture behav of rshiftWordByOctet is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv32_20 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000100000";
    constant ap_const_lv32_3F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000111111";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv32_7 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000111";
    constant ap_const_lv32_40 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001000000";
    constant ap_const_lv32_47 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001000111";
    constant ap_const_lv32_48 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001001000";
    constant ap_const_lv32_43 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001000011";
    constant ap_const_lv32_44 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001000100";
    constant ap_const_lv4_0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    constant ap_const_lv5_10 : STD_LOGIC_VECTOR (4 downto 0) := "10000";

    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_idle_pp0 : STD_LOGIC;
    signal fsmState_load_load_fu_137_p1 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_nbreadreq_fu_76_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_predicate_op7_read_state1 : BOOLEAN;
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal fsmState_load_reg_261 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_reg_265 : STD_LOGIC_VECTOR (0 downto 0);
    signal rs_firstWord_load_reg_283 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_predicate_op34_write_state2 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal fsmState : STD_LOGIC_VECTOR (0 downto 0) := "0";
    signal prevWord_data_V_8 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
    signal prevWord_keep_V_7 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    signal rs_firstWord : STD_LOGIC_VECTOR (0 downto 0) := "1";
    signal txEng_tcpPkgBuffer3_s_6_blk_n : STD_LOGIC;
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal txEng_tcpPkgBuffer4_s_5_blk_n : STD_LOGIC;
    signal p_Val2_20_fu_141_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal p_Val2_20_reg_269 : STD_LOGIC_VECTOR (63 downto 0);
    signal p_Val2_2_reg_274 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_135_fu_155_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal rs_firstWord_load_load_fu_163_p1 : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln647_fu_167_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal trunc_ln647_reg_287 : STD_LOGIC_VECTOR (31 downto 0);
    signal p_Result_19_i_reg_292 : STD_LOGIC_VECTOR (3 downto 0);
    signal tmp_last_V_fu_191_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_last_V_reg_297 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_phi_mux_p_0256_2_0_i_phi_fu_100_p4 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_phi_reg_pp0_iter0_p_0256_2_0_i_reg_97 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_phi_mux_rs_firstWord_new_0_i_phi_fu_111_p4 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_phi_reg_pp0_iter0_rs_firstWord_new_0_i_reg_108 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_1_fu_226_p6 : STD_LOGIC_VECTOR (72 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal tmp_2_fu_248_p5 : STD_LOGIC_VECTOR (72 downto 0);
    signal p_Result_20_i_fu_181_p4 : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_fu_128_p4 : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_fu_119_p4 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_idle_pp0_0to0 : STD_LOGIC;
    signal ap_reset_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_condition_161 : BOOLEAN;
    signal ap_condition_148 : BOOLEAN;
    signal ap_condition_81 : BOOLEAN;
    signal ap_condition_169 : BOOLEAN;


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
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
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


    fsmState_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_boolean_1 = ap_condition_81)) then
                if ((fsmState_load_load_fu_137_p1 = ap_const_lv1_1)) then 
                    fsmState <= ap_const_lv1_0;
                elsif ((ap_const_boolean_1 = ap_condition_148)) then 
                    fsmState <= ap_const_lv1_1;
                end if;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                fsmState_load_reg_261 <= fsmState;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_nbreadreq_fu_76_p3 = ap_const_lv1_1) and (rs_firstWord_load_load_fu_163_p1 = ap_const_lv1_0) and (fsmState = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                p_Result_19_i_reg_292 <= txEng_tcpPkgBuffer3_s_6_dout(67 downto 64);
                tmp_last_V_reg_297 <= tmp_last_V_fu_191_p2;
                trunc_ln647_reg_287 <= trunc_ln647_fu_167_p1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_nbreadreq_fu_76_p3 = ap_const_lv1_1) and (fsmState = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                p_Val2_20_reg_269 <= p_Val2_20_fu_141_p1;
                p_Val2_2_reg_274 <= txEng_tcpPkgBuffer3_s_6_dout(71 downto 64);
                rs_firstWord_load_reg_283 <= rs_firstWord;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_reg_265 = ap_const_lv1_1) and (fsmState_load_reg_261 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                prevWord_data_V_8 <= p_Val2_20_reg_269;
                prevWord_keep_V_7 <= p_Val2_2_reg_274;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_nbreadreq_fu_76_p3 = ap_const_lv1_1) and (fsmState = ap_const_lv1_0) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                rs_firstWord <= ap_phi_mux_rs_firstWord_new_0_i_phi_fu_111_p4;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (fsmState = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                tmp_reg_265 <= tmp_nbreadreq_fu_76_p3;
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

    ap_block_pp0_stage0_01001_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, txEng_tcpPkgBuffer3_s_6_empty_n, ap_predicate_op7_read_state1, txEng_tcpPkgBuffer4_s_5_full_n, fsmState_load_reg_261, ap_predicate_op34_write_state2)
    begin
                ap_block_pp0_stage0_01001 <= ((ap_done_reg = ap_const_logic_1) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (((fsmState_load_reg_261 = ap_const_lv1_1) and (txEng_tcpPkgBuffer4_s_5_full_n = ap_const_logic_0)) or ((txEng_tcpPkgBuffer4_s_5_full_n = ap_const_logic_0) and (ap_predicate_op34_write_state2 = ap_const_boolean_1)))) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpPkgBuffer3_s_6_empty_n = ap_const_logic_0) and (ap_predicate_op7_read_state1 = ap_const_boolean_1)))));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, txEng_tcpPkgBuffer3_s_6_empty_n, ap_predicate_op7_read_state1, txEng_tcpPkgBuffer4_s_5_full_n, fsmState_load_reg_261, ap_predicate_op34_write_state2)
    begin
                ap_block_pp0_stage0_11001 <= ((ap_done_reg = ap_const_logic_1) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (((fsmState_load_reg_261 = ap_const_lv1_1) and (txEng_tcpPkgBuffer4_s_5_full_n = ap_const_logic_0)) or ((txEng_tcpPkgBuffer4_s_5_full_n = ap_const_logic_0) and (ap_predicate_op34_write_state2 = ap_const_boolean_1)))) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpPkgBuffer3_s_6_empty_n = ap_const_logic_0) and (ap_predicate_op7_read_state1 = ap_const_boolean_1)))));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, txEng_tcpPkgBuffer3_s_6_empty_n, ap_predicate_op7_read_state1, txEng_tcpPkgBuffer4_s_5_full_n, fsmState_load_reg_261, ap_predicate_op34_write_state2)
    begin
                ap_block_pp0_stage0_subdone <= ((ap_done_reg = ap_const_logic_1) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (((fsmState_load_reg_261 = ap_const_lv1_1) and (txEng_tcpPkgBuffer4_s_5_full_n = ap_const_logic_0)) or ((txEng_tcpPkgBuffer4_s_5_full_n = ap_const_logic_0) and (ap_predicate_op34_write_state2 = ap_const_boolean_1)))) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpPkgBuffer3_s_6_empty_n = ap_const_logic_0) and (ap_predicate_op7_read_state1 = ap_const_boolean_1)))));
    end process;


    ap_block_state1_pp0_stage0_iter0_assign_proc : process(ap_start, ap_done_reg, txEng_tcpPkgBuffer3_s_6_empty_n, ap_predicate_op7_read_state1)
    begin
                ap_block_state1_pp0_stage0_iter0 <= ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpPkgBuffer3_s_6_empty_n = ap_const_logic_0) and (ap_predicate_op7_read_state1 = ap_const_boolean_1)));
    end process;


    ap_block_state2_pp0_stage0_iter1_assign_proc : process(txEng_tcpPkgBuffer4_s_5_full_n, fsmState_load_reg_261, ap_predicate_op34_write_state2)
    begin
                ap_block_state2_pp0_stage0_iter1 <= (((fsmState_load_reg_261 = ap_const_lv1_1) and (txEng_tcpPkgBuffer4_s_5_full_n = ap_const_logic_0)) or ((txEng_tcpPkgBuffer4_s_5_full_n = ap_const_logic_0) and (ap_predicate_op34_write_state2 = ap_const_boolean_1)));
    end process;


    ap_condition_148_assign_proc : process(tmp_nbreadreq_fu_76_p3, fsmState, tmp_135_fu_155_p3, ap_phi_mux_p_0256_2_0_i_phi_fu_100_p4)
    begin
                ap_condition_148 <= ((tmp_135_fu_155_p3 = ap_const_lv1_1) and (tmp_nbreadreq_fu_76_p3 = ap_const_lv1_1) and (ap_phi_mux_p_0256_2_0_i_phi_fu_100_p4 = ap_const_lv1_0) and (fsmState = ap_const_lv1_0));
    end process;


    ap_condition_161_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, tmp_nbreadreq_fu_76_p3, fsmState, ap_block_pp0_stage0)
    begin
                ap_condition_161 <= ((ap_const_boolean_0 = ap_block_pp0_stage0) and (tmp_nbreadreq_fu_76_p3 = ap_const_lv1_1) and (fsmState = ap_const_lv1_0) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0));
    end process;


    ap_condition_169_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0_01001)
    begin
                ap_condition_169 <= ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_01001));
    end process;


    ap_condition_81_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001)
    begin
                ap_condition_81 <= ((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0));
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
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


    ap_phi_mux_p_0256_2_0_i_phi_fu_100_p4_assign_proc : process(rs_firstWord_load_load_fu_163_p1, tmp_last_V_fu_191_p2, ap_phi_reg_pp0_iter0_p_0256_2_0_i_reg_97, ap_condition_161)
    begin
        if ((ap_const_boolean_1 = ap_condition_161)) then
            if ((rs_firstWord_load_load_fu_163_p1 = ap_const_lv1_1)) then 
                ap_phi_mux_p_0256_2_0_i_phi_fu_100_p4 <= ap_const_lv1_0;
            elsif ((rs_firstWord_load_load_fu_163_p1 = ap_const_lv1_0)) then 
                ap_phi_mux_p_0256_2_0_i_phi_fu_100_p4 <= tmp_last_V_fu_191_p2;
            else 
                ap_phi_mux_p_0256_2_0_i_phi_fu_100_p4 <= ap_phi_reg_pp0_iter0_p_0256_2_0_i_reg_97;
            end if;
        else 
            ap_phi_mux_p_0256_2_0_i_phi_fu_100_p4 <= ap_phi_reg_pp0_iter0_p_0256_2_0_i_reg_97;
        end if; 
    end process;


    ap_phi_mux_rs_firstWord_new_0_i_phi_fu_111_p4_assign_proc : process(tmp_135_fu_155_p3, ap_phi_reg_pp0_iter0_rs_firstWord_new_0_i_reg_108, ap_condition_161)
    begin
        if ((ap_const_boolean_1 = ap_condition_161)) then
            if ((tmp_135_fu_155_p3 = ap_const_lv1_0)) then 
                ap_phi_mux_rs_firstWord_new_0_i_phi_fu_111_p4 <= ap_const_lv1_0;
            elsif ((tmp_135_fu_155_p3 = ap_const_lv1_1)) then 
                ap_phi_mux_rs_firstWord_new_0_i_phi_fu_111_p4 <= ap_const_lv1_1;
            else 
                ap_phi_mux_rs_firstWord_new_0_i_phi_fu_111_p4 <= ap_phi_reg_pp0_iter0_rs_firstWord_new_0_i_reg_108;
            end if;
        else 
            ap_phi_mux_rs_firstWord_new_0_i_phi_fu_111_p4 <= ap_phi_reg_pp0_iter0_rs_firstWord_new_0_i_reg_108;
        end if; 
    end process;

    ap_phi_reg_pp0_iter0_p_0256_2_0_i_reg_97 <= "X";
    ap_phi_reg_pp0_iter0_rs_firstWord_new_0_i_reg_108 <= "X";

    ap_predicate_op34_write_state2_assign_proc : process(fsmState_load_reg_261, tmp_reg_265, rs_firstWord_load_reg_283)
    begin
                ap_predicate_op34_write_state2 <= ((tmp_reg_265 = ap_const_lv1_1) and (rs_firstWord_load_reg_283 = ap_const_lv1_0) and (fsmState_load_reg_261 = ap_const_lv1_0));
    end process;


    ap_predicate_op7_read_state1_assign_proc : process(tmp_nbreadreq_fu_76_p3, fsmState)
    begin
                ap_predicate_op7_read_state1 <= ((tmp_nbreadreq_fu_76_p3 = ap_const_lv1_1) and (fsmState = ap_const_lv1_0));
    end process;


    ap_ready_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
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

    fsmState_load_load_fu_137_p1 <= fsmState;
    grp_fu_119_p4 <= prevWord_data_V_8(63 downto 32);
    grp_fu_128_p4 <= prevWord_keep_V_7(7 downto 4);
    p_Result_20_i_fu_181_p4 <= txEng_tcpPkgBuffer3_s_6_dout(71 downto 68);
    p_Val2_20_fu_141_p1 <= txEng_tcpPkgBuffer3_s_6_dout(64 - 1 downto 0);
    rs_firstWord_load_load_fu_163_p1 <= rs_firstWord;
    tmp_135_fu_155_p3 <= txEng_tcpPkgBuffer3_s_6_dout(72 downto 72);
    tmp_1_fu_226_p6 <= ((((tmp_last_V_reg_297 & p_Result_19_i_reg_292) & grp_fu_128_p4) & trunc_ln647_reg_287) & grp_fu_119_p4);
    tmp_2_fu_248_p5 <= (((ap_const_lv5_10 & grp_fu_128_p4) & ap_const_lv32_0) & grp_fu_119_p4);
    tmp_last_V_fu_191_p2 <= "1" when (p_Result_20_i_fu_181_p4 = ap_const_lv4_0) else "0";
    tmp_nbreadreq_fu_76_p3 <= (0=>(txEng_tcpPkgBuffer3_s_6_empty_n), others=>'-');
    trunc_ln647_fu_167_p1 <= txEng_tcpPkgBuffer3_s_6_dout(32 - 1 downto 0);

    txEng_tcpPkgBuffer3_s_6_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_pp0_stage0, txEng_tcpPkgBuffer3_s_6_empty_n, ap_predicate_op7_read_state1, ap_block_pp0_stage0)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op7_read_state1 = ap_const_boolean_1))) then 
            txEng_tcpPkgBuffer3_s_6_blk_n <= txEng_tcpPkgBuffer3_s_6_empty_n;
        else 
            txEng_tcpPkgBuffer3_s_6_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    txEng_tcpPkgBuffer3_s_6_read_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_predicate_op7_read_state1, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op7_read_state1 = ap_const_boolean_1))) then 
            txEng_tcpPkgBuffer3_s_6_read <= ap_const_logic_1;
        else 
            txEng_tcpPkgBuffer3_s_6_read <= ap_const_logic_0;
        end if; 
    end process;


    txEng_tcpPkgBuffer4_s_5_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, txEng_tcpPkgBuffer4_s_5_full_n, fsmState_load_reg_261, ap_predicate_op34_write_state2, ap_block_pp0_stage0)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage0) and (fsmState_load_reg_261 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op34_write_state2 = ap_const_boolean_1)))) then 
            txEng_tcpPkgBuffer4_s_5_blk_n <= txEng_tcpPkgBuffer4_s_5_full_n;
        else 
            txEng_tcpPkgBuffer4_s_5_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    txEng_tcpPkgBuffer4_s_5_din_assign_proc : process(fsmState_load_reg_261, ap_predicate_op34_write_state2, tmp_1_fu_226_p6, tmp_2_fu_248_p5, ap_condition_169)
    begin
        if ((ap_const_boolean_1 = ap_condition_169)) then
            if ((fsmState_load_reg_261 = ap_const_lv1_1)) then 
                txEng_tcpPkgBuffer4_s_5_din <= tmp_2_fu_248_p5;
            elsif ((ap_predicate_op34_write_state2 = ap_const_boolean_1)) then 
                txEng_tcpPkgBuffer4_s_5_din <= tmp_1_fu_226_p6;
            else 
                txEng_tcpPkgBuffer4_s_5_din <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
            end if;
        else 
            txEng_tcpPkgBuffer4_s_5_din <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;


    txEng_tcpPkgBuffer4_s_5_write_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, fsmState_load_reg_261, ap_predicate_op34_write_state2, ap_block_pp0_stage0_11001)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (fsmState_load_reg_261 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_predicate_op34_write_state2 = ap_const_boolean_1)))) then 
            txEng_tcpPkgBuffer4_s_5_write <= ap_const_logic_1;
        else 
            txEng_tcpPkgBuffer4_s_5_write <= ap_const_logic_0;
        end if; 
    end process;

end behav;
