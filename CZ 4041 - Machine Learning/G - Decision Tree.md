# Decision Tree

A decision tree is used to query particular features at particular points in the tree to come to a decision about the classification of the current $\boldsymbol{X}$. The tree has to be *induced* from the training data and can then be used to *deduce* classifications. There can be more than one tree that fits the same data.

## Induction Algorithms

A tree can be learned by splitting training data into subsets based on outcomes of a feature test. This process is recursively applied on each derived subset until the subset at a node has the same value for the target variable or there is no improvement for prediction.

## Hunt's Algorithm

Hunt's algorithm grows a decision tree in a recursive fashion by partitioning the training records into successively purer subsets. A pure subset is one where the label (i.e. value of $Y$) is the same for all records.

Let $D_t$ be the set of training records that reach a node $t$.

- If $D_t$ contains records that belong to the same class $y_t$, then $t$ is a leaf node labelled as $y_t$.
- Else, if $D_t$ is an empty set, then $t$ is a leaf node labelled by the default class $y_d$.
- Else, if $D_t$ contains records that belong to more than one class of $Y$, then a feature is selected to conduct a conditional test to split the data into smaller subsets.
    - A child node is created for each outcome of the test condition and the records in $D_t$ are distributed to the children based on the outcome.
    - This procedure is recursively applied to each subset.

## Specifying the Split

- Splitting based on binary features will split the $D_t$ into two subsets.
- Splitting based on categorical features can be done in one of two ways:
    - A multi-way split uses as many partitions as distinct values.
    - A binary split divides $D_t$ into two subsets for two distinct sets of possible values of the feature.
- Splitting based on continuous features can be done in one of two ways:
    - A binary split divides $D_t$ into two subsets for two distinct ranges of possible values of the feature. $(X_j < v) \text{ or } (X_j \geq v)$.
    - A multi-way split divides $D_t$ into multiple distinct ranges of possible values of the feature. May be very computationally intensive.

## Determining the Best Split

Intuitive Idea: Nodes with **homogeneous** class distribution is preferred.

A split criterion can be defined in terms of the difference in degrees of node impurity before and after splitting. This impurity can be measured using the entropy at a given node $t$:

$$
\text{Entropy}(t) = - \sum_{y_k} P(Y = y_k | t) \log_2 P(Y = y_k | t)
$$

- Maximum: $\log_2 K$, where $K$ is the total number of all possible values of $Y$ i.e. records are equally distributed among all classes i.e. least information.
- Minimum: $0$ i.e. when all records belong to one class i.e. most information.

\vfill
\begin{center}
P.T.O
\end{center}
\vfill

### Best Split on Information Gain

Suppose a parent node $t$ is split into $P$ partitions, the information gain:

$$
\delta_{\text{info}} = \text{Entropy}(t) - \sum_{j = 1}^{k} \frac{n_j}{n}\text{Entropy}(j)
$$

where $n_j$ represents the number of examples at child $j$ and $n$ represents the number of examples at node $t$.

The feature test that maximizes the information gain must be chosen as it minimizes the weighted average impurity measures of the child nodes.

However, a disadvantage is that splitting based on entropy tends to prefer splits that result in a large number of partitions, each being small but pure.

### Gain Ratio

$$
\delta_{\text{InfoR}} = \frac{\delta_{\text{info}}}{\text{SplitINFO}}
$$

$$
\text{SplitINFO} = - \sum_{i = 1}^{k} \frac{n_i}{n} \log_2 \frac{n_i}{n}
$$

where $n$ is total number of records in the parent node $t$ and $n_i$ is the number of records in partition $i$.

By using the gain ratio to adjust information gain, higher entropy partitioning (i.e. large number of small partitions) is penalized.

## Stopping Criteria for Tree Induction

- Stop expanding a node when all the records belong to the same class.
- Stop expanding a node when all the records have similar attribute values.
- Use early termination.

## Notes

- Decision tree classifiers are easy to interpret and efficient in both, training & testing.
- They are used as a base classifier in many ensemble learning approaches.
