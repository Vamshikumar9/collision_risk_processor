## VIDEO DEMONSTRATION LINK:


## Design and Physical Implementation of a Collision-Risk Detection Processor Using Verilog HDL and Sky130 Technology

## Introduction 

The Collision-Risk Detection Processor is a digital VLSI design project that aims to identify potential collision risks between vehicles using distance and relative-velocity inputs. The processor compares these inputs against predefined thresholds to classify the situation into three categories: SAFE, WARNING, and CRITICAL. A sequential Finite State Machine (FSM) manages the risk states and generates corresponding output signals, including a brake-alert indication during critical conditions.

The design is described using Verilog HDL and verified through functional simulation using Icarus Verilog and GTKWave. Yosys is used for logic synthesis and mapping to the Sky130 standard-cell library, while OpenROAD is used for physical implementation, including floorplanning, placement, and routing. Static Timing Analysis (STA) is performed to evaluate setup and hold timing across the required process, voltage, and temperature (PVT) corners.

The project targets a compact core size of 100 × 100 µm², with feasibility assessed through synthesis and physical-design reports. The overall objective is to demonstrate the complete ASIC design flow, from application definition and RTL verification to physical layout and GDSII generation. This project is an educational prototype and is not intended to serve as a certified automotive safety system.

## Abstract

The Collision-Risk Detection Processor is a digital VLSI project designed to classify potential vehicle collision risks using distance and relative-velocity inputs. The proposed design employs combinational logic to compare input values against predefined thresholds and a sequential Finite State Machine (FSM) to manage three operating states: SAFE, WARNING, and CRITICAL. Based on the detected risk level, the processor generates corresponding status outputs and activates a brake-alert signal under critical conditions.

The design is implemented using Verilog HDL and functionally verified through simulation and testbench analysis. Yosys is used for logic synthesis and Sky130 standard-cell technology mapping, while OpenROAD supports physical implementation, including floorplanning, placement, and routing. Static Timing Analysis (STA) is performed to evaluate setup and hold timing across the required process, voltage, and temperature (PVT) corners. The project targets a core area of 100 × 100 µm², with actual area and timing performance evaluated using implementation reports. The primary objective is to demonstrate a complete RTL-to-GDSII design flow for a compact sequential digital circuit. This prototype provides an educational demonstration of collision-risk classification hardware and is not intended for direct use in safety-critical automotive systems.

## Problem Statement

Road accidents can occur when drivers fail to recognize situations in which the distance between vehicles decreases rapidly. Timely detection of potential collision risks is important for generating appropriate warning signals. This project aims to design a hardware-based Collision-Risk Detection Processor that analyzes vehicle distance and relative velocity to classify the risk level as SAFE, WARNING, or CRITICAL. The processor uses predefined thresholds and a Finite State Machine (FSM) to generate corresponding status signals and a brake-alert output when a critical condition is detected. The design will be developed using Verilog HDL, verified through functional simulation, synthesized using Yosys with the Sky130 standard-cell library, and physically implemented using OpenROAD. The project will evaluate the circuit’s functionality, area, and timing through implementation reports as part of a complete RTL-to-GDSII design flow.


## Objectives

The main objective of this project is to design and implement a Collision-Risk Detection Processor using Verilog HDL and complete the RTL-to-GDSII VLSI design flow.

The specific objectives are:

1. Design RTL architecture: Develop a Verilog-based processor that accepts vehicle distance and relative-velocity inputs.
2. Detect collision risk: Compare input values against predefined thresholds to classify conditions as SAFE, WARNING, or CRITICAL.
3. Implement an FSM: Design a Finite State Machine (FSM) to manage risk states and generate the appropriate output signals.
4. Generate alerts: Activate the brake-alert signal when a critical risk condition is detected.
5. Verify functionality: Use Icarus Verilog and GTKWave to simulate the design and verify its behavior using a testbench.
6. Perform logic synthesis: Use Yosys to synthesize the RTL and map the design to the Sky130 standard-cell library.
7. Implement physical design: Use OpenROAD to perform floorplanning, placement, clock-tree synthesis, and routing.
8. Analyze timing and area: Perform Static Timing Analysis (STA) across the required process, voltage, and temperature (PVT) corners and evaluate the implementation reports.
9. Target a compact layout: Aim for a core area of 100 × 100 µm², subject to feasibility and verification through physical-design reports.
10. Generate the final layout: Complete the RTL-to-GDSII flow and evaluate the resulting physical design as an educational VLSI prototype.


##  Methodology 
## System Overview

The Collision-Risk Detection Processor is a digital VLSI system designed to classify potential vehicle collision risks based on distance and relative-velocity inputs. The system consists of three main modules: a Collision-Risk Calculation Module, a Finite State Machine (FSM), and a Top-Level Integration Module.

The Collision-Risk Calculation Module receives a 16-bit distance value and a 16-bit relative-velocity value. It compares these inputs against predefined thresholds to determine the risk level. The FSM processes the calculated risk conditions and manages three operating states: SAFE, WARNING, and CRITICAL. Based on the current state, the system generates status outputs and activates the brake-alert signal during a critical condition. A clock signal controls state transitions, while an active-high asynchronous reset initializes the system to a known state.

The design is described using Verilog HDL and verified through functional simulation with Icarus Verilog and GTKWave. Yosys is used for logic synthesis and Sky130 standard-cell mapping, while OpenROAD is used for physical implementation, including floorplanning, placement, clock-tree synthesis, and routing. Static Timing Analysis (STA) is performed to evaluate timing performance and identify potential setup and hold violations.

The project targets a core area of 100 × 100 µm², subject to verification through actual physical-design reports. The overall system demonstrates the implementation of a compact sequential digital circuit through the complete RTL-to-GDSII design flow. It is intended for educational purposes and is not a certified automotive safety system.


## Flow Chart

flowchart TD
    A([Start]) --> B[Initialize Clock and Reset]
    B --> C[Read Distance and Relative Velocity]
    C --> D{Relative Velocity = 0?}
    D -- Yes --> E[Set Risk State to SAFE]
    D -- No --> F{Distance ≤ Relative Velocity × 2?}
    F -- Yes --> G[Set Risk State to CRITICAL]
    F -- No --> H{Distance ≤ Relative Velocity × 5?}
    H -- Yes --> I[Set Risk State to WARNING]
    H -- No --> E
    E --> J[Update FSM State and Outputs]
    I --> J
    G --> K[Activate Brake Alert]
    K --> J
    J --> L[Monitor Next Clock Cycle]
    L --> C
    

## Future Scope

The Collision-Risk Detection Processor can be enhanced in several ways to improve its functionality, performance, and practical applicability.

1. Advanced Risk Detection: Implement more sophisticated algorithms that consider vehicle speed, acceleration, braking distance, road conditions, and time-to-collision (TTC) for more accurate risk assessment.

2. Sensor Integration: Interface the processor with real-time sensors such as radar, LiDAR, ultrasonic sensors, or cameras to obtain vehicle distance and relative-velocity data.

3. Adaptive Thresholds: Replace fixed thresholds with adaptive thresholds that adjust according to vehicle speed, environmental conditions, and road situations.

4. Improved Hardware Architecture: Optimize the Verilog RTL to reduce chip area, power consumption, and critical-path delay while maintaining correct functionality.

5. Low-Power Design: Incorporate clock gating and other power-optimization techniques to reduce energy consumption in embedded automotive systems.

6. Enhanced Verification: Extend the testbench to cover additional boundary conditions, unusual input combinations, reset behavior, and extensive functional scenarios. Formal verification can also be considered.

7. Automotive Communication: Add interfaces such as CAN or other suitable communication protocols to exchange information with vehicle electronic control units.

8. Physical Design Optimization: Explore floorplanning, placement, routing, and timing-constraint improvements to evaluate whether the target core area of 100 × 100 µm² can be achieved. Perform Static Timing Analysis across the required process, voltage, and temperature (PVT) corners.

9. FPGA Prototyping: Implement the design on an FPGA board to demonstrate its operation with simulated or sensor-derived input data.

10. Safety and Reliability: Investigate fault detection, input validation, fail-safe behavior, and automotive safety requirements before considering any real-world application.

In the future, these enhancements could transform the current educational prototype into a more advanced collision-warning hardware platform. However, real automotive deployment would require extensive testing, safety validation, and compliance with applicable automotive standards.


