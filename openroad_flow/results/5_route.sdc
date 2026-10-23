###############################################################################
# Created by write_sdc
###############################################################################
current_design collision_risk_top
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 10.0000 [get_ports {clk}]
set_clock_uncertainty 0.2000 clk
set_propagated_clock [get_clocks {clk}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[0]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[10]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[11]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[12]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[13]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[14]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[15]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[1]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[2]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[3]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[4]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[5]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[6]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[7]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[8]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {distance[9]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[0]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[10]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[11]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[12]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[13]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[14]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[15]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[1]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[2]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[3]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[4]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[5]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[6]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[7]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[8]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rel_velocity[9]}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {reset}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {brake_alert}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {critical}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {safe}]
set_output_delay 1.0000 -clock [get_clocks {clk}] -add_delay [get_ports {warning}]
###############################################################################
# Environment
###############################################################################
###############################################################################
# Design Rules
###############################################################################
