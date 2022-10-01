-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2019.1
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity detect_eth_protocol is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    s_axis_raw_TVALID : IN STD_LOGIC;
    ethDataFifo_V_data_V_din : OUT STD_LOGIC_VECTOR (63 downto 0);
    ethDataFifo_V_data_V_full_n : IN STD_LOGIC;
    ethDataFifo_V_data_V_write : OUT STD_LOGIC;
    ethDataFifo_V_keep_V_din : OUT STD_LOGIC_VECTOR (7 downto 0);
    ethDataFifo_V_keep_V_full_n : IN STD_LOGIC;
    ethDataFifo_V_keep_V_write : OUT STD_LOGIC;
    ethDataFifo_V_last_V_din : OUT STD_LOGIC_VECTOR (0 downto 0);
    ethDataFifo_V_last_V_full_n : IN STD_LOGIC;
    ethDataFifo_V_last_V_write : OUT STD_LOGIC;
    etherTypeFifo_V_V_din : OUT STD_LOGIC_VECTOR (15 downto 0);
    etherTypeFifo_V_V_full_n : IN STD_LOGIC;
    etherTypeFifo_V_V_write : OUT STD_LOGIC;
    s_axis_raw_TDATA : IN STD_LOGIC_VECTOR (63 downto 0);
    s_axis_raw_TREADY : OUT STD_LOGIC;
    s_axis_raw_TKEEP : IN STD_LOGIC_VECTOR (7 downto 0);
    s_axis_raw_TLAST : IN STD_LOGIC_VECTOR (0 downto 0) );
end;


architecture behav of detect_eth_protocol is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv16_0 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
    constant ap_const_lv6_0 : STD_LOGIC_VECTOR (5 downto 0) := "000000";
    constant ap_const_lv23_40 : STD_LOGIC_VECTOR (22 downto 0) := "00000000000000001000000";
    constant ap_const_lv23_70 : STD_LOGIC_VECTOR (22 downto 0) := "00000000000000001110000";
    constant ap_const_lv22_3F : STD_LOGIC_VECTOR (21 downto 0) := "0000000000000000111111";
    constant ap_const_lv22_6F : STD_LOGIC_VECTOR (21 downto 0) := "0000000000000001101111";
    constant ap_const_lv16_1 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000001";
    constant ap_const_lv7_6F : STD_LOGIC_VECTOR (6 downto 0) := "1101111";
    constant ap_const_lv32_6F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001101111";
    constant ap_const_lv112_FFFFFFFFFFFFFFFFFFFFFFFFFFFF : STD_LOGIC_VECTOR (111 downto 0) := "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111";
    constant ap_const_lv32_68 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001101000";
    constant ap_const_lv32_60 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001100000";
    constant ap_const_lv32_67 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001100111";

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
    signal tmp_nbreadreq_fu_92_p5 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal io_acc_block_signal_op61 : STD_LOGIC;
    signal tmp_reg_475 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal tmp_reg_475_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln54_reg_529 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_predicate_op75_write_state3 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal header_ready : STD_LOGIC_VECTOR (0 downto 0) := "0";
    signal header_idx_1 : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
    signal header_header_V_1 : STD_LOGIC_VECTOR (111 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    signal metaWritten_1 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    signal s_axis_raw_TDATA_blk_n : STD_LOGIC;
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal etherTypeFifo_V_V_blk_n : STD_LOGIC;
    signal ethDataFifo_V_data_V_blk_n : STD_LOGIC;
    signal ethDataFifo_V_keep_V_blk_n : STD_LOGIC;
    signal ethDataFifo_V_last_V_blk_n : STD_LOGIC;
    signal tmp_data_V_reg_479 : STD_LOGIC_VECTOR (63 downto 0);
    signal tmp_keep_V_reg_485 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_last_V_reg_490 : STD_LOGIC_VECTOR (0 downto 0);
    signal header_ready_load_load_fu_176_p1 : STD_LOGIC_VECTOR (0 downto 0);
    signal header_ready_load_reg_496 : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln58_fu_185_p1 : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln58_reg_500 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln58_2_fu_227_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln58_2_reg_505 : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln58_2_fu_233_p1 : STD_LOGIC_VECTOR (6 downto 0);
    signal trunc_ln58_2_reg_513 : STD_LOGIC_VECTOR (6 downto 0);
    signal or_ln73_fu_251_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln73_reg_519 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln62_fu_257_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln62_reg_524 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln54_fu_426_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln62_fu_432_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_phi_mux_phi_ln73_phi_fu_137_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_phi_reg_pp0_iter0_phi_ln73_reg_134 : STD_LOGIC_VECTOR (15 downto 0);
    signal add_ln67_fu_244_p2 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_phi_mux_write_flag_1_i_i_phi_fu_146_p4 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_phi_reg_pp0_iter0_write_flag_1_i_i_reg_143 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln58_fu_237_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_phi_mux_metaWritten_1_flag_0_phi_fu_156_p4 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_phi_reg_pp0_iter1_metaWritten_1_flag_0_reg_153 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln62_fu_263_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal select_ln62_fu_269_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal or_ln58_fu_405_p2 : STD_LOGIC_VECTOR (111 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal Lo_assign_fu_189_p3 : STD_LOGIC_VECTOR (21 downto 0);
    signal zext_ln58_fu_197_p1 : STD_LOGIC_VECTOR (22 downto 0);
    signal add_ln58_fu_201_p2 : STD_LOGIC_VECTOR (22 downto 0);
    signal icmp_ln58_fu_207_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln60_fu_213_p2 : STD_LOGIC_VECTOR (21 downto 0);
    signal select_ln58_fu_219_p3 : STD_LOGIC_VECTOR (21 downto 0);
    signal tmp_23_fu_296_p3 : STD_LOGIC_VECTOR (6 downto 0);
    signal sub_ln58_fu_303_p2 : STD_LOGIC_VECTOR (6 downto 0);
    signal select_ln58_5_fu_309_p3 : STD_LOGIC_VECTOR (6 downto 0);
    signal select_ln58_7_fu_321_p3 : STD_LOGIC_VECTOR (6 downto 0);
    signal select_ln58_6_fu_315_p3 : STD_LOGIC_VECTOR (6 downto 0);
    signal sub_ln58_2_fu_328_p2 : STD_LOGIC_VECTOR (6 downto 0);
    signal tmp_V_2_fu_293_p1 : STD_LOGIC_VECTOR (111 downto 0);
    signal zext_ln58_4_fu_334_p1 : STD_LOGIC_VECTOR (111 downto 0);
    signal shl_ln58_fu_346_p2 : STD_LOGIC_VECTOR (111 downto 0);
    signal tmp_24_fu_352_p4 : STD_LOGIC_VECTOR (111 downto 0);
    signal zext_ln58_5_fu_338_p1 : STD_LOGIC_VECTOR (111 downto 0);
    signal zext_ln58_6_fu_342_p1 : STD_LOGIC_VECTOR (111 downto 0);
    signal shl_ln58_2_fu_369_p2 : STD_LOGIC_VECTOR (111 downto 0);
    signal lshr_ln58_fu_375_p2 : STD_LOGIC_VECTOR (111 downto 0);
    signal and_ln58_fu_381_p2 : STD_LOGIC_VECTOR (111 downto 0);
    signal xor_ln58_2_fu_387_p2 : STD_LOGIC_VECTOR (111 downto 0);
    signal select_ln58_8_fu_362_p3 : STD_LOGIC_VECTOR (111 downto 0);
    signal and_ln58_3_fu_393_p2 : STD_LOGIC_VECTOR (111 downto 0);
    signal and_ln58_4_fu_399_p2 : STD_LOGIC_VECTOR (111 downto 0);
    signal xor_ln54_fu_421_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Result_50_1_i_i_s_fu_456_p4 : STD_LOGIC_VECTOR (7 downto 0);
    signal p_Result_50_i_i_i_fu_446_p4 : STD_LOGIC_VECTOR (7 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_idle_pp0_0to1 : STD_LOGIC;
    signal ap_reset_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_condition_117 : BOOLEAN;
    signal ap_condition_109 : BOOLEAN;


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
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (header_ready_load_reg_496 = ap_const_lv1_0) and (tmp_reg_475 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                header_header_V_1 <= or_ln58_fu_405_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_nbreadreq_fu_92_p5 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                header_idx_1 <= select_ln62_fu_269_p3;
                header_ready <= and_ln62_fu_263_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_nbreadreq_fu_92_p5 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                header_ready_load_reg_496 <= header_ready;
                or_ln73_reg_519 <= or_ln73_fu_251_p2;
                tmp_data_V_reg_479 <= s_axis_raw_TDATA;
                tmp_keep_V_reg_485 <= s_axis_raw_TKEEP;
                tmp_last_V_reg_490 <= s_axis_raw_TLAST;
                xor_ln62_reg_524 <= xor_ln62_fu_257_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (header_ready_load_load_fu_176_p1 = ap_const_lv1_0) and (tmp_nbreadreq_fu_92_p5 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                icmp_ln58_2_reg_505 <= icmp_ln58_2_fu_227_p2;
                    trunc_ln58_2_reg_513(4) <= trunc_ln58_2_fu_233_p1(4);    trunc_ln58_2_reg_513(6) <= trunc_ln58_2_fu_233_p1(6);
                trunc_ln58_reg_500 <= trunc_ln58_fu_185_p1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_reg_475 = ap_const_lv1_1) and (or_ln62_fu_432_p2 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                metaWritten_1 <= xor_ln62_reg_524;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_reg_475 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                or_ln54_reg_529 <= or_ln54_fu_426_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                tmp_reg_475 <= tmp_nbreadreq_fu_92_p5;
                tmp_reg_475_pp0_iter1_reg <= tmp_reg_475;
            end if;
        end if;
    end process;
    trunc_ln58_2_reg_513(3 downto 0) <= "1111";
    trunc_ln58_2_reg_513(5) <= '1';

    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_block_pp0_stage0_subdone, ap_reset_idle_pp0)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_pp0_stage0 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    Lo_assign_fu_189_p3 <= (header_idx_1 & ap_const_lv6_0);
    add_ln58_fu_201_p2 <= std_logic_vector(unsigned(zext_ln58_fu_197_p1) + unsigned(ap_const_lv23_40));
    add_ln67_fu_244_p2 <= std_logic_vector(unsigned(header_idx_1) + unsigned(ap_const_lv16_1));
    and_ln58_3_fu_393_p2 <= (xor_ln58_2_fu_387_p2 and header_header_V_1);
    and_ln58_4_fu_399_p2 <= (select_ln58_8_fu_362_p3 and and_ln58_fu_381_p2);
    and_ln58_fu_381_p2 <= (shl_ln58_2_fu_369_p2 and lshr_ln58_fu_375_p2);
    and_ln62_fu_263_p2 <= (xor_ln62_fu_257_p2 and or_ln73_fu_251_p2);
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, s_axis_raw_TVALID, tmp_nbreadreq_fu_92_p5, io_acc_block_signal_op61, tmp_reg_475, etherTypeFifo_V_V_full_n, ap_predicate_op75_write_state3)
    begin
                ap_block_pp0_stage0_01001 <= ((ap_done_reg = ap_const_logic_1) or ((etherTypeFifo_V_V_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_predicate_op75_write_state3 = ap_const_boolean_1)) or ((tmp_reg_475 = ap_const_lv1_1) and (io_acc_block_signal_op61 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1)) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_92_p5 = ap_const_lv1_1) and (s_axis_raw_TVALID = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, s_axis_raw_TVALID, tmp_nbreadreq_fu_92_p5, io_acc_block_signal_op61, tmp_reg_475, etherTypeFifo_V_V_full_n, ap_predicate_op75_write_state3)
    begin
                ap_block_pp0_stage0_11001 <= ((ap_done_reg = ap_const_logic_1) or ((etherTypeFifo_V_V_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_predicate_op75_write_state3 = ap_const_boolean_1)) or ((tmp_reg_475 = ap_const_lv1_1) and (io_acc_block_signal_op61 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1)) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_92_p5 = ap_const_lv1_1) and (s_axis_raw_TVALID = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, s_axis_raw_TVALID, tmp_nbreadreq_fu_92_p5, io_acc_block_signal_op61, tmp_reg_475, etherTypeFifo_V_V_full_n, ap_predicate_op75_write_state3)
    begin
                ap_block_pp0_stage0_subdone <= ((ap_done_reg = ap_const_logic_1) or ((etherTypeFifo_V_V_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_predicate_op75_write_state3 = ap_const_boolean_1)) or ((tmp_reg_475 = ap_const_lv1_1) and (io_acc_block_signal_op61 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1)) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_92_p5 = ap_const_lv1_1) and (s_axis_raw_TVALID = ap_const_logic_0)))));
    end process;


    ap_block_state1_pp0_stage0_iter0_assign_proc : process(ap_start, ap_done_reg, s_axis_raw_TVALID, tmp_nbreadreq_fu_92_p5)
    begin
                ap_block_state1_pp0_stage0_iter0 <= ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_92_p5 = ap_const_lv1_1) and (s_axis_raw_TVALID = ap_const_logic_0)));
    end process;


    ap_block_state2_pp0_stage0_iter1_assign_proc : process(io_acc_block_signal_op61, tmp_reg_475)
    begin
                ap_block_state2_pp0_stage0_iter1 <= ((tmp_reg_475 = ap_const_lv1_1) and (io_acc_block_signal_op61 = ap_const_logic_0));
    end process;


    ap_block_state3_pp0_stage0_iter2_assign_proc : process(etherTypeFifo_V_V_full_n, ap_predicate_op75_write_state3)
    begin
                ap_block_state3_pp0_stage0_iter2 <= ((etherTypeFifo_V_V_full_n = ap_const_logic_0) and (ap_predicate_op75_write_state3 = ap_const_boolean_1));
    end process;


    ap_condition_109_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, tmp_nbreadreq_fu_92_p5, ap_block_pp0_stage0)
    begin
                ap_condition_109 <= ((tmp_nbreadreq_fu_92_p5 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0));
    end process;


    ap_condition_117_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, tmp_reg_475, ap_block_pp0_stage0)
    begin
                ap_condition_117 <= ((tmp_reg_475 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0));
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


    ap_phi_mux_metaWritten_1_flag_0_phi_fu_156_p4_assign_proc : process(or_ln54_fu_426_p2, ap_phi_reg_pp0_iter1_metaWritten_1_flag_0_reg_153, ap_condition_117)
    begin
        if ((ap_const_boolean_1 = ap_condition_117)) then
            if ((or_ln54_fu_426_p2 = ap_const_lv1_1)) then 
                ap_phi_mux_metaWritten_1_flag_0_phi_fu_156_p4 <= ap_const_lv1_0;
            elsif ((or_ln54_fu_426_p2 = ap_const_lv1_0)) then 
                ap_phi_mux_metaWritten_1_flag_0_phi_fu_156_p4 <= ap_const_lv1_1;
            else 
                ap_phi_mux_metaWritten_1_flag_0_phi_fu_156_p4 <= ap_phi_reg_pp0_iter1_metaWritten_1_flag_0_reg_153;
            end if;
        else 
            ap_phi_mux_metaWritten_1_flag_0_phi_fu_156_p4 <= ap_phi_reg_pp0_iter1_metaWritten_1_flag_0_reg_153;
        end if; 
    end process;


    ap_phi_mux_phi_ln73_phi_fu_137_p4_assign_proc : process(header_idx_1, header_ready_load_load_fu_176_p1, ap_phi_reg_pp0_iter0_phi_ln73_reg_134, add_ln67_fu_244_p2, ap_condition_109)
    begin
        if ((ap_const_boolean_1 = ap_condition_109)) then
            if ((header_ready_load_load_fu_176_p1 = ap_const_lv1_0)) then 
                ap_phi_mux_phi_ln73_phi_fu_137_p4 <= add_ln67_fu_244_p2;
            elsif ((header_ready_load_load_fu_176_p1 = ap_const_lv1_1)) then 
                ap_phi_mux_phi_ln73_phi_fu_137_p4 <= header_idx_1;
            else 
                ap_phi_mux_phi_ln73_phi_fu_137_p4 <= ap_phi_reg_pp0_iter0_phi_ln73_reg_134;
            end if;
        else 
            ap_phi_mux_phi_ln73_phi_fu_137_p4 <= ap_phi_reg_pp0_iter0_phi_ln73_reg_134;
        end if; 
    end process;


    ap_phi_mux_write_flag_1_i_i_phi_fu_146_p4_assign_proc : process(header_ready_load_load_fu_176_p1, ap_phi_reg_pp0_iter0_write_flag_1_i_i_reg_143, xor_ln58_fu_237_p2, ap_condition_109)
    begin
        if ((ap_const_boolean_1 = ap_condition_109)) then
            if ((header_ready_load_load_fu_176_p1 = ap_const_lv1_0)) then 
                ap_phi_mux_write_flag_1_i_i_phi_fu_146_p4 <= xor_ln58_fu_237_p2;
            elsif ((header_ready_load_load_fu_176_p1 = ap_const_lv1_1)) then 
                ap_phi_mux_write_flag_1_i_i_phi_fu_146_p4 <= ap_const_lv1_0;
            else 
                ap_phi_mux_write_flag_1_i_i_phi_fu_146_p4 <= ap_phi_reg_pp0_iter0_write_flag_1_i_i_reg_143;
            end if;
        else 
            ap_phi_mux_write_flag_1_i_i_phi_fu_146_p4 <= ap_phi_reg_pp0_iter0_write_flag_1_i_i_reg_143;
        end if; 
    end process;

    ap_phi_reg_pp0_iter0_phi_ln73_reg_134 <= "XXXXXXXXXXXXXXXX";
    ap_phi_reg_pp0_iter0_write_flag_1_i_i_reg_143 <= "X";
    ap_phi_reg_pp0_iter1_metaWritten_1_flag_0_reg_153 <= "X";

    ap_predicate_op75_write_state3_assign_proc : process(tmp_reg_475_pp0_iter1_reg, or_ln54_reg_529)
    begin
                ap_predicate_op75_write_state3 <= ((or_ln54_reg_529 = ap_const_lv1_0) and (tmp_reg_475_pp0_iter1_reg = ap_const_lv1_1));
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


    ethDataFifo_V_data_V_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ethDataFifo_V_data_V_full_n, tmp_reg_475, ap_block_pp0_stage0)
    begin
        if (((tmp_reg_475 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0))) then 
            ethDataFifo_V_data_V_blk_n <= ethDataFifo_V_data_V_full_n;
        else 
            ethDataFifo_V_data_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    ethDataFifo_V_data_V_din <= tmp_data_V_reg_479;

    ethDataFifo_V_data_V_write_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, tmp_reg_475, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_reg_475 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ethDataFifo_V_data_V_write <= ap_const_logic_1;
        else 
            ethDataFifo_V_data_V_write <= ap_const_logic_0;
        end if; 
    end process;


    ethDataFifo_V_keep_V_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ethDataFifo_V_keep_V_full_n, tmp_reg_475, ap_block_pp0_stage0)
    begin
        if (((tmp_reg_475 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0))) then 
            ethDataFifo_V_keep_V_blk_n <= ethDataFifo_V_keep_V_full_n;
        else 
            ethDataFifo_V_keep_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    ethDataFifo_V_keep_V_din <= tmp_keep_V_reg_485;

    ethDataFifo_V_keep_V_write_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, tmp_reg_475, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_reg_475 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ethDataFifo_V_keep_V_write <= ap_const_logic_1;
        else 
            ethDataFifo_V_keep_V_write <= ap_const_logic_0;
        end if; 
    end process;


    ethDataFifo_V_last_V_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ethDataFifo_V_last_V_full_n, tmp_reg_475, ap_block_pp0_stage0)
    begin
        if (((tmp_reg_475 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0))) then 
            ethDataFifo_V_last_V_blk_n <= ethDataFifo_V_last_V_full_n;
        else 
            ethDataFifo_V_last_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    ethDataFifo_V_last_V_din <= tmp_last_V_reg_490;

    ethDataFifo_V_last_V_write_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, tmp_reg_475, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_reg_475 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ethDataFifo_V_last_V_write <= ap_const_logic_1;
        else 
            ethDataFifo_V_last_V_write <= ap_const_logic_0;
        end if; 
    end process;


    etherTypeFifo_V_V_blk_n_assign_proc : process(ap_enable_reg_pp0_iter2, etherTypeFifo_V_V_full_n, ap_predicate_op75_write_state3, ap_block_pp0_stage0)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_predicate_op75_write_state3 = ap_const_boolean_1) and (ap_const_boolean_0 = ap_block_pp0_stage0))) then 
            etherTypeFifo_V_V_blk_n <= etherTypeFifo_V_V_full_n;
        else 
            etherTypeFifo_V_V_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    etherTypeFifo_V_V_din <= (p_Result_50_1_i_i_s_fu_456_p4 & p_Result_50_i_i_i_fu_446_p4);

    etherTypeFifo_V_V_write_assign_proc : process(ap_enable_reg_pp0_iter2, ap_predicate_op75_write_state3, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_predicate_op75_write_state3 = ap_const_boolean_1))) then 
            etherTypeFifo_V_V_write <= ap_const_logic_1;
        else 
            etherTypeFifo_V_V_write <= ap_const_logic_0;
        end if; 
    end process;

    header_ready_load_load_fu_176_p1 <= header_ready;
    icmp_ln58_2_fu_227_p2 <= "1" when (unsigned(Lo_assign_fu_189_p3) > unsigned(select_ln58_fu_219_p3)) else "0";
    icmp_ln58_fu_207_p2 <= "1" when (unsigned(add_ln58_fu_201_p2) < unsigned(ap_const_lv23_70)) else "0";
    io_acc_block_signal_op61 <= (ethDataFifo_V_last_V_full_n and ethDataFifo_V_keep_V_full_n and ethDataFifo_V_data_V_full_n);
    lshr_ln58_fu_375_p2 <= std_logic_vector(shift_right(unsigned(ap_const_lv112_FFFFFFFFFFFFFFFFFFFFFFFFFFFF),to_integer(unsigned('0' & zext_ln58_6_fu_342_p1(31-1 downto 0)))));
    or_ln54_fu_426_p2 <= (xor_ln54_fu_421_p2 or metaWritten_1);
    or_ln58_fu_405_p2 <= (and_ln58_4_fu_399_p2 or and_ln58_3_fu_393_p2);
    or_ln60_fu_213_p2 <= (ap_const_lv22_3F or Lo_assign_fu_189_p3);
    or_ln62_fu_432_p2 <= (tmp_last_V_reg_490 or ap_phi_mux_metaWritten_1_flag_0_phi_fu_156_p4);
    or_ln73_fu_251_p2 <= (header_ready or ap_phi_mux_write_flag_1_i_i_phi_fu_146_p4);
    p_Result_50_1_i_i_s_fu_456_p4 <= header_header_V_1(103 downto 96);
    p_Result_50_i_i_i_fu_446_p4 <= header_header_V_1(111 downto 104);

    s_axis_raw_TDATA_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_pp0_stage0, s_axis_raw_TVALID, tmp_nbreadreq_fu_92_p5, ap_block_pp0_stage0)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (tmp_nbreadreq_fu_92_p5 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0))) then 
            s_axis_raw_TDATA_blk_n <= s_axis_raw_TVALID;
        else 
            s_axis_raw_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    s_axis_raw_TREADY_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, tmp_nbreadreq_fu_92_p5, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_nbreadreq_fu_92_p5 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            s_axis_raw_TREADY <= ap_const_logic_1;
        else 
            s_axis_raw_TREADY <= ap_const_logic_0;
        end if; 
    end process;

    select_ln58_5_fu_309_p3 <= 
        tmp_23_fu_296_p3 when (icmp_ln58_2_reg_505(0) = '1') else 
        trunc_ln58_2_reg_513;
    select_ln58_6_fu_315_p3 <= 
        trunc_ln58_2_reg_513 when (icmp_ln58_2_reg_505(0) = '1') else 
        tmp_23_fu_296_p3;
    select_ln58_7_fu_321_p3 <= 
        sub_ln58_fu_303_p2 when (icmp_ln58_2_reg_505(0) = '1') else 
        tmp_23_fu_296_p3;
    select_ln58_8_fu_362_p3 <= 
        tmp_24_fu_352_p4 when (icmp_ln58_2_reg_505(0) = '1') else 
        shl_ln58_fu_346_p2;
    select_ln58_fu_219_p3 <= 
        or_ln60_fu_213_p2 when (icmp_ln58_fu_207_p2(0) = '1') else 
        ap_const_lv22_6F;
    select_ln62_fu_269_p3 <= 
        ap_const_lv16_0 when (s_axis_raw_TLAST(0) = '1') else 
        ap_phi_mux_phi_ln73_phi_fu_137_p4;
    shl_ln58_2_fu_369_p2 <= std_logic_vector(shift_left(unsigned(ap_const_lv112_FFFFFFFFFFFFFFFFFFFFFFFFFFFF),to_integer(unsigned('0' & zext_ln58_5_fu_338_p1(31-1 downto 0)))));
    shl_ln58_fu_346_p2 <= std_logic_vector(shift_left(unsigned(tmp_V_2_fu_293_p1),to_integer(unsigned('0' & zext_ln58_4_fu_334_p1(31-1 downto 0)))));
    sub_ln58_2_fu_328_p2 <= std_logic_vector(signed(ap_const_lv7_6F) - signed(select_ln58_5_fu_309_p3));
    sub_ln58_fu_303_p2 <= std_logic_vector(signed(ap_const_lv7_6F) - signed(tmp_23_fu_296_p3));
    tmp_23_fu_296_p3 <= (trunc_ln58_reg_500 & ap_const_lv6_0);
    
    tmp_24_fu_352_p4_proc : process(shl_ln58_fu_346_p2)
    variable vlo_cpy : STD_LOGIC_VECTOR(112+32 - 1 downto 0);
    variable vhi_cpy : STD_LOGIC_VECTOR(112+32 - 1 downto 0);
    variable v0_cpy : STD_LOGIC_VECTOR(112 - 1 downto 0);
    variable tmp_24_fu_352_p4_i : integer;
    variable section : STD_LOGIC_VECTOR(112 - 1 downto 0);
    variable tmp_mask : STD_LOGIC_VECTOR(112 - 1 downto 0);
    variable resvalue, res_value, res_mask : STD_LOGIC_VECTOR(112 - 1 downto 0);
    begin
        vlo_cpy := (others => '0');
        vlo_cpy(7 - 1 downto 0) := ap_const_lv32_6F(7 - 1 downto 0);
        vhi_cpy := (others => '0');
        vhi_cpy(7 - 1 downto 0) := ap_const_lv32_0(7 - 1 downto 0);
        v0_cpy := shl_ln58_fu_346_p2;
        if (vlo_cpy(7 - 1 downto 0) > vhi_cpy(7 - 1 downto 0)) then
            vhi_cpy(7-1 downto 0) := std_logic_vector(112-1-unsigned(ap_const_lv32_0(7-1 downto 0)));
            vlo_cpy(7-1 downto 0) := std_logic_vector(112-1-unsigned(ap_const_lv32_6F(7-1 downto 0)));
            for tmp_24_fu_352_p4_i in 0 to 112-1 loop
                v0_cpy(tmp_24_fu_352_p4_i) := shl_ln58_fu_346_p2(112-1-tmp_24_fu_352_p4_i);
            end loop;
        end if;
        res_value := std_logic_vector(shift_right(unsigned(v0_cpy), to_integer(unsigned('0' & vlo_cpy(7-1 downto 0)))));

        section := (others=>'0');
        section(7-1 downto 0) := std_logic_vector(unsigned(vhi_cpy(7-1 downto 0)) - unsigned(vlo_cpy(7-1 downto 0)));
        tmp_mask := (others => '1');
        res_mask := std_logic_vector(shift_left(unsigned(tmp_mask),to_integer(unsigned('0' & section(31-1 downto 0)))));
        res_mask := res_mask(112-2 downto 0) & '0';
        resvalue := res_value and not res_mask;
        tmp_24_fu_352_p4 <= resvalue(112-1 downto 0);
    end process;

    tmp_V_2_fu_293_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_data_V_reg_479),112));
    tmp_nbreadreq_fu_92_p5 <= (0=>(s_axis_raw_TVALID), others=>'-');
    trunc_ln58_2_fu_233_p1 <= select_ln58_fu_219_p3(7 - 1 downto 0);
    trunc_ln58_fu_185_p1 <= header_idx_1(1 - 1 downto 0);
    xor_ln54_fu_421_p2 <= (or_ln73_reg_519 xor ap_const_lv1_1);
    xor_ln58_2_fu_387_p2 <= (ap_const_lv112_FFFFFFFFFFFFFFFFFFFFFFFFFFFF xor and_ln58_fu_381_p2);
    xor_ln58_fu_237_p2 <= (icmp_ln58_fu_207_p2 xor ap_const_lv1_1);
    xor_ln62_fu_257_p2 <= (s_axis_raw_TLAST xor ap_const_lv1_1);
    zext_ln58_4_fu_334_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(select_ln58_7_fu_321_p3),112));
    zext_ln58_5_fu_338_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(select_ln58_6_fu_315_p3),112));
    zext_ln58_6_fu_342_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(sub_ln58_2_fu_328_p2),112));
    zext_ln58_fu_197_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(Lo_assign_fu_189_p3),23));
end behav;
