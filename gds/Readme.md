# 🏗️ Physical Design Artifacts

This directory contains the final GDSII layout, physical implementation files, timing constraints, and post-place-and-route reports for the Hopfield Network, implemented using OpenROAD and the Sky130HD standard-cell library.

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
| [`Area.txt`](reports/Area.txt)             | Design area and utilization.      |
| [`Cell_Usage.txt`](reports/Cell_Usage.txt) | Cell counts and area breakdown.   |
| [`Timing.txt`](reports/Timing.txt)         | Static timing analysis results.   |
| [`Power.txt`](reports/Power.txt)           | Estimated power consumption.      |
| [`Skew.txt`](reports/Skew.txt)             | Clock skew and insertion latency. |
| [`cap.txt`](reports/cap.txt)               | Capacitance and slew checks.      |

**Technology:** Sky130HD
**Physical Design Tool:** OpenROAD
**Layout Format:** GDSII
