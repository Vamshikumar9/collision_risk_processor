# PRE STA 

set base_path /data/Desktop/collision_risk_chip/
set lib_name sky130_fd_sc_hd__tt_025C_1v80.lib


read_liberty -min $base_path/lib/$lib_name
read_liberty -max $base_path/lib/$lib_name

read_verilog $base_path/rtl/collision_risk_netlist.v

link_design collision_risk_top

read_sdc $base_path/collision_risk.sdc

#check constraints
check_setup -verbose

# setup Timing report
report_checks -path_delay max -format full_clock_expanded

#hold time report
report_checks -path_delay min -format full_clock_expanded

# Worst slack & total negative slack
report_worst_slack -max
report_worst_slack -min
report_tns

