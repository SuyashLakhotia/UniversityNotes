# Artificial Neural Networks

The human brain is a dense network of neurons, connected to each other via axons. Axons are used to transmit nerve impulses from one neuron to another. The human brain learns by changing the strength of the synaptic connection between neurons. Similarly, an Artificial Neural Network is composed of an interconnected assembly of nodes and directed, weighted links.

## Perceptron

- Every input node is connected via a weighted link to the output node. Weights can be positive, negative or zero (no connection).
- The output node first sums up each of its input values according to the weights of its links. The weighted sum is compared against some threshold $\theta$ (bias factor) and an output is produced based on the sign of the result.

$$
\text{sign}(z)
\begin{cases}
1 & \text{if } z \geq 0 \\
-1 & \text{otherwise}
\end{cases}
$$

$$
y = \text{sign}\bigg(\sum_{i=1}^d w_i X_i - \theta\bigg)
$$

Alternatively, it can be defined as the inner product (Section 9.2.2) of the weights and the input features:

$$
y = \text{sign}(\boldsymbol{w} \cdot \boldsymbol{x})
$$

where:

$$
\begin{gathered}
\boldsymbol{w} = (w_0, w_1, \hdots w_d) \\
\boldsymbol{x} = (X_0, X_1, \hdots X_d) \\
w_0 = -\theta \text{ and } X_0 = 1
\end{gathered}
$$

### Learning (Gradient Descent Approach)

The weight parameter $\boldsymbol{w}$ is initialized with random values. During training, $\boldsymbol{w}$ is adjusted until the outputs of the perceptron become consistent with the true outputs of the training data. $\boldsymbol{w}$ is updated iteratively with every training example using the gradient descent approach.

$$
\boldsymbol{w}^{(t + 1)} = \boldsymbol{w}^{(t)} - \lambda \frac{\partial E(\boldsymbol{w})}{\partial \boldsymbol{w}}
$$

where $\lambda \in (0, 1]$ is the learning rate and $E(\boldsymbol{w})$ is the error function to be minimized.

$$
\boldsymbol{w}^* = \underset{\boldsymbol{w}}{\mathrm{argmin}} \: E(\boldsymbol{w})
$$

Let $h_i$ be the predicted output for $\boldsymbol{x}_i$ and consider the loss function for each training example as:

$$
\begin{split}
E &= \frac{1}{2} (y_i - h_i)^2 \\
  &= \frac{1}{2} (y_i - \text{sign}(\boldsymbol{w}^{(t)} \cdot x_i))^2
\end{split}
$$

The weight update rule can be rewritten as:

$$
\begin{split}
\boldsymbol{w}^{(t + 1)}
&= \boldsymbol{w}^{(t)} - \lambda \frac{\partial E(\boldsymbol{w})}{\partial \boldsymbol{w}} \\
&= \boldsymbol{w}^{(t)} - \lambda \frac{\partial E(h)}{\partial h} \frac{\partial h(z)}{\partial z} \frac{\partial z(\boldsymbol{w})}{\partial \boldsymbol{w}}
\end{split}
$$

where:

$$
\begin{split}
h &= \text{sign}(z) \\
z &= \boldsymbol{w} \cdot \boldsymbol{x}
\end{split}
$$

Thus, after solving:

$$
\boldsymbol{w}^{(t + 1)} = \boldsymbol{w}^{(t)} + \lambda (y_i - h_i) \boldsymbol{x}_i
$$

#### Learning Model

- If the prediction is correct, $(y - h) = 0$, then the weight remains unchanged i.e. $\boldsymbol{w}^{(t + 1)} = \boldsymbol{w}^{(t)}$.
- If $y = +1$ and $h = -1$, then $(y - h) = 2$.
    - The weights of all links with positive inputs need to be updated by increasing their values.
    - The weights of all links with negative inputs need to be updated by decreasing their values.
- If $y = -1$ and $h = +1$, then $(y - h) = -2$.
    - The weights of all links with positive inputs need to be updated by decreasing their values.
    - The weights of all links with negative inputs need to be updated by increasing their values.

### Notes

- The decision boundary of a perceptron is a linear hyperplane.
- The perceptron learning algorithm is guaranteed to converge to an optimal solution for linear classification problems. (See: Lecture 4b, Slide 15)
- However, if the problem is not linearly separable, the algorithm fails to converge.

## Multilayer Neural Networks

- Multilayer ANNs are feed-forward neural networks i.e. the nodes in one layer are only connected to the nodes in the next layer. Input Layer → Hidden Layer(s) → Output Layer.
- Each node in the hidden layer(s) & output layer takes in the inputs and passes it through an **integration function** followed by an **activation function**.

### Integration Functions

Weighted Sum:

$$
\sum_{i=1}^d w_i X_i - \theta
$$

Quadratic Function:

$$
\sum_{i=1}^d w_i X_i^2 - \theta
$$

Spherical Function:

$$
\sum_{i=1}^d (X_i - w_i)^2 - \theta
$$

### Activation Functions

Sign Function (Threshold Function):

$$
a(z) = \text{sign}(z) =
\begin{cases}
1 & \text{if } z \geq 0 \\
-1 & \text{if } z < 0
\end{cases}
$$

Unipolar Sigmoid Function:

$$
a(z) = \frac{1}{1 + e^{-\lambda z}}
$$

When $\lambda = 1$, it is called the sigmoid function.

### General Algorithm for Learning

Just like the perceptron, the learning algorithm for multilayer ANNs starts with initializing the weights of the links and adjusting these weights such that the output of the ANN is consistent with the class labels of the training examples.

Loss function for each training instance:

$$
E = \frac{1}{2} (y_i - h_i)^2
$$

The objective is to find the weights ${w'}_i$ that minimize the error function:

$$
\boldsymbol{w}^{(t + 1)} = \boldsymbol{w}^{(t)} - \lambda \frac{\partial E(\boldsymbol{w})}{\partial \boldsymbol{w}}
$$

However, in multilayer ANNs, the errors cannot be computed directly for the hidden nodes.

### Backpropagation Algorithm

![Multilayer ANN](img/Multilayer%20ANN.png)

After initializing the weights, the training examples are **forward passed** through the neural network to generate outputs. Note that different initializations may lead to different local optima and convergence iterations.

**Backpropagation** involves starting with the output layer to propagate error back to the previous layer in order to update the weights between the two layers. Since it is not possible to calculate the error in the hidden layers, the error is decomposed using the weights and propagated back when a hidden layer is reached.

For example, in Figure 8.1, $E_5$ or the error in $n_5$ will be decomposed using the weights and propagated back. Thus, the value of $E_3$ will be $E_5 \times w_{35}$ and the value of $E_4$ will be $E_5 \times w_{45}$.

Revisiting the gradient descent rule:

$$
\begin{split}
\boldsymbol{w}^{(t + 1)}
&= \boldsymbol{w}^{(t)} + \lambda (y_i - h_i) \frac{\partial a(z)}{\partial z} \boldsymbol{x}_i \\
&= \boldsymbol{w}^{(t)} + \lambda E_i \frac{\partial a(z)}{\partial z} \boldsymbol{x}_i \\
&= \boldsymbol{w}^{(t)} + \lambda \Delta_i \boldsymbol{x}_i \\
\end{split}
$$

where $a(z)$ is the activation function, $\Delta_i$ is the modified error and $\boldsymbol{x}_i$ is the output of the previous layer.

For example, in Figure 8.1, assuming the activation function is the sign function:

$$
\frac{\partial a(z)}{\partial z} = 1
$$

Then:

$$
\boldsymbol{w}_{35}^{(t + 1)} = \boldsymbol{w}_{35}^{(t)} + \lambda E_5 o_3
$$

$$
\boldsymbol{w}_{45}^{(t + 1)} = \boldsymbol{w}_{45}^{(t)} + \lambda E_5 o_4
$$

$$
\begin{split}
\boldsymbol{w}_{13}^{(t + 1)} &= \boldsymbol{w}_{13}^{(t)} + \lambda E_3 o_1 \\
                              &= \boldsymbol{w}_{13}^{(t)} + \lambda (\boldsymbol{w}_{35}^{(t + 1)} \times E_5) o_1
\end{split}
$$

$$
\begin{split}
\boldsymbol{w}_{14}^{(t + 1)} &= \boldsymbol{w}_{14}^{(t)} + \lambda E_4 o_1 \\
                              &= \boldsymbol{w}_{14}^{(t)} + \lambda (\boldsymbol{w}_{45}^{(t + 1)} \times E_5) o_1
\end{split}
$$

$$
\begin{split}
\boldsymbol{w}_{24}^{(t + 1)} &= \boldsymbol{w}_{24}^{(t)} + \lambda E_4 o_2 \\
                              &= \boldsymbol{w}_{24}^{(t)} + \lambda (\boldsymbol{w}_{45}^{(t + 1)} \times E_5) o_2
\end{split}
$$

where $o_i$ is the output of $n_i$.

## Design Issues for ANN

- The number of nodes in the input layer.
    - Assign an input node to each numerical or binary input variable.
- The number of nodes in the output layer.
    - Binary class problem → single output node
    - $k$-class problem → $k$ output nodes
- Training examples with missing values should be removed or replaced with most likely values.

## Addressing Overfitting in ANNs

One way to address overfitting in ANNs is by incorporating model complexity:

$$
e'(f) = e(f) + \Omega(f)
$$

$$
\begin{gathered}
\Omega(f) = ||\boldsymbol{w}||_2^2 \\
||\boldsymbol{w}||_2^2 = \sum_{i = 1}^n (w_i \times w_i)
\end{gathered}
$$

It can also be addressed using **dropout** i.e. randomly keeping some neurons active and setting others to be inactive. The intuition here is to force the network to be accurate even in the absence of certain information.
