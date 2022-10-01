set_property -dict {LOC H6} [get_ports phy_sgmii_rx_p]
set_property -dict {LOC H5} [get_ports phy_sgmii_rx_n]
set_property -dict {LOC J4} [get_ports phy_sgmii_tx_p]
set_property -dict {LOC J3} [get_ports phy_sgmii_tx_n]
set_property -dict {LOC G8} [get_ports phy_sgmii_clk_p]
set_property -dict {LOC G7} [get_ports phy_sgmii_clk_n]
set_property -dict {LOC L20 IOSTANDARD LVCMOS25 SLEW SLOW DRIVE 12} [get_ports phy_reset_n]
set_property -dict {LOC N30 IOSTANDARD LVCMOS25} [get_ports phy_int_n]
create_clock -period 8.000 -name phy_sgmii_clk [get_ports phy_sgmii_clk_p]

set_false_path -to [get_ports {phy_reset_n}]
set_output_delay 0 [get_ports {phy_reset_n}]
set_false_path -from [get_ports {phy_int_n}]
set_input_delay 0 [get_ports {phy_int_n}]