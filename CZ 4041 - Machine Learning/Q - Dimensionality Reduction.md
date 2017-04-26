# Dimensionality Reduction

**Why?**

- Reduces time complexity (less computation).
- Reduces space complexity (fewer parameters).
- Saves the cost of observing the feature.
- Simpler models are more robust on small datasets.
- Data visualization is easier if plotted in 2 or 3 dimensions.

**Feature Selection vs Extraction**

Feature selection involves choosing $k < d$ important features, ignoring the remaining $d - k$ features. E.g. subset selection algorithms.

Feature extraction involves projecting the original $d$ dimensions to new $k < d$ dimensions.

## Subset Selection

There are $2^d$ subsets of $d$ features.

**Forward Search:** Add the best feature at each step.

- Set of features $F$ initially $\varnothing$.
- At each iteration, find the best new feature where the error $E$ after inclusion is minimum. $j = \text{argmin}_i E(F \cup x_i)$.
- Add $x_j$ to $F$ if $E(F \cup x_j) < E(F)$.

**Backward Search:** Start with all the features and remove one at a time, if possible.

**Floating Search:** Add $k$ features, remove $l$ features at every iteration.

## Math Review - Eigenvalues & Eigenvectors

Let $\boldsymbol{A}$ be a square matrix and vector $\boldsymbol{x}$ is said to be an eigenvector of the matrix if:

$$
\boldsymbol{A}\boldsymbol{x} = \lambda\boldsymbol{x}
$$

where the constant $\lambda$ is called the eigenvalue.

$$
(\boldsymbol{A} - \lambda\boldsymbol{I})\boldsymbol{x} = 0
$$

The above equation has a non-zero solution for $\boldsymbol{x}$ if:

$$
|\boldsymbol{A} - \lambda\boldsymbol{I}| = 0
$$

The eigenvalue is obtained by solving the characteristic equation above.

### Matrix Determinant

$$
\begin{gathered}
|\boldsymbol{A}| = \begin{vmatrix} a & b \\ c & d \end{vmatrix} = ad - bc \\
|\boldsymbol{A}| = \begin{vmatrix} a & b & c \\ d & e & f \\ g & h & i \end{vmatrix} = a\,\begin{vmatrix} e & f \\ h & i \end{vmatrix} - b\,\begin{vmatrix} d & f \\ g & i \end{vmatrix} + c\,\begin{vmatrix} d & e \\ g & h \end{vmatrix}
\end{gathered}
$$

## Principal Component Analysis (PCA)

The aim of PCA is to find a lower dimensional space such that when the signal $\boldsymbol{x}$ is projected there, the information loss is minimized. The information in the signal is represented by its variance. PCA finds a set of projection vectors that maximize the variance of the signal in the projected space.

A projection of $\boldsymbol{x}$ in the direction of $\boldsymbol{w}$ is given by:

$$
\begin{gathered}
\boldsymbol{z} = \boldsymbol{w}^T \boldsymbol{x} = |\boldsymbol{w}| |\boldsymbol{x}| \cos(\theta) \\
|\boldsymbol{w}| = 1 \\
|\boldsymbol{x}| = \sqrt{x_1^2 + x_2^2 + \hdots + x_d^2}
\end{gathered}
$$

\vfill
\begin{center}
P.T.O
\end{center}
\vfill

Given a set of patterns $\boldsymbol{x}_p$ where $p = 1, 2, \hdots P$, the goal is to find unit vectors $\boldsymbol{w}$ that maximize the covariance $\text{cov}(z)$.

$$
\begin{split}
\text{cov}(z) &= \frac{1}{P - 1} \sum\limits_{p = 1}^P (z_p - \mu_z)^2 \\
              &= \frac{1}{P - 1} \sum\limits_{p = 1}^P (z_p - \mu_z) (z_p - \mu_z)^T \\
              &= \frac{1}{P - 1} \sum\limits_{p = 1}^P (\boldsymbol{w}^T \boldsymbol{x}_p - \boldsymbol{w}^T \boldsymbol{\mu}) (\boldsymbol{w}^T \boldsymbol{x}_p - \boldsymbol{w}^T \boldsymbol{\mu})^T \\
              &= \boldsymbol{w}^T \frac{1}{P - 1} \sum\limits_{p = 1}^P (\boldsymbol{x}_p - \boldsymbol{\mu}) (\boldsymbol{x}_p^T - \boldsymbol{\mu}^T) \boldsymbol{w} \\
              &= \boldsymbol{w}^T \frac{1}{P - 1} \sum\limits_{p = 1}^P (\boldsymbol{x}_p - \boldsymbol{\mu}) (\boldsymbol{x}_p - \boldsymbol{\mu})^T \boldsymbol{w} \\
              &= \boldsymbol{w}^T \boldsymbol{C_{xx}} \boldsymbol{w}
\end{split}
$$

$\boldsymbol{C_{xx}}$ represents the covariance matrix and the aim of PCA is to find the $\boldsymbol{w}$ that satisfies:

$$
\max_{\boldsymbol{w}} \boldsymbol{w}^T \boldsymbol{C_{xx}} \boldsymbol{w} \:\: \text{such that} \:\: ||\boldsymbol{w}|| = 1
$$

This can be done by minimizing the cost:

$$
J(\boldsymbol{w}) = -\boldsymbol{w}^T \boldsymbol{C_{xx}} \boldsymbol{w} + \lambda(\boldsymbol{w}^T \boldsymbol{w} - 1)
$$

After solving for $\frac{\delta J(\boldsymbol{w})}{\delta \boldsymbol{w}} = 0$:

$$
\begin{split}
-2 \boldsymbol{C_{xx}} \boldsymbol{w} + 2 \lambda \boldsymbol{w} &= 0 \\
\boldsymbol{C_{xx}} \boldsymbol{w} &= \lambda \boldsymbol{w}
\end{split}
$$

Thus, the projection vectors are given by the eigenvectors of the covariance matrix $\boldsymbol{C_{xx}}$. The top principal eigenvector (that corresponds to the largest eigenvalue) gives the direction of maximum variance. The second principal eigenvector gives the direction of the next largest variance and so on.

Given a matrix of size $n \times n$, there are $n$ eigenvectors and $n$ corresponding eigenvalues. Let $\boldsymbol{u}_1, \boldsymbol{u}_2 \hdots \boldsymbol{u}_n$ be the eigenvectors and $\lambda_1, \lambda_2 \hdots \lambda_n$ be the corresponding eigenvalues in decreasing order. Thus, $\boldsymbol{u}_1$ is the first principal eigenvector and the second principal eigenvector is $\boldsymbol{u}_2$ and so on.

Eigenmatrix $\boldsymbol{U}$ contains the eigenvectors as columns with the top principal eigenvector first, the second principal eigenvector next and so on:

$$
\boldsymbol{U} = \begin{pmatrix} \boldsymbol{u}_1 & \boldsymbol{u}_2 & \hdots & \boldsymbol{u}_n \end{pmatrix}
$$

### Projecting the Data

The data can now be represented in eigenspace by rotating the mean-corrected data by the eigenvectors. A given data point $\boldsymbol{x}$ will be represented in eigenspace by $\boldsymbol{z}$:

$$
\boldsymbol{z} = \boldsymbol{U}^T (\boldsymbol{x} - \boldsymbol{\mu})
$$

where $\boldsymbol{z} = (z_1, z_2, \hdots z_n)^T$. $z_1 = \boldsymbol{u_1}^T (\boldsymbol{x} - \boldsymbol{\mu})$ is known as the first principal component of data, $z_2$ is known as the second principal component and so on.

Since the eigenmatrix is orthogonal (i.e. $\boldsymbol{U}^T \boldsymbol{U} = \boldsymbol{U} \boldsymbol{U}^T = \boldsymbol{I}$), the data in eigenspace can be rotated back to original space:

$$
\begin{split}
\boldsymbol{U} \boldsymbol{z} &= \boldsymbol{U} \boldsymbol{U}^T (\boldsymbol{x} - \boldsymbol{\mu}) \\
\boldsymbol{U} \boldsymbol{z} &= \boldsymbol{x} - \boldsymbol{\mu} \\
               \boldsymbol{x} &= \boldsymbol{U} \boldsymbol{z} + \boldsymbol{\mu}
\end{split}
$$

### Dimensionality Reduction

The first principal component of the data carries most of the variance (information) of the data, the second principal component carries the next most and so on. We can represent data in a lower $k$ dimensional space loosing the least amount of information by using the top $k$ principal components of the data.

Let $\boldsymbol{\tilde{z}} = (z_1, z_2, \hdots z_k)^T$ be the data in the $k < n$ dimensional space and $\boldsymbol{U_k}$ be the eigenmatrix with the top $k$ eigenvectors:

$$
\boldsymbol{\tilde{z}} = \boldsymbol{U_k}^T (\boldsymbol{x} - \boldsymbol{\mu})
$$

By transforming data into a lower dimensional space, we inevitably loose information. The reduced dimensional data can be projected back to the original space using:

$$
\boldsymbol{\hat{x}} = \boldsymbol{U_k} \boldsymbol{\tilde{z}} + \boldsymbol{\mu}
$$

### Choosing $k$

Proportion of Variance (PoV) can be used:

$$
\text{PoV}(k) = \frac{\lambda_1 + \lambda_2 + \hdots + \lambda_k}{{\lambda_1 + \lambda_2 + \hdots + \lambda_k + \hdots + \lambda_n}}
$$

A PoV value greater than 0.9 is usually used.

## Math Review - Spectral Decomposition

Let $\boldsymbol{X}$ be a data matrix, the spectral decomposition states:

$$
\boldsymbol{S} = \boldsymbol{X}^T \boldsymbol{X} = \boldsymbol{U} \boldsymbol{D} \boldsymbol{U}^T
$$

where $\boldsymbol{U}$ contains eigenvectors of $\boldsymbol{S}$ as columns and $\boldsymbol{D}$ has the eigenvalues as diagonal elements. The data matrix $\boldsymbol{X}$ has data points as its rows.

When $\boldsymbol{X}$ is the mean-corrected data matrix, $\boldsymbol{S}$ is proportional to the covariance matrix of the data. The spectral decomposition (AKA eigenvalue decomposition) is true for any real symmetric matrix $\boldsymbol{S}$.

## Feature Embedding

When $\boldsymbol{X}$ is a $N \times d$ data matrix:

- $\boldsymbol{X}^T \boldsymbol{X}$ is a $d \times d$ matrix (covariance of features if mean-centered)
- $\boldsymbol{X} \boldsymbol{X}^T$ is a $N \times N$ matrix (pairwise similarities between instances)

PCA uses eigenvectors of $\boldsymbol{X}^T \boldsymbol{X}$ which are $d$-dimensional and can be used for projection. Feature embedding uses the eigenvectors of $\boldsymbol{X} \boldsymbol{X}^T$ which are $N$-dimensional and give the coordinates after projection directly (without a projection vector).

Sometimes, it is possible to define pairwise similarities (or distances) between instances and use feature embedding without needing to represent the instances as vectors.

By spectral decomposition, $\boldsymbol{X} \boldsymbol{X}^T = \boldsymbol{V} \boldsymbol{E} \boldsymbol{V}^T$, where $\boldsymbol{V}$ has eigenvectors of $\boldsymbol{X} \boldsymbol{X}^T$ as columns.

Feature embedding uses the significant eigenvectors of $\boldsymbol{X} \boldsymbol{X}^T$ as features ($k < N$). Feature embedding is preferred when $N < d$.

## Math Review - Singular Value Decomposition

$$
\boldsymbol{X} = \boldsymbol{V} \boldsymbol{A} \boldsymbol{U}^T
$$

where $\boldsymbol{V}$ is $N \times N$ and contains the eigenvectors of $\boldsymbol{X} \boldsymbol{X}^T$, $\boldsymbol{U}$ is $d \times d$ and contains the eigenvectors of $\boldsymbol{X}^T \boldsymbol{X}$ and $\boldsymbol{A}$ is $N \times d$ and contains singular values on its first $k$ diagonal. The singular values are square roots of eigenvalues.

\vfill\eject

$$
\boldsymbol{X} = \boldsymbol{v_1}a_1\boldsymbol{u_1}^T + \hdots + \boldsymbol{v_k}a_k\boldsymbol{u_k}^T
$$

where $k$ is the rank of $\boldsymbol{X}$.

By taking a reduced number of eigenvectors, $\boldsymbol{X} \approx \boldsymbol{V_r} \boldsymbol{A_r} \boldsymbol{U_r}^T$. That is, SVD can be used for matrix factorization.

## Multidimensional Scaling

Given pairwise distances between $N$ points, $d_{ij} \text{ where } i, j = 1, \hdots N$, they can be placed on a low-dimensional map such that the distances are preserved (by feature embedding).

1. Let distance matrix be $\boldsymbol{B} = \boldsymbol{X} \boldsymbol{X}^T$.
2. From spectral decomposition, $\boldsymbol{B} = \boldsymbol{U} \boldsymbol{D} \boldsymbol{U}^T$.
3. Thus, $\boldsymbol{X} = \boldsymbol{U} \boldsymbol{D}^{0.5}$ is an approximation considering only $k$ ($<< d$ and $N$) eigenvectors.

MDS preserves the original distances between data points in the lower dimensional space.

## Linear Discriminant Analysis

The goal is to find a low-dimensional space such that when $\boldsymbol{x}$ is projected, classes are well-separated.

### Fisher's Linear Discriminant

#### $K$ = 2 Classes

![Linear Discriminant Analysis](img/Linear%20Discriminant%20Analysis.png){height=220px}

Find $\boldsymbol{w}$ that maximizes the objective function (Fisher Ratio):

$$
J(\boldsymbol{w}) = \frac{|m_1 - m_2|^2}{s_1^2 + s_2^2}
$$

where mean $m_1$ and scatter $s_1^2$ correspond to Class 1.

$$
\begin{split}
m_1 &= \frac{1}{|C_1|} \sum_{x \in C_1} \boldsymbol{w}^T \boldsymbol{x} \\
s_1^2 &= \sum_{x \in C_1} (\boldsymbol{w}^T \boldsymbol{x} - m_1)^2
\end{split}
$$

The between-class scatter $\boldsymbol{S}_B$:

$$
\boldsymbol{S}_B = (\boldsymbol{m_1} - \boldsymbol{m_2})(\boldsymbol{m_1} - \boldsymbol{m_2})^T
$$

The within-class scatter $\boldsymbol{S}_W$:

$$
\boldsymbol{S}_W = \sum_{x \in C_1} (\boldsymbol{x} - \boldsymbol{m_1}) (\boldsymbol{x} - \boldsymbol{m_1})^T + \sum_{x \in C_2} (\boldsymbol{x} - \boldsymbol{m_2}) (\boldsymbol{x} - \boldsymbol{m_2})^T
$$

Thus, find $\boldsymbol{w}$ that maximizes:

$$
J(\boldsymbol{w}) = \frac{\boldsymbol{w}^T \boldsymbol{S}_B \boldsymbol{w}}{\boldsymbol{w}^T \boldsymbol{S}_W \boldsymbol{w}} = \frac{|\boldsymbol{w}^T (\boldsymbol{m_1} - \boldsymbol{m_2})|^2}{\boldsymbol{w}^T \boldsymbol{S}_W \boldsymbol{w}}
$$

Thus, the LDA solution, $\boldsymbol{w}$ (i.e. Fisher's linear discriminant line) is given by:

$$
\boldsymbol{w} = c \cdot {\boldsymbol{S}_W}^{-1} (\boldsymbol{m_1} - \boldsymbol{m_2})
$$

where $c = 1.0$ is a constant.

#### $K$ > 2 Classes

The between-class scatter $\boldsymbol{S}_B$:

$$
\boldsymbol{S}_B = \sum_{k = 1}^K |C_k| (\boldsymbol{m_k} - \boldsymbol{m})(\boldsymbol{m_k} - \boldsymbol{m})^T
$$

where $\boldsymbol{m}$ is the grand mean.

The within-class scatter $\boldsymbol{S}_W$:

$$
\boldsymbol{S}_W = \sum_{k = 1}^K \sum_{x \in C_k} (\boldsymbol{x} - \boldsymbol{m_k}) (\boldsymbol{x} - \boldsymbol{m_k})^T
$$

Find $\boldsymbol{W}$ that maximizes:

$$
J(\boldsymbol{W}) =  \frac{|\boldsymbol{W}^T \boldsymbol{S}_B \boldsymbol{W}|}{|\boldsymbol{W}^T \boldsymbol{S}_W \boldsymbol{W}|}
$$

The largest eigenvectors of ${\boldsymbol{S}_W}^{-1} \boldsymbol{S}_B$ gives the solution.

## Math Review - Inverse of Matrix

$$
\begin{gathered}
\boldsymbol{A} = \begin{pmatrix} a & b \\ c & d \end{pmatrix} \\
\boldsymbol{A}^{-1} = \frac{1}{|\boldsymbol{A}|} \begin{pmatrix} d & -b \\ -c & a \end{pmatrix}
\end{gathered}
$$

$$
\begin{gathered}
\boldsymbol{A} =
\begin{pmatrix}
    a_{11} & a_{12} & a_{13} \\
    a_{21} & a_{22} & a_{23} \\
    a_{31} & a_{32} & a_{33}
\end{pmatrix} \\
\boldsymbol{A}^{-1} = \frac{1}{|\boldsymbol{A}|}
\begin{pmatrix}
    \begin{vmatrix} a_{22} & a_{23} \\ a_{32} & a_{33} \end{vmatrix} &
    \begin{vmatrix} a_{13} & a_{12} \\ a_{33} & a_{32} \end{vmatrix} &
    \begin{vmatrix} a_{12} & a_{13} \\ a_{22} & a_{23} \end{vmatrix} \\
    & & \\
    \begin{vmatrix} a_{23} & a_{21} \\ a_{33} & a_{31} \end{vmatrix} &
    \begin{vmatrix} a_{11} & a_{13} \\ a_{31} & a_{33} \end{vmatrix} &
    \begin{vmatrix} a_{13} & a_{11} \\ a_{23} & a_{21} \end{vmatrix} \\
    & & \\
    \begin{vmatrix} a_{21} & a_{22} \\ a_{31} & a_{32} \end{vmatrix} &
    \begin{vmatrix} a_{12} & a_{11} \\ a_{32} & a_{31} \end{vmatrix} &
    \begin{vmatrix} a_{11} & a_{12} \\ a_{21} & a_{22} \end{vmatrix}
\end{pmatrix} \\
\text{i.e.} \:
\begin{pmatrix}
    a_{22} a_{33} - a_{23} a_{32} & a_{13} a_{32} - a_{12} a_{33} & a_{12} a_{23} - a_{13} a_{22} \\
    a_{23} a_{31} - a_{21} a_{33} & a_{11} a_{33} - a_{13} a_{31} & a_{13} a_{21} - a_{11} a_{23} \\
    a_{21} a_{32} - a_{22} a_{31} & a_{12} a_{31} - a_{11} a_{32} & a_{11} a_{22} - a_{12} a_{21}
\end{pmatrix}
\end{gathered}
$$

$$
\boldsymbol{A} \boldsymbol{A}^{-1} = \boldsymbol{I}
$$

## Notes

- PCA preserves the variance (information).
- LDA aims to separate classes.

![PCA vs. LDA](img/PCA%20vs.%20LDA.png)
