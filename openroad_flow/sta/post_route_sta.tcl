read_liberty platforms/sky130hd/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_db results/sky130hd/collision_risk_top/base/5_route.odb
read_sdc results/sky130hd/collision_risk_top/base/5_route.sdc
source platforms/sky130hd/setRC.tcl
estimate_parasitics -global_routing

puts "===== WNS ====="
report_wns
puts "===== TNS ====="
report_tns
puts "===== SETUP SLACK ====="
report_worst_slack -max
puts "===== HOLD SLACK ====="
report_worst_slack -min
puts "===== SETUP PATH ====="
report_checks -path_delay max
puts "===== HOLD PATH ====="
report_checks -path_delay min
puts "===== POWER ====="
report_power
puts "===== AREA ====="
report_design_area
