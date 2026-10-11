# Hopfield Network

A parameterized digital implementation of a Hopfield Network using SystemVerilog. The network acts as an associative memory, recovering stored patterns from initial states by iteratively updating neuron states according to their weighted inputs.

The design uses a predefined symmetric weight matrix with zero diagonal entries. Each neuron is updated asynchronously, one neuron per clock cycle, using bipolar state interpretation: binary `1` represents `+1`, while binary `0` represents `-1`. The network terminates when a complete pass produces no state changes or when the maximum pass limit is reached.

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
S_A = [-1,-1,-1,+1]
$$

**Stable State 2: `1110`**

Bipolar representation:

$$
S_B = [+1,+1,+1,-1]
$$

The two patterns are inverses:

$$
S_B=-S_A
$$


## Synthesis Results

**Technology:** Sky130 HD

**Synthesis Tool:** Yosys

| Metric              |            Value |
| ------------------- | ---------------: |
| Standard-Cell Count |           **87** |
| Sequential Cells    |           **14** |
| Chip Area           | **817.0336 µm²** |
| Memory Bits         |            **0** |

## Static Timing Analysis (OpenSTA)

**Clock Period:** 10 ns

| Metric                        |        Value |
| ----------------------------- | -----------: |
| Data Arrival Time             |  **2.52 ns** |
| Data Required Time            |  **9.87 ns** |
| Setup Slack                   | **+7.35 ns** |
| Estimated Critical Path Delay |  **2.52 ns** |
| Estimated Fmax                | **~377 MHz** |

## Power Analysis

| Metric              |      Value |
| ------------------- | ---------: |
| Sequential Power    | **107 µW** |
| Combinational Power | **143 µW** |
| Total Power         | **250 µW** |
