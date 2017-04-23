# Regression

## Linear Regression Model

In a special case where an instance is represented by one input feature, the goal is to learn a linear function $f(x)$ (where $x$ is a scalar) in terms of $w$ (also a scalar) from $\{x_i, y_i\}$ such that the difference (i.e. error) between the predicted values $f(x_i)$ and the ground truth values $y_i$ is as small as possible.

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

The linear model is learned in terms of $w$ by minimizing the error:

$$
w^* = \underset{w}{\mathrm{argmin}} \: E(w)
$$

### Linear Regression Model Learning

To solve the unconstrained minimization problem, the derivate of $E(w)$ with respect to $w$ can be set to zero.

$$
\begin{split}
\frac{\partial E(w)}{\partial w} &= 0 \\
\frac{\partial \bigg(\frac{1}{2} \sum_{i = 1}^N (w \times x_i - y_i)^2 \bigg)}{\partial w} &= 0 \\
\sum_{i = 1}^N (w \times x_i - y_i) \times x_i &= 0 \\
w \sum_{i = 1}^N x_i^2 - \sum_{i = 1}^N y_i \times x_i &= 0
\end{split}
$$

$$
\therefore w = \frac{\sum_{i = 1}^N y_i \times x_i}{\sum_{i = 1}^N x_i^2}
$$

## Math Review

### Matrix Transformation

If a matrix/vector $\boldsymbol{X}$ is transposed to $\boldsymbol{X}^T$, each element in the matrix/vector switches from $e_{ij}$ to $e_{ji}$ where $i$ is the original row number and $j$ is the original column number of the element.

- If $\boldsymbol{X}$ is a **square matrix**, its number of rows and columns is the same.
- If $\boldsymbol{X}$ is a **symmetric matrix**, it is a square matrix and $\boldsymbol{X}^T = \boldsymbol{X}$.

$$
\begin{split}
(\boldsymbol{XY})^T &= \boldsymbol{Y}^T\boldsymbol{X}^T \\
(\boldsymbol{Xw})^T &= \boldsymbol{w}^T\boldsymbol{X}^T \\
(\boldsymbol{x}^T\boldsymbol{w})^T &= \boldsymbol{w}^T\boldsymbol{x} \\
x^T &= x
\end{split}
$$

### Identity Matrix

- For a square matrix, if $\boldsymbol{X}$ is invertible, then $\boldsymbol{X}\boldsymbol{X}^{-1} = \boldsymbol{I}$, where $\boldsymbol{I}$ is the identity matrix.
- Any vector (or matrix) $\boldsymbol{x}$ (or $\boldsymbol{X}$) times the identity matrix $\boldsymbol{I}$ equals to the vector (or matrix) itself.
    - $\boldsymbol{Ix} = \boldsymbol{x}$ & $\boldsymbol{x}^T \boldsymbol{I} = \boldsymbol{x}^T$
    - $\boldsymbol{XI} = \boldsymbol{X}$ & $\boldsymbol{IX} = \boldsymbol{X}$

\vfill
\begin{center}
P.T.O
\end{center}
\vfill

## Linear Regression Model (cont.)

To learn a linear function $f(\boldsymbol{x})$ in a more general form in terms of $\boldsymbol{w}$ and $b$:

$$
f(\boldsymbol{x}) = \boldsymbol{w} \cdot \boldsymbol{x} + b
$$

By defining $w_0 = b$ and $X_0 = 1$, $\boldsymbol{w}$ and $\boldsymbol{x}$ are of $d + 1$ dimensions:

$$
f(\boldsymbol{x}) = \boldsymbol{w} \cdot \boldsymbol{x}
$$

Suppose sum-of-squares error is used:

$$
\begin{split}
E(\boldsymbol{w}) &= \frac{1}{2} \sum_{i = 1}^N (f(\boldsymbol{x_i}) - y_i)^2 \\
                  &= \frac{1}{2} \sum_{i = 1}^N (\boldsymbol{w} \cdot \boldsymbol{x_i} - y_i)^2
\end{split}
$$

Learn the linear model in terms of $\boldsymbol{w}$ by minimizing the error:

$$
\boldsymbol{w^*} = \underset{\boldsymbol{w}}{\mathrm{argmin}} \: E(\boldsymbol{w}) + \frac{\lambda}{2} ||\boldsymbol{w}||_2^2
$$

where $\lambda$ is a positive tradeoff parameter and $||\boldsymbol{w}||_2^2$ is a regularization term to control the complexity of the model.

### Linear Regression Model Learning

To solve the unconstrained minimization problem, the derivate of $E(\boldsymbol{w})$ with respect to $\boldsymbol{w}$ can be set to zero.

$$
\begin{split}
\frac{\partial \bigg(E(\boldsymbol{w}) + \frac{\lambda}{2} ||\boldsymbol{w}||_2^2 \bigg)}{\partial \boldsymbol{w}} &= 0 \\
\frac{\partial \Bigg(\frac{1}{2} \sum_{i = 1}^N (\boldsymbol{w} \cdot \boldsymbol{x_i} - y_i)^2 + \frac{\lambda}{2} \boldsymbol{w} \cdot \boldsymbol{w} \Bigg)}{\partial \boldsymbol{w}} &= 0
\end{split}
$$

A closed-form solution for the above can be obtained.

Denoting $\boldsymbol{X} = (\boldsymbol{x_1}, \boldsymbol{x_2}, \hdots \boldsymbol{x_N})^T$:

$$
\boldsymbol{X} =
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

\vfill\eject

And $\boldsymbol{y}$:

$$
\boldsymbol{y} =
\begin{pmatrix}
    y_1 \\
    \vdots \\
    y_N
\end{pmatrix}
$$

Solving the minimization problem:

$$
\begin{split}
\frac{\partial \Bigg(\frac{1}{2} \sum_{i = 1}^N (\boldsymbol{w} \cdot \boldsymbol{x_i} - y_i)^2 + \frac{\lambda}{2} \boldsymbol{w} \cdot \boldsymbol{w} \Bigg)}{\partial \boldsymbol{w}} &= 0 \\
\sum_{i = 1}^N (\boldsymbol{w} \cdot \boldsymbol{x_i} - y_i)\boldsymbol{x_i} + \lambda\boldsymbol{w} &= 0 \\
\sum_{i = 1}^N (\boldsymbol{w} \cdot \boldsymbol{x_i})\boldsymbol{x_i} - \sum_{i = 1}^N y_i\boldsymbol{x_i} + \lambda\boldsymbol{w} &= 0 \\
\Bigg(\sum_{i = 1}^N (\boldsymbol{x_i} \boldsymbol{x_i}^T) \Bigg) \boldsymbol{w} - \sum_{i = 1}^N y_i \boldsymbol{x_i} + \lambda \boldsymbol{I} \boldsymbol{w} &= 0 \\
(\boldsymbol{X}^T\boldsymbol{X})\boldsymbol{w} - \boldsymbol{X}^T\boldsymbol{y} + \lambda\boldsymbol{I}\boldsymbol{w} &= 0 \\
(\boldsymbol{X}^T\boldsymbol{X} + \lambda\boldsymbol{I})\boldsymbol{w} &= \boldsymbol{X}^T\boldsymbol{y}
\end{split}
$$

$$
\therefore \: \boldsymbol{w} = (\boldsymbol{X}^T\boldsymbol{X} + \lambda\boldsymbol{I})^{-1}\boldsymbol{X}^T\boldsymbol{y}
$$

As long as $\lambda$ is positive, $(\boldsymbol{X}^T\boldsymbol{X} + \lambda\boldsymbol{I})$ is always invertible (Section 16.9).

## Linear Basis Function Models

Linear basis function models can be used for non-linear fitting. The linear function $f(\boldsymbol{x})$ is written in terms of a set of basis functions:

$$
f(\boldsymbol{x}) = \boldsymbol{w} \cdot \boldsymbol{\phi}(\boldsymbol{x})
$$

where $\boldsymbol{\phi}(\boldsymbol{x}) = (\boldsymbol{\phi}_0(\boldsymbol{x}), \boldsymbol{\phi}_1(\boldsymbol{x}), \hdots \boldsymbol{\phi}_m(\boldsymbol{x}))$ and each $\boldsymbol{\phi}_i(\boldsymbol{x})$ maps the instance $\boldsymbol{x}$ to a scalar.

Typically, $\boldsymbol{\phi}_0(\boldsymbol{x}) = 1$, then $w_0$ acts as a bias. In the simplest case, if $m = d$ and $\boldsymbol{\phi}_i(\boldsymbol{x}) = x_i$, it is reduced to a standard linear model.

\vfill
\begin{center}
P.T.O
\end{center}
\vfill

### Examples of Basis Functions

**Polynomial Basis Functions:**

$$
\phi_j(\boldsymbol{x}) = ||\boldsymbol{x}||_2^j
$$

In a special case $x$ with one input feature:

$$
\phi_j(x) = x^j
$$

Then, the polynomial curve will be:

$$
f(\boldsymbol{x}) = \sum_{i = 0}^m w_i x^i
$$

**Gaussian Basis Functions:**

$$
\phi_j(\boldsymbol{x}) = \text{exp}\Bigg(- \frac{||\boldsymbol{x} - \boldsymbol{u}_j||_2^2}{2\sigma^2} \Bigg)
$$

**Sigmoid Basis Functions:**

$$
\phi_j(\boldsymbol{x}) = g\Bigg(\frac{||\boldsymbol{x} - \boldsymbol{u}_j||^2}{\sigma} \Bigg)
$$

where:

$$
g(a) = \frac{1}{1 - \text{exp}(-a)}
$$

where $\boldsymbol{u}_j$ and $\sigma$ control location and scale (width).

### Linear Basis Function Learning

The goal is to minimize the following error:

$$
E(\boldsymbol{w}) = \frac{1}{2} \sum_{i = 1}^N (\boldsymbol{w} \cdot \phi(\boldsymbol{x_i}) - y_i)^2 + \frac{\lambda}{2} ||\boldsymbol{w}||_2^2
$$

A closed-form solution for $\boldsymbol{w}$ can be obtained:

Denoting $\boldsymbol{\Phi} = (\boldsymbol{\phi}(\boldsymbol{x_1}), \boldsymbol{\phi}(\boldsymbol{x_1}), \hdots \boldsymbol{\phi}(\boldsymbol{x_N}))^T$:

$$
\begin{split}
\boldsymbol{\Phi} &=
\begin{pmatrix}
    \phi_0(\boldsymbol{x_1}) & \dots & \phi_0(\boldsymbol{x_N}) \\
    \vdots & \ddots & \vdots \\
    \phi_m(\boldsymbol{x_1}) & \dots & \phi_m(\boldsymbol{x_N})
\end{pmatrix}^T \\
&=
\begin{pmatrix}
    \phi_0(\boldsymbol{x_1}) & \dots & \phi_m(\boldsymbol{x_1}) \\
    \vdots & \ddots & \vdots \\
    \phi_0(\boldsymbol{x_N}) & \dots & \phi_m(\boldsymbol{x_N})
\end{pmatrix}
\end{split}
$$

The closed-form solution for $\boldsymbol{w}$ can be written as:

$$
\boldsymbol{w} = (\boldsymbol{\Phi}^T\boldsymbol{\Phi} + \lambda\boldsymbol{I})^{-1} \boldsymbol{\Phi}^T \boldsymbol{y}
$$

where:

$$
\boldsymbol{y} =
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
f(\boldsymbol{x}) &= \boldsymbol{w} \cdot \boldsymbol{\phi}(\boldsymbol{x}) \\
f(\boldsymbol{x}) &= \boldsymbol{k}(\boldsymbol{x})^T (\boldsymbol{K} + \lambda \boldsymbol{I})^{-1} \boldsymbol{y}
\end{split}
$$

where $\boldsymbol{k_i}(\boldsymbol{x}) = k(x_i, \boldsymbol{x})$ and:

$$
\begin{split}
\boldsymbol{K} &=
\begin{pmatrix}
    k(\boldsymbol{x_1}, \boldsymbol{x_1}) & \dots & k(\boldsymbol{x_1}, \boldsymbol{x_N}) \\
    \vdots & \ddots & \vdots \\
    k(\boldsymbol{x_N}, \boldsymbol{x_1}) & \dots & k(\boldsymbol{x_N}, \boldsymbol{x_N})
\end{pmatrix} \\
&=
\begin{pmatrix}
    \phi(\boldsymbol{x_1}) \cdot \phi(\boldsymbol{x_1}) & \dots & \phi(\boldsymbol{x_1}) \cdot \phi(\boldsymbol{x_N}) \\
    \vdots & \ddots & \vdots \\
    \phi(\boldsymbol{x_N}) \cdot \phi(\boldsymbol{x_1}) & \dots & \phi(\boldsymbol{x_N}) \cdot \phi(\boldsymbol{x_N})
\end{pmatrix}
\end{split}
$$

## Evaluation

**Root Mean Square Error (RMSE):**

$$
\sqrt{\frac{1}{N} \sum_{i = 1}^N (f(\boldsymbol{x_i}) - y_i)^2}
$$

**Mean Absolute Error (MAE):**

$$
\frac{1}{N} \sum_{i = 1}^N |f(\boldsymbol{x_i}) - y_i|
$$
