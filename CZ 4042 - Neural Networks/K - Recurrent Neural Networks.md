# Recurrent Neural Networks

## Computational Graphs

The computations in a neural network can be described in a *computational graph*. Each *node* in the graph indicates a variable that could be a scalar, vector, matrix, tensor or a variable of another type. A *directed edge* denotes an operation executed on one variable and results in another variable. An *operation* is a simple function of one or more variables. A set of allowable operations defines the language of the computational graph. *Functions* are described by a set of operations together.

## Recurrent Neural Networks (RNNs)

RNNs are designed to process sequential information (i.e. data represented as sequences). The next data point in a sequence is usually dependent on the current data point. RNNs attempt to capture dependency among the data points in the sequence.

RNNs have memory that captures information about what has been processed so far. It achieves this by using feedback connections that enable learning of sequential (temporal) information of sequences.

### Types of RNNs

![Types of RNNs](img/RNN%20Types.png)

From left to right:

- Feedforward Neural Network
- RNN w/ Hidden Recurrence (Elman-type)
- RNN w/ Top-Down Recurrence (Jordan-type)

## RNN w/ Hidden Recurrence

Recurrent networks that produce an output at each time step and have recurrent connections between hidden units.

In Elman-type RNNs, the output at the hidden layer at time $t - 1$ is kept and fed to the hidden layer at time $t$ together with the raw input $x(t)$ for time $t$.

![Elman-type RNN](img/Elman-type%20RNN.png){height=150px}

Note that time $t$ is assumed to be discretized and activations are updated at each time instance $t$. The delay unit is added to indicate that the activation is held until the next time instance.

![RNN w/ Hidden Recurrence](img/Elman-type%20RNN%20Unfolded.png)

The recurrent connections can be unfolded in time as shown in the diagram above.

By considering the unfolded recurrence:

$$
\begin{split}
\boldsymbol{h}(t)
&= g^t(\boldsymbol{x}(t), \boldsymbol{x}(t - 1), \cdots, \boldsymbol{x}(2), \boldsymbol{x}(1)) \\
&= f(\boldsymbol{h}(t - 1), \boldsymbol{x}(t))
\end{split}
$$

where the function $g^t$ takes the whole past sequence as input and produces the hidden layer activation. The unfolded recurrent structure allows us to factorize $g^t$ into repeated applications of a function $f$.

The unfolding process has two major advantages:

1. Regardless of the sequence length, the learned model always has the same size rather than specified in terms of a variable-length history of states.
2. It is possible to use the same transition function $f$ with the same parameters at every time step.

### Forward Propagation

Let $\boldsymbol{x}(t)$, $\boldsymbol{y}(t)$ and $\boldsymbol{h}(t)$ be the input, output and hidden output of the network at time $t$. Activation of the three-layer Elman-type RNN is given by:

$$
\begin{gathered}
\boldsymbol{h}(t) = \phi (\boldsymbol{U}^T \boldsymbol{x}(t) + \boldsymbol{W}^T \boldsymbol{h}(t - 1) + \boldsymbol{b}) \\
\boldsymbol{y}(t) = \sigma(\boldsymbol{V}^T \boldsymbol{h}(t) + \boldsymbol{c})
\end{gathered}
$$

- $\boldsymbol{U}$ - Weight vector that transforms raw inputs to the hidden layer activations.
- $\boldsymbol{W}$ - Recurrent weight vector connecting previous hidden layer outputs to the current hidden layer input.
- $\boldsymbol{V}$ - Weight vector connecting the hidden layer to the output layer.
- $\boldsymbol{b}$ - Bias connected to the hidden layer.
- $\boldsymbol{c}$ - Bias connected to the output layer.
- $\phi$ is the tanh activation function (for hidden layer) and $\sigma$ is the sigmoid activation function (for output layer).

The output layer activation function is a softmax for classification and a linear/sigmoid activation for regression.

Typically, the hidden layer activation function is given by the tanh function:

$$
\begin{gathered}
\phi(u) = \text{tanh}(u) = \frac{e^u - e^{-u}}{e^u + e^{-u}} = \frac{1 - e^{-2u}}{1 + e^{-2u}} \\
\phi'(u) = 1 - \phi(u)^2
\end{gathered}
$$

### Deep RNN w/ Hidden Recurrence

![Deep RNN w/ Hidden Recurrence](img/Deep%20Elman-type%20RNN.png){height=180px}

First hidden layer, $l = 1$:

$$
\boldsymbol{h}^1(t) = \phi \Big({\boldsymbol{U}^1}^T \boldsymbol{x}(t) + {\boldsymbol{W}^1}^T \boldsymbol{h}^1(t - 1) + \boldsymbol{b}^1 \Big)
$$

For hidden layers $l = 2, \cdots, L - 1$:

$$
\boldsymbol{h}^l(t) = \phi \Big({\boldsymbol{U}^l}^T \boldsymbol{h}^{l - 1}(t) + {\boldsymbol{W}^l}^T \boldsymbol{h}^l(t - 1) + \boldsymbol{b}^l \Big)
$$

For output layer, $l = L$:

$$
\boldsymbol{h}^L(t) = \sigma \Big({\boldsymbol{U}^L}^T \boldsymbol{h}^{L - 1}(t) + \boldsymbol{b}^L \Big)
$$

## RNN w/ Top-Down Recurrence

In Jordan-type RNNs, the output of the output layer at time $t - 1$ is kept and fed to the hidden layer at time $t$ together with the raw input $x(t)$ for time $t$.

![RNN w/ Top-Down Recurrence](img/Jordan-type%20RNN.png){height=150px}

Note that time $t$ is assumed to be discretized and activations are updated at each time instance $t$. The delay unit is added to indicate that the activation is held until the next time instance.

### Forward Propagation

Let $\boldsymbol{x}(t)$, $\boldsymbol{y}(t)$ and $\boldsymbol{h}(t)$ be the input, output and hidden output of the network at time $t$. Activation of the three-layer Jordan-type RNN is given by:

$$
\begin{gathered}
\boldsymbol{h}(t) = \phi (\boldsymbol{U}^T \boldsymbol{x}(t) + \boldsymbol{W}^T \boldsymbol{y}(t - 1) + \boldsymbol{b}) \\
\boldsymbol{y}(t) = \sigma(\boldsymbol{V}^T \boldsymbol{h}(t) + \boldsymbol{c})
\end{gathered}
$$

where $\boldsymbol{W}$ represents the recurrent weight matrix connecting the previous output to the current hidden input.

### Deep RNN w/ Top-Down Recurrence

First hidden layer, $l = 1$:

$$
\boldsymbol{h}^1(t) = \phi \Big({\boldsymbol{U}^1}^T \boldsymbol{x}(t) + {\boldsymbol{W}^1}^T \boldsymbol{h}^2(t - 1) + \boldsymbol{b}^1 \Big)
$$

For hidden layers $l = 2, \cdots, L - 2$:

$$
\boldsymbol{h}^l(t) = \phi \Big({\boldsymbol{U}^l}^T \boldsymbol{h}^{l - 1}(t) + {\boldsymbol{W}^l}^T \boldsymbol{h}^{l + 1}(t - 1) + \boldsymbol{b}^l \Big)
$$

For hidden layer, $l = L - 1$:

$$
\boldsymbol{h}^{L - 1}(t) = \phi \Big({\boldsymbol{U}^{L - 1}}^T \boldsymbol{h}^{L - 2}(t) + {\boldsymbol{W}^{L - 1}}^T \boldsymbol{y}(t - 1) + \boldsymbol{b}^{L - 1} \Big)
$$

For output layer, $l = L$:

$$
\boldsymbol{h}^L(t) = \sigma \Big({\boldsymbol{U}^L}^T \boldsymbol{h}^{L - 1}(t) + \boldsymbol{b}^L \Big)
$$

where $\boldsymbol{U}^l$ is the weight matrix connecting the output of hidden layer $l - 1$ to hidden layer $l$ and $\boldsymbol{W}^l$ is the weight matrix connecting the hidden layer output of the previous time instance to the current output of the hidden layer.

## Chain Rule in Multidimensions

If $\boldsymbol{x} = (x_i) \in \boldsymbol{R}^n$, $\boldsymbol{y} = (y_k) \in \boldsymbol{R}^K$ and $z \in \boldsymbol{R}$, and $\boldsymbol{y} = f(\boldsymbol{x})$ and $z = g(\boldsymbol{y})$, the chain rule of differentiation in multidimensions is:

$$
\frac{\partial z}{\partial x_i} = \sum_k \frac{\partial z}{\partial y_k} \frac{\partial y_k}{\partial x_i}
$$

This can be rewritten as:

$$
\frac{\partial z}{\partial x_i} = \Bigg(\frac{\partial \boldsymbol{y}}{\partial x_i} \Bigg)^T \frac{\partial z}{\partial \boldsymbol{y}}
$$

$$
\frac{\partial \boldsymbol{y}}{\partial x_i} = \begin{pmatrix} \frac{\partial y_1}{\partial x_i} \\ \vdots \\ \frac{\partial y_K}{\partial x_i} \end{pmatrix}
\quad
\frac{\partial z}{\partial \boldsymbol{y}} = \begin{pmatrix} \frac{\partial z}{\partial y_1} \\ \vdots \\ \frac{\partial z}{\partial y_K} \end{pmatrix}
$$

This can be further rewritten as:

$$
\frac{\partial z}{\partial \boldsymbol{x}} = \Bigg(\frac{\partial \boldsymbol{y}}{\partial \boldsymbol{x}} \Bigg)^T \frac{\partial z}{\partial \boldsymbol{y}}
$$

$$
\frac{\partial \boldsymbol{y}}{\partial \boldsymbol{x}} =
\begin{pmatrix}
\frac{\partial y_1}{\partial x_1} & \cdots & \frac{\partial y_K}{\partial x_1} \\
\vdots & \vdots & \vdots \\
\frac{\partial y_1}{\partial x_n} & \cdots & \frac{\partial y_K}{\partial x_n}
\end{pmatrix}
$$

$\frac{\partial \boldsymbol{y}}{\partial \boldsymbol{x}}$ is called the *Jacobian* of the transformation $\boldsymbol{y} = f(\boldsymbol{x})$.

## Gradient w/ Respect to a Tensor

Consider a scalar function $z$ and an $m$-rank tensor $\boldsymbol{X}$. Let the gradient of $z$ with respect to $\boldsymbol{X}$ be denoted by $\boldsymbol{\nabla}_{\boldsymbol{X}}z$:

$$
\frac{\partial z}{\partial \boldsymbol{X}} = \boldsymbol{\nabla}_{\boldsymbol{X}}z
$$

Assume that a vector with index $j$ maps all dimensions in $m$ ranks of the tensor. Then the gradient of $z$ with respect to the $j$th element $X_j$ of the tensor is denoted by:

$$
(\boldsymbol{\nabla}_{\boldsymbol{X}}z)_j = \frac{\partial z}{\partial X_j}
$$

If $\boldsymbol{Y} = f(\boldsymbol{X})$ and $z = g(\boldsymbol{Y})$, then from the chain rule of differentiation:

$$
\boldsymbol{\nabla}_{\boldsymbol{X}}z = \sum_j (\boldsymbol{\nabla}_{\boldsymbol{X}}Y_j) \frac{\partial z}{\partial Y_j}
$$

## Neuron Layers Revisited

![Computational Graph of a Neuron Layer](img/Neuron%20Layer%20Computational%20Graph.png)

\pagebreak

For a softmax layer:

$$
\begin{gathered}
J = - \sum_k 1(d = \boldsymbol{k}) \log f(u_k) \\
\frac{\partial J}{\partial \boldsymbol{u}} = -(1(d = \boldsymbol{k}) - f(\boldsymbol{u}))
\end{gathered}
$$

For a perceptron layer:

$$
\begin{gathered}
J = (\boldsymbol{d} - f(\boldsymbol{u}))^2 \\
\frac{\partial J}{\partial \boldsymbol{u}} = -2(\boldsymbol{d} - f(\boldsymbol{u}))
\end{gathered}
$$

The synaptic input is given by:

$$
\boldsymbol{u} = \boldsymbol{W}^T \boldsymbol{x} + \boldsymbol{b}
$$

Jacobian:

$$
\frac{\partial \boldsymbol{u}}{\partial \boldsymbol{x}} = \boldsymbol{W}
$$

Therefore,

$$
\frac{\partial J}{\partial \boldsymbol{x}} = \Bigg(\frac{\partial \boldsymbol{u}}{\partial \boldsymbol{x}} \Bigg)^T \frac{\partial J}{\partial \boldsymbol{u}} = \boldsymbol{W}^T \frac{\partial J}{\partial \boldsymbol{u}}
$$

That is, the error terms at the synaptic inputs can be transformed to the input by multiplying by the transpose of the Jacobian.

Therefore,

$$
\begin{gathered}
\boldsymbol{\nabla}_{\boldsymbol{W}} J = \sum_k (\boldsymbol{\nabla}_{\boldsymbol{W}} u_k) \frac{\partial J}{\partial u_k} \\
\boldsymbol{\nabla}_{\boldsymbol{W}} J = \boldsymbol{x} \Bigg(\frac{\partial J}{\partial \boldsymbol{u}} \Bigg)^T \\
\boldsymbol{\nabla}_{\boldsymbol{b}} J = \Bigg(\frac{\partial J}{\partial \boldsymbol{u}} \Bigg)
\end{gathered}
$$

## Backpropagation Revisited

![Computational Graph of Feedforward Network](img/Feedforward%20Network%20Computational%20Graph.png)

$$
\begin{gathered}
\frac{\partial J}{\partial \boldsymbol{h}} = \Bigg(\frac{\partial \boldsymbol{u}}{\partial \boldsymbol{h}} \Bigg)^T \frac{\partial J}{\partial \boldsymbol{u}} = \boldsymbol{V}^T \frac{\partial J}{\partial \boldsymbol{u}} \\
\frac{\partial J}{\partial \boldsymbol{s}} = \Bigg(\frac{\partial \boldsymbol{h}}{\partial \boldsymbol{s}} \Bigg)^T \frac{\partial J}{\partial \boldsymbol{h}}
\end{gathered}
$$

where $\boldsymbol{h} = f(\boldsymbol{s})$ and $\frac{\partial \boldsymbol{h}}{\partial \boldsymbol{s}} = \text{diag}(f'(\boldsymbol{s}))$. $\text{diag}(f'(\boldsymbol{s}))$ is a diagonal matrix with diagonal elements $f'(s_i)$.

Substituting,

$$
\begin{gathered}
\boldsymbol{\nabla}_{\boldsymbol{W}} J = \boldsymbol{x} \Bigg(\frac{\partial J}{\partial \boldsymbol{s}} \Bigg)^T = \boldsymbol{x} \Bigg(\frac{\partial J}{\partial \boldsymbol{u}} \Bigg)^T \boldsymbol{V} \text{diag}(f'(s)) \\
\boldsymbol{\nabla}_{\boldsymbol{b}} J = \frac{\partial J}{\partial \boldsymbol{s}} = \text{diag}(f'(\boldsymbol{s})) \boldsymbol{V}^T \frac{\partial J}{\partial \boldsymbol{u}}
\end{gathered}
$$

## Backpropagation Through Time (BPTT) for RNN w/ Hidden Reccurence

The gradient computation involves performing a forward propagation pass moving left to right through the unfolded graph of the RNN, followed by a backpropagation pass moving right to left through the graph.

The runtime is $O(\tau)$ where $\tau$ is the length of the input sequence and cannot be reduced by parallelization because the forward propagation is inherently sequential.

Hence, a network with recurrence between hidden units is very powerful but also expensive to train.

**Forward Propagation Equations:**

$$
\begin{gathered}
\boldsymbol{h}(t) = \text{tanh}(\boldsymbol{U}^T \boldsymbol{x}(t) + \boldsymbol{W}^T \boldsymbol{h}(t - 1) + \boldsymbol{b}) \\
\boldsymbol{u}(t) = \boldsymbol{V}^T \boldsymbol{h}(t) + \boldsymbol{c}
\end{gathered}
$$

For classification, $\boldsymbol{y}(t) = \text{softmax}(\boldsymbol{u}(t))$.

For regression, $\boldsymbol{y}(t) = \boldsymbol{u}(t)$.

**Total Error:**

$$
J = \sum_{t = 1}^{\tau} J(t)
$$

Note that $\frac{\partial J}{\partial J(t)} = 1$.

**Error Gradients at Output:**

$$
\boldsymbol{\nabla}_{\boldsymbol{u}(t)} J = \boldsymbol{\nabla}_{\boldsymbol{u}(t)} J(t) =
\begin{cases}
-(1(\boldsymbol{k} = d(t)) - f(\boldsymbol{u})) \quad \text{for softmax} \\
-2(\boldsymbol{d}(t) - f(\boldsymbol{u})) \quad \text{for linear regression}
\end{cases}
$$

The gradients propagate backward, starting from the end of the sequence. At the final time step $\tau$, $\boldsymbol{h}(t)$ has only one descendant. Hence, for $t = \tau$:

$$
\boldsymbol{\nabla}_{\boldsymbol{h}(\tau)} J = \boldsymbol{V}^T \boldsymbol{\nabla}_{\boldsymbol{u}(\tau)} J
$$

We can then iterate backward in time to backpropagate gradients. For $t < \tau$, $\boldsymbol{h}(t)$ has descendants both $\boldsymbol{h}(t + 1)$ and $\boldsymbol{u}(t)$. Therefore, for $t = 1, \cdots, \tau - 1$:

$$
\boldsymbol{\nabla}_{\boldsymbol{h}(t)} J = \Bigg(\frac{\partial \boldsymbol{h}(t + 1)}{\partial \boldsymbol{h}(t)} \Bigg)^T \boldsymbol{\nabla}_{\boldsymbol{h}(t + 1)} J + \Bigg(\frac{\partial \boldsymbol{u}(t)}{\partial \boldsymbol{h}(t)} \Bigg)^T \boldsymbol{\nabla}_{\boldsymbol{u}(t)} J
$$

where:

$$
\begin{gathered}
\frac{\partial \boldsymbol{h}(t + 1)}{\partial \boldsymbol{h}(t)} = \frac{\partial \boldsymbol{h}(t + 1)}{\partial \boldsymbol{s}(t + 1)} \frac{\partial \boldsymbol{s}(t + 1)}{\partial \boldsymbol{h}(t)} = \text{diag}(1 - \boldsymbol{h}^2(t + 1)) \boldsymbol{W} \\
\frac{\partial \boldsymbol{u}(t)}{\partial \boldsymbol{h}(t)} = \boldsymbol{V}
\end{gathered}
$$

Substituting,

$$
\boldsymbol{\nabla}_{\boldsymbol{h}(t)} J = \boldsymbol{W}^T \text{diag}(1 - \boldsymbol{h}^2(t + 1)) \boldsymbol{\nabla}_{\boldsymbol{h}(t + 1)} J + \boldsymbol{V} \boldsymbol{\nabla}_{\boldsymbol{u}(t)} J
$$

Using above error gradients, we can calculate the gradients with respect to the parameters $\boldsymbol{\theta} = \{\boldsymbol{U}, \boldsymbol{V}, \boldsymbol{W}, \boldsymbol{b}, \boldsymbol{c}\}$:

$$
\begin{gathered}
\boldsymbol{\nabla}_{\boldsymbol{c}} J = \sum_t \frac{\partial J(t)}{\partial \boldsymbol{c}} = \sum_t \Bigg(\frac{\partial \boldsymbol{u}(t)}{\partial \boldsymbol{c}} \Bigg)^T \boldsymbol{\nabla}_{\boldsymbol{u}(t)} J = \sum_t \boldsymbol{\nabla}_{\boldsymbol{u}(t)} J \\
\boldsymbol{\nabla}_{\boldsymbol{b}} J = \sum_t \Bigg(\frac{\partial \boldsymbol{h}(t)}{\partial \boldsymbol{b}} \Bigg)^T \boldsymbol{\nabla}_{\boldsymbol{h}(t)} J = \sum_t \text{diag}(1 - \boldsymbol{h}(t)^2) \boldsymbol{\nabla}_{\boldsymbol{h}(t)} J \\
\boldsymbol{\nabla}_{\boldsymbol{V}} J = \sum_t \sum_i \frac{\partial \boldsymbol{J}}{\partial u_i(t)} \boldsymbol{\nabla}_{\boldsymbol{V}} u_i(t) = \sum_t \boldsymbol{h}(t)(\boldsymbol{\nabla}_{\boldsymbol{u}(t)} J)^T \\
\boldsymbol{\nabla}_{\boldsymbol{W}} J = \sum_t \sum_i \frac{\partial \boldsymbol{J}}{\partial h_i(t)} \boldsymbol{\nabla}_{\boldsymbol{W}} h_i(t) = \sum_t \boldsymbol{h}(t - 1) (\boldsymbol{\nabla}_{\boldsymbol{h}(t)} J)^T \text{diag}(1 - \boldsymbol{h}(t)^2) \\
\boldsymbol{\nabla}_{\boldsymbol{U}} J = \sum_t \sum_i \frac{\partial \boldsymbol{J}}{\partial h_i(t)} \boldsymbol{\nabla}_{\boldsymbol{U}} h_i(t) = \sum_t \boldsymbol{x}(t) (\boldsymbol{\nabla}_{\boldsymbol{h}(t)} J)^T \text{diag}(1 - \boldsymbol{h}(t)^2)
\end{gathered}
$$
