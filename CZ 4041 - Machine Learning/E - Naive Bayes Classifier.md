# Naive Bayes Classifier

## Bayesian Classifiers

Given a vector of features $X$ and a class label $Y = y_k$, $X$ and $Y$ are treated as random variables and their relationship is captured using $P(Y | X)$ using training data.

A test record $X = x^*$ or $X^*$ can be classified by finding the class $y_i$ that maximizes the posterior $P(Y | X^*)$

$$
Y = y_i \text{ if } y_i = \max_k P(Y = y_k | X^*)
$$

$$
Y = y_i \text{ if } y_i = \max_k P(X^* | Y = y_k) P(Y = y_k)
$$

## Independence & Conditional Independence

Let $X$ and $Y$ be two sets of random variables.

The variables in $X$ are said to be **independent** of $Y$ if the following condition holds:

$$
P(X, Y) = P(X | Y) \times P(Y) = P(X) \times P(Y)
$$

Let $X$, $Y$ and $Z$ be three sets of random variables.

The variables in $X$ are said to be **conditionally independent** of $Y$, given $Z$, if the following condition holds:

$$
P(X | Y, Z) = P(X | Z)
$$

The conditional independence between $X$ and $Y$ given $Z$ can be used to derive the following:

$$
\begin{split}
P(X, Y | Z) &= \frac{P(X,Y,Z)}{P(Z)} \\
            &= \frac{P(X,Y,Z)}{P(Y,Z)} \times \frac{P(Y,Z)}{P(Z)} \\
            &= P(X | Y, Z) \times P(Y | Z) \\
            &= P(X | Z) \times P(Y | Z)
\end{split}
$$

## Naive Bayes Classifier

Assuming that the features in $X$ are conditionally independent given the class label:

$$
P(X | Y = y_{k}) = \prod_{i = 1}^{d} P(X_{i} | Y = y_{k})
$$

$$
P(X_1, X_2, ... , X_d | Y = y_{k}) = \prod_{i = 1}^{d} P(X_{i} | Y = y_{k})
$$

To classify a test record $X^*$, the posteriors for each class $y_k$ need to be computed using:

$$
P(Y = y_k | X^*) = \frac{P(Y = y_k)\prod_{i = 1}^{d}P(X_i^* | Y = y_k)}{P(X^*)}
$$

Since $P(X^*)$ is fixed for each $y_k$, it is sufficient to choose the class that maximises the numerator:

$$
P(Y = y_k)\prod_{i = 1}^{d}P(X_i^* | Y = y_k)
$$

### Estimate Priors

$$
P(Y = y_k) = \frac{|Y = y_k|}{N}
$$

where $N$ is the total number of training examples.

### Estimate Conditional Probabilities for Discrete Features

$$
P(X = x_{ij} | Y = y_k) = \frac{|(X = x_{ij}) \cap (Y = y_k)|}{|Y = y_k|}
$$

where $x_{ij}$ is the $j$th distinct value of the feature $X_i$.

### Estimate Conditional Probabilities for Continuous Features

- Assume the values of a feature given a specific $y_k$ follows a Gaussian distribution i.e. $P(X_i | Y = y_k)$ is a Gaussian distribution.
- Use the training data to estimate the mean ($\mu$) and variance ($\sigma^2$) of the distribution.

$$
P(X_i | Y = y_j) = \frac{1}{\sqrt{2 \pi \sigma^{2}_{ij}}} e ^ { - \frac{(X_{i} - \mu_{ij})^{2} }{2 \sigma^{2}_{ij}}}
$$

## Laplace Estimate & M-Estimate

If one of the conditional probabilities is zero, then the entire expression becomes zero. Therefore, an alternative probability estimation is needed.

**Laplace Estimate:**

$$
P(X_i = x_{ij} | Y = y_k) = \frac{|(X = x_{ij}) \cap (Y = y_k) + 1}{|Y = y_k| + n_i}
$$

where $n_i$ is the number of possible values for $X_i$.

**M-Estimate:**

$$
P(X_i = x_{ij} | Y = y_k) = \frac{|(X = x_{ij}) \cap (Y = y_k) + m \times p}{|Y = y_k| + m}
$$

where $m$ and $p$ are user-specified parameters based on prior information of $P(X_i = x_{ij} | Y = y_k)$.

## Notes

- Naive Bayes Classifier is computationally efficient.
- The independence assumption may not hold for some features.
- Correlated features can degrade the performance of Naive Bayes Classifiers.
