# Hopfield Network

A digital implementation of a **Hopfield Neural Network** using SystemVerilog. The network acts as an associative memory, recovering a stored binary pattern from corrupted input states through iterative neuron updates based on weighted interactions.

This project explores how associative memory and neural computation can be implemented as a deterministic digital system using synthesizable RTL.

## Architecture

The network consists of 25 interconnected binary neurons governed by a predefined Hebbian weight matrix. Each neuron evaluates the weighted influence of the other neurons and updates its state according to a bipolar activation rule.

The implementation includes:

* **Hebbian Weight Matrix:** A predefined 25 × 25 matrix encoding the connections between neurons.
* **Bipolar State Representation:** Binary `1` represents `+1`, while binary `0` represents `−1`.
* **Weighted-Sum Computation:** Calculates the influence of the other neurons on the neuron being updated.
* **Sequential Neuron Updates:** Updates one neuron per clock cycle in a fixed order.
* **Convergence Detection:** Determines whether a complete pass through the network produces any state changes.
* **Iteration Limit:** Terminates the network when the configured maximum number of passes is reached.

## Stored Pattern

The network is configured to recall the following 5 × 5 binary pattern:

```text
0 1 0 0 1
0 1 0 1 0
0 1 1 0 0
0 1 0 1 0
0 1 0 0 1
```

The pattern is flattened row-wise into a 25-bit vector:

```text
0100101010011000101001001
```

Each binary state is mapped to a bipolar value:

* `1` → `+1`
* `0` → `−1`

The corresponding bipolar state vector is:

$$
S = [-1,+1,-1,-1,+1,\,
     -1,+1,-1,+1,-1,\,
     -1,+1,+1,-1,-1,\,
     -1,+1,-1,+1,-1,\,
     -1,+1,-1,-1,+1]
$$

This vector is used to construct the weight matrix and serves as the reference pattern for recall verification.

## Hebbian Weight Matrix

The network uses a predefined symmetric weight matrix constructed using the Hebbian learning rule.

For a stored bipolar pattern \(S\), the weight between neurons \(i\) and \(j\) is defined as:

$$
w_{ij} =
\begin{cases}
s_i s_j, & i \neq j \\
0, & i = j
\end{cases}
$$

where \(s_i\) and \(s_j\) represent the bipolar states of neurons \(i\) and \(j\).

The diagonal entries are set to zero to eliminate self-connections.

### Weight Matrix

The following is the 25 × 25 weight matrix corresponding to the stored pattern. Rows and columns are indexed from 1 to 25.

```asm
                                               Hebbian Weight Matrix:
   0   -1    1    1   -1    1   -1    1   -1    1    1   -1   -1    1    1    1   -1    1   -1    1    1   -1    1    1   -1
  -1    0   -1   -1    1   -1    1   -1    1   -1   -1    1    1   -1   -1   -1    1   -1    1   -1   -1    1   -1   -1    1
   1   -1    0    1   -1    1   -1    1   -1    1    1   -1   -1    1    1    1   -1    1   -1    1    1   -1    1    1   -1
   1   -1    1    0   -1    1   -1    1   -1    1    1   -1   -1    1    1    1   -1    1   -1    1    1   -1    1    1   -1
  -1    1   -1   -1    0   -1    1   -1    1   -1   -1    1    1   -1   -1   -1    1   -1    1   -1   -1    1   -1   -1    1
   1   -1    1    1   -1    0   -1    1   -1    1    1   -1   -1    1    1    1   -1    1   -1    1    1   -1    1    1   -1
  -1    1   -1   -1    1   -1    0   -1    1   -1   -1    1    1   -1   -1   -1    1   -1    1   -1   -1    1   -1   -1    1
   1   -1    1    1   -1    1   -1    0   -1    1    1   -1   -1    1    1    1   -1    1   -1    1    1   -1    1    1   -1
  -1    1   -1   -1    1   -1    1   -1    0   -1   -1    1    1   -1   -1   -1    1   -1    1   -1   -1    1   -1   -1    1
   1   -1    1    1   -1    1   -1    1   -1    0    1   -1   -1    1    1    1   -1    1   -1    1    1   -1    1    1   -1
   1   -1    1    1   -1    1   -1    1   -1    1    0   -1   -1    1    1    1   -1    1   -1    1    1   -1    1    1   -1
  -1    1   -1   -1    1   -1    1   -1    1   -1   -1    0    1   -1   -1   -1    1   -1    1   -1   -1    1   -1   -1    1
  -1    1   -1   -1    1   -1    1   -1    1   -1   -1    1    0   -1   -1   -1    1   -1    1   -1   -1    1   -1   -1    1
   1   -1    1    1   -1    1   -1    1   -1    1    1   -1   -1    0    1    1   -1    1   -1    1    1   -1    1    1   -1
   1   -1    1    1   -1    1   -1    1   -1    1    1   -1   -1    1    0    1   -1    1   -1    1    1   -1    1    1   -1
   1   -1    1    1   -1    1   -1    1   -1    1    1   -1   -1    1    1    0   -1    1   -1    1    1   -1    1    1   -1
  -1    1   -1   -1    1   -1    1   -1    1   -1   -1    1    1   -1   -1   -1    0   -1    1   -1   -1    1   -1   -1    1
   1   -1    1    1   -1    1   -1    1   -1    1    1   -1   -1    1    1    1   -1    0   -1    1    1   -1    1    1   -1
  -1    1   -1   -1    1   -1    1   -1    1   -1   -1    1    1   -1   -1   -1    1   -1    0   -1   -1    1   -1   -1    1
   1   -1    1    1   -1    1   -1    1   -1    1    1   -1   -1    1    1    1   -1    1   -1    0    1   -1    1    1   -1
   1   -1    1    1   -1    1   -1    1   -1    1    1   -1   -1    1    1    1   -1    1   -1    1    0   -1    1    1   -1
  -1    1   -1   -1    1   -1    1   -1    1   -1   -1    1    1   -1   -1   -1    1   -1    1   -1   -1    0   -1   -1    1
   1   -1    1    1   -1    1   -1    1   -1    1    1   -1   -1    1    1    1   -1    1   -1    1    1   -1    0    1   -1
   1   -1    1    1   -1    1   -1    1   -1    1    1   -1   -1    1    1    1   -1    1   -1    1    1   -1    1    0   -1
  -1    1   -1   -1    1   -1    1   -1    1   -1   -1    1    1   -1   -1   -1    1   -1    1   -1   -1    1   -1   -1    0
```
Generated by [Hebbian Weights Matrix Generator](../Hebbian.py)

The matrix satisfies:

$$
W = W^T
$$

and

$$
w_{ii} = 0
$$

Symmetry ensures that the connections are reciprocal, while the zero diagonal prevents self-connections.

## Neuron Update Rule

Each neuron computes its weighted input:

$$
h_i = \sum_{j=0}^{N-1} w_{ij}s_j
$$

The bipolar activation rule is:

$$
s_i^{\text{new}} =
\begin{cases}
+1, & h_i > 0 \\
-1, & h_i < 0 \\
s_i, & h_i = 0
\end{cases}
$$

In the RTL implementation, the bipolar states are represented using binary signals:

* A binary `1` corresponds to a bipolar state of `+1`.
* A binary `0` corresponds to a bipolar state of `−1`.
* If the weighted input is zero, the neuron retains its current state.

The network updates one neuron per clock cycle, using a fixed neuron-update order.

## Associative Recall

During recall, the network receives an initial state that may contain errors relative to the stored pattern.

The network iteratively updates its neurons according to their weighted inputs. Each update can change a neuron's state, allowing the network to correct differences between the initial state and the stored pattern.

After every complete pass through all neurons, the controller determines whether any state changes occurred.

The network terminates when either:

1. A complete pass produces no state changes, indicating convergence.
2. The configured maximum number of passes is reached.

The final state is made available through the network's output.

## Verification

The design is verified using SystemVerilog simulation and gate-level simulation.

A testbench applies multiple initial patterns and checks whether the network reaches the expected stored pattern.

The verification suite includes:

* Multiple corrupted input patterns.
* Checks of the final recalled state.
* Checks for convergence and completion.
* A timeout to prevent indefinite simulation.
* Gate-level simulation of the synthesized netlist.

### Verification Results

The current test suite successfully recovered the expected stored pattern in all 20 selected test cases.

| Verification Stage     | Result                      |
| ---------------------- | --------------------------- |
| RTL Simulation         | 20/20 tests passed          |
| Gate-Level Simulation  | 20/20 tests passed          |
| Expected final pattern | `0100101010011000101001001` |

These results demonstrate successful recall for the tested inputs. They do not establish that every possible 25-bit input will converge to the stored pattern.

## Project Objective

This project explores the implementation of associative memory using digital hardware. It connects the mathematical principles of Hopfield networks with sequential logic design, demonstrating how a network of weighted binary neurons can recover a stored pattern through iterative state updates.

The focus is on neural-network behavior, Hebbian weight construction, associative recall, convergence, and RTL verification.
