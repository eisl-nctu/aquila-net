-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2019.1
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity insert_checksum_64_s is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    txEng_tcpPkgBuffer4_s_5_dout : IN STD_LOGIC_VECTOR (72 downto 0);
    txEng_tcpPkgBuffer4_s_5_empty_n : IN STD_LOGIC;
    txEng_tcpPkgBuffer4_s_5_read : OUT STD_LOGIC;
    txEng_tcpPkgBuffer5_s_4_din : OUT STD_LOGIC_VECTOR (72 downto 0);
    txEng_tcpPkgBuffer5_s_4_full_n : IN STD_LOGIC;
    txEng_tcpPkgBuffer5_s_4_write : OUT STD_LOGIC;
    txEng_tcpChecksumFif_1_dout : IN STD_LOGIC_VECTOR (15 downto 0);
    txEng_tcpChecksumFif_1_empty_n : IN STD_LOGIC;
    txEng_tcpChecksumFif_1_read : OUT STD_LOGIC );
end;


architecture behav of insert_checksum_64_s is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv2_1 : STD_LOGIC_VECTOR (1 downto 0) := "01";
    constant ap_const_lv2_2 : STD_LOGIC_VECTOR (1 downto 0) := "10";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv32_48 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001001000";
    constant ap_const_lv32_8 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001000";
    constant ap_const_lv32_F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001111";
    constant ap_const_lv32_40 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001000000";
    constant ap_const_lv3_1 : STD_LOGIC_VECTOR (2 downto 0) := "001";
    constant ap_const_lv3_2 : STD_LOGIC_VECTOR (2 downto 0) := "010";

    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal state_V_1 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    signal wordCount_V : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal txEng_tcpPkgBuffer4_s_5_blk_n : STD_LOGIC;
    signal grp_nbreadreq_fu_66_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_234_nbreadreq_fu_88_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal txEng_tcpPkgBuffer5_s_4_blk_n : STD_LOGIC;
    signal txEng_tcpChecksumFif_1_blk_n : STD_LOGIC;
    signal ap_phi_mux_wordCount_V_new_0_i_phi_fu_105_p4 : STD_LOGIC_VECTOR (2 downto 0);
    signal ap_predicate_op9_read_state1 : BOOLEAN;
    signal ap_predicate_op11_write_state1 : BOOLEAN;
    signal ap_predicate_op21_read_state1 : BOOLEAN;
    signal ap_predicate_op22_read_state1 : BOOLEAN;
    signal ap_predicate_op31_write_state1 : BOOLEAN;
    signal ap_predicate_op38_read_state1 : BOOLEAN;
    signal ap_predicate_op39_write_state1 : BOOLEAN;
    signal ap_block_state1 : BOOLEAN;
    signal icmp_ln879_fu_212_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal add_ln700_fu_205_p2 : STD_LOGIC_VECTOR (2 downto 0);
    signal grp_fu_112_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal select_ln1570_fu_187_p3 : STD_LOGIC_VECTOR (1 downto 0);
    signal tmp_3_fu_178_p3 : STD_LOGIC_VECTOR (72 downto 0);
    signal trunc_ln647_fu_144_p1 : STD_LOGIC_VECTOR (7 downto 0);
    signal p_Result_126_i_i_fu_134_p4 : STD_LOGIC_VECTOR (7 downto 0);
    signal p_Val2_54_fu_130_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal agg_result_V_0_1_i_i_fu_148_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal tmp_133_i_fu_168_p4 : STD_LOGIC_VECTOR (8 downto 0);
    signal p_Result_s_fu_156_p5 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_condition_49 : BOOLEAN;
    signal ap_condition_204 : BOOLEAN;


begin




    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
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
                elsif ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    state_V_1_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_boolean_1 = ap_condition_204)) then
                if (((icmp_ln879_fu_212_p2 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_0))) then 
                    state_V_1 <= ap_const_lv2_1;
                elsif (((tmp_234_nbreadreq_fu_88_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_1))) then 
                    state_V_1 <= select_ln1570_fu_187_p3;
                elsif (((grp_fu_112_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_2))) then 
                    state_V_1 <= ap_const_lv2_0;
                end if;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) and (grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                wordCount_V <= ap_phi_mux_wordCount_V_new_0_i_phi_fu_105_p4;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, txEng_tcpPkgBuffer4_s_5_empty_n, txEng_tcpPkgBuffer5_s_4_full_n, txEng_tcpChecksumFif_1_empty_n, ap_predicate_op9_read_state1, ap_predicate_op11_write_state1, ap_predicate_op21_read_state1, ap_predicate_op22_read_state1, ap_predicate_op31_write_state1, ap_predicate_op38_read_state1, ap_predicate_op39_write_state1)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    add_ln700_fu_205_p2 <= std_logic_vector(unsigned(wordCount_V) + unsigned(ap_const_lv3_1));
    agg_result_V_0_1_i_i_fu_148_p3 <= (trunc_ln647_fu_144_p1 & p_Result_126_i_i_fu_134_p4);
    ap_CS_fsm_state1 <= ap_CS_fsm(0);

    ap_block_state1_assign_proc : process(ap_start, ap_done_reg, txEng_tcpPkgBuffer4_s_5_empty_n, txEng_tcpPkgBuffer5_s_4_full_n, txEng_tcpChecksumFif_1_empty_n, ap_predicate_op9_read_state1, ap_predicate_op11_write_state1, ap_predicate_op21_read_state1, ap_predicate_op22_read_state1, ap_predicate_op31_write_state1, ap_predicate_op38_read_state1, ap_predicate_op39_write_state1)
    begin
                ap_block_state1 <= ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)));
    end process;


    ap_condition_204_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, txEng_tcpPkgBuffer4_s_5_empty_n, txEng_tcpPkgBuffer5_s_4_full_n, txEng_tcpChecksumFif_1_empty_n, grp_nbreadreq_fu_66_p3, ap_predicate_op9_read_state1, ap_predicate_op11_write_state1, ap_predicate_op21_read_state1, ap_predicate_op22_read_state1, ap_predicate_op31_write_state1, ap_predicate_op38_read_state1, ap_predicate_op39_write_state1)
    begin
                ap_condition_204 <= (not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) and (grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state1));
    end process;


    ap_condition_49_assign_proc : process(ap_CS_fsm_state1, state_V_1, grp_nbreadreq_fu_66_p3)
    begin
                ap_condition_49 <= ((grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_0) and (ap_const_logic_1 = ap_CS_fsm_state1));
    end process;


    ap_done_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, txEng_tcpPkgBuffer4_s_5_empty_n, txEng_tcpPkgBuffer5_s_4_full_n, txEng_tcpChecksumFif_1_empty_n, ap_predicate_op9_read_state1, ap_predicate_op11_write_state1, ap_predicate_op21_read_state1, ap_predicate_op22_read_state1, ap_predicate_op31_write_state1, ap_predicate_op38_read_state1, ap_predicate_op39_write_state1)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_done_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_phi_mux_wordCount_V_new_0_i_phi_fu_105_p4_assign_proc : process(icmp_ln879_fu_212_p2, add_ln700_fu_205_p2, ap_condition_49)
    begin
        if ((ap_const_boolean_1 = ap_condition_49)) then
            if ((icmp_ln879_fu_212_p2 = ap_const_lv1_0)) then 
                ap_phi_mux_wordCount_V_new_0_i_phi_fu_105_p4 <= add_ln700_fu_205_p2;
            elsif ((icmp_ln879_fu_212_p2 = ap_const_lv1_1)) then 
                ap_phi_mux_wordCount_V_new_0_i_phi_fu_105_p4 <= ap_const_lv3_0;
            else 
                ap_phi_mux_wordCount_V_new_0_i_phi_fu_105_p4 <= "XXX";
            end if;
        else 
            ap_phi_mux_wordCount_V_new_0_i_phi_fu_105_p4 <= "XXX";
        end if; 
    end process;


    ap_predicate_op11_write_state1_assign_proc : process(state_V_1, grp_nbreadreq_fu_66_p3)
    begin
                ap_predicate_op11_write_state1 <= ((grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_2));
    end process;


    ap_predicate_op21_read_state1_assign_proc : process(state_V_1, grp_nbreadreq_fu_66_p3, tmp_234_nbreadreq_fu_88_p3)
    begin
                ap_predicate_op21_read_state1 <= ((tmp_234_nbreadreq_fu_88_p3 = ap_const_lv1_1) and (grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_1));
    end process;


    ap_predicate_op22_read_state1_assign_proc : process(state_V_1, grp_nbreadreq_fu_66_p3, tmp_234_nbreadreq_fu_88_p3)
    begin
                ap_predicate_op22_read_state1 <= ((tmp_234_nbreadreq_fu_88_p3 = ap_const_lv1_1) and (grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_1));
    end process;


    ap_predicate_op31_write_state1_assign_proc : process(state_V_1, grp_nbreadreq_fu_66_p3, tmp_234_nbreadreq_fu_88_p3)
    begin
                ap_predicate_op31_write_state1 <= ((tmp_234_nbreadreq_fu_88_p3 = ap_const_lv1_1) and (grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_1));
    end process;


    ap_predicate_op38_read_state1_assign_proc : process(state_V_1, grp_nbreadreq_fu_66_p3)
    begin
                ap_predicate_op38_read_state1 <= ((grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_0));
    end process;


    ap_predicate_op39_write_state1_assign_proc : process(state_V_1, grp_nbreadreq_fu_66_p3)
    begin
                ap_predicate_op39_write_state1 <= ((grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_0));
    end process;


    ap_predicate_op9_read_state1_assign_proc : process(state_V_1, grp_nbreadreq_fu_66_p3)
    begin
                ap_predicate_op9_read_state1 <= ((grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_2));
    end process;


    ap_ready_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, txEng_tcpPkgBuffer4_s_5_empty_n, txEng_tcpPkgBuffer5_s_4_full_n, txEng_tcpChecksumFif_1_empty_n, ap_predicate_op9_read_state1, ap_predicate_op11_write_state1, ap_predicate_op21_read_state1, ap_predicate_op22_read_state1, ap_predicate_op31_write_state1, ap_predicate_op38_read_state1, ap_predicate_op39_write_state1)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_112_p3 <= txEng_tcpPkgBuffer4_s_5_dout(72 downto 72);
    grp_nbreadreq_fu_66_p3 <= (0=>(txEng_tcpPkgBuffer4_s_5_empty_n), others=>'-');
    icmp_ln879_fu_212_p2 <= "1" when (add_ln700_fu_205_p2 = ap_const_lv3_2) else "0";
    p_Result_126_i_i_fu_134_p4 <= txEng_tcpChecksumFif_1_dout(15 downto 8);
    p_Result_s_fu_156_p5 <= (p_Val2_54_fu_130_p1(63 downto 16) & agg_result_V_0_1_i_i_fu_148_p3);
    p_Val2_54_fu_130_p1 <= txEng_tcpPkgBuffer4_s_5_dout(64 - 1 downto 0);
    select_ln1570_fu_187_p3 <= 
        ap_const_lv2_0 when (grp_fu_112_p3(0) = '1') else 
        ap_const_lv2_2;
    tmp_133_i_fu_168_p4 <= txEng_tcpPkgBuffer4_s_5_dout(72 downto 64);
    tmp_234_nbreadreq_fu_88_p3 <= (0=>(txEng_tcpChecksumFif_1_empty_n), others=>'-');
    tmp_3_fu_178_p3 <= (tmp_133_i_fu_168_p4 & p_Result_s_fu_156_p5);
    trunc_ln647_fu_144_p1 <= txEng_tcpChecksumFif_1_dout(8 - 1 downto 0);

    txEng_tcpChecksumFif_1_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, state_V_1, txEng_tcpChecksumFif_1_empty_n, grp_nbreadreq_fu_66_p3, tmp_234_nbreadreq_fu_88_p3)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (tmp_234_nbreadreq_fu_88_p3 = ap_const_lv1_1) and (grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            txEng_tcpChecksumFif_1_blk_n <= txEng_tcpChecksumFif_1_empty_n;
        else 
            txEng_tcpChecksumFif_1_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    txEng_tcpChecksumFif_1_read_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, txEng_tcpPkgBuffer4_s_5_empty_n, txEng_tcpPkgBuffer5_s_4_full_n, txEng_tcpChecksumFif_1_empty_n, ap_predicate_op9_read_state1, ap_predicate_op11_write_state1, ap_predicate_op21_read_state1, ap_predicate_op22_read_state1, ap_predicate_op31_write_state1, ap_predicate_op38_read_state1, ap_predicate_op39_write_state1)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_predicate_op21_read_state1 = ap_const_boolean_1))) then 
            txEng_tcpChecksumFif_1_read <= ap_const_logic_1;
        else 
            txEng_tcpChecksumFif_1_read <= ap_const_logic_0;
        end if; 
    end process;


    txEng_tcpPkgBuffer4_s_5_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, state_V_1, txEng_tcpPkgBuffer4_s_5_empty_n, grp_nbreadreq_fu_66_p3, tmp_234_nbreadreq_fu_88_p3)
    begin
        if (((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_2) and (ap_const_logic_1 = ap_CS_fsm_state1)) or (not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (tmp_234_nbreadreq_fu_88_p3 = ap_const_lv1_1) and (grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_1) and (ap_const_logic_1 = ap_CS_fsm_state1)) or (not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_0) and (ap_const_logic_1 = ap_CS_fsm_state1)))) then 
            txEng_tcpPkgBuffer4_s_5_blk_n <= txEng_tcpPkgBuffer4_s_5_empty_n;
        else 
            txEng_tcpPkgBuffer4_s_5_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    txEng_tcpPkgBuffer4_s_5_read_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, txEng_tcpPkgBuffer4_s_5_empty_n, txEng_tcpPkgBuffer5_s_4_full_n, txEng_tcpChecksumFif_1_empty_n, ap_predicate_op9_read_state1, ap_predicate_op11_write_state1, ap_predicate_op21_read_state1, ap_predicate_op22_read_state1, ap_predicate_op31_write_state1, ap_predicate_op38_read_state1, ap_predicate_op39_write_state1)
    begin
        if (((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or (not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or (not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) then 
            txEng_tcpPkgBuffer4_s_5_read <= ap_const_logic_1;
        else 
            txEng_tcpPkgBuffer4_s_5_read <= ap_const_logic_0;
        end if; 
    end process;


    txEng_tcpPkgBuffer5_s_4_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, state_V_1, txEng_tcpPkgBuffer5_s_4_full_n, grp_nbreadreq_fu_66_p3, tmp_234_nbreadreq_fu_88_p3)
    begin
        if (((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_2) and (ap_const_logic_1 = ap_CS_fsm_state1)) or (not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (tmp_234_nbreadreq_fu_88_p3 = ap_const_lv1_1) and (grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_1) and (ap_const_logic_1 = ap_CS_fsm_state1)) or (not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (grp_nbreadreq_fu_66_p3 = ap_const_lv1_1) and (state_V_1 = ap_const_lv2_0) and (ap_const_logic_1 = ap_CS_fsm_state1)))) then 
            txEng_tcpPkgBuffer5_s_4_blk_n <= txEng_tcpPkgBuffer5_s_4_full_n;
        else 
            txEng_tcpPkgBuffer5_s_4_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    txEng_tcpPkgBuffer5_s_4_din_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, txEng_tcpPkgBuffer4_s_5_dout, txEng_tcpPkgBuffer4_s_5_empty_n, txEng_tcpPkgBuffer5_s_4_full_n, txEng_tcpChecksumFif_1_empty_n, ap_predicate_op9_read_state1, ap_predicate_op11_write_state1, ap_predicate_op21_read_state1, ap_predicate_op22_read_state1, ap_predicate_op31_write_state1, ap_predicate_op38_read_state1, ap_predicate_op39_write_state1, tmp_3_fu_178_p3)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_predicate_op31_write_state1 = ap_const_boolean_1))) then 
            txEng_tcpPkgBuffer5_s_4_din <= tmp_3_fu_178_p3;
        elsif (((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or (not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)))) then 
            txEng_tcpPkgBuffer5_s_4_din <= txEng_tcpPkgBuffer4_s_5_dout;
        else 
            txEng_tcpPkgBuffer5_s_4_din <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;


    txEng_tcpPkgBuffer5_s_4_write_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, txEng_tcpPkgBuffer4_s_5_empty_n, txEng_tcpPkgBuffer5_s_4_full_n, txEng_tcpChecksumFif_1_empty_n, ap_predicate_op9_read_state1, ap_predicate_op11_write_state1, ap_predicate_op21_read_state1, ap_predicate_op22_read_state1, ap_predicate_op31_write_state1, ap_predicate_op38_read_state1, ap_predicate_op39_write_state1)
    begin
        if (((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or (not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or (not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((txEng_tcpChecksumFif_1_empty_n = ap_const_logic_0) and (ap_predicate_op21_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op39_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op31_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer5_s_4_full_n = ap_const_logic_0) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op38_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op22_read_state1 = ap_const_boolean_1)) or ((txEng_tcpPkgBuffer4_s_5_empty_n = ap_const_logic_0) and (ap_predicate_op9_read_state1 = ap_const_boolean_1)))) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_predicate_op11_write_state1 = ap_const_boolean_1)))) then 
            txEng_tcpPkgBuffer5_s_4_write <= ap_const_logic_1;
        else 
            txEng_tcpPkgBuffer5_s_4_write <= ap_const_logic_0;
        end if; 
    end process;

end behav;