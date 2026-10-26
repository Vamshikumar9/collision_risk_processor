# Collision Risk Processor Configuration

set ::env(DESIGN_NAME) collision_risk_top

# RTL files
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/src/*.v]

# Clock
set ::env(CLOCK_PORT) clk
set ::env(CLOCK_PERIOD) 10

# Floorplan
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 110 110"

# Placement
set ::env(FP_CORE_UTIL) 60
set ::env(PL_TARGET_DENSITY) 0.60
