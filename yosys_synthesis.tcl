read_verilog rtl/collision_risk_core.v
read_verilog rtl/risk_fsm.v
read_verilog rtl/collision_risk_top.v
read_liberty -lib lib/sky130_fd_sc_hd__025C_1v80.lib
synth -top collision_risk_top
dfflibmap -liberty lib/sky130_fd_sc_hd__025C_1v80.lib
opt
abc -liberty lib/sky130_fd_sc_hd__025C_1v80.lib
show collision_risk_top
flatten
setundef -zero
clean -purge
reanme -enumerate
write_verilog -noattr collision_risk_netlist.v
stat
