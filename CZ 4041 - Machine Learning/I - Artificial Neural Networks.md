# Artificial Neural Networks

The human brain is a densely interconnected network of neurons, connected to others via axons. Axons are used to transmit nerve impulses from one neuron to another. The human brain learns by changing the strength of the synaptic connection between neurons. An Artificial Neural Network is composed of an interconnected assembly of nodes and directed links.

## Perceptron

- Every input node is connected via a weighted link to the output node. Weights can be positive, negative or zero (no connection).
- The model is an assembly of interconnected nodes and weighted links.
- Output node first sums up each of its input value according to the weights of its links. The weighted sum is compared against some threshold $\theta$ and an output is produced based on the sign of the result.

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

Alternatively,

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

During training, the weight parameters $\boldsymbol{w}$ are adjusted until the outputs of the perceptron become consistent with the true outputs of the training data. The weight parameters $\boldsymbol{w}$ are updated iteratively with every training example using the gradient descent approach.

$$
\boldsymbol{w}^{(t + 1)} = \boldsymbol{w}^{t} - \lambda \frac{\partial E(\boldsymbol{w})}{\partial \boldsymbol{w}}
$$

where $\lambda \in (0, 1]$ is the learning rate and $E(\boldsymbol{w})$ is the error function to be minimized.

$$
\boldsymbol{w}^* = \min_{\boldsymbol{w}} E(\boldsymbol{w})
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
\boldsymbol{w}^{t + 1}
&= \boldsymbol{w}^{t} - \lambda \frac{\partial E(\boldsymbol{w})}{\partial \boldsymbol{w}} \\
&= \boldsymbol{w}^{t} - \lambda \frac{\partial E(h)}{\partial h} \frac{\partial h(z)}{\partial z} \frac{\partial z(\boldsymbol{w})}{\partial \boldsymbol{w}}
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

- If the prediction is correct, $(y - h) = 0$, then the weight remains unchanged i.e. $\boldsymbol{w}^{(k + 1)} = \boldsymbol{w}^{(k)}$.
- If $y = +1$ and $h = -1$, then $(y - h) = 2$.
    - The weights of all links with positive inputs need to be updated by increasing their values.
    - The weights of all links with negative inputs need to be updated by decreasing their weights.
- If $y = -1$ and $h = +1$, then $(y - h) = -2$.
    - The weights of all links with positive inputs need to be updated by decreasing their values.
    - The weights of all links with negative inputs need to be updated by increasing their weights.

### Notes

- The decision boundary of a perceptron is a linear hyperplane.
- The perceptron learning algorithm is guaranteed to converge to an optimal solution for linear classification problems.
- However, if the problem is not linearly separable, the algorithm fails to converge.

## Multilayer Neural Networks

- Multilayer ANNs are feed-forward neural networks i.e. the nodes in one layer are only connected to the nodes in the next layer.
- Each node takes in the inputs and passes it through an **integration function** followed by an **activation function**.

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
\boldsymbol{w}^{(t + 1)} = \boldsymbol{w}^{t} - \lambda \frac{\partial E(\boldsymbol{w})}{\partial \boldsymbol{w}}
$$

However, in multilayer ANNs, the errors cannot be computed directly for the hidden nodes.

### Backpropagation Algorithm

![Multilayer ANN](img/Multilayer%20ANN.png)

After initializing the weights, the training examples are *forward passed* through the neural network to generate outputs.

*Backpropagation* involves starting with the output layer to propagate error back to the previous layer in order to update the weights between the two layers. Since it is not possible to calculate the error in the hidden layers, the error is decomposed using the weights and propagated back when a hidden layer is reached.

For example, in Figure 8.1, $E_5$ or the error in $n_5$ will be decomposed using the weights and propagated back. Thus, the value of $E_3$ will be $E_5 \times w_35$ and the value of $E_4$ will be $E_5 \times w_45$.

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
    - Binary class problem → single node
    - $k$-class problem → $k$ output nodes
- Training examples with missing values should be removed or replaced with most likely values.
