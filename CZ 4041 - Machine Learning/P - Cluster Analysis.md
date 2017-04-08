# Cluster Analysis

## What is Cluster Analysis?

Finding groups of objects such that the objects in a group will be similar (or related) to one another and different from (or unrelated to) the objects in the other groups. Intra-cluster distances are minimized whereas inter-cluster distances are maximized.

### Measurements & Distances

Any technique for clustering needs a measure of distance between items. The distance $d_i$ between two objects $x_i$ and $x_j$ can be calculated using the Euclidean distance between two points of $p$ dimensions.

$$
d_{ij} = \sqrt{(x_{i1} - x_{j1})^2 + (x_{i2} - x_{j2})^2 + \cdot \cdot \cdot + (x_{ip} - x_{jp})^2}
$$

The Euclidean distance is an example of a dissimilarity measure. However, it may be more convenient to work with a similarity measure, such as the square of the correlation coefficient:

$$
r_{ij}^2 = \frac{\sum\limits_{m = 1}^p (x_{im} - \bar{x}_m) (x_{jm} - \bar{x}_m)}{\sqrt{\sum\limits_{m = 1}^p (x_{im} - \bar{x}_m)^2 \sum\limits_{m = 1}^p (x_{jm} - \bar{x}_m)}}
$$

where $\bar{x}_m$ is the mean of the $m$ dimension between the two points.

### Application of Clustering in Image Segmentation

- There is a need for data reduction i.e. obtaining a compact representation for *interesting* image data in terms of a set of components.
- The aim is to find components that belong together (form clusters).

### Types of Clusterings

A **clustering** is a set of clusters. There are two main types of clusterings:

1. Partitional Clustering - non-overlapping subsets, each data object is in exactly one subset.
2. Hierarchical Clustering - nested clusters, organized as a hierarchical tree.

## K-means Clustering

K-means clustering is a partitional clustering approach, where each cluster is associated with a centroid (i.e. center point). Each point is assigned to the cluster with the closest centroid and the number of clusters (i.e. K) must be specified.

Algorithm:

1. Select K points as the initial centroids.
2. Repeat:
    a. Form K clusters by assigning all points to the closest centroid.
    b. Recompute the centroid of each cluster.
3. Stop when the centroids no longer change.

### Further Details

- The initial centroids are often chosen randomly and the clusters produced vary from one run to another.
- The centroid is (usually) the mean of the points in the cluster.
- 'Closeness' is measured by Euclidean distance, cosine similarity, correlation etc.
- K-means will converge for common similarity measures and most of the convergence happens in the first few iterations. Often, the stopping condition may be changed to "Stop when relatively few points change clusters".
- Complexity is $O(n \times K \times I \times d)$, where $n$ = number of points, $K$ = number of clusters, $I$ = number of iterations, $d$ = number of attributes.

### Problems with Selecting Initial Points

If there are K 'real' clusters, then the chance of selecting one centroid from each cluster is small. The chance is relatively small when K is large and it is not guaranteed that the centroids will readjust themselves in the right way. To solve this, the following methods can be used:

1. Multiple runs.
2. Use hierarchical clustering to determine initial centroids.
3. Select more than K initial centroids (that are widely separated) and then select among these initial centroids.

### Evaluating K-means Clusters

The most common measure is Sum of Squared Error (SSE), where the error for each point is the distance to the nearest cluster.

$$
SSE = \sum\limits_{i = 1}^K \sum\limits_{x \in C_i} d(m_i, x)^2
$$

where $x$ is a data point in cluster $C_i$ and $m_i$ is the representative point for cluster $C_i$.

### Limitations of K-means

K-means has problems when:

1. Clusters are of different sizes or densities.
2. Data contains outliers.
3. The number of clusters (i.e. K) is difficult to determine.

## Hierarchical Clustering

Hierarchical clustering produces a set of nested clusters organized as a hierarchical tree and can be visualized as a dendogram.

![Hierarchical Clustering](img/Hierarchical%20Clustering.png)

### Strengths of Hierarchical Clustering

- There is no assumption about the number of clusters and any desired number of clusters can be obtained by *cutting* the dendogram at the appropriate level.
- The clustering may correspond to meaningful taxonomies (e.g. animal kingdom).

### Types of Hierarchical Clustering

1. Agglomerative: Start with the points as individual clusters and at each step, the closest pair of clusters is merged until one cluster (or $k$ clusters) are left.
2. Divisive: Start with one, all-inclusive cluster and at each step, split a cluster until each cluster contains one point (or there are $k$ clusters).

### Agglomerative Hierarchical Clustering

Algorithm:

1. Compute the proximity matrix.
2. Let each data point be a cluster.
3. Repeat:
    a. Merge the two closest clusters.
    b. Update the proximity matrix.
4. Stop when only one cluster remains.

The key operation is the computation of proximity between two clusters. The different approaches to calculate this proximity distinguish the different algorithms.

#### Inter-Cluster Similarity

1. MIN (Single Linkage): Similarity of two clusters is based on the two most similar (i.e. closest) points in the different clusters. Hence, this inter-cluster similarity is only determined by one pair of pints i.e. by one link in the proximity graph.

$$
d(A, B) = \min_{a \in A, b \in B} d(a, b)
$$

2. MAX (Complete Linkage): Similarity of two clusters is based on the two least similar (i.e. farthest) points in the different clusters. Hence, this inter-cluster similarity is determined by all pairs of points in the two clusters and a cluster is only formed when all points in the cluster are completely linked.

$$
d(A, B) = \max_{a \in A, b \in B} d(a, b)
$$

3. Group Average: Proximity of two clusters is the average of pairwise proximity between points in the two clusters. There is a need to use average connectivity for scalability since total proximity favors large clusters. This method is less susceptible to noise and outliers but is biased towards globular clusters.

$$
d(A, B) = \frac{1}{|A||B|} \sum_{a \in A, b \in B} d(a, b)
$$

4. Distance Between Centroids:

$$
d(A, B) = d(c_A, c_B)
$$

#### Time & Space Complexity

- $O(N^2)$ space complexity due to the proximity matrix (where $N$ is the number of points).
- $O(N^3)$ time complexity as there are $N$ steps and at each step, $N^2$ time is needed to search and update the proximity matrix. In some approaches, the time complexity can be reduced to $O(N^2 log(N))$.
