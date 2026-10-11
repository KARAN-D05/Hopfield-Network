# Hopfield-Network
A Hopfield Network is a recurrent neural network that functions as an associative memory system. It stores patterns within a network of interconnected neurons and retrieves them by evolving an initial state toward a stable configuration.

Unlike conventional memory systems, which typically require an explicit address to retrieve stored data, associative memory can recover a stored pattern from a sufficiently similar or partially corrupted input.

## 🛠️ Tools & Technologies

![Icarus Verilog](https://img.shields.io/badge/Icarus_Verilog-Simulation-1E88E5?style=flat-square)
![GTKWave](https://img.shields.io/badge/GTKWave-Waveforms-F57C00?style=flat-square)
![Yosys](https://img.shields.io/badge/Yosys-Synthesis-43A047?style=flat-square)
![OpenSTA](https://img.shields.io/badge/OpenSTA-Static_Timing_Analysis-8E24AA?style=flat-square)
![Sky130HD](https://img.shields.io/badge/Sky130HD-Primary_Characterization-455A64?style=flat-square)

## 🧠 Convergence
<p align="center">
  <img src="images/waveform.png" width="1000"/>
  <br>
  <sub>Sequential neuron updates and convergence to a stable state.</sub>
</p>

## 🔢 Hebbian Weight Matrix

The network uses the following weight matrix:

```text
Hebbian Weight Matrix:

   0    1    1   -1
   1    0    1   -1
   1    1    0   -1
  -1   -1   -1    0
```

The matrix is symmetric, with zero diagonal entries to prevent self-connections.

The weights support two stable configurations: a bipolar pattern and its inverse.

### Stable Configurations

**Stable State 1: `0001`**

Bipolar representation:

$$
S_A = [-1,-1,-1,+1]^T
$$

Weighted input:

$$
WS_A = [-1,-1,-1,+3]^T
$$

The weighted inputs reinforce the current neuron states, so a complete update pass leaves the pattern unchanged.

**Stable State 2: `1110`**

Bipolar representation:

$$
S_B = [+1,+1,+1,-1]^T
$$

Weighted input:

$$
WS_B = [+1,+1,+1,-3]^T
$$

This pattern is also stable because all neurons retain their current states after updating.

The two patterns are inverses:

$$
S_B=-S_A
$$

Since reversing every neuron's sign also reverses its weighted input, both configurations remain stable under the same weight matrix.

The final state depends on the initial configuration and the sequential neuron-update order.

## 🔬 Physical Characterization

The following results were obtained after synthesis using the Sky130 HD standard-cell library.

> **Technology:** Sky130 HD
> **Synthesis Tool:** Yosys

| Metric                       |    Value |
| ---------------------------- | -------  |
| Standard-Cell Count          |       87 |
| Sequential Cells             |       14 |
| Cell Area (µm²)              | 817.0336 |
| Estimated Critical Path (ns) |     2.52 |
| Setup Slack (ns)             |    +7.35 |
| Estimated Fmax (MHz)         |     ~377 |
| Total Power (µW)             |      250 |

## 📜 License

- Source code and HDL files are licensed under the MIT License.
- Documentation, diagrams, images, and PDFs are licensed under Creative Commons Attribution 4.0 (CC BY 4.0).
