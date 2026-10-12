# 🏗️ Physical Design Artifacts

This directory contains the final GDSII layout, physical implementation files, timing constraints, and post-place-and-route reports for the Hopfield Network, implemented using OpenROAD and the Sky130HD standard-cell library.

## 🔬 Post-Place-and-Route Characterization

The design was implemented through the RTL-to-GDSII flow using OpenROAD and the Sky130 HD standard-cell library.

Timing analysis was performed using a 25 ns clock period with 1 ns input and output delays. Post-route implementation metrics were collected from the OpenROAD session.

**Technology:** Sky130HD

### Implementation Results

| Metric                             |       Result |
| ---------------------------------- | -----------: |
| Total Cell Area                    | 9,724.33 µm² |
| Placement Utilization              |          82% |
| Total Cell Count                   |        1,334 |
| Critical Register-to-Register Path |    20.206 ns |
| Estimated Maximum Frequency        |    ~49.5 MHz |
| Worst Setup Slack                  |     +5.00 ns |
| Worst Hold Slack                   |     +0.52 ns |
| Setup Clock Skew                   |     -0.01 ns |
| Total Estimated Power              |       504 µW |

### Cell Area Breakdown

| Cell Category                   |     Count |             Area |
| ------------------------------- | --------: | ---------------: |
| Multi-Input Combinational Cells |     1,148 |     8,340.50 µm² |
| Sequential Cells                |        38 |       952.16 µm² |
| Timing Repair Buffers           |         8 |       145.14 µm² |
| Clock Buffers                   |         5 |        37.54 µm² |
| Clock Inverters                 |         3 |        16.27 µm² |
| Inverters                       |        27 |       101.35 µm² |
| Tap Cells                       |       105 |       131.38 µm² |
| **Total**                       | **1,334** | **9,724.33 µm²** |

### Power Breakdown

| Component           | Estimated Power | Percentage |
| ------------------- | --------------: | ---------: |
| Combinational Logic |          397 µW |      78.8% |
| Sequential Logic    |         78.3 µW |      15.5% |
| Clock Network       |         28.4 µW |       5.6% |
| Leakage             |      0.00379 µW |     <0.01% |
| **Total**           |      **504 µW** |   **100%** |

### 📦 Files

| File                             | Description                                    |
| -------------------------------- | ---------------------------------------------- |
| [`hopfield.gds`](hopfield.gds)   | Final GDSII layout.                            |
| [`hopfield.def`](hopfield.def)   | Final placement and routing data.              |
| [`hopfield.sdc`](hopfield.sdc)   | Timing constraints used during implementation. |
| [`def_to_gds.rb`](def_to_gds.rb) | KLayout script for converting DEF to GDSII.    |

### 📊 Post-Route Reports

| File                                       | Description                       |
| ------------------------------------------ | --------------------------------- |
| [`Area.txt`](Area.txt)             | Design area and utilization.      |
| [`Cell_Usage.txt`](Cell_Usage.txt) | Cell counts and area breakdown.   |
| [`Timing.txt`](Timing.txt)         | Static timing analysis results.   |
| [`Power.txt`](Power.txt)           | Estimated power consumption.      |
| [`Skew.txt`](Skew.txt)             | Clock skew and insertion latency. |
| [`Cap.txt`](Cap.txt)               | Capacitance and slew checks.      |
