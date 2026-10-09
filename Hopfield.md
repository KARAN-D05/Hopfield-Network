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

## 🔗 Connection Weights
In a Hopfield Network, each connection between neurons has an associated weight. The weight determines how strongly, and in what direction, one neuron's state contributes to another neuron's input.

For a connection from neuron \(i\) to neuron \(j\), the contribution is:

$$
h_j^{(i)}=w_{ji}s_i
$$

where:

- sᵢ is the current state of neuron i.
- wⱼᵢ is the connection weight.
- hⱼ⁽ⁱ⁾ is the contribution of neuron i to neuron j.
For example, if w₂₁ = −3 and s₁ = +1, then:

$$
h_2^{(1)}=(-3)(+1)=-3
$$

This negative contribution favors neuron \(2\) taking the state \(-1\), all else being equal.

In general:

* A positive weight favors connected neurons having the same state.
* A negative weight favors connected neurons having opposite states.
* A zero weight contributes nothing through that connection.

These interpretations follow from how connection contributions influence the neuron's update calculation. A single connection does not necessarily determine the neuron's next state because other connections may contribute as well.

The neuron's next state is determined by combining the contributions from its connections and applying the update rule.

