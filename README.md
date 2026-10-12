# Hopfield Network

A Hopfield network functions as an associative memory, recovering stored patterns from corrupted inputs by iteratively updating neuron states until the network reaches a stable configuration.

Unlike conventional memory systems, which retrieve data using an explicit address, associative memory recalls information from the content of an input pattern. When presented with a sufficiently similar pattern, the network can recover the stored configuration through interactions between its interconnected neurons.

## 🏗️ Physical Implementation
The Hopfield Network was taken for physical implementation to evaluate its area, timing, and power characteristics beyond synthesis. The design was taken through floorplanning, placement, clock tree synthesis, and global and detailed routing using OpenROAD and the Sky130HD standard-cell library, culminating in GDSII layout generation.

<table align="center">
  <tr>
    <td align="center" style="padding-right: 50px;">
      <img src="images/route.png" width="500"><br>
         <sub></b> Hopfield Network Post-Route Physical Layout (OpenROAD)
    </td>
    <td align="center" style="padding-left: 50px;">
      <img src="images/gds.png" width="500"><br>
         <sub></b> Hopfield Network GDSII Layout (KLayout)
    </td>
  </tr>
</table>

## 🧠 Associative Recall

The network stores a 5 × 5 binary pattern and attempts to recover it from an initially corrupted state.

<p align="center">
  <img src="images/single_recall.png" width="1000" />
</p>

<p align="center">
  <img src="images/recall.png" width="900" alt="A corrupted 5 by 5 input pattern transformed into the stored pattern by the Hopfield network."/>
   <br>
  <sub>A corrupted input pattern is recalled as the stored configuration through iterative neuron updates.</sub>
</p>

## 🔬 Post-Place-and-Route Characterization

The design was implemented through the RTL-to-GDSII flow using OpenROAD and the Sky130 HD standard-cell library.

Timing analysis was performed using a 25 ns clock period with 1 ns input and output delays. Post-route implementation metrics were collected from the OpenROAD session.

**Technology:** Sky130HD

### Implementation Results

| Metric                             |       Result |
|  --------------------------------- | -----------  |
| Total Cell Area                    | 9,724.33 µm² |
| Placement Utilization              |          82% |
| Total Cell Count                   |        1,334 |
| Critical Register-to-Register Path |     20.00 ns |
| Estimated Maximum Frequency        |      ~50 MHz |
| Worst Setup Slack                  |     +5.00 ns |
| Worst Hold Slack                   |     +0.52 ns |
| Setup Clock Skew                   |     -0.01 ns |
| Total Estimated Power              |       504 µW |

### Cell Area Breakdown

| Cell Category                   |     Count |             Area |
|  ------------------------------ | --------  | ---------------  |
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
|  ------------------ | --------------  | ---------  |
| Combinational Logic |          397 µW |      78.8% |
| Sequential Logic    |         78.3 µW |      15.5% |
| Clock Network       |         28.4 µW |       5.6% |
| Leakage             |      0.00379 µW |     <0.01% |
| **Total**           |      **504 µW** |   **100%** |

## ⚙️ Implementation

- Hebbian Weight Matrix: A predefined symmetric weight matrix with zero diagonal entries.
- Bipolar Neurons: Binary `1` represents `+1`, while binary `0` represents `−1`.
- Sequential Updates: Neurons are updated individually according to their weighted inputs.
- Convergence Detection: The network stops when a complete pass produces no state changes.
- Bounded Execution: A configurable maximum pass count prevents indefinite operation.

## 🧪 Verification

The implementation has been tested through both RTL simulation and gate-level simulation.

| Verification          |             Result |
| --------------------- | -----------------: |
| RTL simulation        | 20/20 tests passed |
| Gate-level simulation | 20/20 tests passed |

<p align="center">
  <img src="images/multiple_recalls.png" width="1000""/>
   <br>
  <sub>All 20 selected test inputs converged to the expected stored pattern.</sub>
</p>

## 📚 Documentation

- [Hopfield Network Fundamentals](Hopfield.md)
- [Hebbian Matrix Generator](Hebbian.py) 
- [Source Files](src) 

## 📜 License

- Source code and HDL files are licensed under the MIT License.
- Documentation, diagrams, images, and PDFs are licensed under the Creative Commons Attribution 4.0 International (CC BY 4.0) License.
