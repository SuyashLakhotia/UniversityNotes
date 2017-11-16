# Multilayer Perceptron

![Multilayer Perceptron](img/Multilayer%20Perceptron.png)

- A multilayer perceptron (MLP) is a feedforward network with $L$ layers, where the hidden layers of the network consists of perceptrons.
- MLP has been applied successfully to resolve many complex real-world problems consisting of *non-linear decision boundaries*.
- The network is trained in a *supervised* manner with the *error back-propagation algorithm* based on the gradient descent algorithm.
- Backpropagation learning can be seen as a generalization of the delta learning equations for multilayer networks.

## Three-Layer MLP Network

Given a training dataset $\{ (\boldsymbol{x}_p, \boldsymbol{d}_p) \}_{p = 1}^P$ where $\boldsymbol{x}_p \in \boldsymbol{R}^n$ and $d_p \in \boldsymbol{R}^K$. The three-layer MLP can learn to approximate an arbitrary complex function $\phi$:

$$
\phi: \boldsymbol{R}^n \rightarrow \boldsymbol{R}^K
$$

The hidden layer neurons converts input signal into a hidden representation in order to approximate the input-output mapping posed by the training patterns.

![Three-Layer MLP Network (neurons have sigmoid activation functions)](img/Three-Layer%20MLP.png)

For the hidden layer, $g$ is the activation function, synaptic input $\boldsymbol{S} = \boldsymbol{X} \boldsymbol{V} + \boldsymbol{B}_h$ and output $\boldsymbol{Z} = g(\boldsymbol{S})$.

For the output layer, $f$ is the activation function, synaptic input $\boldsymbol{U} = \boldsymbol{Z} \boldsymbol{W} + \boldsymbol{B}_o$ and output $\boldsymbol{Y} = f(\boldsymbol{U})$.

### GD for Output Layer

The output layer is a perceptron layer receiving outputs $\boldsymbol{Z}$ from the hidden layer. So we can directly apply equations of a perceptron layer to the output layer:

$$
\begin{gathered}
\boldsymbol{U} = \boldsymbol{Z} \boldsymbol{W} + \boldsymbol{B}_o \\
\boldsymbol{Y} = f(\boldsymbol{U})
\end{gathered}
$$

Delta learning equations:

$$
\begin{gathered}
\Delta_o = (\boldsymbol{D} - \boldsymbol{Y}) \cdot f'(\boldsymbol{U}) \\
\boldsymbol{W} = \boldsymbol{W} + \alpha_1 \boldsymbol{Z}^T \Delta_o \\
\boldsymbol{b}_o = \boldsymbol{b}_o + \alpha_1 \Delta_o^T \boldsymbol{1}_P
\end{gathered}
$$

### GD for Hidden Layer

The mean square error function:

$$
J = \frac{1}{P} \sum_{p = 1}^P \sum_{k = 1}^K (d_{pk} - y_{pk})^2
$$

where $y_{pk}$ is the $k$th neuron output at the output layer.

Gradient with respect to the $j$th hidden layer neuron weight $\boldsymbol{v}_j$ (complete derivation in Lecture Notes):

$$
\begin{split}
\frac{\partial J}{\partial \boldsymbol{v}_j}
&= - \frac{2}{P} \sum_{p = 1}^P \sum_{k = 1}^K (d_{pk} - y_{pk}) \frac{\partial y_{pk}}{\partial \boldsymbol{v}_j} \\
&= - \frac{2}{P} \sum_{p = 1}^P \sum_{k = 1}^K (d_{pk} - y_{pk}) f'(u_{pk}) w_{kj} g'(s_{pj}) \boldsymbol{x}_p \\
&= - \frac{2}{P} \sum_{p = 1}^P \sum_{k = 1}^K \delta_{opk} w_{kj} g'(s_{pj}) \boldsymbol{x}_p \\
&= \frac{2}{P} \sum_{p = 1}^P ({\boldsymbol{\delta}_{op}}^T \boldsymbol{w}_{j}) \cdot g'(s_{pj}) \boldsymbol{x}_p \\
&= - \frac{2}{P} \begin{pmatrix} \boldsymbol{x}_1 & \hdots & \boldsymbol{x}_P \end{pmatrix} \begin{pmatrix} ({\boldsymbol{\delta}_{o1}}^T \boldsymbol{w}_j) \cdot g'(s_{1j}) \\ \vdots \\ ({\boldsymbol{\delta}_{oP}}^T \boldsymbol{w}_j) \cdot g'(s_{Pj}) \end{pmatrix} \\
&= - \frac{2}{P} \boldsymbol{X}^T \boldsymbol{\delta}_{hj}
\end{split}
$$

where:

$$
\begin{split}
\boldsymbol{\delta}_{hj}
&= \begin{pmatrix} ({\boldsymbol{\delta}_{o1}}^T \boldsymbol{w}_j) \cdot g'(s_{1j}) \\ \vdots \\ ({\boldsymbol{\delta}_{oP}}^T \boldsymbol{w}_j) \cdot g'(s_{Pj}) \end{pmatrix} \\
&= \begin{pmatrix} {\boldsymbol{\delta}_{o1}}^T \\ \vdots \\ {\boldsymbol{\delta}_{oP}}^T \end{pmatrix} \boldsymbol{w}_j \cdot \begin{pmatrix} g'(s_{1j}) \\ \vdots \\ g'(s_{Pj}) \end{pmatrix} \\
&= \Delta_o \boldsymbol{w}_j \cdot g'(\boldsymbol{s}_j)
\end{split}
$$

Substituting in the GD equation for the $j$th hidden neuron:

$$
\begin{gathered}
\boldsymbol{v}_j = \boldsymbol{v}_j - \alpha \frac{\partial J}{\partial \boldsymbol{v}_j} \\
\boldsymbol{v}_j = \boldsymbol{v}_j + \alpha_1 \boldsymbol{X}^T \boldsymbol{\delta}_{hj}
\end{gathered}
$$

where $\alpha_1 = \frac{2 \alpha}{P}$.

Therefore, for the hidden layer:

$$
\boldsymbol{V} = \boldsymbol{V} + \alpha_1 \boldsymbol{X}^T \Delta_h
$$

where:

$$
\begin{split}
\Delta_h
&= \begin{pmatrix} \boldsymbol{\delta}_{h1} & \hdots & \boldsymbol{\delta}_{hM} \end{pmatrix} \\
&= \begin{pmatrix} \Delta_o \boldsymbol{w}_1 \cdot g'(\boldsymbol{s}_1) & \hdots & \Delta_o \boldsymbol{w}_M \cdot g'(\boldsymbol{s}_M) \end{pmatrix} \\
&= \Delta_o \boldsymbol{W}^T \cdot g'(\boldsymbol{S})
\end{split}
$$

Similarly, for bias:

$$
\boldsymbol{b}_h = \boldsymbol{b}_h + \alpha_1 {\Delta_h}^T \boldsymbol{1}_P
$$

### SGD for Three-Layer MLP

![SGD for Three-Layer MLP](img/Three-Layer%20MLP%20SGD.png)

### Backpropagation of Error

Note that the hidden layer terms $\Delta_h$ are computed from output error terms $\Delta_o$. The error can be seen as propagating to the hidden layer from the output layer and therefore learning is known as the *backpropagation algorithm*.

## Functional Approximation with MLP

Multilayer feedforward networks such as MLP that use continuous perceptrons are able to approximate complex multidimensional functions. Given a set of training samples, the network finds a smooth function that approximates the actual functional mapping.

![MLP Functional Approximation](img/MLP%20Functional%20Approximation.png)

MLP finds a multidimensional functional mapping:

$$
\phi: \boldsymbol{R}^n \rightarrow \boldsymbol{R}^K
$$

by minimizing the mean square error cost function:

$$
J = \frac{1}{P} \sum_{p = 1}^P || \boldsymbol{d}_p - \boldsymbol{y}_p ||^2
$$

Once the weights and biases are learnt by backpropagation, the predicted value $\hat{\boldsymbol{y}}$ for an input pattern $\boldsymbol{x}$ can be found:

$$
\hat{\boldsymbol{y}} = \phi(\boldsymbol{x})
$$

## Universal Approximation Theorem

**Kolmogorov Theorem:** Given any function $\phi: I^n \rightarrow \boldsymbol{R}^k$ where $I$ is the closed unit interval $[0, 1]$, $\phi$ can be implemented exactly by a three layer neural network with $n$ input nodes, $2n + 1$ hidden layer neurons and $K$ output layer neurons.

The theorem doesn't refer to the algorithms or the amount of training data needed for the approximation. Recent researches find that deep neural networks and a large number of training data are required to learn any arbitrarily complex function.

## Output Layer Activation Function

MLP uses sigmoid as the activation function of neurons. Hence, the output neuron activation function should be scaled and translated to match the space of output.

If output $y \in [y_{min}, y_{max}]$, the output layer activation function:

$$
f(u) = \frac{a}{1 + e^{-u}} + b
$$

where $a = y_{max} - y_{min}$ and $b = y_{min}$.

## Normalization of Inputs

If inputs have similar variations, a better approximation of inputs is achieved. Mainly, there are two approaches to normalization. If $\widetilde{x}_i$ denotes the normalized input:

I. Scale the inputs such that $x_i \in [0, 1]$:

$$
\widetilde{x}_i = \frac{x_i - x_{i, min}}{x_{i, max} - x_{i, min}}
$$

II. Normalize the input to have standard normal distributions $x_i \sim N(0, 1)$:

$$
\widetilde{x}_i = \frac{x_i - \mu_i}{\sigma_i}
$$

## Number of Hidden Neurons

With increasing number of hidden units, the number of parameters of the network increases and therefore, the network attempts to remember the training patterns. That is, the network aims at minimizing the training error but this can increase the errors on test data (i.e. overfitting) after some point.

As the number of hidden units increases, the test error decreases initially but tends to increase at some point. The optimal number of hidden neurons is often determined empirically (i.e. trial and error).

\pagebreak

## Deep Feedforward Networks

Total $L + 1$ layers.

- Layer $l$:
    - Number of Neurons: $n_l$
    - Weight Vector: $\boldsymbol{W}^l$
    - Bias: $\boldsymbol{b}^l$
    - Synaptic Input: $\boldsymbol{U}^l$
    - Output of Layer: $\boldsymbol{Y}^l$
    - Input from Previous Layer: $\boldsymbol{Y}^{l - 1}$
- Input Layer ($l = 0$):
    - Number of Inputs: $n_0 = n$
    - Input to Network: $\boldsymbol{Y}^0 = \boldsymbol{X}$
- Output Layer ($l = L$):
    - Softmax layer for classification or linear neurons for functional approximation.

### GD for Deep Feedforward Network

- Input: $(\boldsymbol{X}, \boldsymbol{D})$
- Input Layer: $\boldsymbol{Y}^0 = \boldsymbol{X}$
- Layers $l = 1, 2, \hdots L$:
    - $\boldsymbol{U}^l = \boldsymbol{Y}^{l - 1} \boldsymbol{W}^l + \boldsymbol{B}^l$
    - $\boldsymbol{Y}^l = f(\boldsymbol{U}^l)$
- Output Layer: $\Delta^L = (\boldsymbol{D} - \boldsymbol{Y}^L) \cdot f'(\boldsymbol{U}^L)$
- Layers $l = L - 1, L - 2, \hdots, 1$:
    - $\Delta^l = \Delta^{l + 1} {\boldsymbol{W}^{l + 1}}^T \cdot f'(\boldsymbol{U}^l)$
- Layers $l = 1, 2, \hdots L$:
    - $\boldsymbol{W}^l = \boldsymbol{W}^l + \alpha_1 {\boldsymbol{Y}^{l - 1}}^T \Delta^l$
    - $\boldsymbol{b}^l = \boldsymbol{b}^l + \alpha_1 {\Delta^l}^T \boldsymbol{1}_P$

### SGD for Deep Feedforward Network

- Input: $(\boldsymbol{x}, \boldsymbol{d})$
- Input Layer: $\boldsymbol{y}^0 = \boldsymbol{x}$
- Layers $l = 1, 2, \hdots L$:
    - $\boldsymbol{u}^l = {\boldsymbol{W}^l}^T \boldsymbol{y}^{l - 1} + \boldsymbol{b}^l$
    - $\boldsymbol{y}^l = f(\boldsymbol{u}^l)$
- Output Layer: $\boldsymbol{\delta}^L = (\boldsymbol{d} - \boldsymbol{y}^L) \cdot f'(\boldsymbol{u}^L)$
- Layers $l = L - 1, L - 2, \hdots, 1$:
    - $\boldsymbol{\delta}^l = {\boldsymbol{W}^{l + 1}}^T \boldsymbol{\delta}^{l + 1} \cdot f'(\boldsymbol{u}^l)$
- Layers $l = 1, 2, \hdots L$:
    - $\boldsymbol{W}^l = \boldsymbol{W}^l + \alpha_1 \boldsymbol{y}^{l - 1} {\boldsymbol{\delta}^l}^T$
    - $\boldsymbol{b}^l = \boldsymbol{b}^l + \alpha_1 {\boldsymbol{\delta}^l}^T$

## GD vs. SGD

SGD explores the randomness of individual data points and presentation of data can be randomized. Therefore, this usually improves convergence. However, the number of parameter updates in a training epoch is equal to the number of training patterns in SGD, which makes it very slow in practice.

GD has one update per training epoch. Updates are based on the average loss of error function over the training data, and hence, convergence is smoother. So, a higher learning factor can be used as compared to SGD.

GD can explore the parallelism in batch processing and matrix processing. So, the time for one iteration is less for GD than for SGD. For large training datasets, SGD is computationally prohibitive.

### Mini-Batch SGD

In practice, gradient descent is performed on mini-batch updates of gradients within a batch or block of data of size $B$. In mini-batch SGD, the data is divided into blocks and the gradients are averaged for each block in an epoch.

- $B = 1$: stochastic (online) gradient descent
- $B = P$: (batch) gradient descent
- $1 < B < P$: mini-batch stochastic gradient descent

When $B$ increases, there are more add-multiply operations per second, taking advantage of parallelism and matrix computation. At the same time, the number of computations per update of parameters increases.

Therefore, the curve of the time for weight update against batch size usually takes a U-shaped curve. There exists an optimal value of $B$, which depends on the size of the cache of the CPU / GPU.

In order to efficiently sample blocks, the training patterns are shuffled at the beginning of every training epoch and then blocks are sequentially fetched from memory.

Typical batch sizes: 16, 32, 64, 128 and 256.
