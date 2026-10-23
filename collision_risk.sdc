# clock constraint: 100MHz example
create_clock -name clk -period 10.0 [get_ports clk]

# External timing assumption 
# Replace these with actual top_level input/output names
 set_input_delay -clock clk 1.0 [get_ports {reset distance[*] rel_velocity[*]}]
 set_output_delay -clock clk 1.0 [get_ports {safe warning critical brake_alert}]

#clock uncertainity: 0.2 ns example
set_clock_uncertainty 0.2 [get_clocks clk]
