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
d(\mathbf{x_i}, \mathbf{x_j}) = \sqrt{\sum_{k = 1}^d (x_{ik} - x_{jk})^2}
$$

To determine the class from the nearest neighbor list, a majority vote of class labels among the $k$-nearest neighbors can be used.

$$
y^* = \max_y \sum_{(\mathbf{x_i},y_i) \in N_{\mathbf{x^*}}} I(y = y_i)
$$

## Value of $k$

- If $k$ is too small, sensitive to noise points.
- If $k$ is too large, neighborhood may include points from other classes.

## Voting Approaches

In simple majority voting, every neighbor has the same impact on the classification which makes the algorithm sensitive to the choice of $k$. The solution is to implement **distance-weight voting**:

$$
y^* = \max_y \sum_{(\mathbf{x_i},y_i) \in N_{\mathbf{x^*}}} w_i \times I(y = y_i)
$$

where $w_i$ is the weight according to the distance of the nearest neighbor:

$$
w_i = \frac{1}{d(\mathbf{x^*}, \mathbf{x_1})^2}
$$

## Normalization

Another issue is that the feature may need to be scaled to prevent the distance from being dominated by some features. For example, the height of a person may vary from 1.5m to 1.8m but the income may vary from $10K to $10M. The solution is to normalize the features on different scales.

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

- $k$-NN Classifiers are lazy learners.
    - It does not build models explicitly.
- *Training* is very efficient.
- Classifying unknown test instances is relatively expensive.
