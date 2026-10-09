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

## ∑ Total Input to a Neuron
A neuron in a Hopfield Network typically receives contributions from multiple connected neurons. To determine the overall influence on a neuron, we sum the contributions from all neurons.

For neuron \(j\), the total input is:

$$
h_j=\sum_{i=1}^{N}w_{ji}s_i
$$

where:

* \(N\) is the number of neurons in the network.
* wⱼᵢ is the weight connecting neuron \(i\) to neuron \(j\).
* sᵢ is the current state of neuron \(i\).
* hⱼ is the total input received by neuron \(j\).

For example, consider a neuron receiving inputs from two neurons:

$$
w_{31}=+4,\quad s_1=-1
$$

$$
w_{32}=-2,\quad s_2=-1
$$

The individual contributions are:

$$
h_3^{(1)}=(+4)(-1)=-4
$$

$$
h_3^{(2)}=(-2)(-1)=+2
$$

Therefore, the total input is:

$$
h_3=-4+2=-2
$$

The total input combines the influences of all connected neurons into a single value. Its sign and magnitude depend on the contributions and their relative strengths.

## 🧬 Neuron Update Rule
After calculating its total input, a neuron applies an update rule to determine its next state.

For neuron \(j\), the total input is:

$$
h_j=\sum_{i=1}^{N}w_{ji}s_i
$$

We use the following update rule for our initial implementation:

$$
s_j^{new}=
\begin{cases}
+1 & \text{if } h_j>0\\
-1 & \text{if } h_j<0\\
s_j^{old} & \text{if } h_j=0
\end{cases}
$$

The rule has three cases:

* **Positive input:** The neuron takes state \(+1\).
* **Negative input:** The neuron takes state \(-1\).
* **Zero input:** The neuron retains its current state.

For example, if a neuron has current state \(+1\) and total input \(-5\), its new state becomes \(-1\). If its total input is zero, it remains in state \(+1\).

The neuron update rule converts the weighted sum of its inputs into a binary decision.

## 🎯 Network Convergence
A Hopfield Network evolves through repeated neuron-state updates. During each update, a neuron calculates its total input and applies the update rule to determine its next state.

When a neuron changes its state, the contributions it makes to connected neurons can also change. This may influence their subsequent updates, allowing changes to propagate through the network.

For example, consider a four-neuron network with the initial state:

$$
\mathbf{s}=[+1,-1,+1,-1]
$$

If the second neuron's state changes from \(-1\) to \(+1\), the network becomes:

$$
\mathbf{s}=[+1,+1,+1,-1]
$$

Although only one neuron was updated, the overall network state has changed.

### Stable states

A network has reached a stable state when applying its update procedure no longer changes its state.
A stable state does not necessarily correspond to an intended stored pattern. The network may instead settle into another stable configuration.

## 🧮 Storing Patterns in Weights
A Hopfield Network stores patterns by encoding relationships between neurons in its connection weights.

For a bipolar pattern, where each neuron has state \(+1\) or \(-1\), we can use the classical Hebbian learning rule to calculate the weights.

For a single pattern:

$$
w_{ij}=x_i x_j,\qquad i\ne j
$$

where xᵢ and $$x_j$$ are the states of neurons \(i\) and \(j\) in the pattern.

For example, consider:

$$
\mathbf{x}=[+1,-1,+1]
$$

The weight between Neurons 1 and 2 is:

$$
w_{12}=(+1)(-1)=-1
$$

The weight between Neurons 1 and 3 is:

$$
w_{13}=(+1)(+1)=+1
$$

For multiple stored patterns, the Hebbian rule adds their contributions:

$$
w_{ij}=\sum_{p=1}^{P}x_i^{(p)}x_j^{(p)},\qquad i\ne j
$$

where \(P\) is the number of stored patterns.

For example, consider two patterns:

$$
\mathbf{x}^{(1)}=[+1,-1,+1]
$$

$$
\mathbf{x}^{(2)}=[+1,+1,-1]
$$

The weight between Neurons 1 and 2 becomes:

$$
w_{12}=(-1)+(+1)=0
$$

The contributions cancel each other.

The weight between Neurons 2 and 3 becomes:

$$
w_{23}=(-1)+(-1)=-2
$$

The contributions reinforce each other.

We also impose zero self-connections:

$$
w_{ii}=0
$$
