# Generalization

## Underfitting & Overfitting

- See Lecture 4a.1, Slides 2 - 5 for graphical example.
- Underfitting occurs when the model is too simple, and hence, both training and test error rates are large.
- Overfitting occurs when the test error rate begins to increase even though the training error rate continues to decrease.
    - Overfitting results in decision trees that are more complex than necessary.
    - The training error no longer provides a good estimate of how well the tree will perform on previously unseen records. Therefore, there is a need for new ways to estimate the error rate.

## Generalization Error

Generalization error is a measure of how accurately an algorithm is able to predict outcome values on previously unseen data. A model with the ideal complexity is the one that produces the lowest generalization error. Since there is no knowledge of the test data and how well the model will perform, the generalization error of the induced model needs to be estimated.

### Occam's Razor

- Given two models of similar generalization errors, one should prefer the simpler model over the more complex model.
- For complex models, there is a greater chance that it was fitted accidentally by errors in data. Therefore, one should include model complexity when evaluating a model.

### Pessimistic Error Estimate

Explicitly compute the generalization error as the sum of no. of training errors and a penalty term for model complexity.

$$
e'(T) = e(T) + \Omega(T)
$$

In a decision tree, we can define a penalty term of $k > 0$ on each leaf node:

$$
e'(T) = e(T) + N \times k
$$

where $N$ is the total number of leaf nodes.

### Using a Validation Set

- Divide the original training dataset into two subsets &mdash; one for training and the other (i.e. validation set) is for estimating the generalization error.
- The complexity of the best model can be estimated using the performance of the model on the validation set.

## Addressing Overfitting

### Pre-Pruning (Early Stopping Rule)

- Stop the algorithm before it becomes a fully-grown tree.
- Typical stopping conditions for a node:
    - Stop if all instances belong to the same class.
    - Stop if all the feature values are the same.
- More restrictive stopping conditions for a node:
    - Stop if the number of instances is less than some user-specified threshold.
    - Stop if the class distribution of the instances is independent of the available features.
    - Stop if expanding the current node does not improve impurity measures.

### Post-Pruning

- Grow decision to its entirety and trim the nodes in a bottom-up fashion.
- If generalization error improves after trimming, replace the sub-tree with a new leaf node. The class label of this leaf node is determined from the majority class of the instances in the sub-tree.
