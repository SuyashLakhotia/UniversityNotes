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

where $x_c$ is the center of each bin, $P_H(x_c)$ is the height of each bin and $P_W$ is the width.

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
P = \int_{R_{\text{lower}}}^{R_{\text{upper}}} p(x) dx
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

The kernel, which corresponds to a unit hypercube centered at the origin is known as Parzen window or the naive estimator.

Then, $K((x - x_i) / h)$ is equal to 1 if $|(x - x_i)| < h / 2$. In other words, the point $x_i$ is inside a hypercube of side $h$ centered on $x$.

The total number of points at $x$ inside the hypercube is:

$$
k = \sum_{i = 1}^N K\bigg(\frac{x - x_i}{h}\bigg)
$$

Now that we know $k$, $V$ & $N$:

$$
p_{\text{KDE}}(x) = \frac{1}{Nh^d} \sum_{i = 1}^N K\bigg(\frac{x - x_i}{h}\bigg)
$$

Notice that the Parzen window density estimate resembles the histogram, with the exception that the bin locations are determined by the data points.

We can calculate the probability of the original distribution at $x$ by:

$$
p(x) = p_{\text{KDE}}(x) \times h^d
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

The multivariate Gaussian density function can be used:

$$
K(x) = \frac{1}{(2 \pi)^{d / 2}} \text{exp}\bigg(-\frac{1}{2} x^T x \bigg)
$$

The Parzen window approach can be considered as a sum of boxes centered at the observations while the smooth kernel approach can be considered as a sum of *bumps* placed at the data points. The shape of the bumps is determined by the kernel function. The parameter $h$, also called the smoothing parameter or bandwidth determines their width.

## Bandwidth Selection

The problem of choosing the bandwidth is crucial in the density estimation, for Parzen windows and histograms alike.

- A large bandwidth will over-smooth the density and mask the structure in the data.
- A small bandwidth will yield a density estimate that is spiky and very hard to interpret.

We would like to find a value of the smoothing parameter that minimizes the error between the estimated density ($p_{\text{KDE}}(x)$) and the true density. A commonly used error metric is the mean square error at the estimation point $x$:

$$
\begin{split}
\text{MSE}(p_{\text{KDE}}(x)) &= E\big[(p_{\text{KDE}}(x) - p(x))^2\big] \\
                              &= \big(E(p_{\text{KDE}}(x) - p(x))\big)^2 + \text{Var}(p_{\text{KDE}}(x))
\end{split}
$$

where $p_{\text{KDE}}(x)$ is a random variable, however, $p(x)$ is a constant.

This expression is an example of the bias-variance tradeoff. Reducing the bias would increase variance and vice-versa.

- Bias shows the expected difference of the estimation.
- Variance shows the variance of the estimation.

The bias-variance dilemma applied to bandwidth selection means that:

- A large bandwidth will reduce the differences among the estimates of $p_{\text{KDE}}(x)$ for different datasets (i.e. the variance) but it will increase the bias of $p_{\text{KDE}}(x)$ with respect to the true density $p(x)$.
- A small bandwidth will reduce the bias of $p_{\text{KDE}}(x)$ at the expense of a larger variance in the estimates of $p_{\text{KDE}}(x)$.

### Subjective Choice

The natural way for choosing the smoothing parameter is to plot out several curves and choose the estimate that is most in accordance with one's prior (subjective) ideas. However, this method is not practical in pattern recognition since we typically have high dimensional data.

### Reference to Standard Distribution

Assume a standard density function and find the value of the bandwidth that minimizes the integral of the square error (MISE):

$$
\begin{split}
h_{\text{opt}} &= \underset{h}{\mathrm{argmin}} \{\text{MISE}(p_{\text{KDE}}(x))\} \\
               &= \underset{h}{\mathrm{argmin}} \Bigg\{E \bigg[\int (p_{\text{KDE}}(x) - p(x))^2 dx \bigg] \Bigg\}
\end{split}
$$

If we assume that the true distribution is a Gaussian density and we use a Gaussian kernel, it can be shown that the optimal value of the bandwidth becomes $h_{\text{opt}} = 1.06 \sigma N^{-1/5}$, where $\sigma$ is the sample variance and $N$ is the number of training examples.

### Likelihood Cross-Validation

If we consider the estimation of the bandwidth, $h$, to be a parametric estimation problem, we can use an approach based on cross-validation. The final $h$ is defined as:

$$
h_{\text{MLCV}} = \underset{h}{\mathrm{argmax}} \bigg\{\frac{1}{N} \sum_{i = 1}^N \log(p_{-i}(x^i))\bigg\}
$$

where $p_{-n}$ is computed using leave-one-out cross-validation:

$$
p_{-n}(x) = \frac{1}{(N - 1)h} \sum_{i = 1, i \neq n}^N K \bigg(\frac{x^i - x}{h}\bigg)
$$

## Multivariate Density Estimation

Till now, for one dimension or high dimensional problems, we use the same equation for $p_{\text{KDE}}(x)$. Thus, it should be noted that the bandwidth $h$ is the same for all axes. Hence, this density estimate will weigh all the axes equally.

$$
p_{\text{KDE}}(x) = \frac{1}{Nh^d} \sum_{i = 1}^N K\bigg(\frac{x - x_i}{h}\bigg)
$$

However, if the spread of the data is much greater in one of the coordinate directions than the others, we should use a wider bandwidth for that direction. Thus, the above equation is modified to:

$$
p_{\text{KDE}}(x) = \frac{1}{N} \sum_{i = 1}^N K(x, x_i, h_1, h_2, \hdots h_d)
$$

$$
K(x, x_i, h_1, h_2, \hdots h_d) = \frac{1}{h_1 \hdots h_D} \prod_{r = 1}^d K_1 \bigg(\frac{x(r) - x_i(r)}{h_r} \bigg)
$$

where $K_1$ is a one-dimensional kernel.

## $k$ Nearest Neighbor

In the $k$NN method, we grow the volume surrounding the estimation point $x$ until it encloses a total of $k$ data points. The density estimate for $k$NN becomes:

$$
p(x) \approx \frac{k}{NV} = \frac{k}{N \times c_d \times R_k^d(x)}
$$

where $R_k^d(x)$ is the distance between the estimation point $x$ and its $k$-th closest neighbor in $d$ dimensions, $c_d$ is the volume of the unit sphere in $d$ dimensions.

$$
c_d = \frac{\pi^{d/2}}{\Gamma(d/2 + 1)}
$$

$$
c_d =
\begin{cases}
2 & d = 1 \\
\pi & d = 2 \\
\frac{4\pi}{3} & d = 3
\end{cases}
$$

where $\Gamma(d/2 + 1)$ is called the gamma function defined as:

$$
\Gamma(m) = 2 \int_0^{\infty} e^{-r^2} r^{2m - 1} dr
$$

### Disadvantages

In general, the estimates obtained with the $k$NN method are not very satisfactory.

- The estimates are prone to local noise.
- The method produces estimates with very heavy tails.
- Since the function $R_k(x)$ is not differentiable, the density estimate will have discontinuities.
- The resulting density is not a true probability density since its integral over all the sample space diverges.

### Approximation to Bayes Classifier

The main advantage of the $k$NN method is that it leads to a very simple approximation of the (optimal) Bayes classifier.

Assume a dataset of $N$ examples, $N_i$ from class $\omega_i$, and an unknown sample $x_u$ that needs to be classified. By drawing a hypersphere of volume $V$ around $x_u$ that contains a total of $k$ examples, $k_i$ from class $\omega_i$, it is possible to approximate the likelihood functions using the $k$NN method by:

$$
p(x | \omega_i) = \frac{k_i}{N_i V}
$$

\vfill\eject

Similarly, the unconditional density is estimated by:

$$
p(x) = \frac{k}{NV}
$$

The priors are approximated by:

$$
p(\omega_i) = \frac{N_i}{N}
$$

Therefore,

$$
\begin{split}
p(\omega_i | x) &= \frac{p(x | \omega_i) p(\omega_i)}{p(x)} \\
                &= \frac{\frac{k_i}{N_i V} \frac{N_i}{N}}{\frac{k}{NV}} \\
                &= \frac{k_i}{k}
\end{split}
$$

## Curse of Dimensionality

For high dimensional problems, it is not possible to directly use the non-parametric approach to estimate $p(x | \omega_i)$.

## Naive Bayes Classifier

To simplify the estimation for $p(x | \omega_i)$, Naive Bayes Classifier was developed. It employs the assumption that the features are class-conditionally independent across dimensions i.e.:

$$
p(x | \omega_i) = \prod_{d = 1}^D p(x(d) | \omega_i)
$$

Note that this assumption is different from independent features:

$$
p(x) = \prod_{d = 1}^D p(x(d))
$$

Therefore, the Bayes decision rule $j = \underset{i}{\mathrm{argmax}} (p(x | \omega_i) p(\omega_i))$ can be rewritten as:

$$
j = \underset{i}{\mathrm{argmax}} \Bigg(\prod_{d = 1}^D p(x(d) | \omega_i) p(\omega_i) \Bigg)
$$

This is the Naive Bayes Classifier.
