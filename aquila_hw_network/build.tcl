#*****************************************************************************************
#  Create the aquial_bare workspace.
#*****************************************************************************************

# Set the reference directory for source file relative paths
set origin_dir "."

# Set the project name
set proj_name "aquila_kc705"

variable script_file
set script_file "${proj_name}.tcl"

# Create project
create_project ${proj_name} ./${proj_name} -part xc7k325tffg900-2

# Set project properties
set obj [current_project]
set_property -name "board_part" -value "xilinx.com:kc705:part0:1.6" -objects $obj
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "xpm_libraries" -value "XPM_CDC XPM_MEMORY" -objects $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]

# Import local files from the original project
set files [list \
 [file normalize "$origin_dir/aquila_src/core_rtl/alu.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/aquila_top.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/atomic_unit.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/bcu.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/bpu.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/clint.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/core_top.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/csr_file.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/dcache.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/decode.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/distri_ram.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/execute.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/fetch.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/forwarding_unit.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/icache.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/memory.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/muldiv.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/pipeline_control.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/program_counter.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/reg_file.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/sram.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/sram_dp.v" ]\
 [file normalize "$origin_dir/aquila_src/uart.v" ]\
 [file normalize "$origin_dir/aquila_src/core_rtl/writeback.v" ]\
 [file normalize "$origin_dir/aquila_src/soc_top.v" ]\
 [file normalize "$origin_dir/aquila_src/cdc_sync.v" ]\
 [file normalize "$origin_dir/aquila_src/mem_arbiter.v" ]\
 [file normalize "$origin_dir/aquila_src/mem/bootrom_uart.mem" ]\
 [file normalize "$origin_dir/aquila_src/mem/bootrom_sdcard.mem" ]\
]
set imported_files [import_files -fileset sources_1 $files]

# Set 'sources_1' fileset file properties for local files
set file "mem/bootrom_uart.mem"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Memory File" -objects $file_obj

# Set 'sources_1' fileset file properties for local files
set file "mem/bootrom_sdcard.mem"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Memory File" -objects $file_obj

# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property -name "top" -value "soc_top" -objects $obj

# Adding an Asynchronous FIFO Addr IP
create_ip -name fifo_generator -vendor xilinx.com -library ip -module_name async_fifo_addr
set_property -dict [list \
    CONFIG.fifo_implementation {independent_clocks_distributed_ram} \
    CONFIG.synchronization_stages {3} \
    CONFIG.input_data_width {32} \
    CONFIG.input_depth {16} \
    CONFIG.reset_pin {false} \
    CONFIG.performance_options {first_word_fall_through} ] [get_ips async_fifo_addr]
generate_target {instantiation_template} [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/async_fifo_addr/async_fifo_addr.xci]

# Adding an Asynchronous FIFO Data IP
create_ip -name fifo_generator -vendor xilinx.com -library ip -module_name async_fifo_data
set_property -dict [list \
    CONFIG.fifo_implementation {independent_clocks_distributed_ram} \
    CONFIG.synchronization_stages {3} \
    CONFIG.input_data_width {256} \
    CONFIG.input_depth {16} \
    CONFIG.reset_pin {false} \
    CONFIG.performance_options {first_word_fall_through} ] [get_ips async_fifo_data]
generate_target {instantiation_template} [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/async_fifo_data/async_fifo_data.xci]

# Adding an Asynchronous FIFO Signal IP
create_ip -name fifo_generator -vendor xilinx.com -library ip -module_name async_fifo_signal
set_property -dict [list \
    CONFIG.fifo_implementation {independent_clocks_distributed_ram} \
    CONFIG.synchronization_stages {3} \
    CONFIG.input_data_width {1} \
    CONFIG.input_depth {16} \
    CONFIG.reset_pin {false} \
    CONFIG.performance_options {first_word_fall_through} ] [get_ips async_fifo_signal]
generate_target {instantiation_template} [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/async_fifo_signal/async_fifo_signal.xci]

# Adding a Clock Wizard IP
create_ip -name clk_wiz -vendor xilinx.com -library ip -module_name clk_wiz_0
set_property -dict [list \
    CONFIG.PRIM_IN_FREQ {200.000} \
    CONFIG.CLKOUT2_USED {false} \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {100.000} \
    CONFIG.USE_RESET {false} \
    CONFIG.USE_LOCKED {false}] [get_ips clk_wiz_0]
generate_target {instantiation_template} [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci]

# Adding an SPI IP
create_ip -name axi_quad_spi -vendor xilinx.com -library ip -module_name axi_quad_spi_0
set_property -dict [ list \
   CONFIG.C_FIFO_DEPTH {256} \
   CONFIG.C_SCK_RATIO {4} \
   CONFIG.C_USE_STARTUP {0} \
   CONFIG.C_USE_STARTUP_INT {0} \
   CONFIG.QSPI_BOARD_INTERFACE {custom}] [get_ips axi_quad_spi_0]
generate_target {instantiation_template} [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axi_quad_spi_0/axi_quad_spi_0.xci]

# Adding an MIG IP
create_ip -name mig_7series -vendor xilinx.com -library ip -module_name mig_7series_0
file copy $origin_dir/aquila_src/mig/mig.prj ${proj_name}/${proj_name}.srcs/sources_1/ip/mig_7series_0
set_property -dict [list CONFIG.XML_INPUT_FILE {mig.prj}] [get_ips mig_7series_0]
generate_target {instantiation_template} [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/mig_7series_0/mig_7series_0.xci]
generate_target {instantiation_template} [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/mig_7series_0/mig_7series_0.xci]

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$origin_dir/aquila_src/xdc/kc705.xdc"]"
set file_imported [import_files -fileset constrs_1 [list $file]]
set file "kc705.xdc"
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property -name "file_type" -value "XDC" -objects $file_obj

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]
set_property -name "target_constrs_file" -value "[get_files */kc705.xdc]" -objects $obj
set_property -name "target_ucf" -value "[get_files */kc705.xdc]" -objects $obj

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
# Import local files from the original project
set files [list \
 "$origin_dir/aquila_src/sim/aquila_tb.v"\
]
set imported_files [import_files -fileset sim_1 $files]

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property -name "top" -value "aquila_tb" -objects $obj
set_property -name "top_lib" -value "xil_defaultlib" -objects $obj

puts "INFO: Project created:${proj_name}"

# Network module
set root_dir [pwd]/network_module
set hdl_dir $root_dir/hdl
set ip_repo $root_dir/iprepo
set packaged_ip_dir $root_dir/packaged_ip
set constraint_dir $root_dir/constraint

# import hls ip
set_property IP_REPO_PATHS $ip_repo [current_fileset]
update_ip_catalog
add_files $hdl_dir

# Add constraints
add_files -fileset constrs_1 $constraint_dir/eth_mac_fifo.tcl
add_files -fileset constrs_1 $constraint_dir/sync_reset.tcl

# Add pcs/pma ip
create_ip -name gig_ethernet_pcs_pma -vendor xilinx.com -library ip -module_name gig_ethernet_pcs_pma_0
set_property -dict [list \
    CONFIG.Standard {SGMII} \
    CONFIG.Physical_Interface {Transceiver} \
    CONFIG.Management_Interface {false} \
    CONFIG.SupportLevel {Include_Shared_Logic_in_Core} \
] [get_ips gig_ethernet_pcs_pma_0]


#FIFOs
create_ip -name axis_data_fifo -vendor xilinx.com -library ip -version 2.0 -module_name axis_data_fifo_64_cc
set_property -dict [ list \
   CONFIG.TDATA_NUM_BYTES {8} \
   CONFIG.IS_ACLK_ASYNC {1} \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.SYNCHRONIZATION_STAGES {3} \
   CONFIG.Component_Name {axis_data_fifo_64_cc}
] [get_ips axis_data_fifo_64_cc]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_data_fifo_64_cc/axis_data_fifo_64_cc.xci]

create_ip -name axi_datamover -vendor xilinx.com -library ip -version 5.1 -module_name axi_datamover_64_to_512
set_property -dict [ list \
   CONFIG.c_m_axi_mm2s_data_width {512} \
   CONFIG.c_m_axis_mm2s_tdata_width {64} \
   CONFIG.c_include_mm2s_dre {true} \
   CONFIG.c_mm2s_burst_size {16} \
   CONFIG.c_m_axi_s2mm_data_width {512} \
   CONFIG.c_s_axis_s2mm_tdata_width {64} \
   CONFIG.c_include_s2mm_dre {true} \
   CONFIG.c_s2mm_burst_size {16} \
   CONFIG.c_mm2s_stscmd_is_async {true} \
   CONFIG.c_s2mm_stscmd_is_async {true}
] [get_ips axi_datamover_64_to_512]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axi_datamover_64_to_512/axi_datamover_64_to_512.xci]

create_ip -name axis_data_fifo -vendor xilinx.com -library ip -version 2.0 -module_name axis_data_fifo_64_d2048
set_property -dict [list \
   CONFIG.TDATA_NUM_BYTES {8} \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.Component_Name {axis_data_fifo_64_d2048}
] [get_ips axis_data_fifo_64_d2048]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_data_fifo_64_d2048/axis_data_fifo_64_d2048.xci]

create_ip -name axi_datamover -vendor xilinx.com -library ip -version 5.1 -module_name axi_datamover_512_to_512
set_property -dict [ list \
   CONFIG.c_m_axi_mm2s_data_width {512} \
   CONFIG.c_m_axis_mm2s_tdata_width {512} \
   CONFIG.c_include_mm2s_dre {true} \
   CONFIG.c_mm2s_burst_size {16} \
   CONFIG.c_m_axi_s2mm_data_width {512} \
   CONFIG.c_s_axis_s2mm_tdata_width {512} \
   CONFIG.c_include_s2mm_dre {true} \
   CONFIG.c_s2mm_burst_size {16} \
   CONFIG.c_mm2s_stscmd_is_async {true} \
   CONFIG.c_s2mm_stscmd_is_async {true}
] [get_ips axi_datamover_512_to_512]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axi_datamover_512_to_512/axi_datamover_512_to_512.xci]


#IPs used in network_stack.sv


#Data Width Converters

create_ip -name axis_dwidth_converter -vendor xilinx.com -library ip -version 1.1 -module_name axis_64_to_512_converter
set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {8} CONFIG.M_TDATA_NUM_BYTES {64} CONFIG.HAS_TLAST {1} CONFIG.HAS_TKEEP {1} CONFIG.HAS_MI_TKEEP {1} CONFIG.Component_Name {axis_64_to_512_converter}] [get_ips axis_64_to_512_converter]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_64_to_512_converter/axis_64_to_512_converter.xci]
update_compile_order -fileset sources_1

create_ip -name axis_dwidth_converter -vendor xilinx.com -library ip -version 1.1 -module_name axis_512_to_64_converter
set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {64} CONFIG.M_TDATA_NUM_BYTES {8} CONFIG.HAS_TLAST {1} CONFIG.HAS_TKEEP {1} CONFIG.HAS_MI_TKEEP {1} CONFIG.Component_Name {axis_512_to_64_converter}] [get_ips axis_512_to_64_converter]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_512_to_64_converter/axis_512_to_64_converter.xci]
update_compile_order -fileset sources_1

create_ip -name axis_dwidth_converter -vendor xilinx.com -library ip -version 1.1 -module_name axis_128_to_512_converter
set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {16} CONFIG.M_TDATA_NUM_BYTES {64} CONFIG.HAS_TLAST {1} CONFIG.HAS_TKEEP {1} CONFIG.HAS_MI_TKEEP {1} CONFIG.Component_Name {axis_128_to_512_converter}] [get_ips axis_128_to_512_converter]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_128_to_512_converter/axis_128_to_512_converter.xci]
update_compile_order -fileset sources_1

create_ip -name axis_dwidth_converter -vendor xilinx.com -library ip -version 1.1 -module_name axis_512_to_128_converter
set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {64} CONFIG.M_TDATA_NUM_BYTES {16} CONFIG.HAS_TLAST {1} CONFIG.HAS_TKEEP {1} CONFIG.HAS_MI_TKEEP {1} CONFIG.Component_Name {axis_512_to_128_converter}] [get_ips axis_512_to_128_converter]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_512_to_128_converter/axis_512_to_128_converter.xci]
update_compile_order -fileset sources_1

create_ip -name axis_dwidth_converter -vendor xilinx.com -library ip -version 1.1 -module_name axis_64_to_128_converter
set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {8} CONFIG.M_TDATA_NUM_BYTES {16} CONFIG.HAS_TLAST {1} CONFIG.HAS_TKEEP {1} CONFIG.HAS_MI_TKEEP {1} CONFIG.Component_Name {axis_64_to_128_converter}] [get_ips axis_64_to_128_converter]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_64_to_128_converter/axis_64_to_128_converter.xci]
update_compile_order -fileset sources_1

create_ip -name axis_dwidth_converter -vendor xilinx.com -library ip -version 1.1 -module_name axis_128_to_64_converter
set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {16} CONFIG.M_TDATA_NUM_BYTES {8} CONFIG.HAS_TLAST {1} CONFIG.HAS_TKEEP {1} CONFIG.HAS_MI_TKEEP {1} CONFIG.Component_Name {axis_128_to_64_converter}] [get_ips axis_128_to_64_converter]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_128_to_64_converter/axis_128_to_64_converter.xci]
update_compile_order -fileset sources_1

create_ip -name axis_dwidth_converter -vendor xilinx.com -library ip -version 1.1 -module_name axis_64_to_256_converter
set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {8} CONFIG.M_TDATA_NUM_BYTES {32} CONFIG.HAS_TLAST {1} CONFIG.HAS_TKEEP {1} CONFIG.HAS_MI_TKEEP {1} CONFIG.Component_Name {axis_64_to_256_converter}] [get_ips axis_64_to_256_converter]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_64_to_256_converter/axis_64_to_256_converter.xci]
update_compile_order -fileset sources_1

create_ip -name axis_dwidth_converter -vendor xilinx.com -library ip -version 1.1 -module_name axis_256_to_64_converter
set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {32} CONFIG.M_TDATA_NUM_BYTES {8} CONFIG.HAS_TLAST {1} CONFIG.HAS_TKEEP {1} CONFIG.HAS_MI_TKEEP {1} CONFIG.Component_Name {axis_256to_64_converter}] [get_ips axis_256_to_64_converter]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_256_to_64_converter/axis_256_to_64_converter.xci]
update_compile_order -fileset sources_1

create_ip -name axis_dwidth_converter -vendor xilinx.com -library ip -version 1.1 -module_name axis_256_to_512_converter
set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {32} CONFIG.M_TDATA_NUM_BYTES {64} CONFIG.HAS_TLAST {1} CONFIG.HAS_TKEEP {1} CONFIG.HAS_MI_TKEEP {1} CONFIG.Component_Name {axis_256_to_512_converter}] [get_ips axis_256_to_512_converter]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_256_to_512_converter/axis_256_to_512_converter.xci]
update_compile_order -fileset sources_1


create_ip -name axis_dwidth_converter -vendor xilinx.com -library ip -version 1.1 -module_name axis_512_to_256_converter
set_property -dict [list CONFIG.S_TDATA_NUM_BYTES {64} CONFIG.M_TDATA_NUM_BYTES {32} CONFIG.HAS_TLAST {1} CONFIG.HAS_TKEEP {1} CONFIG.HAS_MI_TKEEP {1} CONFIG.Component_Name {axis_512_to_256_converter}] [get_ips axis_512_to_256_converter]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_512_to_256_converter/axis_512_to_256_converter.xci]
update_compile_order -fileset sources_1


create_ip -name axi_crossbar -vendor xilinx.com -library ip -version 2.1 -module_name axil_controller_crossbar
set_property -dict [list CONFIG.PROTOCOL {AXI4LITE} CONFIG.CONNECTIVITY_MODE {SASD} CONFIG.R_REGISTER {1} CONFIG.NUM_MI {5} CONFIG.M01_A00_BASE_ADDR {0x0000000000001000} CONFIG.M02_A00_BASE_ADDR {0x0000000000002000} CONFIG.M03_A00_BASE_ADDR {0x0000000000003000} CONFIG.M04_A00_BASE_ADDR {0x0000000000004000} CONFIG.S00_WRITE_ACCEPTANCE {1} CONFIG.S01_WRITE_ACCEPTANCE {1} CONFIG.S02_WRITE_ACCEPTANCE {1} CONFIG.S03_WRITE_ACCEPTANCE {1} CONFIG.S04_WRITE_ACCEPTANCE {1} CONFIG.S05_WRITE_ACCEPTANCE {1} CONFIG.S06_WRITE_ACCEPTANCE {1} CONFIG.S07_WRITE_ACCEPTANCE {1} CONFIG.S08_WRITE_ACCEPTANCE {1} CONFIG.S09_WRITE_ACCEPTANCE {1} CONFIG.S10_WRITE_ACCEPTANCE {1} CONFIG.S11_WRITE_ACCEPTANCE {1} CONFIG.S12_WRITE_ACCEPTANCE {1} CONFIG.S13_WRITE_ACCEPTANCE {1} CONFIG.S14_WRITE_ACCEPTANCE {1} CONFIG.S15_WRITE_ACCEPTANCE {1} CONFIG.S00_READ_ACCEPTANCE {1} CONFIG.S01_READ_ACCEPTANCE {1} CONFIG.S02_READ_ACCEPTANCE {1} CONFIG.S03_READ_ACCEPTANCE {1} CONFIG.S04_READ_ACCEPTANCE {1} CONFIG.S05_READ_ACCEPTANCE {1} CONFIG.S06_READ_ACCEPTANCE {1} CONFIG.S07_READ_ACCEPTANCE {1} CONFIG.S08_READ_ACCEPTANCE {1} CONFIG.S09_READ_ACCEPTANCE {1} CONFIG.S10_READ_ACCEPTANCE {1} CONFIG.S11_READ_ACCEPTANCE {1} CONFIG.S12_READ_ACCEPTANCE {1} CONFIG.S13_READ_ACCEPTANCE {1} CONFIG.S14_READ_ACCEPTANCE {1} CONFIG.S15_READ_ACCEPTANCE {1} CONFIG.M00_WRITE_ISSUING {1} CONFIG.M01_WRITE_ISSUING {1} CONFIG.M02_WRITE_ISSUING {1} CONFIG.M03_WRITE_ISSUING {1} CONFIG.M04_WRITE_ISSUING {1} CONFIG.M05_WRITE_ISSUING {1} CONFIG.M06_WRITE_ISSUING {1} CONFIG.M07_WRITE_ISSUING {1} CONFIG.M08_WRITE_ISSUING {1} CONFIG.M09_WRITE_ISSUING {1} CONFIG.M10_WRITE_ISSUING {1} CONFIG.M11_WRITE_ISSUING {1} CONFIG.M12_WRITE_ISSUING {1} CONFIG.M13_WRITE_ISSUING {1} CONFIG.M14_WRITE_ISSUING {1} CONFIG.M15_WRITE_ISSUING {1} CONFIG.M00_READ_ISSUING {1} CONFIG.M01_READ_ISSUING {1} CONFIG.M02_READ_ISSUING {1} CONFIG.M03_READ_ISSUING {1} CONFIG.M04_READ_ISSUING {1} CONFIG.M05_READ_ISSUING {1} CONFIG.M06_READ_ISSUING {1} CONFIG.M07_READ_ISSUING {1} CONFIG.M08_READ_ISSUING {1} CONFIG.M09_READ_ISSUING {1} CONFIG.M10_READ_ISSUING {1} CONFIG.M11_READ_ISSUING {1} CONFIG.M12_READ_ISSUING {1} CONFIG.M13_READ_ISSUING {1} CONFIG.M14_READ_ISSUING {1} CONFIG.M15_READ_ISSUING {1} CONFIG.S00_SINGLE_THREAD {1} CONFIG.Component_Name {axil_controller_crossbar}] [get_ips axil_controller_crossbar]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axil_controller_crossbar/axil_controller_crossbar.xci]
update_compile_order -fileset sources_1

#FIFO / RX Buffer
create_ip -name axis_data_fifo -vendor xilinx.com -library ip -version 2.0 -module_name axis_data_fifo_64_d1024
set_property -dict [list CONFIG.TDATA_NUM_BYTES {8} CONFIG.FIFO_DEPTH {1024} CONFIG.HAS_TKEEP {1} CONFIG.HAS_TLAST {1} CONFIG.HAS_WR_DATA_COUNT {1} CONFIG.HAS_RD_DATA_COUNT {1} CONFIG.Component_Name {axis_data_fifo_64_d1024}] [get_ips axis_data_fifo_64_d1024]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_data_fifo_64_d1024/axis_data_fifo_64_d1024.xci]
update_compile_order -fileset sources_1

create_ip -name axis_data_fifo -vendor xilinx.com -library ip -version 2.0 -module_name axis_data_fifo_128_d1024
set_property -dict [list CONFIG.TDATA_NUM_BYTES {16} CONFIG.FIFO_DEPTH {1024} CONFIG.HAS_TKEEP {1} CONFIG.HAS_TLAST {1} CONFIG.HAS_WR_DATA_COUNT {1} CONFIG.HAS_RD_DATA_COUNT {1} CONFIG.Component_Name {axis_data_fifo_128_d1024}] [get_ips axis_data_fifo_128_d1024]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_data_fifo_128_d1024/axis_data_fifo_128_d1024.xci]
update_compile_order -fileset sources_1

create_ip -name axis_data_fifo -vendor xilinx.com -library ip -version 2.0 -module_name axis_data_fifo_256_d1024
set_property -dict [list CONFIG.TDATA_NUM_BYTES {32} CONFIG.FIFO_DEPTH {1024} CONFIG.HAS_TKEEP {1} CONFIG.HAS_TLAST {1} CONFIG.HAS_WR_DATA_COUNT {1} CONFIG.HAS_RD_DATA_COUNT {1} CONFIG.Component_Name {axis_data_fifo_256_d1024}] [get_ips axis_data_fifo_256_d1024]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_data_fifo_256_d1024/axis_data_fifo_256_d1024.xci]
update_compile_order -fileset sources_1

create_ip -name axis_data_fifo -vendor xilinx.com -library ip -version 2.0 -module_name axis_data_fifo_512_d1024
set_property -dict [list CONFIG.TDATA_NUM_BYTES {64} CONFIG.FIFO_DEPTH {1024} CONFIG.HAS_TKEEP {1} CONFIG.HAS_TLAST {1} CONFIG.HAS_WR_DATA_COUNT {1} CONFIG.HAS_RD_DATA_COUNT {1} CONFIG.Component_Name {axis_data_fifo_512_d1024}] [get_ips axis_data_fifo_512_d1024]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_data_fifo_512_d1024/axis_data_fifo_512_d1024.xci]
update_compile_order -fileset sources_1

create_ip -name axis_data_fifo -vendor xilinx.com -library ip -version 2.0 -module_name axis_data_fifo_64_d4096
set_property -dict [list CONFIG.TDATA_NUM_BYTES {8} CONFIG.FIFO_DEPTH {4096} CONFIG.HAS_TKEEP {1} CONFIG.HAS_TLAST {1} CONFIG.HAS_WR_DATA_COUNT {1} CONFIG.HAS_RD_DATA_COUNT {1} CONFIG.Component_Name {axis_data_fifo_64_d4096}] [get_ips axis_data_fifo_64_d4096]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_data_fifo_64_d4096/axis_data_fifo_64_d4096.xci]
update_compile_order -fileset sources_1

create_ip -name axis_data_fifo -vendor xilinx.com -library ip -version 2.0 -module_name axis_data_fifo_128_d4096
set_property -dict [list CONFIG.TDATA_NUM_BYTES {16} CONFIG.FIFO_DEPTH {4096} CONFIG.HAS_TKEEP {1} CONFIG.HAS_TLAST {1} CONFIG.HAS_WR_DATA_COUNT {1} CONFIG.HAS_RD_DATA_COUNT {1} CONFIG.Component_Name {axis_data_fifo_128_d4096}] [get_ips axis_data_fifo_128_d4096]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_data_fifo_128_d4096/axis_data_fifo_128_d4096.xci]
update_compile_order -fileset sources_1

create_ip -name axis_data_fifo -vendor xilinx.com -library ip -version 2.0 -module_name axis_data_fifo_256_d4096
set_property -dict [list CONFIG.TDATA_NUM_BYTES {32} CONFIG.FIFO_DEPTH {4096} CONFIG.HAS_TKEEP {1} CONFIG.HAS_TLAST {1} CONFIG.HAS_WR_DATA_COUNT {1} CONFIG.HAS_RD_DATA_COUNT {1} CONFIG.Component_Name {axis_data_fifo_256_d4096}] [get_ips axis_data_fifo_256_d4096]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_data_fifo_256_d4096/axis_data_fifo_256_d4096.xci]
update_compile_order -fileset sources_1

create_ip -name axis_data_fifo -vendor xilinx.com -library ip -version 2.0 -module_name axis_data_fifo_512_d4096
set_property -dict [list CONFIG.TDATA_NUM_BYTES {64} CONFIG.FIFO_DEPTH {4096} CONFIG.HAS_TKEEP {1} CONFIG.HAS_TLAST {1} CONFIG.HAS_WR_DATA_COUNT {1} CONFIG.HAS_RD_DATA_COUNT {1} CONFIG.Component_Name {axis_data_fifo_512_d4096}] [get_ips axis_data_fifo_512_d4096]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_data_fifo_512_d4096/axis_data_fifo_512_d4096.xci]
update_compile_order -fileset sources_1

#Register slices
create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name axis_register_slice_8
set_property -dict [list CONFIG.TDATA_NUM_BYTES {1} CONFIG.Component_Name {axis_register_slice_8}] [get_ips axis_register_slice_8]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_register_slice_8/axis_register_slice_8.xci]
update_compile_order -fileset sources_1

create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name axis_register_slice_16
set_property -dict [list CONFIG.TDATA_NUM_BYTES {2} CONFIG.Component_Name {axis_register_slice_16}] [get_ips axis_register_slice_16]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_register_slice_16/axis_register_slice_16.xci]
update_compile_order -fileset sources_1

create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name axis_register_slice_24
set_property -dict [list CONFIG.TDATA_NUM_BYTES {3} CONFIG.Component_Name {axis_register_slice_24}] [get_ips axis_register_slice_24]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_register_slice_24/axis_register_slice_24.xci]
update_compile_order -fileset sources_1

create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name axis_register_slice_32
set_property -dict [list CONFIG.TDATA_NUM_BYTES {4} CONFIG.Component_Name {axis_register_slice_32}] [get_ips axis_register_slice_32]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_register_slice_32/axis_register_slice_32.xci]
update_compile_order -fileset sources_1

create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name axis_register_slice_48
set_property -dict [list CONFIG.TDATA_NUM_BYTES {6} CONFIG.Component_Name {axis_register_slice_48}] [get_ips axis_register_slice_48]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_register_slice_48/axis_register_slice_48.xci]
update_compile_order -fileset sources_1

create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name axis_register_slice_56
set_property -dict [list CONFIG.TDATA_NUM_BYTES {7} CONFIG.Component_Name {axis_register_slice_56}] [get_ips axis_register_slice_56]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_register_slice_56/axis_register_slice_56.xci]
update_compile_order -fileset sources_1

create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name meta_axis_register_slice_64
set_property -dict [list CONFIG.TDATA_NUM_BYTES {8} CONFIG.Component_Name {meta_axis_register_slice_64}] [get_ips meta_axis_register_slice_64]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/meta_axis_register_slice_64/meta_axis_register_slice_64.xci]
update_compile_order -fileset sources_1

create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name axis_register_slice_64
set_property -dict [list CONFIG.TDATA_NUM_BYTES {8} CONFIG.HAS_TKEEP {1} CONFIG.HAS_TLAST {1} CONFIG.Component_Name {axis_register_slice_64}] [get_ips axis_register_slice_64]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_register_slice_64/axis_register_slice_64.xci]
update_compile_order -fileset sources_1

create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name axis_register_slice_88
set_property -dict [list CONFIG.TDATA_NUM_BYTES {11} CONFIG.Component_Name {axis_register_slice_88}] [get_ips axis_register_slice_88]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_register_slice_88/axis_register_slice_88.xci]
update_compile_order -fileset sources_1

create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name axis_register_slice_96
set_property -dict [list CONFIG.TDATA_NUM_BYTES {12} CONFIG.Component_Name {axis_register_slice_96}] [get_ips axis_register_slice_96]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_register_slice_96/axis_register_slice_96.xci]
update_compile_order -fileset sources_1

create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name axis_register_slice_128
set_property -dict [list CONFIG.TDATA_NUM_BYTES {16} CONFIG.HAS_TKEEP {1} CONFIG.HAS_TLAST {1} CONFIG.Component_Name {axis_register_slice_128}] [get_ips axis_register_slice_128]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_register_slice_128/axis_register_slice_128.xci]
update_compile_order -fileset sources_1

create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name axis_register_slice_176
set_property -dict [list CONFIG.TDATA_NUM_BYTES {22} CONFIG.Component_Name {axis_register_slice_176}] [get_ips axis_register_slice_176]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_register_slice_176/axis_register_slice_176.xci]
update_compile_order -fileset sources_1

create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name axis_register_slice_256
set_property -dict [list CONFIG.TDATA_NUM_BYTES {32} CONFIG.HAS_TKEEP {1} CONFIG.HAS_TLAST {1} CONFIG.Component_Name {axis_register_slice_256}] [get_ips axis_register_slice_256]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_register_slice_256/axis_register_slice_256.xci]
update_compile_order -fileset sources_1

create_ip -name axis_register_slice -vendor xilinx.com -library ip -version 1.1 -module_name axis_register_slice_512
set_property -dict [list CONFIG.TDATA_NUM_BYTES {64} CONFIG.HAS_TKEEP {1} CONFIG.HAS_TLAST {1} CONFIG.Component_Name {axis_register_slice_512}] [get_ips axis_register_slice_512]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_register_slice_512/axis_register_slice_512.xci]
update_compile_order -fileset sources_1


#FIFOs

create_ip -name axis_data_fifo -vendor xilinx.com -library ip -version 2.0 -module_name axis_data_fifo_96
set_property -dict [list CONFIG.TDATA_NUM_BYTES {12} CONFIG.Component_Name {axis_data_fifo_96}] [get_ips axis_data_fifo_96]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_data_fifo_96/axis_data_fifo_96.xci]
update_compile_order -fileset sources_1

create_ip -name axis_data_fifo -vendor xilinx.com -library ip -version 2.0 -module_name axis_data_fifo_160
set_property -dict [list CONFIG.TDATA_NUM_BYTES {20} CONFIG.Component_Name {axis_data_fifo_160} CONFIG.HAS_WR_DATA_COUNT {1} CONFIG.HAS_RD_DATA_COUNT {1}] [get_ips axis_data_fifo_160]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_data_fifo_160/axis_data_fifo_160.xci]
update_compile_order -fileset sources_1

create_ip -name axis_data_fifo -vendor xilinx.com -library ip -version 2.0 -module_name axis_data_fifo_160_cc
set_property -dict [list CONFIG.TDATA_NUM_BYTES {20} CONFIG.IS_ACLK_ASYNC {1} CONFIG.Component_Name {axis_data_fifo_160_cc} CONFIG.HAS_WR_DATA_COUNT {1} CONFIG.HAS_RD_DATA_COUNT {1}] [get_ips axis_data_fifo_160_cc]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_data_fifo_160_cc/axis_data_fifo_160_cc.xci]
update_compile_order -fileset sources_1

create_ip -name axis_data_fifo -vendor xilinx.com -library ip -version 2.0 -module_name axis_data_fifo_512_cc
set_property -dict [list CONFIG.TDATA_NUM_BYTES {64} CONFIG.IS_ACLK_ASYNC {1} CONFIG.HAS_TKEEP {1} CONFIG.HAS_TLAST {1} CONFIG.Component_Name {axis_data_fifo_512_cc}] [get_ips axis_data_fifo_512_cc]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_data_fifo_512_cc/axis_data_fifo_512_cc.xci]
update_compile_order -fileset sources_1


create_ip -name axi_register_slice -vendor xilinx.com -library ip -version 2.1 -module_name axi_register_slice
set_property -dict [list CONFIG.PROTOCOL {AXI4LITE} CONFIG.REG_W {7} CONFIG.REG_R {7} CONFIG.Component_Name {axi_register_slice}] [get_ips axi_register_slice]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axi_register_slice/axi_register_slice.xci]
update_compile_order -fileset sources_1

#Interconnects
create_ip -name axis_interconnect -vendor xilinx.com -library ip -version 1.1 -module_name axis_interconnect_96_1to2
set_property -dict [list CONFIG.Component_Name {axis_interconnect_96_1to2} CONFIG.C_NUM_MI_SLOTS {2} CONFIG.SWITCH_TDATA_NUM_BYTES {12} CONFIG.HAS_TSTRB {false} CONFIG.HAS_TKEEP {false} CONFIG.HAS_TLAST {false} CONFIG.HAS_TID {false} CONFIG.C_M00_AXIS_REG_CONFIG {1} CONFIG.C_S00_AXIS_REG_CONFIG {1} CONFIG.C_M01_AXIS_REG_CONFIG {1} CONFIG.HAS_TDEST {true} CONFIG.C_SWITCH_TDEST_WIDTH {1} CONFIG.SWITCH_PACKET_MODE {false} CONFIG.C_SWITCH_MAX_XFERS_PER_ARB {1} CONFIG.C_SWITCH_NUM_CYCLES_TIMEOUT {0} CONFIG.M00_AXIS_TDATA_NUM_BYTES {12} CONFIG.S00_AXIS_TDATA_NUM_BYTES {12} CONFIG.M01_AXIS_TDATA_NUM_BYTES {12} CONFIG.C_M00_AXIS_BASETDEST {0x00000000} CONFIG.C_M00_AXIS_HIGHTDEST {0x00000000} CONFIG.C_M01_AXIS_BASETDEST {0x00000001} CONFIG.C_M01_AXIS_HIGHTDEST {0x00000001} CONFIG.M01_S00_CONNECTIVITY {true}] [get_ips axis_interconnect_96_1to2]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_interconnect_96_1to2/axis_interconnect_96_1to2.xci]
update_compile_order -fileset sources_1

create_ip -name axis_interconnect -vendor xilinx.com -library ip -version 1.1 -module_name axis_interconnect_160_2to1
set_property -dict [list CONFIG.Component_Name {axis_interconnect_160_2to1} CONFIG.C_NUM_SI_SLOTS {2} CONFIG.SWITCH_TDATA_NUM_BYTES {20} CONFIG.HAS_TSTRB {false} CONFIG.HAS_TKEEP {false} CONFIG.HAS_TLAST {false} CONFIG.HAS_TID {false} CONFIG.HAS_TDEST {false} CONFIG.C_SWITCH_MAX_XFERS_PER_ARB {1} CONFIG.C_SWITCH_NUM_CYCLES_TIMEOUT {0} CONFIG.M00_AXIS_TDATA_NUM_BYTES {20} CONFIG.S00_AXIS_TDATA_NUM_BYTES {20} CONFIG.S01_AXIS_TDATA_NUM_BYTES {20} CONFIG.M00_S01_CONNECTIVITY {true}] [get_ips axis_interconnect_160_2to1]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_interconnect_160_2to1/axis_interconnect_160_2to1.xci]
update_compile_order -fileset sources_1

create_ip -name axis_interconnect -vendor xilinx.com -library ip -version 1.1 -module_name axis_interconnect_64_1to2
set_property -dict [list CONFIG.Component_Name {axis_interconnect_64_1to2} CONFIG.C_NUM_MI_SLOTS {2} CONFIG.SWITCH_TDATA_NUM_BYTES {8} CONFIG.HAS_TSTRB {false} CONFIG.HAS_TID {false} CONFIG.C_M00_AXIS_REG_CONFIG {1} CONFIG.C_S00_AXIS_REG_CONFIG {1} CONFIG.C_M01_AXIS_REG_CONFIG {1} CONFIG.HAS_TDEST {true} CONFIG.C_SWITCH_TDEST_WIDTH {1} CONFIG.C_SWITCH_NUM_CYCLES_TIMEOUT {0} CONFIG.M00_AXIS_TDATA_NUM_BYTES {8} CONFIG.S00_AXIS_TDATA_NUM_BYTES {8} CONFIG.M01_AXIS_TDATA_NUM_BYTES {8} CONFIG.C_M00_AXIS_BASETDEST {0x00000000} CONFIG.C_M00_AXIS_HIGHTDEST {0x00000000} CONFIG.C_M01_AXIS_BASETDEST {0x00000001} CONFIG.C_M01_AXIS_HIGHTDEST {0x00000001} CONFIG.M01_S00_CONNECTIVITY {true}] [get_ips axis_interconnect_64_1to2]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_interconnect_64_1to2/axis_interconnect_64_1to2.xci]
update_compile_order -fileset sources_1

create_ip -name axis_interconnect -vendor xilinx.com -library ip -version 1.1 -module_name axis_interconnect_512_1to2
set_property -dict [list CONFIG.Component_Name {axis_interconnect_512_1to2} CONFIG.C_NUM_MI_SLOTS {2} CONFIG.SWITCH_TDATA_NUM_BYTES {64} CONFIG.HAS_TSTRB {false} CONFIG.HAS_TID {false} CONFIG.C_M00_AXIS_REG_CONFIG {1} CONFIG.C_S00_AXIS_REG_CONFIG {1} CONFIG.C_M01_AXIS_REG_CONFIG {1} CONFIG.HAS_TDEST {true} CONFIG.C_SWITCH_TDEST_WIDTH {1} CONFIG.C_SWITCH_NUM_CYCLES_TIMEOUT {0} CONFIG.M00_AXIS_TDATA_NUM_BYTES {64} CONFIG.S00_AXIS_TDATA_NUM_BYTES {64} CONFIG.M01_AXIS_TDATA_NUM_BYTES {64} CONFIG.C_M00_AXIS_BASETDEST {0x00000000} CONFIG.C_M00_AXIS_HIGHTDEST {0x00000000} CONFIG.C_M01_AXIS_BASETDEST {0x00000001} CONFIG.C_M01_AXIS_HIGHTDEST {0x00000001} CONFIG.M01_S00_CONNECTIVITY {true}] [get_ips axis_interconnect_512_1to2]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_interconnect_512_1to2/axis_interconnect_512_1to2.xci]
update_compile_order -fileset sources_1

create_ip -name axis_interconnect -vendor xilinx.com -library ip -version 1.1 -module_name axis_interconnect_merger_160
set_property -dict [list CONFIG.Component_Name {axis_interconnect_merger_160} CONFIG.C_NUM_SI_SLOTS {2} CONFIG.SWITCH_TDATA_NUM_BYTES {20} CONFIG.HAS_TSTRB {false} CONFIG.HAS_TKEEP {false} CONFIG.HAS_TLAST {false} CONFIG.HAS_TID {false} CONFIG.HAS_TDEST {false} CONFIG.SWITCH_PACKET_MODE {false} CONFIG.C_SWITCH_MAX_XFERS_PER_ARB {1} CONFIG.C_SWITCH_NUM_CYCLES_TIMEOUT {0} CONFIG.M00_AXIS_TDATA_NUM_BYTES {20} CONFIG.S00_AXIS_TDATA_NUM_BYTES {20} CONFIG.S01_AXIS_TDATA_NUM_BYTES {20} CONFIG.M00_S01_CONNECTIVITY {true}] [get_ips axis_interconnect_merger_160]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_interconnect_merger_160/axis_interconnect_merger_160.xci]
update_compile_order -fileset sources_1

create_ip -name axis_interconnect -vendor xilinx.com -library ip -version 1.1 -module_name axis_interconnect_2to1
set_property -dict [list CONFIG.C_NUM_SI_SLOTS {2} CONFIG.SWITCH_TDATA_NUM_BYTES {8} CONFIG.HAS_TSTRB {false} CONFIG.HAS_TID {false} CONFIG.HAS_TDEST {false} CONFIG.SWITCH_PACKET_MODE {true} CONFIG.C_SWITCH_MAX_XFERS_PER_ARB {0} CONFIG.C_M00_AXIS_REG_CONFIG {1} CONFIG.C_S00_AXIS_REG_CONFIG {1} CONFIG.C_S01_AXIS_REG_CONFIG {1} CONFIG.C_SWITCH_NUM_CYCLES_TIMEOUT {0} CONFIG.M00_AXIS_TDATA_NUM_BYTES {8} CONFIG.S00_AXIS_TDATA_NUM_BYTES {8} CONFIG.S01_AXIS_TDATA_NUM_BYTES {8} CONFIG.M00_S01_CONNECTIVITY {true}] [get_ips axis_interconnect_2to1]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_interconnect_2to1/axis_interconnect_2to1.xci]
update_compile_order -fileset sources_1

create_ip -name axis_interconnect -vendor xilinx.com -library ip -version 1.1 -module_name axis_interconnect_3to1
set_property -dict [list CONFIG.C_NUM_SI_SLOTS {3} CONFIG.SWITCH_TDATA_NUM_BYTES {8} CONFIG.HAS_TSTRB {false} CONFIG.HAS_TID {false} CONFIG.HAS_TDEST {false} CONFIG.SWITCH_PACKET_MODE {true} CONFIG.C_S00_AXIS_REG_CONFIG {1} CONFIG.C_S01_AXIS_REG_CONFIG {1} CONFIG.C_S02_AXIS_REG_CONFIG {1} CONFIG.C_SWITCH_MAX_XFERS_PER_ARB {0} CONFIG.C_SWITCH_NUM_CYCLES_TIMEOUT {0} CONFIG.M00_AXIS_TDATA_NUM_BYTES {8} CONFIG.S00_AXIS_TDATA_NUM_BYTES {8} CONFIG.S01_AXIS_TDATA_NUM_BYTES {8} CONFIG.S02_AXIS_TDATA_NUM_BYTES {8} CONFIG.M00_S01_CONNECTIVITY {true} CONFIG.M00_S02_CONNECTIVITY {true}] [get_ips axis_interconnect_3to1]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_interconnect_3to1/axis_interconnect_3to1.xci]
update_compile_order -fileset sources_1

create_ip -name axis_interconnect -vendor xilinx.com -library ip -version 1.1 -module_name axis_interconnect_4to1
set_property -dict [list CONFIG.C_NUM_SI_SLOTS {4} CONFIG.SWITCH_TDATA_NUM_BYTES {8} CONFIG.HAS_TSTRB {false} CONFIG.HAS_TID {false} CONFIG.HAS_TDEST {false} CONFIG.SWITCH_PACKET_MODE {true} CONFIG.C_SWITCH_MAX_XFERS_PER_ARB {0} CONFIG.C_M00_AXIS_REG_CONFIG {1} CONFIG.C_S00_AXIS_REG_CONFIG {1} CONFIG.C_S01_AXIS_REG_CONFIG {1} CONFIG.C_S02_AXIS_REG_CONFIG {1} CONFIG.C_S03_AXIS_REG_CONFIG {1} CONFIG.C_SWITCH_NUM_CYCLES_TIMEOUT {0} CONFIG.M00_AXIS_TDATA_NUM_BYTES {8} CONFIG.S00_AXIS_TDATA_NUM_BYTES {8} CONFIG.S01_AXIS_TDATA_NUM_BYTES {8} CONFIG.S02_AXIS_TDATA_NUM_BYTES {8} CONFIG.S03_AXIS_TDATA_NUM_BYTES {8} CONFIG.M00_S01_CONNECTIVITY {true} CONFIG.M00_S02_CONNECTIVITY {true} CONFIG.M00_S03_CONNECTIVITY {true}] [get_ips axis_interconnect_4to1]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_interconnect_4to1/axis_interconnect_4to1.xci]
update_compile_order -fileset sources_1

create_ip -name axis_interconnect -vendor xilinx.com -library ip -version 1.1 -module_name axis_interconnect_128_2to1
set_property -dict [list CONFIG.C_NUM_SI_SLOTS {2} CONFIG.SWITCH_TDATA_NUM_BYTES {16} CONFIG.HAS_TSTRB {false} CONFIG.HAS_TID {false} CONFIG.HAS_TDEST {false} CONFIG.SWITCH_PACKET_MODE {true} CONFIG.C_SWITCH_MAX_XFERS_PER_ARB {0} CONFIG.C_M00_AXIS_REG_CONFIG {1} CONFIG.C_S00_AXIS_REG_CONFIG {1} CONFIG.C_S01_AXIS_REG_CONFIG {1} CONFIG.C_SWITCH_NUM_CYCLES_TIMEOUT {0} CONFIG.M00_AXIS_TDATA_NUM_BYTES {16} CONFIG.S00_AXIS_TDATA_NUM_BYTES {16} CONFIG.S01_AXIS_TDATA_NUM_BYTES {16} CONFIG.M00_S01_CONNECTIVITY {true}] [get_ips axis_interconnect_128_2to1]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_interconnect_128_2to1/axis_interconnect_128_2to1.xci]
update_compile_order -fileset sources_1

create_ip -name axis_interconnect -vendor xilinx.com -library ip -version 1.1 -module_name axis_interconnect_128_4to1
set_property -dict [list CONFIG.C_NUM_SI_SLOTS {4} CONFIG.SWITCH_TDATA_NUM_BYTES {16} CONFIG.HAS_TSTRB {false} CONFIG.HAS_TID {false} CONFIG.HAS_TDEST {false} CONFIG.SWITCH_PACKET_MODE {true} CONFIG.C_SWITCH_MAX_XFERS_PER_ARB {0} CONFIG.C_M00_AXIS_REG_CONFIG {1} CONFIG.C_S00_AXIS_REG_CONFIG {1} CONFIG.C_S01_AXIS_REG_CONFIG {1} CONFIG.C_S02_AXIS_REG_CONFIG {1} CONFIG.C_S03_AXIS_REG_CONFIG {1} CONFIG.C_SWITCH_NUM_CYCLES_TIMEOUT {0} CONFIG.M00_AXIS_TDATA_NUM_BYTES {16} CONFIG.S00_AXIS_TDATA_NUM_BYTES {16} CONFIG.S01_AXIS_TDATA_NUM_BYTES {16} CONFIG.S02_AXIS_TDATA_NUM_BYTES {16} CONFIG.S03_AXIS_TDATA_NUM_BYTES {16} CONFIG.M00_S01_CONNECTIVITY {true} CONFIG.M00_S02_CONNECTIVITY {true} CONFIG.M00_S03_CONNECTIVITY {true}] [get_ips axis_interconnect_128_4to1]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_interconnect_4to1/axis_interconnect_128_4to1.xci]
update_compile_order -fileset sources_1

create_ip -name axis_interconnect -vendor xilinx.com -library ip -version 1.1 -module_name axis_interconnect_256_2to1
set_property -dict [list CONFIG.C_NUM_SI_SLOTS {2} CONFIG.SWITCH_TDATA_NUM_BYTES {32} CONFIG.HAS_TSTRB {false} CONFIG.HAS_TID {false} CONFIG.HAS_TDEST {false} CONFIG.SWITCH_PACKET_MODE {true} CONFIG.C_SWITCH_MAX_XFERS_PER_ARB {0} CONFIG.C_M00_AXIS_REG_CONFIG {1} CONFIG.C_S00_AXIS_REG_CONFIG {1} CONFIG.C_S01_AXIS_REG_CONFIG {1} CONFIG.C_SWITCH_NUM_CYCLES_TIMEOUT {0} CONFIG.M00_AXIS_TDATA_NUM_BYTES {32} CONFIG.S00_AXIS_TDATA_NUM_BYTES {32} CONFIG.S01_AXIS_TDATA_NUM_BYTES {32} CONFIG.M00_S01_CONNECTIVITY {true}] [get_ips axis_interconnect_256_2to1]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_interconnect_256_2to1/axis_interconnect_256_2to1.xci]
update_compile_order -fileset sources_1

create_ip -name axis_interconnect -vendor xilinx.com -library ip -version 1.1 -module_name axis_interconnect_256_4to1
set_property -dict [list CONFIG.C_NUM_SI_SLOTS {4} CONFIG.SWITCH_TDATA_NUM_BYTES {32} CONFIG.HAS_TSTRB {false} CONFIG.HAS_TID {false} CONFIG.HAS_TDEST {false} CONFIG.SWITCH_PACKET_MODE {true} CONFIG.C_SWITCH_MAX_XFERS_PER_ARB {0} CONFIG.C_M00_AXIS_REG_CONFIG {1} CONFIG.C_S00_AXIS_REG_CONFIG {1} CONFIG.C_S01_AXIS_REG_CONFIG {1} CONFIG.C_S02_AXIS_REG_CONFIG {1} CONFIG.C_S03_AXIS_REG_CONFIG {1} CONFIG.C_SWITCH_NUM_CYCLES_TIMEOUT {0} CONFIG.M00_AXIS_TDATA_NUM_BYTES {32} CONFIG.S00_AXIS_TDATA_NUM_BYTES {32} CONFIG.S01_AXIS_TDATA_NUM_BYTES {32} CONFIG.S02_AXIS_TDATA_NUM_BYTES {32} CONFIG.S03_AXIS_TDATA_NUM_BYTES {32} CONFIG.M00_S01_CONNECTIVITY {true} CONFIG.M00_S02_CONNECTIVITY {true} CONFIG.M00_S03_CONNECTIVITY {true}] [get_ips axis_interconnect_256_4to1]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_interconnect_4to1/axis_interconnect_256_4to1.xci]
update_compile_order -fileset sources_1

create_ip -name axis_interconnect -vendor xilinx.com -library ip -version 1.1 -module_name axis_interconnect_512_2to1
set_property -dict [list CONFIG.C_NUM_SI_SLOTS {2} CONFIG.SWITCH_TDATA_NUM_BYTES {64} CONFIG.HAS_TSTRB {false} CONFIG.HAS_TID {false} CONFIG.HAS_TDEST {false} CONFIG.SWITCH_PACKET_MODE {true} CONFIG.C_SWITCH_MAX_XFERS_PER_ARB {0} CONFIG.C_M00_AXIS_REG_CONFIG {1} CONFIG.C_S00_AXIS_REG_CONFIG {1} CONFIG.C_S01_AXIS_REG_CONFIG {1} CONFIG.C_SWITCH_NUM_CYCLES_TIMEOUT {0} CONFIG.M00_AXIS_TDATA_NUM_BYTES {64} CONFIG.S00_AXIS_TDATA_NUM_BYTES {64} CONFIG.S01_AXIS_TDATA_NUM_BYTES {64} CONFIG.M00_S01_CONNECTIVITY {true}] [get_ips axis_interconnect_512_2to1]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_interconnect_512_2to1/axis_interconnect_512_2to1.xci]
update_compile_order -fileset sources_1

create_ip -name axis_interconnect -vendor xilinx.com -library ip -version 1.1 -module_name axis_interconnect_512_4to1
set_property -dict [list CONFIG.C_NUM_SI_SLOTS {4} CONFIG.SWITCH_TDATA_NUM_BYTES {64} CONFIG.HAS_TSTRB {false} CONFIG.HAS_TID {false} CONFIG.HAS_TDEST {false} CONFIG.SWITCH_PACKET_MODE {true} CONFIG.C_SWITCH_MAX_XFERS_PER_ARB {0} CONFIG.C_M00_AXIS_REG_CONFIG {1} CONFIG.C_S00_AXIS_REG_CONFIG {1} CONFIG.C_S01_AXIS_REG_CONFIG {1} CONFIG.C_S02_AXIS_REG_CONFIG {1} CONFIG.C_S03_AXIS_REG_CONFIG {1} CONFIG.C_SWITCH_NUM_CYCLES_TIMEOUT {0} CONFIG.M00_AXIS_TDATA_NUM_BYTES {64} CONFIG.S00_AXIS_TDATA_NUM_BYTES {64} CONFIG.S01_AXIS_TDATA_NUM_BYTES {64} CONFIG.S02_AXIS_TDATA_NUM_BYTES {64} CONFIG.S03_AXIS_TDATA_NUM_BYTES {64} CONFIG.M00_S01_CONNECTIVITY {true} CONFIG.M00_S02_CONNECTIVITY {true} CONFIG.M00_S03_CONNECTIVITY {true}] [get_ips axis_interconnect_512_4to1]
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/axis_interconnect_4to1/axis_interconnect_512_4to1.xci]
update_compile_order -fileset sources_1


#HLS IP cores

create_ip -name toe -vendor ethz.systems -library hls -version 1.6 -module_name toe_ip
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/toe_ip/toe_ip.xci]
update_compile_order -fileset sources_1

create_ip -name ip_handler -vendor ethz.systems.fpga -library hls -version 2.0 -module_name ip_handler_ip
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/ip_handler_ip/ip_handler_ip.xci]
update_compile_order -fileset sources_1

create_ip -name mac_ip_encode -vendor ethz.systems.fpga -library hls -version 2.0 -module_name mac_ip_encode_ip
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/mac_ip_encode_ip/mac_ip_encode_ip.xci]
update_compile_order -fileset sources_1

create_ip -name icmp_server -vendor xilinx.labs -library hls -version 1.67 -module_name icmp_server_ip
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/icmp_server_ip/icmp_server_ip.xci]
update_compile_order -fileset sources_1

create_ip -name arp_server_subnet -vendor ethz.systems.fpga -library hls -version 1.1 -module_name arp_server_subnet_ip
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/arp_server_subnet_ip/arp_server_subnet_ip.xci]
update_compile_order -fileset sources_1

create_ip -name ipv4 -vendor ethz.systems.fpga -library hls -version 0.1 -module_name ipv4_ip
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/ipv4_ip/ipv4_ip.xci]
update_compile_order -fileset sources_1

create_ip -name udp -vendor ethz.systems.fpga -library hls -version 0.4 -module_name udp_ip
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/udp_ip/udp_ip.xci]
update_compile_order -fileset sources_1

create_ip -name hash_table -vendor ethz.systems.fpga -library hls -version 1.0 -module_name hash_table_ip
generate_target all [get_files ${proj_name}/${proj_name}.srcs/sources_1/ip/hash_table_ip/hash_table_ip.xci]
update_compile_order -fileset sources_1

upgrade_ip [get_ips *]
start_gui
