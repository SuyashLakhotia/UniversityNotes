# Naive Bayes Classifier

## Bayesian Classifiers

Given a vector of features $\boldsymbol{X}$ and a class label $Y = y_k$, $\boldsymbol{X}$ and $Y$ are treated as random variables and their relationship is captured using $P(Y | \boldsymbol{X})$ using training data.

A test record $\boldsymbol{X} = \boldsymbol{x^*}$ or $\boldsymbol{X^*}$ can be classified by finding the class $y_i$ that maximizes the posterior $P(Y | \boldsymbol{X^*})$. Predict $Y = y_i$ if:

$$
\begin{split}
y_i &= \underset{k}{\mathrm{argmax}} \: P(Y = y_k | \boldsymbol{X^*}) \\
y_i &= \underset{k}{\mathrm{argmax}} \: P(\boldsymbol{X^*} | Y = y_k) P(Y = y_k)
\end{split}
$$

## Math Review - Independence & Conditional Independence

Let $\boldsymbol{X}$, $\boldsymbol{Y}$ and $\boldsymbol{Z}$ be three sets of random variables.

The variables in $\boldsymbol{X}$ are said to be **independent** of $\boldsymbol{Y}$ if the following condition holds:

$$
P(\boldsymbol{X}, \boldsymbol{Y}) = P(\boldsymbol{X} | \boldsymbol{Y}) \times P(\boldsymbol{Y}) = P(\boldsymbol{X}) \times P(\boldsymbol{Y})
$$

The variables in $\boldsymbol{X}$ are said to be **conditionally independent** of $\boldsymbol{Y}$, given $\boldsymbol{Z}$, if the following condition holds:

$$
P(\boldsymbol{X} | \boldsymbol{Y}, \boldsymbol{Z}) = P(\boldsymbol{X} | \boldsymbol{Z})
$$

The conditional independence between $\boldsymbol{X}$ and $\boldsymbol{Y}$ given $\boldsymbol{Z}$ can be used to derive the following:

$$
\begin{split}
P(\boldsymbol{X}, \boldsymbol{Y} | \boldsymbol{Z})
&= \frac{P(\boldsymbol{X},\boldsymbol{Y},\boldsymbol{Z})}{P(\boldsymbol{Z})} \\
&= \frac{P(\boldsymbol{X},\boldsymbol{Y},\boldsymbol{Z})}{P(\boldsymbol{Y},\boldsymbol{Z})} \times \frac{P(\boldsymbol{Y},\boldsymbol{Z})}{P(\boldsymbol{Z})} \\
&= P(\boldsymbol{X} | \boldsymbol{Y}, \boldsymbol{Z}) \times P(\boldsymbol{Y} | \boldsymbol{Z}) \\
&= P(\boldsymbol{X} | \boldsymbol{Z}) \times P(\boldsymbol{Y} | \boldsymbol{Z})
\end{split}
$$

## Naive Bayes Classifier

Assuming that the features in $\boldsymbol{X}$ are conditionally independent given the class label:

$$
\begin{gathered}
P(\boldsymbol{X} | Y = y_{k}) = \prod_{i = 1}^{d} P(X_{i} | Y = y_{k}) \\
P(X_1, X_2, \hdots X_d | Y = y_{k}) = \prod_{i = 1}^{d} P(X_{i} | Y = y_{k})
\end{gathered}
$$

To classify a test record $\boldsymbol{X^*}$, the posteriors for each class $y_k$ need to be computed using:

$$
P(Y = y_k | \boldsymbol{X^*}) = \frac{P(Y = y_k)\prod_{i = 1}^{d}P(X_i^* | Y = y_k)}{P(\boldsymbol{X^*})}
$$

Since $P(\boldsymbol{X^*})$ is fixed for each $y_k$, it is sufficient to choose the class that maximizes the numerator:

$$
\max_k P(Y = y_k)\prod_{i = 1}^{d}P(\boldsymbol{X_i^*} | Y = y_k)
$$

### Estimating Priors

$$
P(Y = y_k) = \frac{|Y = y_k|}{N}
$$

where $N$ is the total number of training examples.

### Estimating Conditional Probabilities for Discrete Features

$$
P(X_i = x_{ij} | Y = y_k) = \frac{|(X_i = x_{ij}) \cap (Y = y_k)|}{|Y = y_k|}
$$

where $x_{ij}$ is the $j$th distinct value of the feature $X_i$.

### Estimating Conditional Probabilities for Continuous Features

- Assume the values of a feature given a specific $y_k$ follows a Gaussian distribution i.e. $P(X_i | Y = y_k)$ is a Gaussian distribution.
- Use the training data to estimate the mean ($\mu$) and variance ($\sigma^2$) of the distribution.

$$
P(X_i | Y = y_j) = \frac{1}{\sqrt{2 \pi \sigma^{2}_{ij}}} e ^ { - \frac{(X_{i} - \mu_{ij})^{2} }{2 \sigma^{2}_{ij}}}
$$

## Laplace Estimate & M-Estimate

If one of the conditional probabilities is zero, then the entire expression becomes zero. Therefore, an alternative probability estimation is needed.

### Laplace Estimate

$$
P(X_i = x_{ij} | Y = y_k) = \frac{|(X_i = x_{ij}) \cap (Y = y_k)| + 1}{|Y = y_k| + n_i}
$$

where $n_i$ is the number of possible values for $X_i$.

### M-Estimate

$$
P(X_i = x_{ij} | Y = y_k) = \frac{|(X_i = x_{ij}) \cap (Y = y_k)| + m \times p}{|Y = y_k| + m}
$$

where $m$ and $p$ are user-specified parameters based on prior information of $P(X_i = x_{ij} | Y = y_k)$.

#### Normalizing Probabilities

After using m-estimate to derive the conditional probabilities, it is important to maintain the $\sum_j P(X_i = x_{ij} | Y = y_k) = 1$ property. Thus, the probabilities may have to be normalized.

For example, if the probabilities for $P(A = 0 | Z = 1)$ and $P(A = 1 | Z = 1)$ become $\frac{5}{10}$ and $\frac{6}{10}$ respectively after applying m-estimate, they will have to be normalized:

$$
\begin{gathered}
P(A = 0 | Z = 1) = \frac{\frac{5}{10}}{\frac{5}{10} + \frac{6}{10}} = \frac{5}{11} \\
P(A = 1 | Z = 1) = \frac{\frac{6}{10}}{\frac{5}{10} + \frac{6}{10}} = \frac{6}{11}
\end{gathered}
$$

## Notes

- Naive Bayes Classifier is computationally efficient.
- The independence assumption may not hold for some features.
- Correlated features can degrade the performance of Naive Bayes Classifiers.
