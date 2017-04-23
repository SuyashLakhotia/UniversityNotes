# Support Vector Machines

SVMs are based on statistical learning theory and have shown promising empirical results in many practical applications, such as computer vision, sensor networks and text mining. SVMs are based on the concept of a **maximum margin hyperplane**.

## Maximum Margin

The goal is to learn a binary classifier by finding a hyperplane (decision boundary) such that all the squares reside on one side of the hyperplane and all the circles reside on the other side. Although there are many hyperplanes that can separate the training examples perfectly, their generalization errors may be different.

![Maximum Margin Example](img/Maximum%20Margin%20Example.png)

Each decision boundary $B_1$ is associated with a pair of parallel hyperplanes &mdash; $b_{i1}$ and $b_{i2}$. $b_{i1}$ is obtained by moving the hyperplane until it touches the closest circle(s) and $b_{i2}$ is obtained by moving a hyperplane away from the decision boundary until it touches the closest square(s).

The distance between the two parallel hyperplanes ($b_{i1}$ & $b_{i2}$) is known as the margin of the classifier. The assumption is that larger margins imply better generalization errors. Since the margin of $B_1$ is larger than the margin of $B_2$, $B_1$ is better than $B_2$.

## Math Review

### Direction of Vectors

![$\boldsymbol{a} + \boldsymbol{b}$](img/Direction%20of%20Vectors%20(1).png){height=160px}

![$\boldsymbol{a} - \boldsymbol{b}$](img/Direction%20of%20Vectors%20(2).png){height=160px}

### Inner Product

The inner product of two vectors, $\boldsymbol{u}$ and $\boldsymbol{v}$ of $d$ dimensions is defined as:

$$
\boldsymbol{u} \cdot \boldsymbol{v} = \sum_{i = 1}^{d} (u_i \times v_i)
$$

From a geometry viewpoint:

![$\boldsymbol{u}$ & $\boldsymbol{v}$](img/Inner%20Product%20Vectors.png){height=150px}

$$
\boldsymbol{u} \cdot \boldsymbol{v} = ||\boldsymbol{u}||_2 \times ||\boldsymbol{v}||_2 \times \cos(\theta)
$$

$$
||\boldsymbol{u}||_2^2 = \boldsymbol{u} \cdot \boldsymbol{u} = \sum_{i = 1}^d (u_i \times u_i)
$$

Thus, when $\boldsymbol{u} \cdot \boldsymbol{v} = 0$, $\theta = 90^{\circ}$ i.e. $\boldsymbol{u}$ and $\boldsymbol{v}$ are orthogonal.

$$
\begin{split}
\boldsymbol{u} \cdot \boldsymbol{v} &= ||\boldsymbol{u}||_2 \times ||\boldsymbol{v}||_2 \times \cos(\theta) \\
                                    &= ||\boldsymbol{u}||_2 \times (||\boldsymbol{v}||_2 \times \cos(\theta)) \\
                                    &= ||\boldsymbol{u}||_2 \times v_u
\end{split}
$$

where $v_u$ represents the length of $\boldsymbol{v}$ in the direction of $\boldsymbol{u}$.

## Linear SVM: Separable Case

Given a binary classification task, denoting $y_i = +1$ as the circle class and $y_i = -1$ as the square class, the decision boundary is defined as:

$$
\boldsymbol{w} \cdot \boldsymbol{x} + b = 0
$$

For any test example $\boldsymbol{x}^*$:

$$
\boldsymbol{x}^*:
\begin{cases}
f(\boldsymbol{x}^*) = +1 & \text{if } \boldsymbol{w} \cdot \boldsymbol{x} + b \geq 0 \\
f(\boldsymbol{x}^*) = -1 & \text{if } \boldsymbol{w} \cdot \boldsymbol{x} + b < 0
\end{cases}
$$

### Direction of $\boldsymbol{w}$

Suppose $\boldsymbol{x_a}$ and $\boldsymbol{x_b}$ are two points on the decision boundary:

$$
\begin{split}
\boldsymbol{w} \cdot \boldsymbol{x_a} + b &= 0 \\
\boldsymbol{w} \cdot \boldsymbol{x_b} + b &= 0
\end{split}
$$

$$
\boldsymbol{w} \cdot (\boldsymbol{x_a} - \boldsymbol{x_b}) = 0
$$

Since $(\boldsymbol{x_a} - \boldsymbol{x_b})$ is a vector on the decision boundary, based on the definition of inner product, the direction of $\boldsymbol{w}$ is orthogonal to the decision boundary.

### Equations for Parallel Hyperplanes (i.e. Support Vectors)

For any circle $\boldsymbol{x_c}$ located above the decision boundary:

$$
\boldsymbol{w} \cdot \boldsymbol{x_c} + b = k\text{, where } k > 0
$$

For any square $\boldsymbol{x_s}$ located below the decision boundary:

$$
\boldsymbol{w} \cdot \boldsymbol{x_s} + b = k'\text{, where } k' < 0
$$

Because the decision boundary is equidistant from both support vectors, the two parallel hyperplanes passing the closest circle(s) and square(s) can be written as:

$$
\begin{gathered}
\boldsymbol{w} \cdot \boldsymbol{x_c} + b = +\bar{k} \\
\boldsymbol{w} \cdot \boldsymbol{x_s} + b = -\bar{k} \\
\text{where } \bar{k} > 0
\end{gathered}
$$

After rescaling $\boldsymbol{w}$ and $b$, the two parallel hyperplanes can be further rewritten as:

$$
\begin{split}
\boldsymbol{w} \cdot \boldsymbol{x_c} + b &= +1 \\
\boldsymbol{w} \cdot \boldsymbol{x_s} + b &= -1
\end{split}
$$

\vfill
\begin{center}
P.T.O
\end{center}
\vfill

### Deriving the Margin

Let $\boldsymbol{x_1}$ be a point on $b_{11}$ and $\boldsymbol{x_2}$ be a point on $b_{12}$:

$$
\begin{split}
b_{11}: \boldsymbol{w} \cdot \boldsymbol{x_1} + b &= +1 \\
b_{12}: \boldsymbol{w} \cdot \boldsymbol{x_2} + b &= -1
\end{split}
$$

$$
\boldsymbol{w} \cdot (\boldsymbol{x_1} - \boldsymbol{x_2}) = 2
$$

Based on the definition of inner product:

$$
||\boldsymbol{w}||_2 \times d = 2
$$

$$
d = \frac{2}{||\boldsymbol{w}||_2}
$$

where $d$ represents the margin i.e. $||\boldsymbol{x_1} - \boldsymbol{x_2}||_2 \times \cos(\theta)$.

![Deriving the Margin](img/Linear%20SVM%20Margin.png)

### Learning in Linear SVM

The goal is to maximize the margin $d$, or in other words, minimize the following:

$$
\min_{\boldsymbol{w}} \frac{||\boldsymbol{w}||_2^2}{2}
$$

Given the following constraints:

$$
\begin{split}
\boldsymbol{w} \cdot \boldsymbol{x_i} + b \geq +1 & \text{, if } y_i = +1 \\
\boldsymbol{w} \cdot \boldsymbol{x_i} + b \leq -1 & \text{, if } y_i = -1
\end{split}
$$

Or, in other words:

$$
y_i \times (\boldsymbol{w} \cdot \boldsymbol{x_i} + b) \geq 1
$$

Thus, the optimization problem of linear SVM is:

$$
\begin{gathered}
\min_{\boldsymbol{w}} \frac{||\boldsymbol{w}||_2^2}{2} \\
\text{s.t. } y_i \times (\boldsymbol{w} \cdot \boldsymbol{x_i} + b) \geq 1 \text{, } i = 1, 2, \hdots N
\end{gathered}
$$

## Linear SVM: Non-separable Case

In separable cases, there is no training data within the margin. However, in non-separable cases, there may be training data that lies within the margin. Thus, slack variables $\xi \geq 0$ need to be introduced to absorb errors.

$$
\begin{split}
\boldsymbol{w} \cdot \boldsymbol{x_i} + b \geq +1 - \xi_i & \text{, if } y_i = +1 \\
\boldsymbol{w} \cdot \boldsymbol{x_i} + b \leq -1 + \xi_i & \text{, if } y_i = -1
\end{split}
$$

Or, in other words:

$$
y_i \times (\boldsymbol{w} \cdot \boldsymbol{x_i} + b) \geq 1 - \xi_i
$$

- If $\xi_i = 0$, there is no problem with $\boldsymbol{x_i}$.
- If $0 < \xi_i < 1$, $\boldsymbol{x_i}$ is correctly classified but in the margin.
- If $\xi_i = 1$, $\boldsymbol{x_i}$ is on the decision boundary (random guess).
- If $\xi_i > 1$, $\boldsymbol{x_i}$ is misclassified.

### Soft Error

- Number of Misclassifications = #$\{\xi_i > 1\}$
- Number of Non-separable Points = #$\{\xi_i > 0\}$

Soft Errors:

$$
\sum_{i = 1}^N \xi_i
$$

Learning with soft errors:

$$
\begin{gathered}
\min_{\boldsymbol{w}} \frac{||\boldsymbol{w}||_2^2}{2} + C \Bigg(\sum_{i = 1}^N \xi_i \Bigg) \\
\text{s.t. } y_i (\boldsymbol{w} \cdot \boldsymbol{x_i} + b) \geq 1 - \xi_i \text{, } i = 1, 2, \hdots N, \xi_i \geq 0
\end{gathered}
$$

where $C \geq 0$ is a parameter to tradeoff the impact of margin maximization and tolerable errors and a nonnegative $\xi_i$ provides an estimate of the error of the decision boundary on the training example $\boldsymbol{x_i}$.

## Non-linear SVM

To generalize the linear decision boundary to become non-linear, $\boldsymbol{x_i}$ has to be transformed to a higher dimensional space using a function $\varphi(\boldsymbol{x_i})$. The original input space is mapped to a higher dimensional feature space where the training set is linearly separable.

$$
\varphi : \boldsymbol{x} \rightarrow \varphi(\boldsymbol{x})
$$

The assumption is that in a higher dimensional space, it is easier to find a linear hyperplane to classify the data.

Optimization problem of non-linear SVM:

$$
\begin{gathered}
\min_w \frac{||\boldsymbol{w}||_2^2}{2} \\
\text{s.t. } y_i \times (\boldsymbol{w} \cdot \varphi(\boldsymbol{x_i}) + b) \geq 1 \text{, } i = 1, 2, \hdots N
\end{gathered}
$$

where $\boldsymbol{w} \cdot \varphi(\boldsymbol{x_i}) + b = 0$ is the hyperplane in feature space.

However, computation in the feature space can be costly because it is typically very high dimensional.

### Kernel Trick

Suppose $\varphi(\cdot)$ is given as follows, mapping an instance from two-dimensional space to six-dimensional space:

$$
\varphi([X_1, X_2]) = [1, \sqrt{2}X_1, \sqrt{2}X_2, X_1^2, X_2^2, \sqrt{2}X_1X_2]
$$

Given two data instances, $\boldsymbol{a}$ and $\boldsymbol{b}$:

$$
\begin{split}
\varphi(\boldsymbol{a}) \cdot \varphi(\boldsymbol{b})
&= 1 + 2A_1B_1 + 2A_2B_2 + A_1^2B_1^2 + A_2^2B_2^2 + 2A_1A_2B_1B_2 \\
&= (1 + A_1B_1 + A_2B_2)^2
\end{split}
$$

So, if we define the kernel function as follows, there is no need to carry out $\varphi(\cdot)$ explicitly:

$$
\begin{split}
k(\boldsymbol{a}, \boldsymbol{b}) &= (1 + A_1B_1 + A_2B_2)^2 \\
                                  &= (1 + \boldsymbol{a} \cdot \boldsymbol{b})^2
\end{split}
$$

The use of the kernel function to avoid carrying out $\varphi(\cdot)$ explicitly is known as the **kernel trick**.

Thus, if $\varphi(\cdot)$ satisfies some conditions, then we can find a function $k(\cdot,\cdot)$ such that:

$$
k(\boldsymbol{x_i}, \boldsymbol{x_j}) = \varphi(\boldsymbol{x_i}) \cdot \varphi(\boldsymbol{x_j})
$$

#### Well-Known Kernel Functions

Linear Kernel:

$$
k(\boldsymbol{x_i}, \boldsymbol{x_j}) = \boldsymbol{x_i} \cdot \boldsymbol{x_j}
$$

Radial Basis Kernel Function w/ Width $\sigma$:

$$
k(\boldsymbol{x_i}, \boldsymbol{x_j}) = \text{exp}\bigg(-\frac{||\boldsymbol{x_i} - \boldsymbol{x_j}||_2^2}{2 \sigma^2}\bigg)
$$

Polynomial Kernel Function w/ Degree $d$:

$$
k(\boldsymbol{x_i}, \boldsymbol{x_j}) = (\boldsymbol{x_i} \cdot \boldsymbol{x_j} + 1)^d
$$

### Lagrange Multiplier Method

In its primal form, it is not possible to solve the optimization problem for non-linear SVMs using the kernel trick as instances in the feature space do not appear in the form of inner products. Thus, its dual form needs to be used.

Using the Lagrange Multiplier Method, we can transform the original optimization problem to its dual form where the mapping function $\varphi(\boldsymbol{x})$ does not need to computed explicitly.

Given an objective function to be minimized, with a set of inequality constraints:

$$
\begin{gathered}
\min_{\boldsymbol{w}} f(\boldsymbol{w}) \\
\text{s.t. } h_i(\boldsymbol{w}) \leq 0$, $i = 1, 2, \hdots q
\end{gathered}
$$

The Langrangian for the optimization problem will be:

$$
L(\boldsymbol{w}, \boldsymbol{\lambda}) = f(\boldsymbol{w}) + \sum_{i = 1}^q \lambda_i h_i (\boldsymbol{w})
$$

where $\boldsymbol{\lambda} = \{\lambda_1, \lambda_2, \hdots \lambda_q\}$ are the Langrange multipliers.

Thus,

$$
\begin{gathered}
\min_w \frac{||\boldsymbol{w}||_2^2}{2} \\
\text{s.t. } y_i \times (\boldsymbol{w} \cdot \varphi(\boldsymbol{x_i}) + b) \geq 1 \text{, } i = 1, 2, \hdots N
\end{gathered}
$$

can be transformed to its dual form:

$$
\max_{\boldsymbol{\lambda}}L_D(\boldsymbol{\lambda}) = - \Bigg(\frac{1}{2} \sum_{i, j} \lambda_i \lambda_j y_i y_j \big(\varphi(\boldsymbol{x_i}) \cdot \varphi(\boldsymbol{x_j})\big) - \sum_{i = 1}^N \lambda_i \Bigg)
$$

#### Dual Optimization Problem

- The dual Langrangian involves only the Langrange multipliers and the training data.
- The negative sign in the dual Langrangian transforms a minimization problem of the primal form to a maximization problem of the dual form.
- The objective is to maximize $L_D(\boldsymbol{\lambda})$, which can be solved using numerical techniques such as quadratic programming.

Once the $\lambda_i$ values are found, we can obtain the feasible solutions for $\boldsymbol{w}$ and $b$ from the two equations below:

$$
\boldsymbol{w} = \sum_{i = 1}^N \lambda_i y_i \varphi(\boldsymbol{x_i})
$$

$$
\lambda_i(y_i(\boldsymbol{w} \cdot \varphi(\boldsymbol{x_i}) + b) - 1) = 0
$$

The decision boundary can be expressed as:

$$
\begin{split}
\boldsymbol{w} \cdot \varphi(\boldsymbol{x_i}) + b &= 0 \\
\Bigg(\sum_{i = 1}^N \lambda_i y_i \varphi(\boldsymbol{x_i}) \cdot \varphi(\boldsymbol{x}) \Bigg) + b &= 0
\end{split}
$$

If $\boldsymbol{x_i}$ is a support vector, then the corresponding $\lambda_i > 0$, otherwise, $\lambda_i = 0$.

A test instance $\boldsymbol{x^*}$ can be classified using:

$$
f(\boldsymbol{x^*}) = \text{sign}\Bigg(\sum_{i = 1}^N \lambda_i y_i \varphi(\boldsymbol{x_i}) \cdot \varphi(\boldsymbol{x^*}) + b \Bigg)
$$

### Non-linear SVM via Kernel Trick

Training:

$$
\max_{\boldsymbol{\lambda}} \Bigg(\sum_{i = 1}^N \lambda_i - \frac{1}{2} \sum_{i, j} \lambda_i \lambda_j y_i y_j \big(\varphi(\boldsymbol{x_i}) \cdot \varphi(\boldsymbol{x_j})\big) \Bigg)
$$

Decision Boundary:

$$
\sum_{i = 1}^N \lambda_i y_i \big(\varphi(\boldsymbol{x_i}) \cdot \varphi(\boldsymbol{x^*})\big) + b
$$

Thus, the data points only appear as inner products in the feature space and can be replaced by the kernel function.

Training:

$$
\max_{\boldsymbol{\lambda}} \Bigg(\sum_{i = 1}^N \lambda_i - \frac{1}{2} \sum_{i, j} \lambda_i \lambda_j y_i y_j k(\boldsymbol{x_i}, \boldsymbol{x_j}) \Bigg)
$$

Decision Boundary:

$$
\sum_{i = 1}^N \lambda_i y_i k(\boldsymbol{x_i}, \boldsymbol{x^*}) + b
$$

If $\boldsymbol{x_i}$ is a support vector, then the corresponding $\lambda_i > 0$, otherwise, $\lambda_i = 0$.

### Soft Margin Dual Form

$$
\begin{gathered}
\min_{\boldsymbol{w}} \frac{||\boldsymbol{w}||_2^2}{2} + C \Bigg(\sum_{i = 1}^N \xi_i \Bigg) \\
\text{s.t. } y_i (\boldsymbol{w} \cdot \varphi(\boldsymbol{x_i}) + b) \geq 1 - \xi_i \text{, } i = 1, 2, \hdots N, \xi_i \geq 0
\end{gathered}
$$

The optimization problem can be transformed to its dual form using Lagrangian multipliers:

$$
\begin{gathered}
\min_{\boldsymbol{\lambda}} L_D(\boldsymbol{\lambda}) = - \Bigg(\frac{1}{2} \sum_{i, j} \lambda_i \lambda_j y_i y_j (\varphi(\boldsymbol{x_i}) \cdot \varphi(\boldsymbol{x_j})) - \sum_{i = 1}^N \lambda_i \Bigg) \\
\text{s.t. } 0 \leq \lambda_i \leq C
\end{gathered}
$$

The decision boundary is given by:

$$
\boldsymbol{w} \cdot \varphi(\boldsymbol{x}) + b = \Bigg(\sum_{i = 1}^N \lambda_i y_i (\varphi(\boldsymbol{x_i}) \cdot \varphi(\boldsymbol{x})) \Bigg) + b = 0
$$

The kernel trick can be applied to the inner products in the training & decision boundary equations above.

A test instance $\boldsymbol{x^*}$ can be classified using:

$$
f(\boldsymbol{x^*}) = \text{sign}\Bigg(\sum_{i = 1}^N \lambda_i y_i (\varphi(\boldsymbol{x_i}) \cdot \varphi(\boldsymbol{x^*})) + b \Bigg)
$$
