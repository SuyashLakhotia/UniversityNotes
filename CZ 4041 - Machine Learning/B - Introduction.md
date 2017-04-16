# Introduction

## Definition

Machine learning is a type of artificial intelligence that provides computers with the ability to learn from examples and/or experience without being explicitly programmed.

## Different Paradigms

### Supervised Learning

- The examples presented to the computer are pairs of inputs (i.e. features) and the corresponding outputs (i.e. labels). Labelled training data.
- If the labels are discrete, it is a **classification** problem.
- If the labels are continuous, it is a **regression** problem.
- The goal is to *learn* a **model** that maps inputs to the correct labels.

$$
f:label = f(input)
$$

### Unsupervised Learning

- The examples presented to the computer are a set of inputs without any outputs. Unlabelled training data.
- The goal is to *learn* an **intrinsic structure** of the examples. For example, the goal in such problems may be to discover groups of similar examples within the data (i.e. clustering) or to determine the distribution of data within the input space (i.e. density estimation).

### Semi-Supervised Learning

- The examples presented to the computer include both labelled data and unlabelled data.
- The goal is to the utilize the unlabelled data to help supervised learning.
- More precise $f$.

### Active Learning

- The examples presented to the computer are unlabelled.
- An active learner (i.e. computer) may pose queries in the form of unlabelled examples to be labelled by an oracle (e.g. human annotator).

### Transfer Learning

- The goal is to adapt the same learning to different tasks, environments or agents.

### Reinforcement Learning

- Learning by **interacting** with an environment to achieve a goal.
- The goal is to learn an optimal policy mapping states to actions.
