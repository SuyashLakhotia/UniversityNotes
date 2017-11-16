# Regression

## Linear Regression w/ Linear Neuron

In linear regression, the output (dependent) variable is predicted as a linear combination of input (independent) variables.

Given input $\boldsymbol{x} \in \boldsymbol{R}^n$ and output $y \in \boldsymbol{R}$, linear regression states that:

$$
y = w_0 + w_1 x_1 + w_2 x_2 + \cdots + w_n x_n
$$

Therefore, linear regression can be implemented with a linear neuron (where $y = f(u) = u$) having a weight vector $\boldsymbol{w} = (w_1 \quad w_2 \quad \cdots w_n)$ and bias $b$. Then:

$$
y = \boldsymbol{w}^T \boldsymbol{x} + b
$$

Given a training dataset $\{ (\boldsymbol{x}_p, d_p) \}_{p = 1}^P$ where $\boldsymbol{x}_p \in \boldsymbol{R}^n$ and $d_p \in \boldsymbol{R}$, a linear neuron finds the linear regression function $\phi$ by learning from the training data.

$$
\phi : \boldsymbol{R}^n \to \boldsymbol{R}
$$

### GD for Linear Neuron

For a perceptron, the error term is $\boldsymbol{\delta} = (\boldsymbol{d} - \boldsymbol{y}) \cdot f'(u)$. However, for a linear neuron, $f(u) = u$ and $f'(u) = 1$. Therefore, the delta learning equations are:

$$
\begin{gathered}
\boldsymbol{y} = \boldsymbol{X} \boldsymbol{w} + b \boldsymbol{1}_P \\
\boldsymbol{\delta} = \boldsymbol{d} - \boldsymbol{y} \\
\boldsymbol{w} = \boldsymbol{w} + \alpha_1 \boldsymbol{X}^T \boldsymbol{\delta} \\
b = b + \alpha_1 {\boldsymbol{1}_P}^T \boldsymbol{\delta}
\end{gathered}
$$

where $\alpha_1 = \frac{2 \alpha}{P}$.

\pagebreak

### SGD for Linear Neuron

For every training pattern:

$$
\begin{gathered}
y_p = {\boldsymbol{x}_p}^T \boldsymbol{w} + b \\
\delta_p = d_p - y_p \\
\boldsymbol{w} = \boldsymbol{w} + \alpha_1 \delta_p \boldsymbol{x}_p \\
b = b + \alpha_1 \delta_p
\end{gathered}
$$

where $\alpha_1 = 2 \alpha$.

## Logistic Regression

A neuron performing logistic regression classifies inputs into two classes ('0' or '1'). The activation (logistic function) gives the probability of the neuron output belonging to class '1':

$$
\begin{gathered}
P(y = 1 | \boldsymbol{x}) = f(u) = \frac{1}{1 + e^{-u}} \\
P(y = 0 | \boldsymbol{x}) = 1 - P(y = 1 | \boldsymbol{x}) = 1 - f(u)
\end{gathered}
$$

where $u = \boldsymbol{w}^T \boldsymbol{x} + b$.

The output of the neuron:

$$
y =
\begin{cases}
1 \quad \text{ if } f(u) = P(y = 1 | \boldsymbol{x}) > 0.5 \\
0 \quad \text{ otherwise}
\end{cases}
$$

Given a training dataset $\{ (\boldsymbol{x}_p, d_p) \}_{p = 1}^P$ where $\boldsymbol{x}_p \in \boldsymbol{R}^n$ and $d_p \in \{0, 1\}$, the cost function for logistic regression is given by the **cross-entropy** (or negative log-likelihood) over all the training patterns:

$$
J(\boldsymbol{w}, b) = - \sum_{p = 1}^P d_p \log \big(f(u_p) \big) + (1 - d_p) \log \big(1 - f(u_p) \big)
$$

where $u = {\boldsymbol{x}_p}^T \boldsymbol{w} + b$.

### GD for Logistic Regression

The cost function $J$ is minimized using the gradient descent algorithm. The partial derivative is derived as follows (complete derivation in Lecture Notes):

$$
\begin{split}
\frac{\partial J(\boldsymbol{w}, b)}{\partial \boldsymbol{w}}
&= - \sum_{p = 1}^P \Bigg( \frac{d_p}{f(u_p)} - \frac{(1 - d_p)}{1 - f(u_p)} \Bigg) \frac{\partial f(u_p)}{\partial \boldsymbol{w}} \\
&= - \sum_{p = 1}^P \Bigg( \frac{d_p - f(u_p)}{f(u_p) (1 - f(u_p))} \Bigg) \frac{\partial f(u_p)}{\partial u_p} \frac{\partial u_p}{\partial \boldsymbol{w}} \\
&= - \sum_{p = 1}^P \Bigg( \frac{d_p - f(u_p)}{f(u_p) (1 - f(u_p))} \Bigg) f(u_p) \big(1 - f(u_p) \big) \boldsymbol{x}_p \\
&= - \sum_{p = 1}^P \big(d_p - f(u_p) \big) \boldsymbol{x}_p \\
&= - \big( (d_1 - f(u_1)) \boldsymbol{x}_1 + \cdots + (d_P - f(u_P)) \boldsymbol{x}_P \big) \\
&= - \begin{pmatrix} \boldsymbol{x}_1 & \cdots & \boldsymbol{x}_P \end{pmatrix} \begin{pmatrix} d_1 - f(u_1) \\ \vdots \\ d_P - f(u_P) \end{pmatrix} \\
&= - \boldsymbol{X}^T \big(\boldsymbol{d} - f(\boldsymbol{u}) \big) \\
&= - \boldsymbol{X}^T \boldsymbol{\delta}
\end{split}
$$

where $\boldsymbol{\delta} = \boldsymbol{d} - f(\boldsymbol{u})$ and,

$$
\boldsymbol{d} = \begin{pmatrix} d_1 \\ d_2 \\ \vdots \\ d_P \end{pmatrix} \quad f(\boldsymbol{u}) = \begin{pmatrix} f(u_1) \\ f(u_2) \\ \vdots \\ f(u_P) \end{pmatrix}
$$

#### Learning Equations

$$
\begin{gathered}
\boldsymbol{w} = \boldsymbol{w} - \alpha \frac{\partial J(\boldsymbol{w}, b)}{\partial \boldsymbol{w}} \\
\boldsymbol{w} = \boldsymbol{w} + \alpha_1 \boldsymbol{X}^T \boldsymbol{\boldsymbol{\delta}} \\
b = b + \alpha_1 {\boldsymbol{1}_P}^T \boldsymbol{\delta}
\end{gathered}
$$

where $\boldsymbol{\delta} = \boldsymbol{d} - f(\boldsymbol{u})$ and $\alpha_1 = \alpha$ for a logistic neuron. Note that $\boldsymbol{y}$ in the linear regression neuron equations is now replaced with $f(\boldsymbol{u})$ for logistic regression.

### Indicator Function

Using the *indicator function* $1(\cdot)$:

$$
y = 1(f(u) > 0.5)
$$

where:

$$
1(a) =
\begin{cases}
1 \quad \text{if } a \text{ is True} \\
0 \quad \text{if } a \text{ is False}
\end{cases}
$$

### SGD for Logistic Regression

![Stochastic Gradient Descent](img/Logistic%20Regression%20SGD.png)

## Neuron GD Summary

$$
\begin{gathered}
(\boldsymbol{X}, \boldsymbol{d}) \\
\boldsymbol{u} = \boldsymbol{X} \boldsymbol{w} + b \boldsymbol{1}_P \\
\boldsymbol{w} = \boldsymbol{w} + \alpha_1 \boldsymbol{X}^T \boldsymbol{\delta} \\
b = b + \alpha_1 {\boldsymbol{1}_P}^T \boldsymbol{\delta}
\end{gathered}
$$

![Neuron Gradient Descent Summary](img/Neuron%20GD%20Summary.png)
