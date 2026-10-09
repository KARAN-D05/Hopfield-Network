# Theory

## 🧠 Hopfield Network
A Hopfield Network is a type of recurrent neural network that acts as an associative memory. It can retrieve a stored pattern by being presented with a similar or partially corrupted version of that pattern.

In conventional computer memories, such as RAM, data is typically accessed using a memory address. In contrast, a Hopfield Network performs content-based recall: the network uses the input pattern and the information encoded in its weights to evolve toward a stable state that may correspond to a stored pattern.

The network consists of interconnected neurons whose relationships are represented by weights. These weights encode the stored patterns, while the neurons maintain the network's current state. Through repeated state updates, the network can recover a stored pattern from an incomplete or corrupted input.

## 🕸️ Neurons and Network States
A Hopfield Network consists of interconnected neurons, each holding a state that contributes to the network's overall state.

In the classical binary Hopfield Network, each neuron has one of two possible states:

* `+1`: Positive state.
* `-1`: Negative state.

For a network containing \(N\) neurons, its current state can be represented by a vector:

$$
\mathbf{s} = [s_1,s_2,\ldots,s_N]
$$

where each sᵢ ∈ {−1, +1} represents the current state of neuron \(i\).

For example, a four-neuron network might have the state:

$$
\mathbf{s} = [+1,-1,-1,+1]
$$

This vector represents the current state of all four neurons, not four separate stored patterns.

The network's state may change as neurons are updated according to the network's weights and update rules. A state is stable when applying the update rules no longer changes it.

**Key distinction:** Stored patterns are encoded in the network's weights, whereas the state vector represents the neurons' current values during operation.
