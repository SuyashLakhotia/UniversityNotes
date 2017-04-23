# $k$-Nearest Neighbor Classifier

NN Classifier uses $k$ *closest* points (nearest neighbors) for performing classification. It requires three things:

1. Set of stored labeled instances.
2. Distance metric to compute the distance between instances.
3. The value of $k$, the number of nearest neighbors to retrieve.

To classify an unknown instance:

1. Compute the distance to other training instances.
2. Identify the $k$ nearest neighbors.
3. Use class labels of nearest neighbors to determine the class label of unknown instances.

## Distance Metric

One way to compute the distance between two points is by computing the Euclidean distance:

$$
\begin{split}
d(\boldsymbol{x_i}, \boldsymbol{x_j}) &= \sqrt{(\boldsymbol{x_i} - \boldsymbol{x_j})^T (\boldsymbol{x_i} - \boldsymbol{x_j})} \\
                                      &= \sqrt{\sum_{k = 1}^d (x_{ik} - x_{jk})^2}
\end{split}
$$

Another metric is the Mahalanobis distance:

$$
d(\boldsymbol{x_i}, \boldsymbol{x_j}) = \sqrt{(\boldsymbol{x_i} - \boldsymbol{x_j})^T \boldsymbol{M} (\boldsymbol{x_i} - \boldsymbol{x_j})}
$$

where $\boldsymbol{M}$ is a $d \times d$ matrix that is learned from training data i.e. Metric Learning.

To determine the class from the nearest neighbor list, a majority vote of class labels among the $k$-nearest neighbors can be used.

$$
y^* = \underset{k}{\mathrm{argmax}} \: \sum_{(\boldsymbol{x_i},y_i) \in N_{\boldsymbol{x^*}}} I(y = y_i)
$$

where $I$ is an indicator function that returns 1 if its input is true and 0 otherwise.

## Value of $k$

- If $k$ is too small, sensitive to noise points.
- If $k$ is too large, neighborhood may include points from other classes.

## Voting Approaches

In simple majority voting, every neighbor has the same impact on the classification, which makes the algorithm sensitive to the choice of $k$. The solution is to implement **distance-weight voting**:

$$
y^* = \underset{k}{\mathrm{argmax}} \: \sum_{(\boldsymbol{x_i},y_i) \in N_{\boldsymbol{x^*}}} w_i \times I(y = y_i)
$$

where $w_i$ is the weight according to the distance of the nearest neighbor:

$$
w_i = \frac{1}{d(\boldsymbol{x^*}, \boldsymbol{x_1})^2}
$$

## Normalization

Another issue is that features may need to be scaled to prevent the distance from being dominated by some features. For example, the height of a person may vary from 1.5m to 1.8m but the income may vary from $10K to $10M. The solution is to normalize the features of different scales.

### Min-Max Normalization

$$
v_{new} = \frac{v_{old} - min_{old}}{max_{old} - min_{old}} (max_{new} - min_{new}) + min_{new}
$$

where $old$ represents the original scale and $new$ represents the new scale to be normalized to.

### Standardization

$$
v_{new} = \frac{v_{old} - \mu_{old}}{\sigma_{old}}
$$

The above results in $\mu_{new} = 0$ and $\sigma_{new} = 1$.

## Notes

- $k$-NN Classifiers are lazy learners as they do not explicitly build models.
- *Training* is very efficient but classifying unknown test instances is relatively expensive.
