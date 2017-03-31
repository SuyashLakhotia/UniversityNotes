# Overview of Supervised Learning

- In supervised learning, the examples presented to a computer are pairs of inputs and the corresponding outputs (i.e. labelled training data).
- The goal is to *learn* a **map** or a **model** from inputs to labels.
- Given a set of $\{x_i, y_i\}$ (i.e. labelled training data) for $i = 1, ... , N$ where $x_i = [x_{i1}, x_{i2}, ... , x_{im}]$ (i.e. a vector of features) and $y_i$ (i.e. output) is a scalar, the goal is to learn a mapping $f:x \rightarrow y$ (i.e. classifier) by requiring $f(x_i) = y_i$.
- The learned mapping $f$ is expected to be able to make precise predictions on any unseen $x^*$ as $f(x^*)$.

## Classification vs. Regression

- In classification problems, $y$ is discrete.
    - If $y$ is binary, then it is a binary classification problem.
    - If $y$ is nominal but not binary, then it is a multi-class classification problem.
- In regression problems, $y$ is continuous.

## Typical Learning Procedure

**Inductive Learning** consists of two phases:

1. Training Phase
    - Given labelled training data, apply supervised learning algorithms to learn a model $f$ such that $f(x_i) = y_i$.
2. Testing or Prediction Phase
    - Given unseen test data $x_i^*$, use the trained model $f$ to make predictions for $f(x_i^*)$.


**Lazy Learning** involves taking an unseen test data $x_i^*$ and using an algorithm to find the appropriate $\{x_i, y_i\}$ pair from the training data to output a predicted label $y^*$.

## Evaluation of Supervised Learning

- The learned predictive model should be able to make predictions on previously unseen data as accurately as possible.
- The whole training data is usually divided into *training* and *test* sets.
- The training set is used to learn the predictive model and the test set is used to validate the performance of the learned model.
- **Common Evaluation Metrics:**
    - Classification: Accuracy, Error Rate, F-Score etc.
    - Regression: Mean Absolute Error (MAE), Root Mean Squared Error (RMSE)
- **Splitting Training Data to Disjoint Training & Evaluation Sets:**
    - Random Subsampling: Randomly sample a fraction of the data for evaluation and the rest for training. Repeat this process for several iterations.
    - Cross Validation: Divide the entire dataset into `k` subsets of the same size. Hold aside one subset for evaluation and use the others to build the model. Traverse through all the subsets, changing the training subset at each iteration. For example, a five-fold cross validation will have five iterations.
    - Bootstrap: Similar to random subsampling, however, the training set is sampled with replacement (i.e. duplicate samples allowed).
