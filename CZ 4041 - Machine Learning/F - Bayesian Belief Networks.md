# Bayesian Belief Networks

When two features are correlated, the conditional independence assumption for Naive Bayes Classifier does not hold true.

$$
P(X_1, X_2 | Y) \neq P(X_1 | Y) \times P(X_2 | Y)
$$

BBNs provide a more flexible approach for modeling the likelihood probabilities $P(\boldsymbol{X} | Y)$. A Bayesian network provides a graphical representation of the probabilistic relationships among a set of random variables.

There are two key elements:

1. A directed acyclic graph (DAG) encoding the dependence relationships among a set of variables.
2. A probability table associating each node to its immediate parent nodes.

## BBN Directed Acyclic Graph

Considering three random variables $A$, $B$ & $C$, where $A$ and $B$ are independent variables and each has a direct influence on $C$:

- There will be a directed arc from $A$ to $C$ and $B$ to $C$ in the DAG.
- $A$ & $B$ are parents of $C$.
- $C$ is the child of $A$ & $B$.

## Conditional Independence

- A node in a Bayesian network is **conditionally independent** of its non-descendants, if its parents are known.
- A Naive Bayes Classifier can be represented using a Bayesian network where $Y$ is the parent to all the features in $\boldsymbol{X}$.

## BBN Representation

Besides the conditional independence conditions imposed by the network topology, each node is also associated with a probability table.

- If a node $X$ does not have any parents, then the table contains only the prior probability $P(X)$.
- If a node $X$ has only one parent $Z$, then the table contains the conditional probability $P(X | Z)$.
- If a node $X$ has multiple parents $\{Z_1, Z_2, \hdots Z_k\}$, then the table contains the conditional probability $P(X | Z_1, Z_2, \hdots Z_k)$.

## BBN Model Building

- Step 1: Create the structure of the network.
    - Network topology can be obtained by encoding the subjective knowledge of domain experts;
    - Or can be learned from data (structure learning).
- Step 2: Estimate the probability values in the table associated with each node.

## Inference from BBNs

Given a BBN and an inference problem:

1. Translate the problem into a probabilistic expression.
2. Based on the property of conditional independence, find all dependent variables to the probabilities being estimated.
3. If the probabilities to be estimated cannot be obtained directly from the probability tables of the BBN, apply the Sum Rule, Product Rule and/or Bayes Theorem to decompose the probabilities until all decomposed probabilities can be obtained from the tables.

## Notes

- BBN provides an approach for capturing the prior knowledge of a specific domain using a directed graphical model.
- Network construction, however, is time consuming as it requires domain knowledge or a system that can learn structure from data.
