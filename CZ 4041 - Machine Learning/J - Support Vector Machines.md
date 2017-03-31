# Support Vector Machines

SVMs are based on statistical learning theory that has shown promising empirical results in many practical applications, such as computer vision, sensor networks and text mining. The basic idea behind SVMs is the **maximum margin hyperplane**.

## Maximum Margin

The goal is to learn a binary classifier by finding a hyperplane (decision boundary) such that all the squares reside on one side of the hyperplane and all the circles reside on the other side. Although there are many hyperplanes that can separate the training examples perfectly, their generalization errors may be different.

![Maximum Margin Example (2)](img/Maximum%20Margin%20Example.png)

Each decision boundary $B_1$ is associated with a pair of parallel hyperplanes &mdash; $b_{i1}$ and $b_{i2}$. $b_{i1}$ is obtained by moving the hyperplane until it touches the closest circle(s) and $b_{i2}$ is obtained by moving a hyperplane away from the decision boundary until it touches the closest square(s).

The assumption is that larger margins imply better generalization errors. Since the margin of $B_1$ is larger than the margin of $B_2$, $B_1$ is better than $B_2$.

## Math Review

### Direction of Vectors

![$\mathbf{a} + \mathbf{b}$](img/Direction%20of%20Vectors%20(1).png){height=160px}

![$\mathbf{a} - \mathbf{b}$](img/Direction%20of%20Vectors%20(2).png){height=160px}

### Inner Product

The inner product of two vectors, $\mathbf{u}$ and $\mathbf{v}$ of $d$ dimensions is defined as:

$$
\mathbf{u} \cdot \mathbf{v} = \sum_{i = 1}^{d} (u_i \times v_i)
$$

From a geometry viewpoint:

![$\mathbf{u}$ & $\mathbf{v}$](img/Inner%20Product%20Vectors.png){height=150px}

$$
\mathbf{u} \cdot \mathbf{v} = ||\mathbf{u}||_2 \times ||\mathbf{v}||_2 \times \cos(\theta)
$$

$$
||\mathbf{u}||_2^2 = \mathbf{u} \cdot \mathbf{u} = \sum_{i = 1}^d (u_i \times u_i)
$$

Thus, when $\mathbf{u} \cdot \mathbf{v} = 0$, $\theta = 90^{\circ}$ i.e. $\mathbf{u}$ and $\mathbf{v}$ are orthogonal.

$$
\begin{split}
\mathbf{u} \cdot \mathbf{v} &= ||\mathbf{u}||_2 \times ||\mathbf{v}||_2 \times \cos(\theta) \\
                            &= ||\mathbf{u}||_2 \times (||\mathbf{v}||_2 \times \cos(\theta)) \\
                            &= ||\mathbf{u}||_2 \times v_u
\end{split}
$$

where $v_u$ represents the length of $\mathbf{v}$ in the direction of $\mathbf{u}$.

## Linear SVM: Separable Case

Given a binary classification task, denoting $y_i = +1$ as the circle class and $y_i = -1$ as the square class, the decision boundary is defined as:

$$
\mathbf{w} \cdot \mathbf{x} + b = 0
$$

For any test example $\mathbf{x}^*$:

$$
\mathbf{x}^*:
\begin{cases}
f(\mathbf{x}^*) = +1 & \text{if } \mathbf{w} \cdot \mathbf{x} + b \geq 0 \\
f(\mathbf{x}^*) = -1 & \text{if } \mathbf{w} \cdot \mathbf{x} + b < 0
\end{cases}
$$

### Direction of $\mathbf{w}$

Suppose $\mathbf{x_a}$ and $\mathbf{x_b}$ are two points on the decision boundary:

$$
\begin{split}
\mathbf{w} \cdot \mathbf{x_a} + b &= 0 \\
\mathbf{w} \cdot \mathbf{x_b} + b &= 0
\end{split}
$$

$$
\mathbf{w} \cdot (\mathbf{x_a} - \mathbf{x_b}) = 0
$$

Since $(\mathbf{x_a} - \mathbf{x_b})$ is a vector on the decision boundary, based on the definition of inner product, the direction of $\mathbf{w}$ is orthogonal to the decision boundary.

### Equations for Parallel Hyperplanes (i.e. Support Vectors)

For any circle $\mathbf{x_c}$ located above the decision boundary:

$$
\mathbf{w} \cdot \mathbf{x_c} + b = k\text{, where } k > 0
$$

For any square $\mathbf{x_s}$ located below the decision boundary:

$$
\mathbf{w} \cdot \mathbf{x_s} + b = k'\text{, where } k' < 0
$$

The two parallel hyperplanes passing the closest circle(s) and square(s) can be written as:

$$
\begin{gathered}
\mathbf{w} \cdot \mathbf{x} + b = \bar{k} \\
\mathbf{w} \cdot \mathbf{x} + b = -\bar{k} \\
\text{where } \bar{k} > 0
\end{gathered}
$$

After rescaling $\mathbf{w}$ and $b$, the two parallel hyperplanes can be further rewritten as:

$$
\begin{split}
\mathbf{w} \cdot \mathbf{x} + b &= +1 \\
\mathbf{w} \cdot \mathbf{x} + b &= -1
\end{split}
$$

### Deriving the Margin

Let $\mathbf{x_1}$ be a point on $b_11$ and $\mathbf{x_2}$ be a point on $b_12$:

![Deriving the Margin](img/Linear%20SVM%20Margin.png)

$$
\begin{split}
b_{11}: \mathbf{w} \cdot \mathbf{x_1} + b &= +1 \\
b_{12}: \mathbf{w} \cdot \mathbf{x_2} + b &= -1
\end{split}
$$

$$
\mathbf{w} \cdot (\mathbf{x_1} - \mathbf{x_2}) = 2
$$

Based on the definition of inner product:

$$
||\mathbf{w}||_2 \times d = 2
$$

$$
d = \frac{2}{||\mathbf{w}||_2}
$$

where $d$ represents the margin i.e. $(||\mathbf{x_1} - \mathbf{x_2}||_2 \times \cos(\theta))$.

### Learning in Linear SVM

The goal is to maximize the margin $d$, or in other words, minimize the following:

$$
\frac{||\mathbf{w}||_2^2}{2}
$$

Given the following constraints:

$$
\begin{split}
\mathbf{w} \cdot \mathbf{x_i} + b \geq +1 & \text{, if} y_i = 1 \\
\mathbf{w} \cdot \mathbf{x_i} + b \leq -1 & \text{, if} y_i = -1
\end{split}
$$

Or, in other words:

$$
y_i \times (\mathbf{w} \cdot \mathbf{x_i} + b) \geq 1
$$

Thus, the optimization problem of linear SVM is:

$$
\begin{gathered}
\min_w \frac{||\mathbf{w}||_2^2}{2} \\
\text{s.t. } y_i \times (\mathbf{w} \cdot \mathbf{x_i} + b) \geq 1 \text{, } i = 1, ... , N
\end{gathered}
$$

The optimization is convex and there are many numerical approaches that can be applied to solve it.

## Linear SVM: Nonseperable Case

In seperable cases, there is no training data within the margin. However, in nonseperable cases, there may be training data that lies within the margin. Thus, slack variables $\xi \geq 0$ need to be introduced to absorb errors.

$$
\begin{split}
\mathbf{w} \cdot \mathbf{x_i} + b \geq +1 - \xi_i & \text{, if} y_i = 1 \\
\mathbf{w} \cdot \mathbf{x_i} + b \leq -1 + \xi_i & \text{, if} y_i = -1
\end{split}
$$

Or, in other words:

$$
y_i \times (\mathbf{w} \cdot \mathbf{x_i} + b) \geq 1 - \xi_i
$$

- If $\xi_i = 0$, there is no problem with $\mathbf{x_i}$.
- If $0 < \xi_i < 1$, $\mathbf{x_i}$ is correctly classified but in the margin.
- If $\xi_i = 1$, $\mathbf{x_i}$ is on the decision boundary (random guess).
- If $\xi_i > 1$, $\mathbf{x_i}$ is misclassified.

### Soft Error

- Number of Misclassifications = #$\{\xi_i > 1\}$
- Number of Nonseperable Points = #$\{\xi_i > 0\}$

Soft Errors:

$$
\sum_{i = 1}^N \xi_i
$$

Learning with soft errors:

$$
\begin{gathered}
\min_w \frac{||\mathbf{w}||_2^2}{2} + C \Bigg(\sum_{i = 1}^N \xi_i \Bigg) \\
\text{s.t. } y_i (\mathbf{w} \cdot \mathbf{x_i} + b) \geq 1 - \xi_i \text{, } i = 1, ... , N, \xi_i \geq 0
\end{gathered}
$$

where $C \geq 0$ is a parameter to tradeoff the impact of margin maximization and tolerable errors and a nonnegative $\xi_i$ provides an estimate of the error of the decision boundary on the training example $\mathbf{x_i}$.

## Non-linear SVM

To generalize linear decision boundary to become non-linear, $\mathbf{x_i}$ has to be transformed to a higher dimensional space using a function $\varphi(\mathbf{x_i})$. The original input space is mapped to a higher dimensional feature space where the training set is separable.

$$
\varphi : \mathbf{x} \rightarrow \varphi(\mathbf{x})
$$

The assumption is that in a higher dimensional space, it is easier to find a linear hyperplane to classify the data.

Optimization problem of non-linear SVM:

$$
\begin{gathered}
\min_w \frac{||\mathbf{w}||_2^2}{2} \\
\text{s.t. } y_i \times (\mathbf{w} \cdot \varphi(\mathbf{x_i}) + b) \geq 1 \text{, } i = 1, ... , N
\end{gathered}
$$

where $\mathbf{w} \cdot \varphi(\mathbf{x_i}) + b = 0$ is the hyperplane in feature space.

However, computation in the feature space can be costly because it is high dimensional since the feature space is typically very high dimensional.

### Kernel Trick

Suppose $\varphi(\cdot)$ is given as follows, mapping an instance from two-dimensional space to six-dimensional space:

$$
\varphi([X_1, X_2]) = [1, \sqrt{2}X_1, \sqrt{2}X_2, X_1^2, X_2^2, \sqrt{2}X_1X_2]
$$

Given two data instances, $\mathbf{a}$ and $\mathbf{b}$:

$$
\begin{split}
\varphi(\mathbf{a}) \cdot \varphi(\mathbf{b}) &= 1 + 2A_1B_1 + 2A_2B_2 + A_1^2B_1^2 + A_2^2B_2^2 + 2A_1A_2B_1B_2 \\
                                              &= (1 + A_1B_1 + A_2B_2)^2
\end{split}
$$

So, if we define the kernel function as follows, there is no need to carry out $\varphi(\cdot)$ explicitly:

$$
\begin{split}
k(\mathbf{a}, \mathbf{b}) &= (1 + A_1B_1 + A_2B_2)^2 \\
                          &= (1 + \mathbf{a} \cdot \mathbf{b})^2
\end{split}
$$

The use of the kernel function to avoid carrying out $\varphi(\cdot)$ explicitly is known as the **kernel trick**.

Thus, if $\varphi(\cdot)$ satisfies some conditions, then we can find a function $k(\cdot,\cdot)$ such that:

$$
k(\mathbf{x_i}, \mathbf{x_j}) = \varphi(\mathbf{x_i}) \cdot \varphi(\mathbf{x_j})
$$

#### Well-Known Kernel Functions

Linear Kernel:

$$
k(\mathbf{x_i}, \mathbf{x_j}) = \mathbf{x_i} \cdot \mathbf{x_j}
$$

Radial Basis Kernel Function w/ Width $sigma$:

$$
k(\mathbf{x_i}, \mathbf{x_j}) = \text{exp}\bigg(-\frac{||\mathbf{x_i} - \mathbf{x_j}||_2^2}{2 \sigma^2}\bigg)
$$

Polynomial Kernel Function w/ Degree $d$:

$$
k(\mathbf{x_i}, \mathbf{x_j}) = (\mathbf{x_i} \cdot \mathbf{x_j} + 1)^d
$$

### Lagrange Multiplier Method

In its primal form, it is not possible to solve the optimization problem for non-linear SVMs using the kernel trick as instances in the feature space do not appear in the form of inner products. Thus, its dual form needs to be used.

Using the Lagrange Multiplier Method, we can transform the original optimization problem to its dual form where the mapping function $\varphi(\mathbf{x})$ does not need to computed explicitly.

Given an objective function to be minimized, with a set of inequality constraints:

$$
\begin{gathered}
\min_{\mathbf{w}} f(\mathbf{w}) \\
\text{s.t. } h_i(\mathbf{w}) \leq 0$, $i = 1, 2, ... , q
\end{gathered}
$$

The Langrangian for the optimization problem will be:

$$
L(\mathbf{w}, \mathbf{\lambda}) = f(\mathbf{w}) + \sum_{i = 1}^q \lambda_i h_i (\mathbf{w})
$$

where $\mathbf{\lambda} = \{\lambda_1, ... , \lambda_q\}$ are the Langrange multipliers.

Thus,

$$
\begin{gathered}
\min_w \frac{||\mathbf{w}||_2^2}{2} \\
\text{s.t. } y_i \times (\mathbf{w} \cdot \varphi(\mathbf{x_i}) + b) \geq 1 \text{, } i = 1, ... , N
\end{gathered}
$$

can be transformed to its dual form:

$$
\max_{\mathbf{\lambda}}L_D(\mathbf{\lambda}) = - \Bigg(\frac{1}{2} \sum_{i, j} \lambda_i \lambda_j y_i y_j \big(\varphi(\mathbf{x_i}) \cdot \varphi(\mathbf{x_j})\big) - \sum_{i = 1}^N \lambda_i \Bigg)
$$

#### Dual Optimization Problem

- The dual Langrangian involves only the Langrange multipliers and the training data.
- The negative sign in the dual Langrangian transforms a minimization problem of the primal form to a maximization problem of the dual form.
- The objective is to maximize $L_D(\mathbf{\lambda})$.
    - Can be solved using numerical techniques such as quadratic programming.

Once the $\lambda_i$ values are found, we can obtain the feasible solutions for $\mathbf{w}$ and $b$ from the two equations below:

$$
\mathbf{w} = \sum_{i = 1}^N \lambda_i y_i \varphi(\mathbf{x_i})
$$

$$
\lambda_i(y_i(\mathbf{w} \cdot \varphi(\mathbf{x_i}) + b) - 1) = 0
$$

The decision boundary can be expressed as:

$$
\begin{split}
\mathbf{w} \cdot \varphi(\mathbf{x_i}) + b &= 0 \\
\Bigg(\sum_{i = 1}^N \lambda_i y_i \varphi(\mathbf{x_i}) \cdot \varphi(\mathbf{x}) \Bigg) + b &= 0
\end{split}
$$

A test instance $\mathbf{x^*}$ can be classified using:

$$
f(\mathbf{x^*}) = sign\Bigg(\sum_{i = 1}^N \lambda_i y_i \varphi(\mathbf{x_i}) \cdot \varphi(\mathbf{x^*}) + b \Bigg)
$$

If $\mathbf{x_i}$ is a support vector, then the corresponding $\lambda_i > 0$, otherwise, $\lambda_i = 0$.

### Non-linear SVM via Kernel Trick

Training:

$$
\max_{\mathbf{\lambda}} \Bigg(\sum_{i = 1}^N \lambda_i - \frac{1}{2} \sum_{i, j} \lambda_i \lambda_j y_i y_j \big(\varphi(\mathbf{x_i}) \cdot \varphi(\mathbf{x_j})\big) \Bigg)
$$

Decision Boundary:

$$
\sum_{i = 1}^N \lambda_i y_i \big(\varphi(\mathbf{x_i}) \cdot \varphi(\mathbf{x^*})\big) + b
$$

Thus, the data points only appear as inner product in feature space and can be replaced by the kernel function.

Training:

$$
\max_{\mathbf{\lambda}} \Bigg(\sum_{i = 1}^N \lambda_i - \frac{1}{2} \sum_{i, j} \lambda_i \lambda_j y_i y_j k(\mathbf{x_i}, \mathbf{x_j}) \Bigg)
$$

Decision Boundary:

$$
\sum_{i = 1}^N \lambda_i y_i k(\mathbf{x_i}, \mathbf{x^*}) + b
$$

If $\mathbf{x_i}$ is a support vector, then the corresponding $\lambda_i > 0$, otherwise, $\lambda_i = 0$.
