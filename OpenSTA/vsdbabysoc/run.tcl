set base_path /data/OpenSTA/vsdbabysoc/
set lib_name sky130_fd_sc_hd__tt_025C_1v80.lib



read_liberty -min $base_path/lib/$lib_name
read_liberty -max $base_path/lib/$lib_name


read_liberty -min /data/OpenSTA/vsdbabysoc/lib/avsdpll.lib
read_liberty -max /data/OpenSTA/vsdbabysoc/lib/avsdpll.lib


read_liberty -min /data/OpenSTA/vsdbabysoc/lib/avsddac.lib
read_liberty -max /data/OpenSTA/vsdbabysoc/lib/avsddac.lib

read_verilog /data/OpenSTA/vsdbabysoc/vsdbabysoc.synth.v

link_design vsdbabysoc

read_sdc /data/OpenSTA/VSDBabySoC/src/sdc/vsdbabysoc_synthesis.sdc

report_checks
