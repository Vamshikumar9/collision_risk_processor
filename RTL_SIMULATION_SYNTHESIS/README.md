### 1.Pre-Synthesis RTL Simulation

<img width="1357" height="462" alt="pre_synthesis_cmd" src="https://github.com/user-attachments/assets/99f73a8f-1c1a-4ef2-9157-17090655f52f" />


To verify the functional correctness of the collision risk core logic and finite state machine (FSM) before logic synthesis, the Verilog RTL code and testbench were compiled and executed using **Icarus Verilog (`iverilog`)**.

./pre_synth

gtkwave pre_synth.vcd
### Key Technical Highlights included in this documentation:
* **Tools Used:** Icarus Verilog (`iverilog`), GTKWave
* **RTL Files Compiled:** `collision_risk_core.v`, `risk_fsm.v`, `collision_risk_top.v`
* **Testbench File:** `tb_collision_risk.v`
* **Generated Output:** `pre_synth.vcd` (Value Change Dump file)
iverilog -g2012 -o pre_synth rtl/collision_risk_core.v rtl/risk_fsm.v rtl/collision_risk_top.v tb/tb_collision_risk.v


## 2. GTKWave Timing Diagram (pre_synth.vcd):

<img src="https://github.com/user-attachments/assets/5322574c-e187-44f6-9852-031763c9065c" alt="Pre-synthesis GTKWave timing diagram" width="900">


The waveform visualization confirms correct clock synchronization (clk), reset handling (reset), multi-bit bus values (distance[15:0], rel_velocity[15:0]), and corresponding control signals (safe, warning, critical, and brake alert)


##  3. Logic Synthesis (Yosys)

<img width="386" height="274" alt="yosys_synthesis_tcl" src="https://github.com/user-attachments/assets/df6fd14e-adf6-41ab-a7e5-6cb9db54b16b" />


To convert the RTL design into a gate-level netlist, **Yosys Open Synthesis Suite** is used along with the SkyWater 130nm standard cell library (`sky130_fd_sc_hd`).

#### **Synthesis Script (`yosys_synthesis.tcl`):**
```tcl
read_verilog rtl/collision_risk_core.v
read_verilog rtl/risk_fsm.v
read_verilog rtl/collision_risk_top.v
read_liberty -lib lib/sky130_fd_sc_hd_025C_1v80.lib
synth -top collision_risk_top
dfflibmap -liberty lib/sky130_fd_sc_hd_025C_1v80.lib
opt
abc -liberty lib/sky130_fd_sc_hd_025C_1v80.lib
show collision_risk_top
flatten
setundef -zero
clean -purge
rename -enumerate
write_verilog -noattr collision_risk_netlist.v
stat
```

#### **Script Breakdown:**
* **RTL Reading:** Loads the core logic, FSM, and top-level Verilog files (`collision_risk_core.v`, `risk_fsm.v`, `collision_risk_top.v`).
* **Library Definition:** Imports the target standard cell library (`sky130_fd_sc_hd_025C_1v80.lib`) using the Liberty format.
* **Synthesis & Mapping:** 
  * Performs generic synthesis targeting the top module `collision_risk_top`.
  * Maps flip-flops (`dfflibmap`) and logic gates (`abc`) to the Sky130 technology library[cite: 3].
* **Optimization & Cleanup:** Optimizes the netlist, flattens hierarchy, replaces undefined values with zeros (`setundef -zero`), and purges unused elements (`clean -purge`)[cite: 3].
* **Netlist Generation:** Exports the final synthesized gate-level netlist to `collision_risk_netlist.v` and displays area/cell statistics (`stat`)[cite: 3].

## Key Technical Highlights included:
Tool: Yosys Open Synthesis Suite
Technology Library: SkyWater 130nm High-Density Standard Cells (sky130_fd_sc_hd_025C_1v80.lib)
Top Module: collision_risk_top
Output: Gate-level netlist (collision_risk_netlist.v)


### 4. RTL Architecture & Synthesized Schematic

<img width="1526" height="302" alt="collision_risk_top_1" src="https://github.com/user-attachments/assets/55ab23fa-d0da-4bd9-a1f9-909279b8aaaf" />


The architectural hierarchy of the top-level design (`collision_risk_top`) consists of two primary sub-blocks: the **collision risk core** and the **risk finite state machine (FSM)**

#### **Dataflow & Connectivity Breakdown:**
* **Inputs:** 
  * `distance` and `rel_velocity` enter the system as multi-bit buses feeding into the core module (`u_collision_risk_core`)
  * `clk` and `reset` provide synchronization and initialization signals to the state machine
* **Core Processing (`u_collision_risk_core`):**
  * Evaluates the distance and relative velocity to generate internal condition flags: `critical_condition`, `safe_condition`, and `warning_condition`
* **State Machine (`u_risk_fsm`):**
  * Takes the condition flags alongside `clk` and `reset` as inputs to manage state transitions
  * Drives the final output alert signals: `brake_alert`, `critical`, `safe`, and `warning`


### 5. Synthesis Statistics (`risk_fsm` Module)

<img width="280" height="289" alt="risk_fsm" src="https://github.com/user-attachments/assets/6ce73fd7-7935-4d57-a534-1daee7ba3f9d" />

The synthesis report provides detailed metrics on the internal wire complexity, port count, and gate-level cell distribution for the `risk_fsm` module
#### **Resource Utilization Breakdown:**
* **Signal Complexity:**
  * **Number of wires:** 32
  * **Number of wire bits:** 34
  * **Number of public wires:** 11
  * **Number of public wire bits:** 13
* **Ports & Memories:**
  * **Number of ports:** 9
  * **Number of port bits:** 9
  * **Number of memories / memory bits:** 0
  * **Number of processes:** 0
* **Cell Distribution (Total: 28 cells):**
  * `$_ANDNOT_`: 9
  * `$_ORNOT_`: 5
  * `$_DFF_PP0_`: 4
  * `$_AND_`: 3
  * `$_NOR_`: 3
  * `$_OR_`: 2
  * `$_DFF_PP1_`: 1
  * `$_XNOR_`: 1

### 6. Synthesis Statistics (`collision_risk_core` Module)

<img width="326" height="296" alt="coll_risk_core" src="https://github.com/user-attachments/assets/096756dd-a4d1-4ef4-a5aa-a58f95b2a761" />

The synthesis report outlines the internal wire complexity, port configuration, and gate-level cell distribution for the primary `collision_risk_core` computational block
#### **Resource Utilization Breakdown:**
* **Signal Complexity:**
  * **Number of wires:** 330
  * **Number of wire bits:** 394
  * **Number of public wires:** 7
  * **Number of public wire bits:** 71
* **Ports & Memories:**
  * **Number of ports:** 5
  * **Number of port bits:** 35
  * **Number of memories / memory bits:** 0
  * **Number of processes:** 0
* **Cell Distribution (Total: 326 cells):**
  * `$_ANDNOT_`: 115
  * `$_XOR_`: 55
  * `$_OR_`: 52
  * `$_ORNOT_`: 31
  * `$_NOR_`: 23
  * `$_XNOR_`: 18
  * `$_NAND_`: 15
  * `$_AND_`: 11
  * `$_NOT_`: 6

### 7. Synthesis Statistics (`collision_risk_top` Module)

<img width="266" height="200" alt="collision_risk_top" src="https://github.com/user-attachments/assets/ab2e5b8f-8f8a-48ec-a331-c82bdf7e92bf" />

The synthesis report for the top-level wrapper module provides the overall wire metrics, port definitions, and instantiation breakdown of its sub-modules.
#### **Resource Utilization & Hierarchy Breakdown:**
* **Signal Complexity:**
  * **Number of wires:** 11
  * **Number of wire bits:** 41
  * **Number of public wires:** 11
  * **Number of public wire bits:** 41
* **Ports & Memories:**
  * **Number of ports:** 8
  * **Number of port bits:** 38
  * **Number of memories / memory bits:** 0
  * **Number of processes:** 0
* **Cell / Sub-module Instantiation (Total: 2 cells):**
  * `collision_risk_core`: 1
  * `risk_fsm`: 1
 

### 8. Total Design Hierarchy & Combined Synthesis Statistics

<img width="310" height="386" alt="design_hierarchy" src="https://github.com/user-attachments/assets/59ebd826-6654-46ae-b9b8-ee1322f85823" />

The final global synthesis report aggregates the complete design hierarchy and provides the total resource utilization across all instantiated modules.
#### **Design Hierarchy Breakdown:**
* **`collision_risk_top`**: 1
  * **`collision_risk_core`**: 1
  * **`risk_fsm`**: 1

#### **Total Resource Utilization Metrics:**
* **Signal Complexity:**
  * **Number of wires:** 373
  * **Number of wire bits:** 469
  * **Number of public wires:** 29
  * **Number of public wire bits:** 125
* **Ports & Memories:**
  * **Number of ports:** 22
  * **Number of port bits:** 82
  * **Number of memories / memory bits:** 0
  * **Number of processes:** 0
* **Total Cell Distribution (Total: 354 cells):**
  * `$_ANDNOT_`: 124
  * `$_XOR_`: 55
  * `$_OR_`: 54
  * `$_ORNOT_`: 36
  * `$_NOR_`: 26
  * `$_XNOR_`: 19
  * `$_NAND_`: 15
  * `$_AND_`: 14
  * `$_NOT_`: 6
  * `$_DFF_PP0_`: 4
  * `$_DFF_PP1_`: 1
 

### 9. Gate-Level Netlist Statistics (`collision_risk_top`)

<img width="244" height="609" alt="netlist" src="https://github.com/user-attachments/assets/d02b4b9b-8d33-460c-b2ef-fc9ac6ebfca1" />

After running ABC technology mapping using the SkyWater 130nm standard cell library (`sky130_fd_sc_hd`), the design is successfully mapped to physical standard cells.
#### **Netlist Resource Utilization Metrics:**
* **Signal Complexity:**
  * **Number of wires:** 208
  * **Number of wire bits:** 240
  * **Number of public wires:** 208
  * **Number of public wire bits:** 240
* **Ports:**
  * **Number of ports:** 8
  * **Number of port bits:** 38
  * **Number of memories / processes:** 0
* **Total Cells:** 207 (mapped to physical Sky130 standard cells)

#### **Sky130 Standard Cell Distribution Highlights:**
* **Sequential Elements:**
  * `sky130_fd_sc_hd__dfrtp_1`: 4
  * `sky130_fd_sc_hd__dfstp_2`: 1
* **Combinational Logic & Complex Gates:**
  * `sky130_fd_sc_hd__a21loi_1`: 16
  * `sky130_fd_sc_hd__nor2_1`: 15
  * `sky130_fd_sc_hd__nand2_1`: 14
  * `sky130_fd_sc_hd__xor2_1`: 14
  * `sky130_fd_sc_hd__clkinv_1`: 13
  * `sky130_fd_sc_hd__xnor2_1`: 13
  * `sky130_fd_sc_hd__o21ai_0`: 12
  * `sky130_fd_sc_hd__nor3_1`: 11
  * `sky130_fd_sc_hd__nand3_1`: 10


### 10. Gate-Level Simulation (Post-Synthesis Verification)

To ensure that the synthesized gate-level netlist matches the expected RTL functionality and satisfies unit timing delays, a **Gate-Level Simulation (GLS)** was executed using Icarus Verilog (`iverilog`).

<img width="1917" height="435" alt="post_synth_cmd" src="https://github.com/user-attachments/assets/1ee08363-483b-461a-8146-4d48bbf13457" />

./post_synth_sim

gtkwave post_synth.vcd


### 11. Post-Synthesis GTKWave Simulation Analysis

The post-synthesis simulation waveform verifies that the gate-level netlist operates correctly with unit-delay modeling under GTKWave.

<img width="1917" height="1022" alt="post_synth" src="https://github.com/user-attachments/assets/82ab444e-ce7a-4736-91a9-438dd612be26" />

#### **Waveform Verification Summary:**
* **Clock & Reset:** Clean clock edge synchronization and proper reset behavior.
* **Bus Inputs:** Accurate multi-bit propagation for `distance[15:0]` (`01F4`, `0028`, `000F`, `0064`, `001E`) and `rel_velocity[15:0]` (`0000`, `000A`, `0014`).
* **Alert Outputs:** Successful gate-level transition of control signals (`safe`, `safe_condition`, `critical`, `critical_condition`, `warning`, and `brake_alert`) matching the pre-synthesis functional behavior while accounting for standard cell netlist delays




### 12. Static Timing Analysis (STA) TCL Script Configuration

To perform static timing analysis on the synthesized gate-level netlist, an STA TCL configuration script (`collision_risk_sta.tcl`) was created to evaluate setup and hold timings, constraints, and slack metrics using OpenSTA.

<img width="1917" height="1021" alt="pre_sta_tcl" src="https://github.com/user-attachments/assets/90edb736-54c9-4c41-a34f-e2c285de33d0" />

#### **Script Breakdown & Commands:**
* **Environment Paths & Libraries:**
  * Defines the base path (`/data/Desktop/collision_risk_chip/`)
  * Loads the Sky130 standard cell library (`sky130_fd_sc_hd_tt_025C_1v80.lib`) for min and max timing corners using `read_liberty -min` and `read_liberty -max`
* **Design Netlist & Linking:**
  * Reads the synthesized gate-level netlist (`collision_risk_netlist.v`)
  * Links the top-level design module (`link_design collision_risk_top`)
* **Constraints & Timing Reports:**
  * Reads timing constraints via `read_sdc`
  * Checks setup constraints verbosely (`check_setup -verbose`)
  * Generates setup and hold timing reports with full clock path expansion (`report_checks -path_delay max/min -format full_clock_expanded`)
  * Reports worst negative slack (`report_worst_slack`), minimum slack, and total negative slack (`report_tns`)


### 13. Static Timing Analysis (STA) Execution


<img width="1327" height="317" alt="pre_sta_cmd" src="https://github.com/user-attachments/assets/c61fb41c-07e5-4a83-a68c-9225f2ef570b" />

Static Timing Analysis is executed using **OpenSTA** running inside a Docker container to evaluate the timing constraints, slack performance, and setup/hold requirements of the synthesized netlist.

 **STA Execution Command (Docker):**
sudo docker run -it -v $HOME:/data opensta:latest /data/Desktop/collision_risk_chip/collision_risk_sta.tcl


### 14. Static Timing Analysis: Asynchronous Recovery Check (`max` Path)
The STA report evaluates the maximum path delay for asynchronous recovery checks, ensuring that reset de-assertion safely meets timing requirements relative to the clock edge.

<img width="535" height="475" alt="max_ass" src="https://github.com/user-attachments/assets/491b3720-e9a7-48ec-9195-fde43127df41" />

#### **Timing Path Summary:**
* **Startpoint:** `reset` (input port clocked by `clk`).
* **Endpoint:** `_395_` (recovery check against rising-edge clock `clk`, utilizing the `sky130_fd_sc_hd__dfstp_2` flip-flop cell).
* **Path Group:** asynchronous.
* **Path Type:** max.

#### **Delay & Slack Breakdown:**
* **Data Arrival Time:** `1.08 ns` (comprising a `1.00 ns` input external delay and `0.08 ns` buffer cell delay through `sky130_fd_sc_hd__clkinv_1`).
* **Data Required Time:** `9.92 ns` (derived from the `10.00 ns` rising clock edge, adjusted by `-0.20 ns` clock uncertainty and `0.12 ns` library recovery time).
* **Timing Result:** **Slack = +8.84 ns (`MET`)**, confirming that the asynchronous recovery timing constraint is successfully satisfied with a positive margin.


### 15. Static Timing Analysis: Synchronous Clock Path Setup Check (`max` Path)

The STA report for the synchronous clock path evaluates the maximum setup delay from input ports through combinational logic to ensure proper data capture at the sequential register.

<img width="535" height="705" alt="max_clk" src="https://github.com/user-attachments/assets/77cdfb18-2af3-4bc4-9dce-ffb3c19d3aba" />

#### **Timing Path Summary:**
* **Startpoint:** `rel_velocity[3]` (input port clocked by `clk`).
* **Endpoint:** `_397_` (rising edge-triggered flip-flop clocked by `clk`, using the `sky130_fd_sc_hd__dfrtp_1` cell).
* **Path Group:** `clk`.
* **Path Type:** `max`.

#### **Delay & Slack Breakdown:**
* **Data Arrival Time:** `3.88 ns` (traversing through multiple Sky130 standard cells including `nor2_1`, `o21ai_0`, `maj3_1`, `xnor2_1`, `a22oi_1`, `a22lo_1`, `a21loi_1`, `o22lai_1`, `a31lo_1`, `lpflow_isobufsrc_1`, `o3lai_1`, and `and2_0`).
* **Data Required Time:** `9.73 ns` (derived from the `10.00 ns` rising clock edge, adjusted by `-0.20 ns` clock uncertainty and `-0.07 ns` library setup time).
* **Timing Result:** **Slack = +5.86 ns (`MET`)**, confirming that the synchronous setup timing constraint is successfully satisfied with a healthy positive margin.


### 16. Static Timing Analysis: Asynchronous Removal Check (`min` Path)

The STA report for the asynchronous removal check ensures that the reset signal remains stable long enough after the active clock edge to prevent race conditions or metastability in sequential elements.

<img width="532" height="481" alt="min_ass" src="https://github.com/user-attachments/assets/0c648844-181f-49ca-82e8-68d2bad2c9e6" />

#### **Timing Path Summary:**
* **Startpoint:** `reset` (input port clocked by `clk`)
* **Endpoint:** `_396_` (removal check against rising-edge clock `clk`, using the `sky130_fd_sc_hd__dfrtp_1` flip-flop cell)
* **Path Group:** asynchronous
* **Path Type:** min

#### **Delay & Slack Breakdown:**
* **Data Arrival Time:** `1.08 ns` (comprising a `1.00 ns` input external delay and `0.08 ns` inverter buffer delay through `sky130_fd_sc_hd__clkinv_1`)
* **Data Required Time:** `0.52 ns` (derived from the `0.00 ns` clock edge, adjusted by `0.20 ns` clock uncertainty and `0.32 ns` library removal time)
* **Timing Result:** **Slack = +0.56 ns (`MET`)**, confirming that the asynchronous removal timing constraint is successfully satisfied with a positive margin.



### 17. Static Timing Analysis: Synchronous Clock Path Hold Check (`min` Path)

The STA report for the synchronous hold check evaluates the minimum path delay between registers to ensure that data does not change too quickly and corrupt the previous state (hold violation prevention).

  <img width="562" height="495" alt="min_clk" src="https://github.com/user-attachments/assets/11d3e5df-af71-4c42-ac36-e748857deee9" />

#### **Timing Path Summary:**
* **Startpoint:** `_399_` (rising edge-triggered flip-flop clocked by `clk`, using the `sky130_fd_sc_hd__dfrtp_1` cell)
* **Endpoint:** `_395_` (rising edge-triggered flip-flop clocked by `clk`, using the `sky130_fd_sc_hd__dfstp_2` cell)
* **Path Group:** `clk`
* **Path Type:** `min`

#### **Delay & Slack Breakdown:**
* **Data Arrival Time:** `0.53 ns` (comprising register clock-to-Q delay `0.38 ns` and combinational logic path delays through `o3lai_1` and `a32oi_1` cells)
* **Data Required Time:** `0.18 ns` (derived from the `0.00 ns` clock edge, adjusted by `0.20 ns` clock uncertainty and `-0.02 ns` library hold time)
* **Timing Result:** **Slack = +0.34 ns (`MET`)**, confirming that the synchronous hold timing constraint is successfully satisfied without hold violations


### 18. Global Timing Summary (Worst Slack & TNS)

The final STA summary aggregates the worst-case setup and hold margins along with the total negative slack for the entire design, confirming that timing closure is fully achieved.

<img width="237" height="87" alt="worst_slack" src="https://github.com/user-attachments/assets/4275b93c-7ead-4753-9bb7-ab5b9c940a39" />

#### **Summary Metrics:**
* **Worst Slack (Max / Setup):** `+5.86`.
* **Worst Slack (Min / Hold):** `+0.34`.
* **Total Negative Slack (TNS max):** `0.00`.
* **Timing Closure Status:** **MET** (Zero timing violations; all paths meet setup and hold criteria cleanly).


















