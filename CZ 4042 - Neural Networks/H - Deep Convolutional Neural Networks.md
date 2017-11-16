# Deep Convolutional Neural Networks

Convolutional neural networks (or CNNs) are biologically inspired variants of MLP.

The animal visual cortex is the most powerful visual processing system and CNNs emulate its behavior:

- Each neuron in the visual cortex is responsive to small subregions of the visual field, known as receptive fields.
- The subregions are tiled together to cover the entire visual field.
- The neurons act as local filters over the input space and exploit the strong local correlations in natural images.

Thus, two types of cells (i.e. neurons) are identified: *simple cells* and *complex cells*. Simple cells respond maximally to specific edge-like patterns within their respective receptive field whereas complex cells have larger receptive fields and are locally invariant to the exact position of the patterns.

## Locally Connected Networks

- Backpropagation works well for signals and images that are low in resolution. Deep CNNs were developed to process more realistic signals and images that are of larger dimensions.
- Fully connected networks are not feasible for signals of large resolutions since they are computationally expensive for feedforward and backpropagation computations.
- One solution is to restrict the number of connections from one layer to another to a smaller subset. The idea is to connect only a contiguous (local) set of nodes to the next layer.

### Sparse Local Connectivity

CNNs exploit spatially local correlations by enforcing local connectivity between neurons of adjacent layers. Thus, the receptive fields of the neurons are limited.

### Shared Connections

In CNNs, each filter is replicated across the entire visual field. These replicated units share the same parameterization (i.e. weights & biases) and form a feature map. In the image below, weights of the same color are shared.

![Feature Map](img/Feature%20Map.png)

Replicating weights in this way allows for features to be detected regardless of the position in the visual field. Additionally, weight sharing increases learning efficiency by greatly reducing the number of free parameters.

## Convolutional Layer

CNNs are usually made of alternating convolutional and pooling layers.

- Features of natural images are invariant at every location of the image. Thus, filters can be replicated and used to cover the entire visual field.
- The convolutional layer learns the features over small patches of the image and the learned features are then convolved with the image to obtain feature activations.
- The weights can be learned using feature detectors or backpropagation.
- The region of the input layer that is connected to a layer is referred to as the *receptive field*. The weights learned are known as *filters* or *kernels*.
- The output activation learned by a particular filter is known as a feature map.

### Input $\rightarrow$ Output

Synaptic input at location $(i, j)$ of the first hidden layer due to a kernel $\boldsymbol{w} = \{ w(l, m) \}_{l, m = -L, -M}^{L, M}$ is given by:

$$
u(i, j) = \sum_{l} \sum_{m} x(i + l, j + m) w(l, m) + b
$$

The output of the neuron at $(i, j)$ of the convolution layer is:

$$
y(i, j) = f(u(i, j))
$$

where $f$ is the sigmoid activation function.

Note that one kernel (filter) creates one feature map.

### Handling Boundaries

There are two ways to handle the boundary:

1. Apply the filter wherever it completely overlaps with the input. (default)
2. Apply the filter wherever it partially overlaps the input.

![Handling Boundaries](img/CNN%20Padding.png)

If we have $k$ kernels, input image is $I \times J$ and kernel size is $L \times M$, then the size of the convolution-layer:

Case 1: $k \times (I - L + 1) \times (J - M + 1)$

Case 2: $k \times (I + L - 1) \times (J + M - 1)$

Stride is the factor with which the output is subsampled. The default stride is 1.

## Pooling Layer

- To reduce the dimensions of the convolutional layer output, the pooling of the activation is performed at the pooling layer. Either max of average pooling is used at the pooling layer. Pooling *downsamples* the input.
- The convolved features are divided into disjoint regions and pooled by either taking the maximum or the mean. Pooled features are *translational invariant*. The default stride is equal to the pooling width.

### Input $\rightarrow$ Output

Consider pooling with non-overlapping windows $\{(p, q)\}_{p, q = -P, -Q}^{P, Q}$ of size $2P \times 2Q$.

The max pooling output is the maximum of the activation inside the pooling window:

$$
z(i, j) = \underset{max}{p, q} \{y(i + p, j + q)\}
$$

The mean pooling output is the mean of activations in the pooling window:

$$
z(i, j) = \frac{1}{2P \times 2Q} \sum_{p} \sum_{q} y(i + p, j + q)
$$

## Fully Connected Layer

- The final layers of a deep CNN consist of one or more fully connected layers.
- The output layer is usually a softmax regression layer for classification.

For example, with three filters (of size $5 \times 5$) followed by pooling (of $2 \times 2$ regions):

![Deep CNN](img/Deep%20CNN.png)

## Backpropagation for CNNs

During forward propagation, activations are downsampled at the pooling layer. Thus, during error backward propagation, the error terms need to be upsampled at the pooling layer.

In MLP, the error $\Delta^{l + 1}$ is propagated to layer $l$ as:

$$
\Delta^l = \Delta^{l + 1} {\boldsymbol{W}^{l + 1}}^T \cdot f'(\boldsymbol{U}^l)
$$

For deep CNNs, the transfer of error terms involves upsampling of errors at the pooling layer:

$$
\Delta^l = \text{upsample}(\Delta^{l + 1} {\boldsymbol{W}^{l + 1}}^T) \cdot f'(\boldsymbol{U}^l)
$$

## GD w/ Momentum

The method of momentum is designed to accelerate learning, especially in the face of high curvature, small but consistent gradients or noisy gradients. The momentum algorithm accumulates an exponentially decaying moving average of past gradients and continues to move in their direction.

When the error function has the form a shallow ravine leading to the optimum and steep walls on the side, stochastic gradient descent algorithm tends to oscillate near the optimum. This leads to very slow converging rates. The problem is typical in deep learning architecture.

![GD with Momentum](img/GD%20with%20Momentum.png)

Momentum is one method of speeding the convergence along a narrow ravine. The momentum update is given by:

$$
\begin{gathered}
\boldsymbol{V} = \gamma \boldsymbol{V} - \alpha \frac{\partial J}{\partial \boldsymbol{W}} \\
\boldsymbol{W} = \boldsymbol{W} + \boldsymbol{V}
\end{gathered}
$$

where $\boldsymbol{V}$ is known as the velocity term and has the same dimension as the weight vector. The momentum parameter $\gamma \in [0, 1]$ indicates how much of the previous gradients are incorporated into the current update.

Often, $\gamma$ is initially set to $0.1$ until learning stabilizes and increased to $0.9$ thereafter.

## GD w/ Annealing

Often, stochastic gradient descent is employed in a few training samples or a mini batch. This reduces variance of the individual patterns and achieves stable convergence but at the expense of the true minima.

The learning rate in the online (stochastic) version is usually much less than the learning rate in a batch version. When online or mini-batch versions of gradient descent is used, it is not easy to determine the value of the learning parameter because of the variance in individual patterns. One way to overcome this is to use an annealing schedule, that is, to start with a large learning factor and then gradually reduce it.

A possible annealing schedule ($t$ is the iteration count):

$$
\alpha(t) = \frac{a}{b + t}
$$

where $\alpha(0) = a / b$ and $\alpha(\infty) = 0$.

## RMSProp Algorithm

Adaptive learning rates with annealing usually works with convex cost functions.

The learning trajectory of a neural network minimizing a non-convex cost function passes through many different structures and eventually arrives at a region that is locally convex.

RMSProp uses an exponentially decaying average to discard the history from the extreme past so that it can converge rapidly after finding a convex region.

$$
\begin{gathered}
\boldsymbol{r} = \rho \boldsymbol{r} + (1 - \rho) \Big(\frac{\partial J}{\partial \boldsymbol{W}} \Big)^2 \\
\boldsymbol{W} = \boldsymbol{W} - \frac{\epsilon}{\sqrt{\delta + \boldsymbol{r}}} \cdot \Big(\frac{\partial J}{\partial \boldsymbol{W}} \Big)
\end{gathered}
$$

where $\rho$, $\epsilon$ and $\delta$ are parameters to be determined empirically.

RMSProp has been shown to be an effective and practical optimization algorithm for deep neural networks.
