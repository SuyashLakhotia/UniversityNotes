# Regression

## Linear Regression Model

In a special case where an instance is represented by one input feature, the goal is to learn a linear function $f(x)$ ($x$ is a scalar) in terms of $w$ (also a scalar) from $\{x_i, y_i\}, i = 1, ... , N$ such that the difference (i.e. error) between the predicted values of $f(x_i)^{'}$s and the ground truth values $y_i^{'}$s is as small as possible.

$$
f(x) = x \times w
$$

Suppose sum-of-squares error is used:

$$
\begin{split}
E(w) &= \frac{1}{2} \sum_{i = 1}^N (f(x_i) - y_i)^2 \\
     &= \frac{1}{2} \sum_{i = 1}^N (w \times x_i - y_i)^2
\end{split}
$$

The linear model is learnt in terms of $w$ by minimizing the error:

$$
w^* = \min_w E(w)
$$

### Linear Regression Model Learning

To solve the unconstrained minimization problem, the derivate of $E(w)$ with respect to $w$ can be set to zero.

$$
\begin{split}
\frac{\partial E(w)}{\partial w} &= 0 \\
\frac{\partial \bigg(\frac{1}{2} \sum_{i = 1}^N (w \times x_i - y_i)^2 \bigg)}{\partial w} &= 0 \\
\sum_{i = 1}^N (w \times x_i - y_i) \times x_i &= 0 \\
w \sum_{i = 1}^N x_i^2 \sum_{i = 1}^N y_i \times x_i &= 0
\end{split}
$$

$$
w = \frac{\sum_{i = 1}^N y_i \times x_i}{\sum_{i = 1}^N x_i^2}
$$

## Math Review

### Matrix Transformation

If a matrix/vector $\mathbf{X}$ is transposed to $\mathbf{X}^T$, each element in the matrix/vector switches from $\text{el}_{ij}$ to $\text{el}_{ji}$ where $i$ is the original row number and $j$ is the original column number of the element.

- If $\mathbf{X}$ is a **square matrix**, its number of rows and columns is the same.
- If $\mathbf{X}$ is a **symmetric matrix**, it is a square matrix and $\mathbf{X}^T = \mathbf{X}$.

$$
\begin{split}
\mathbf{XY}^T &= \mathbf{Y}^T\mathbf{X}^T \\
\mathbf{Xw}^T &= \mathbf{w}^T\mathbf{X}^T \\
\mathbf{x^Tw}^T &= \mathbf{w}^T\mathbf{x} \\
x^T &= x
\end{split}
$$

### Identity Matrix

- For a square matrix, if $\mathbf{X}$ is invertible, then $\mathbf{X}\mathbf{X}^{-1} = \mathbf{I}$ where $\mathbf{I}$ is the identity matrix.
- Any vector (or matrix) $\mathbf{x}$ (or $\mathbf{X}$) times the identity matrix $\mathbf{I}$ equals to the vector (or matrix) itself.

## Linear Regression Model (cont.)

To learn a linear function $f(\mathbf{x})$ in a more general form in terms of $\mathbf{w}$ and $b$:

$$
f(\mathbf{x}) = \mathbf{w} \cdot \mathbf{x} + b
$$

By defining $w_0 = b$ and $X_0 = 1$, $\mathbf{w}$ and $\mathbf{x}$ are of $d + 1$ dimensions:

$$
f(\mathbf{x}) = \mathbf{w} \cdot \mathbf{x}
$$

Suppose sum-of-squares error is used:

$$
\begin{split}
E(\mathbf{w}) &= \frac{1}{2} \sum_{i = 1}^N (f(\mathbf{x_i}) - y_i)^2 \\
              &= \frac{1}{2} \sum_{i = 1}^N (\mathbf{w} \cdot \mathbf{x_i} - y_i)^2
\end{split}
$$

Learn the linear model using in terms of $\mathbf{w}$ by minimizing the error:

$$
\mathbf{w^*} = \min_{\mathbf{w}} E(\mathbf{w}) + \frac{\lambda}{2} ||\mathbf{w}||_2^2
$$

where $\lambda$ is a positive tradeoff parameter and $||\mathbf{w}||_2^2$ is a regularization term to control the complexity of the model.

### Linear Regression Model Learning

To solve the unconstrained minimization problem, the derivate of $E(\mathbf{w})$ with respect to $\mathbf{w}$ can be set to zero.

$$
\begin{split}
\frac{\partial \bigg(E(\mathbf{w}) + \frac{\lambda}{2} ||\mathbf{w}||_2^2 \bigg)}{\partial \mathbf{w}} &= 0 \\
\frac{\partial \Bigg(\frac{1}{2} \sum_{i = 1}^N (\mathbf{w} \cdot \mathbf{x_i} - y_i)^2 + \frac{\lambda}{2} \mathbf{w} \cdot \mathbf{w} \Bigg)}{\partial \mathbf{w}} &= 0
\end{split}
$$

A closed-form solution for the above can be obtained.

Denoting $\mathbf{X} = (\mathbf{x_1}, \mathbf{x_2}, ... , \mathbf{x_N})^T$:

$$
\mathbf{X} =
\begin{pmatrix}
    x_{10} & \dots & x_{N0} \\
    \vdots & \ddots & \vdots \\
    x_{1d} & \dots & x_{Nd}
\end{pmatrix}^T
=
\begin{pmatrix}
    x_{10} & \dots & x_{1d} \\
    \vdots & \ddots & \vdots \\
    x_{N0} & \dots & x_{Nd}
\end{pmatrix}
$$

And $\mathbf{y}$:

$$
\mathbf{y} =
\begin{pmatrix}
    y_1 \\
    \vdots \\
    y_N
\end{pmatrix}
$$

Solving the minimization problem:

$$
\begin{split}
\frac{\partial \Bigg(\frac{1}{2} \sum_{i = 1}^N (\mathbf{w} \cdot \mathbf{x_i} - y_i)^2 + \frac{\lambda}{2} \mathbf{w} \cdot \mathbf{w} \Bigg)}{\partial \mathbf{w}} &= 0 \\
\sum_{i = 1}^N (\mathbf{w} \cdot \mathbf{x_i} - y_i)\mathbf{x_i} + \lambda\mathbf{w} &= 0 \\
\sum_{i = 1}^N (\mathbf{w} \cdot \mathbf{x_i})\mathbf{x_i} - \sum_{i = 1}^N y_i\mathbf{x_i} + \lambda\mathbf{w} &= 0 \\
(\mathbf{X}^T\mathbf{X})\mathbf{w} - \mathbf{X}^T\mathbf{y} + \lambda\mathbf{I}\mathbf{w} &= 0 \\
(\mathbf{X}^T\mathbf{X} + \lambda\mathbf{I})\mathbf{w} &= \mathbf{X}^T\mathbf{y}
\end{split}
$$

$$
\mathbf{w} = (\mathbf{X}^T\mathbf{X} + \lambda\mathbf{I})^{-1}\mathbf{X}^T\mathbf{y}
$$

As long as $\lambda$ is positive, $(\mathbf{X}^T\mathbf{X} + \lambda\mathbf{I})$ is always invertible.

## Linear Basis Function Models

Linear basis function models can be used for non-linear fitting. The linear function $f(\mathbf{x})$ in terms of a set of basis functions is written as:

$$
f(\mathbf{x}) = \mathbf{w} \cdot \mathbf{\phi}(\mathbf{x})
$$

where $\mathbf{\phi}(\mathbf{x}) = (\mathbf{\phi}_0(\mathbf{x}), \mathbf{\phi}_1(\mathbf{x}), ... , \mathbf{\phi}_m(\mathbf{x}))$ and each $\mathbf{\phi}_i(\mathbf{x})$ maps the instance $\mathbf{x}$ to a scalar.

Typically, $\mathbf{\phi}_0(\mathbf{x}) = 1$, then $w_0$ acts as a bias.

In the simplest case ($d = m$ and $\mathbf{\phi}_i(\mathbf{x}) = x_i$), it is reduced to a standard linear model.

### Examples of Basis Functions

**Polynomial Basis Functions:**

$$
\phi_j(\mathbf{x}) = ||\mathbf{x}||_2^j
$$

In a special case $x$ with one input feature:

$$
\phi_j(x) = x^j
$$

Then, the polynomial curve will be:

$$
f(\mathbf{x}) = \sum_{i = 0}^m w_i x^i
$$

**Gaussian Basis Functions:**

$$
\phi_j(\mathbf{x}) = \text{exp}\Big(- \frac{||mathbf{x} - \mathbf{u}_j||_2^2}{2\sigma^2} \Big)
$$

**Sigmoid Basis Functions:**

$$
\phi_j(\mathbf{x}) = g\Big(\frac{||\mathbf{x} - \mathbf{u}_j||^2}{\sigma} \Big)
$$

where:

$$
g(a) = \frac{1}{1 - \text{exp}(-a)}
$$

where $\mathbf{u}_j$ and $\sigma$ control location and scale (width).

### Linear Basis Function Learning

The goal is to minimize the following error:

$$
E(\mathbf{w}) = \frac{1}{2} \sum_{i = 1}^N (\mathbf{w} \cdot \phi(\mathbf{x_i}) - y_i)^2 + \frac{\lambda}{2} ||\mathbf{w}||_2^2
$$

A closed-form solution for $\mathbf{w}$ can be obtained:

Denoting $\mathbf{\Phi} = (\mathbf{\phi}(\mathbf{x_1}), \mathbf{\phi}(\mathbf{x_1}), ... , \mathbf{\phi}(\mathbf{x_N})^T$:

$$
\begin{split}
\mathbf{\Phi} &=
\begin{pmatrix}
    \phi_0(\mathbf{x_1}) & \dots & \phi_0(\mathbf{x_N}) \\
    \vdots & \ddots & \vdots \\
    \phi_m(\mathbf{x_1}) & \dots & \phi_m(\mathbf{x_N})
\end{pmatrix}^T \\
&=
\begin{pmatrix}
    \phi_0(\mathbf{x_1}) & \dots & \phi_m(\mathbf{x_1}) \\
    \vdots & \ddots & \vdots \\
    \phi_0(\mathbf{x_N}) & \dots & \phi_m(\mathbf{x_N})
\end{pmatrix}
\end{split}
$$

The closed-form solution for $\mathbf{w}$ can be written as:

$$
\mathbf{w} = (\mathbf{\Phi}^T\mathbf{\Phi} + \lambda\mathbf{I})^{-1} \mathbf{\Phi}^T \mathbf{y}
$$

where:

$$
\mathbf{y} =
\begin{pmatrix}
    y_1 \\
    \vdots \\
    y_N
\end{pmatrix}
$$

### Limitations

- In practice, to learn a precise regression model, we may need a large number of basis functions.
- The computational cost is expensive.

### Kernelized Regression

By using the kernel trick $k(x_i, x_j) = \phi(x_i) \cdot \phi(x_j)$:

$$
\begin{split}
f(\mathbf{x}) &= \mathbf{w} \cdot \mathbf{\phi}(\mathbf{x}) \\
f(\mathbf{x}) &= \mathbf{k}(\mathbf{x})(\mathbf{K} + \lambda \mathbf{I})^{-1} \mathbf{y}
\end{split}
$$

where:

$$
\begin{split}
\mathbf{K} &=
\begin{pmatrix}
    k(\mathbf{x_1}, \mathbf{x_1}) & \dots & k(\mathbf{x_1}, \mathbf{x_N}) \\
    \vdots & \ddots & \vdots \\
    k(\mathbf{x_N}, \mathbf{x_1}) & \dots & k(\mathbf{x_N}, \mathbf{x_N})
\end{pmatrix} \\
&=
\begin{pmatrix}
    \phi(\mathbf{x_1}) \cdot \phi(\mathbf{x_1}) & \dots & \phi(\mathbf{x_1}) \cdot \phi(\mathbf{x_N}) \\
    \vdots & \ddots & \vdots \\
    \phi(\mathbf{x_N}) \cdot \phi(\mathbf{x_1}) & \dots & \phi(\mathbf{x_N}) \cdot \phi(\mathbf{x_N})
\end{pmatrix}
\end{split}
$$

## Evaluation

**Root Mean Square Error (RMSE):**

$$
\sqrt{\frac{1}{N} \sum_{i = 1}^N (f(\mathbf{x_i}) - y_i)^2}
$$

**Mean Absolute Error (MAE):**

$$
\frac{1}{N} \sum_{i = 1}^N |f(\mathbf{x_i}) - y_i|
$$
