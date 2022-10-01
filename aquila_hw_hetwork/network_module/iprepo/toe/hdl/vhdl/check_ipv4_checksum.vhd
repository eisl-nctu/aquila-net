-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2019.1
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity check_ipv4_checksum is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    subSumFifo_V_sum_V_0_dout : IN STD_LOGIC_VECTOR (16 downto 0);
    subSumFifo_V_sum_V_0_empty_n : IN STD_LOGIC;
    subSumFifo_V_sum_V_0_read : OUT STD_LOGIC;
    subSumFifo_V_sum_V_1_dout : IN STD_LOGIC_VECTOR (16 downto 0);
    subSumFifo_V_sum_V_1_empty_n : IN STD_LOGIC;
    subSumFifo_V_sum_V_1_read : OUT STD_LOGIC;
    subSumFifo_V_sum_V_2_dout : IN STD_LOGIC_VECTOR (16 downto 0);
    subSumFifo_V_sum_V_2_empty_n : IN STD_LOGIC;
    subSumFifo_V_sum_V_2_read : OUT STD_LOGIC;
    subSumFifo_V_sum_V_3_dout : IN STD_LOGIC_VECTOR (16 downto 0);
    subSumFifo_V_sum_V_3_empty_n : IN STD_LOGIC;
    subSumFifo_V_sum_V_3_read : OUT STD_LOGIC;
    rxEng_checksumValidF_1_din : OUT STD_LOGIC_VECTOR (0 downto 0);
    rxEng_checksumValidF_1_full_n : IN STD_LOGIC;
    rxEng_checksumValidF_1_write : OUT STD_LOGIC );
end;


architecture behav of check_ipv4_checksum is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv32_10 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000010000";
    constant ap_const_lv16_FFFF : STD_LOGIC_VECTOR (15 downto 0) := "1111111111111111";

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
    signal io_acc_block_signal_op6 : STD_LOGIC;
    signal tmp_nbreadreq_fu_38_p6 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal tmp_reg_201 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_reg_201_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_state3_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal subSumFifo_V_sum_V_0_blk_n : STD_LOGIC;
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal subSumFifo_V_sum_V_1_blk_n : STD_LOGIC;
    signal subSumFifo_V_sum_V_2_blk_n : STD_LOGIC;
    signal subSumFifo_V_sum_V_3_blk_n : STD_LOGIC;
    signal rxEng_checksumValidF_1_blk_n : STD_LOGIC;
    signal trunc_ln700_fu_87_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln700_reg_205 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln700_7_fu_91_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln700_7_reg_210 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln700_8_fu_101_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln700_8_reg_215 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln700_9_fu_105_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln700_9_reg_220 : STD_LOGIC_VECTOR (15 downto 0);
    signal tmp_308_reg_225 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_309_reg_230 : STD_LOGIC_VECTOR (0 downto 0);
    signal add_ln769_fu_189_p2 : STD_LOGIC_VECTOR (15 downto 0);
    signal add_ln769_reg_235 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal add_ln700_fu_95_p2 : STD_LOGIC_VECTOR (16 downto 0);
    signal add_ln700_20_fu_109_p2 : STD_LOGIC_VECTOR (16 downto 0);
    signal zext_ln214_20_fu_131_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal add_ln214_fu_134_p2 : STD_LOGIC_VECTOR (15 downto 0);
    signal add_ln214_29_fu_139_p2 : STD_LOGIC_VECTOR (15 downto 0);
    signal zext_ln214_21_fu_148_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal add_ln214_30_fu_151_p2 : STD_LOGIC_VECTOR (15 downto 0);
    signal add_ln214_31_fu_156_p2 : STD_LOGIC_VECTOR (15 downto 0);
    signal zext_ln214_10_fu_161_p1 : STD_LOGIC_VECTOR (16 downto 0);
    signal zext_ln214_fu_144_p1 : STD_LOGIC_VECTOR (16 downto 0);
    signal add_ln700_21_fu_171_p2 : STD_LOGIC_VECTOR (16 downto 0);
    signal tmp_310_fu_177_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal zext_ln214_22_fu_185_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal add_ln700_22_fu_165_p2 : STD_LOGIC_VECTOR (15 downto 0);
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
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_reg_201 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                add_ln769_reg_235 <= add_ln769_fu_189_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_nbreadreq_fu_38_p6 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                tmp_308_reg_225 <= add_ln700_fu_95_p2(16 downto 16);
                tmp_309_reg_230 <= add_ln700_20_fu_109_p2(16 downto 16);
                trunc_ln700_7_reg_210 <= trunc_ln700_7_fu_91_p1;
                trunc_ln700_8_reg_215 <= trunc_ln700_8_fu_101_p1;
                trunc_ln700_9_reg_220 <= trunc_ln700_9_fu_105_p1;
                trunc_ln700_reg_205 <= trunc_ln700_fu_87_p1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                tmp_reg_201 <= tmp_nbreadreq_fu_38_p6;
                tmp_reg_201_pp0_iter1_reg <= tmp_reg_201;
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
    add_ln214_29_fu_139_p2 <= std_logic_vector(unsigned(trunc_ln700_reg_205) + unsigned(add_ln214_fu_134_p2));
    add_ln214_30_fu_151_p2 <= std_logic_vector(unsigned(zext_ln214_21_fu_148_p1) + unsigned(trunc_ln700_9_reg_220));
    add_ln214_31_fu_156_p2 <= std_logic_vector(unsigned(trunc_ln700_8_reg_215) + unsigned(add_ln214_30_fu_151_p2));
    add_ln214_fu_134_p2 <= std_logic_vector(unsigned(zext_ln214_20_fu_131_p1) + unsigned(trunc_ln700_7_reg_210));
    add_ln700_20_fu_109_p2 <= std_logic_vector(unsigned(subSumFifo_V_sum_V_1_dout) + unsigned(subSumFifo_V_sum_V_3_dout));
    add_ln700_21_fu_171_p2 <= std_logic_vector(unsigned(zext_ln214_10_fu_161_p1) + unsigned(zext_ln214_fu_144_p1));
    add_ln700_22_fu_165_p2 <= std_logic_vector(unsigned(add_ln214_29_fu_139_p2) + unsigned(add_ln214_31_fu_156_p2));
    add_ln700_fu_95_p2 <= std_logic_vector(unsigned(subSumFifo_V_sum_V_0_dout) + unsigned(subSumFifo_V_sum_V_2_dout));
    add_ln769_fu_189_p2 <= std_logic_vector(unsigned(zext_ln214_22_fu_185_p1) + unsigned(add_ln700_22_fu_165_p2));
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter2, io_acc_block_signal_op6, tmp_nbreadreq_fu_38_p6, rxEng_checksumValidF_1_full_n, tmp_reg_201_pp0_iter1_reg)
    begin
                ap_block_pp0_stage0_01001 <= ((ap_done_reg = ap_const_logic_1) or ((tmp_reg_201_pp0_iter1_reg = ap_const_lv1_1) and (rxEng_checksumValidF_1_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_38_p6 = ap_const_lv1_1) and (io_acc_block_signal_op6 = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter2, io_acc_block_signal_op6, tmp_nbreadreq_fu_38_p6, rxEng_checksumValidF_1_full_n, tmp_reg_201_pp0_iter1_reg)
    begin
                ap_block_pp0_stage0_11001 <= ((ap_done_reg = ap_const_logic_1) or ((tmp_reg_201_pp0_iter1_reg = ap_const_lv1_1) and (rxEng_checksumValidF_1_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_38_p6 = ap_const_lv1_1) and (io_acc_block_signal_op6 = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(ap_start, ap_done_reg, ap_enable_reg_pp0_iter2, io_acc_block_signal_op6, tmp_nbreadreq_fu_38_p6, rxEng_checksumValidF_1_full_n, tmp_reg_201_pp0_iter1_reg)
    begin
                ap_block_pp0_stage0_subdone <= ((ap_done_reg = ap_const_logic_1) or ((tmp_reg_201_pp0_iter1_reg = ap_const_lv1_1) and (rxEng_checksumValidF_1_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)) or ((ap_start = ap_const_logic_1) and ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_38_p6 = ap_const_lv1_1) and (io_acc_block_signal_op6 = ap_const_logic_0)))));
    end process;


    ap_block_state1_pp0_stage0_iter0_assign_proc : process(ap_start, ap_done_reg, io_acc_block_signal_op6, tmp_nbreadreq_fu_38_p6)
    begin
                ap_block_state1_pp0_stage0_iter0 <= ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1) or ((tmp_nbreadreq_fu_38_p6 = ap_const_lv1_1) and (io_acc_block_signal_op6 = ap_const_logic_0)));
    end process;

        ap_block_state2_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state3_pp0_stage0_iter2_assign_proc : process(rxEng_checksumValidF_1_full_n, tmp_reg_201_pp0_iter1_reg)
    begin
                ap_block_state3_pp0_stage0_iter2 <= ((tmp_reg_201_pp0_iter1_reg = ap_const_lv1_1) and (rxEng_checksumValidF_1_full_n = ap_const_logic_0));
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

    io_acc_block_signal_op6 <= (subSumFifo_V_sum_V_3_empty_n and subSumFifo_V_sum_V_2_empty_n and subSumFifo_V_sum_V_1_empty_n and subSumFifo_V_sum_V_0_empty_n);

    rxEng_checksumValidF_1_blk_n_assign_proc : process(ap_enable_reg_pp0_iter2, rxEng_checksumValidF_1_full_n, tmp_reg_201_pp0_iter1_reg, ap_block_pp0_stage0)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (tmp_reg_201_pp0_iter1_reg = ap_const_lv1_1) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            rxEng_checksumValidF_1_blk_n <= rxEng_checksumValidF_1_full_n;
        else 
            rxEng_checksumValidF_1_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    rxEng_checksumValidF_1_din <= "1" when (add_ln769_reg_235 = ap_const_lv16_FFFF) else "0";

    rxEng_checksumValidF_1_write_assign_proc : process(ap_enable_reg_pp0_iter2, tmp_reg_201_pp0_iter1_reg, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_reg_201_pp0_iter1_reg = ap_const_lv1_1) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            rxEng_checksumValidF_1_write <= ap_const_logic_1;
        else 
            rxEng_checksumValidF_1_write <= ap_const_logic_0;
        end if; 
    end process;


    subSumFifo_V_sum_V_0_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_pp0_stage0, subSumFifo_V_sum_V_0_empty_n, tmp_nbreadreq_fu_38_p6, ap_block_pp0_stage0)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (tmp_nbreadreq_fu_38_p6 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            subSumFifo_V_sum_V_0_blk_n <= subSumFifo_V_sum_V_0_empty_n;
        else 
            subSumFifo_V_sum_V_0_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    subSumFifo_V_sum_V_0_read_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, tmp_nbreadreq_fu_38_p6, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_nbreadreq_fu_38_p6 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            subSumFifo_V_sum_V_0_read <= ap_const_logic_1;
        else 
            subSumFifo_V_sum_V_0_read <= ap_const_logic_0;
        end if; 
    end process;


    subSumFifo_V_sum_V_1_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_pp0_stage0, subSumFifo_V_sum_V_1_empty_n, tmp_nbreadreq_fu_38_p6, ap_block_pp0_stage0)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (tmp_nbreadreq_fu_38_p6 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            subSumFifo_V_sum_V_1_blk_n <= subSumFifo_V_sum_V_1_empty_n;
        else 
            subSumFifo_V_sum_V_1_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    subSumFifo_V_sum_V_1_read_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, tmp_nbreadreq_fu_38_p6, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_nbreadreq_fu_38_p6 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            subSumFifo_V_sum_V_1_read <= ap_const_logic_1;
        else 
            subSumFifo_V_sum_V_1_read <= ap_const_logic_0;
        end if; 
    end process;


    subSumFifo_V_sum_V_2_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_pp0_stage0, subSumFifo_V_sum_V_2_empty_n, tmp_nbreadreq_fu_38_p6, ap_block_pp0_stage0)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (tmp_nbreadreq_fu_38_p6 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            subSumFifo_V_sum_V_2_blk_n <= subSumFifo_V_sum_V_2_empty_n;
        else 
            subSumFifo_V_sum_V_2_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    subSumFifo_V_sum_V_2_read_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, tmp_nbreadreq_fu_38_p6, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_nbreadreq_fu_38_p6 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            subSumFifo_V_sum_V_2_read <= ap_const_logic_1;
        else 
            subSumFifo_V_sum_V_2_read <= ap_const_logic_0;
        end if; 
    end process;


    subSumFifo_V_sum_V_3_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_pp0_stage0, subSumFifo_V_sum_V_3_empty_n, tmp_nbreadreq_fu_38_p6, ap_block_pp0_stage0)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (tmp_nbreadreq_fu_38_p6 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            subSumFifo_V_sum_V_3_blk_n <= subSumFifo_V_sum_V_3_empty_n;
        else 
            subSumFifo_V_sum_V_3_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    subSumFifo_V_sum_V_3_read_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, tmp_nbreadreq_fu_38_p6, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (tmp_nbreadreq_fu_38_p6 = ap_const_lv1_1) and (ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            subSumFifo_V_sum_V_3_read <= ap_const_logic_1;
        else 
            subSumFifo_V_sum_V_3_read <= ap_const_logic_0;
        end if; 
    end process;

    tmp_310_fu_177_p3 <= add_ln700_21_fu_171_p2(16 downto 16);
    tmp_nbreadreq_fu_38_p6 <= (0=>(subSumFifo_V_sum_V_3_empty_n and subSumFifo_V_sum_V_2_empty_n and subSumFifo_V_sum_V_1_empty_n and subSumFifo_V_sum_V_0_empty_n), others=>'-');
    trunc_ln700_7_fu_91_p1 <= subSumFifo_V_sum_V_2_dout(16 - 1 downto 0);
    trunc_ln700_8_fu_101_p1 <= subSumFifo_V_sum_V_1_dout(16 - 1 downto 0);
    trunc_ln700_9_fu_105_p1 <= subSumFifo_V_sum_V_3_dout(16 - 1 downto 0);
    trunc_ln700_fu_87_p1 <= subSumFifo_V_sum_V_0_dout(16 - 1 downto 0);
    zext_ln214_10_fu_161_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(add_ln214_31_fu_156_p2),17));
    zext_ln214_20_fu_131_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_308_reg_225),16));
    zext_ln214_21_fu_148_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_309_reg_230),16));
    zext_ln214_22_fu_185_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_310_fu_177_p3),16));
    zext_ln214_fu_144_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(add_ln214_29_fu_139_p2),17));
end behav;