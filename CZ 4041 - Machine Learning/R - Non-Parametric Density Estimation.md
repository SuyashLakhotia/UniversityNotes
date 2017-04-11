# Non-Parametric Density Estimation

In Machine Learning, we try to estimate $p(x | \omega_i, D_i)$. This approach requires some knowledge about $p(x | \omega_i, D_i)$ (e.g. the form of the distribution) and only the parameters need to be estimated. However, if we do not have any knowledge about the distribution, we need to use non-parametric density estimation.

## Histograms

A histogram divides the sample space into a number of bins and approximates the density at the center of each bin by the fraction of points in the training data that falls into the corresponding bin.

Histogram estimator:

$$
P_H(x) = \frac{1}{N} \frac{[\text{number of } x^k \text{ in the same bin as } x]}{[\text{width of bin containing } x]}
$$

where $x^k$ is one training sample and $N$ is the total number of training samples.

Histograms require two parameters, bin width and starting position of the first bin.

$$
\int P_H dx = \sum P_H (x_c) \times P_W = 1
$$

where $P_H(x_c)$ is the height of each bin and $P_W$ is the width.

### Pros/Cons

**Pros:**

- Easy to understand.
- Easy to implement.

**Cons:**

- The estimated density depends on the starting position of the bins and bin width.
- The discontinuities of the estimate may not be due to the underlying density. They are an artifact of the chosen bin locations.
- These discontinuities make it very difficult to grasp the structure of the data.
- The most serious problem is the curse of dimensionality, since the number of bins grows exponentially with the number of dimensions.
    - For example, a five-dimension problem where each dimension uses 10 bins would result in $10^5$ hypercubes.

## General Theory for Non-Parametric Density Estimation

The probability that a vector $x$, drawn from a distribution $p(x)$, will fall in a given region $R$ of the same space is:

$$
P = \int_{R_{\text{lower}}}^{R_{\text{upper}}} p(u) du
$$

Assume that we have $N$ sample points $x_1, x_2, \hdots x_N$ from the distribution that we want to estimate. The probability that $k$ of these $N$ sample points fall in $R$ is given by the binomial distribution:

$$
P(k) = \begin{pmatrix} N \\ k \end{pmatrix} P^k (1 - P)^{N - k}
$$

where:

$$
\begin{pmatrix} N \\ k \end{pmatrix} = \frac{N!}{(N - k)! k!}
$$

The mean of the binomial distribution is $\text{E}(k) = NP$ and variance is $\text{Var}(k) = NP(1 - P)$. Therefore, it can be proved that:

$$
\begin{gathered}
\text{E}(k/N) = P \\
\text{Var}(k/N) = P(1 - P)/N
\end{gathered}
$$

Therefore, when $N \to \infty$, $P(1 - P)/N \approx 0$. This means that the distribution of $k / N$ becomes very sharp at $k / N = P$. Therefore, we can use $k / N$ to approximate $P$.

If we assume $R$ is very small and $p(x)$ does not change too much in $R$:

$$
P = \int_R p(x')dx' \approx p(x)V
$$

where $V$ is the volume enclosed by region $R$.

Combining the results,

$$
\begin{gathered}
P = \frac{k}{N} \approx p(x)V \\
p(x) \approx \frac{k}{NV}
\end{gathered}
$$

where $p$ is the probability density that we want to estimate, $V$ is the volume surrounding $x$, $N$ is the total number of examples and $k$ is the number of examples inside $V$.

Comparing to the histogram estimator equation for $P_H(x)$, $k =$ [number of $x^k$ in the same bin as $x$] and $V =$ [width of bin containing $x$].

We have two approaches to apply this result:

1. We can select a fixed value of the volume $V$ and determine $k$ from the data i.e. Kernel Density Estimation (KDE).
2. We can select a fixed value of $k$ and determine the corresponding volume $V$ from the data i.e. $k$ Nearest Neighbor ($k$NN) Approach.

## Parzen Windows

Let $R$ be a hypercube with sides of length $h$ centered at the estimation point $x$. Therefore, the volume is:

$$
V = h^d
$$

where $d$ is the number of dimensions.

To count the number of sample points that fall inside the hypercube, we define a kernel function $K(u)$ where $u = (u_1, u_2, \hdots u_d)$:

$$
K(u) =
\begin{cases}
1 & |u_j| < \frac{1}{2} \enspace \forall j = 1, 2, \hdots d \\
0 & \text{otherwise}
\end{cases}
$$

The kernel, which corresponds to a unit hypercube centered at the origin is knows as Parzen window or the naive estimator.

Then, $K((x - x^i) / h)$ is equal to one if $|(x - x^i)| < h / 2$. In other words, the point $x^i$ is inside a hypercube of side $h$ centered on $x$.

The total number of points at $x$ inside the hypercube is:

$$
k = \sum_{i = 1}^N K\bigg(\frac{x - x^i}{h}\bigg)
$$

Now that we know $k$, $V$ & $N$:

$$
p_{\text{KDE}}(x) = \frac{1}{Nh^d} \sum_{i = 1}^N K\bigg(\frac{x - x^i}{h}\bigg)
$$

Notice that the Parzen window density estimate resembles the histogram, with the exception that the bin locations are determined by the data points.

We can calculate the probability of the original distribution at $x$ by:

$$
P(x) = p_{\text{KDE}}(x) \times h^d
$$

### Drawbacks

- The estimated density has discontinuities.
- The weights of $x_i$ are equal, regardless of their distance to the estimation point $x$.

## Smooth Kernels

To overcome the drawbacks of Parzen window, the hypercube in the original Parzen window can be replaced with other smooth kernel functions $K(u)$ such that:

$$
\int_R K(x)dx = 1
$$

Usually, the selected kernel function fulfills the following conditions:

- Smooth (also means differentiable)
- Symmetric
- Unimodal

Therefore, the multivariate Gaussian density function can be used:

$$
K(x) = \frac{1}{(2 \pi)^{d / 2}} \text{exp}\bigg(-\frac{1}{2} x^T x \bigg)
$$

The Parzen window approach can be considered as a sum of boxes centered at the observations while the smooth kernel approach can be considered as a sum of *bumps* placed at the data points. The shape of the bumps is determined by the kernel function. The parameter $h$, also called the smoothing parameter or bandwidth determines the width.

## Bandwidth Selection

The problem of choosing the bandwidth is crucial in the density estimation, for smooth kernel functions and histograms alike.

- A large bandwidth will over-smooth the density and mask the structure in the data.
- A small bandwidth will yield a density estimate that is spiky and very hard to interpret.
