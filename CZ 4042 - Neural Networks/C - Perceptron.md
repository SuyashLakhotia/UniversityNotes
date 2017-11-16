# Perceptron

Fundamental Objective: To provide meaningful categorization from some input information.

A typical pattern recognition system is comprised of two stages:

1. Feature Extraction
2. Classification / Clustering

## Linear Classifier

A linear classifier implements a discriminant function or decision boundary represented by a straight line (hyperplane) in the multidimensional feature space.

Given an input (features), $\boldsymbol{x} = (x_1, x_2, \hdots, x_n)^T$, the decision boundary of a linear classifier is given by a linear discriminant function:

$$
g(\boldsymbol{x}) = w_0 + w_1 x_1 + w_2 x_2 + \hdots + w_n x_n
$$

where $\boldsymbol{w} = (w_1, w_2, \hdots, w_n)^T$ are the coefficients or weights and $w_0$ is the constant term.

The decision boundary is given by $g(\boldsymbol{x}) = 0$. The challenge is to determine a suitable weight vector that gives the correct results for all inputs from the two classes.

### Linear Neuron

$$
\begin{gathered}
g(\boldsymbol{x}) = w_0 + w_1 x_1 + w_2 x_2 + \hdots + w_n x_n = 0 \\
w_0 + \boldsymbol{x}^T \boldsymbol{w} = 0
\end{gathered}
$$

Therefore, a two-class linear classifier can be implemented with an artificial neuron that has a threshold activation function.

$$
g(\boldsymbol{x}) = \boldsymbol{x}^T \boldsymbol{w} + b
$$

Then,

$$
\begin{gathered}
g(\boldsymbol{x}) > 0 \implies y = 1 \implies \text{Class 1} \\
g(\boldsymbol{x}) \leq 0 \implies y = 0 \implies \text{Class 2}
\end{gathered}
$$

Therefore, the output of the linear neuron represents the label of the class. The bias is needed so that the discriminant boundary does not always go through origin.

### Weight Vector

At the decision boundary,

$$
g(\boldsymbol{x}) = \boldsymbol{x}^T \boldsymbol{w} + b = \boldsymbol{0}
$$

the weight vector is normal to the decision boundary because the dot product for two orthogonal vectors is always zero.

**Proof:** Considering two points, $\boldsymbol{x_1}$ and $\boldsymbol{x_2}$, on the decision boundary:

$$
\begin{gathered}
\boldsymbol{x_1}^T \boldsymbol{w} + b = \boldsymbol{x_2}^T \boldsymbol{w} + b = 0 \\
\therefore (\boldsymbol{x_1} - \boldsymbol{x_2})^T \boldsymbol{w} = 0
\end{gathered}
$$

Since $(\boldsymbol{x_1} - \boldsymbol{x_2})$ represents the decision boundary and the dot product with $\boldsymbol{w}$ is zero, they are orthogonal.

## Simple (or Discrete) Perceptron

- The simple (or discrete) perceptron is a neuron that has a threshold activation function.
- It classifies input patterns into two (linearly separable) classes.
- It acts as a two-class classifier or dichotomizer.

### Simple Perceptron Learning Algorithm

The perceptron learning algorithm is a form of supervised learning.

Assuming that there are $P$ training pairs of the form $(\boldsymbol{x}_p, d_p)$ in the training dataset, where $\boldsymbol{x}_p \in \boldsymbol{R}^n$ is the $n$-dimensional input and $d_p \in \{ 0, 1 \}$ is the binary desired output of the $p$th training pattern.

Initially, the weight vector and bias are initialized to small random values and the inputs are presented to the network in a sequence from $\boldsymbol{x}_1$ to $\boldsymbol{x}_P$. The weights and bias are updated for every presentation of an input pattern (if $y_p \neq d_p$) and the training iterations are continued until convergence is achieved. Note that in every epoch, the sequence in which the training patterns will be presented will be randomized.

```
if (y_p == 1 && d_p == 0) {
    w = w - x_p
    b = b - 1
} else if (y_p == 0 && d_p == 1) {
    w = w + x_p
    b = b + 1
}
```

#### Convergence

Convergence is achieved when:

- all outputs of training patterns equal their desired (target) outputs, or
- the weights and biases converge to stable values, or
- the output for every input does not change

If the patterns are linearly separable, the perceptron is able to separate the patterns correctly after convergence.

### Modified Simple Perceptron Learning Algorithm

The weights change proportional to the difference between the desired output $d$ and perceptron output $y$.

For training pattern $(\boldsymbol{x}_p, d_p)$:

$$
\begin{gathered}
u_p = \boldsymbol{x}_p^T \boldsymbol{w} + b \\
y_p = f(u_p) \\
\delta_p = d_p - y_p
\end{gathered}
$$

Learning:

$$
\begin{gathered}
\boldsymbol{w} = \boldsymbol{w} + \alpha_1 \delta_p \boldsymbol{x}_p \\
b = b + \alpha_1 \delta_p
\end{gathered}
$$

The learning rate $\alpha_1 \in (0.0, 1.0]$ slows down the change in the weights, hence, taking smaller steps towards a stable solution.

Note that $\delta_p \in \{ -1, 0, +1 \}$ and the simple perceptron algorithm corresponds to the case when $\alpha_1 = 1.0$.

\pagebreak

## Continuous Perceptron

- A continuous perceptron has a sigmoidal activation function.

Assuming the training dataset ${{(\boldsymbol{x}_p, d_p)}}_{p = 1}^P$ where $\boldsymbol{x}_p = (x_{p1}, x_{p2}, \hdots, x_{pn})^T \in \boldsymbol{R}^n$ and $d_p \in \boldsymbol{R}$, the continuous perceptron finds the following functional mapping through learning:

$$
\phi : \boldsymbol{R}^n \to \boldsymbol{R}
$$

The adjustment of the weight vector is resolved by minimizing an error (cost) function by using a gradient descent approach.

### Gradient Descent Learning

The cost function $J(\boldsymbol{w}, b)$ of an artificial neuron is typically a multi-dimensional function that depends on the weight vector and bias. The gradient descent approach states that the value of $\boldsymbol{w}$ and $b$ is updated during learning by searching in the direction of and proportional to the negative gradient of the cost function.

$$
\begin{gathered}
\Delta \boldsymbol{w} \propto -\frac{\partial J(\boldsymbol{w}, b)}{\partial \boldsymbol{w}} \\
\Delta \boldsymbol{w} = -\alpha \frac{\partial J(\boldsymbol{w}, b)}{\partial \boldsymbol{w}}
\end{gathered}
$$

where $\alpha$ is the gradient descent learning rate.

Therefore, the gradient descent learning equations are:

$$
\begin{gathered}
\boldsymbol{w} = \boldsymbol{w} - \alpha \frac{\partial J(\boldsymbol{w}, b)}{\partial \boldsymbol{w}} \\
b = b - \alpha \frac{\partial J(\boldsymbol{w}, b)}{\partial \boldsymbol{w}}
\end{gathered}
$$

The error function $J$ for the continuous function is defined as the mean squared error of the outputs.

$$
J(\boldsymbol{w}, b) = \frac{1}{P} \sum_{p = 1}^P (d_p - y_p)^2
$$

The perceptron learning algorithm aims to find $\boldsymbol{w^*}$ such that:

$$
\boldsymbol{w^*} = \arg\min_{\boldsymbol{w}} J(\boldsymbol{w}, b)
$$

\pagebreak

The partial derivative is derived as follows (complete derivation in Lecture Notes):

$$
\begin{split}
\frac{\partial J(\boldsymbol{w}, b)}{\partial \boldsymbol{w}}
&= -\frac{2}{P} \sum_{p = 1}^P (d_p - y_p) \frac{\partial y_p}{\partial \boldsymbol{w}} \\
&= -\frac{2}{P} \sum_{p = 1}^P (d_p - y_p) \frac{\partial y_p}{\partial u_p} \frac{\partial u_p}{\partial \boldsymbol{w}} \\
&= -\frac{2}{P} \sum_{p = 1}^P (d_p - y_p) f'(u_p) \boldsymbol{x}_p \\
&= -\frac{2}{P} ((d_1 - y_1)f'(u_1)\boldsymbol{x}_1 + \cdots + (d_P - y_P)f'(u_P)\boldsymbol{x}_P) \\
&= -\frac{2}{P} \begin{pmatrix} \boldsymbol{x}_1 & \cdots & \boldsymbol{x}_P \end{pmatrix} \begin{pmatrix} (d_1 - y_1) f'(u_1) \\ \vdots \\ (d_P - y_P) f'(u_P) \end{pmatrix}
\end{split}
$$

Substituting the following values:

$$
\boldsymbol{d} = \begin{pmatrix} d_1 \\ d_2 \\ \vdots \\ d_P \end{pmatrix} \quad
\boldsymbol{y} = \begin{pmatrix} y_1 \\ y_2 \\ \vdots \\ y_P \end{pmatrix} \quad
f(\boldsymbol{u}) = \begin{pmatrix} f(u_1) \\ f(u_2) \\ \vdots \\ f(u_P) \end{pmatrix} \quad
\boldsymbol{X} = \begin{pmatrix} \boldsymbol{x}_1^T \\ \boldsymbol{x}_2^T \\ \vdots \\ \boldsymbol{x}_P^T \end{pmatrix}
$$

$$
\begin{split}
\frac{\partial J(\boldsymbol{w}, b)}{\partial \boldsymbol{w}}
&= -\frac{2}{P} \boldsymbol{X}^T (\boldsymbol{d} - \boldsymbol{y}) \cdot f'(\boldsymbol{u}) \\
&= -\frac{2}{P} \boldsymbol{X}^T \boldsymbol{\delta}
\end{split}
$$

Substituting into the gradient descent learning equation:

$$
\boldsymbol{w} = \boldsymbol{w} + \alpha_1 \boldsymbol{X}^T \boldsymbol{\delta}
$$

where $\alpha_1 = \frac{2 \alpha}{P}$ and the error term $\boldsymbol{\delta} = (\boldsymbol{d} - \boldsymbol{y}) \cdot f'(\boldsymbol{u})$.

Similarly for bias:

$$
b = b + \alpha_1 {\boldsymbol{1}_P}^T \boldsymbol{\delta}
$$

where $\boldsymbol{1}_P = (1 \quad 1 \quad \cdots \quad 1)^T$.

### Delta Learning Equations

The below learning equations are known as the delta learning or least mean squares (LMS) learning equations:

$$
\begin{gathered}
\boldsymbol{\delta} = (\boldsymbol{d} - \boldsymbol{y}) \cdot f'(\boldsymbol{u}) \\
\boldsymbol{w} = \boldsymbol{w} + \alpha_1 \boldsymbol{X}^T \boldsymbol{\delta} \\
b = b + \alpha_1 {\boldsymbol{1}_P}^T \boldsymbol{\delta}
\end{gathered}
$$

where $\alpha_1$ is the delta learning rate.

Since all the training patterns are presented in a batch in one epoch, this learning is known as *batch learning*. Note the synaptic input to the layer for a batch of $P$ patterns:

$$
\boldsymbol{u}
= \begin{pmatrix} u_1 \\ u_2 \\ \vdots \\ u_P \end{pmatrix}
= \begin{pmatrix} \boldsymbol{x}_1 \\ \boldsymbol{x}_2 \\ \vdots \\ \boldsymbol{x}_P \end{pmatrix} \boldsymbol{w} + b \begin{pmatrix} 1 \\ 1 \\ \vdots \\ 1 \end{pmatrix}
= \boldsymbol{X} \boldsymbol{w} + b \boldsymbol{1}_P
$$

where $\boldsymbol{X}$ is the data matrix where each data point is represented as a row.

### Derivatives of Sigmoid Functions

**Logistic Function:**

$$
\begin{gathered}
y = f(u) = \frac{1}{1 + e^{-u}} \\
f'(u) = y(1 - y)
\end{gathered}
$$

**Bipolar Sigmoidal:**

$$
\begin{gathered}
y = f(u) = \frac{1 - e^{-u}}{1 + e^{-u}} \\
f'(u) = \frac{1}{2} (1 - y^2)
\end{gathered}
$$

### Stochastic Gradient Descent

In (batch) gradient descent, in one epoch, all the patterns are applied in a batch and the weights and biases are updated at once. In stochastic gradient descent (SGD), training patterns are applied to the perceptron in a sequence in one epoch and the weights and bias are updated after presenting every individual pattern.

![Stochastic Gradient Descent](img/Perceptron%20SGD.png)

### Converging Speed & Values

- At a higher learning rate, the number of epochs required for convergence decreases but the convergence may not be stable. A higher learning rate is possible with GD.
- The time for one add/multiply computation is less when patterns are trained in a batch. Usually, time for a weight update versus batch size takes a U-shape curve.
- The optimal learning rate is the largest rate at which learning does not diverge. The optimum learning speed depends on the *learning rate* & *batch size*.
- In practice, *mini-batch SGD* is used.

## Limitations of Perceptrons

- Linear Separability:
    - Linear separability requires that the patterns to be classified must be sufficiently separated from each other to ensure that the decision boundaries are hyperplanes.
    - As long as an ANN consists of a linear combiner followed by a non-linear element, then regardless of the form of non-linearity used, a perceptron can only perform pattern classification on linearly separable patterns. Therefore, more complex functions cannot be approximated by a perceptron.
- Local Minima Problem:
    - The learning algorithm may get stuck in a local minimum of the error function depending on the initial weights.
