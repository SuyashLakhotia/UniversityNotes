# Model Selection

- In most pattern recognition techniques, there exist one or more free parameters (i.e. hyperparameters). For example, the learning parameters, number of hidden layers, number of hidden neurons etc.
- Every set of parameters for the network leads to a specific model.
- Therefore, it is necessary to find the set of parameters that leads to the optimum model.

## Performance Estimation

**Mean Square Error / Root Mean Square Error** for approximation.

$$
\text{MSE } = \frac{1}{P} \sum_{p = 1}^P \sum_{k = 1}^K (d_{pk} - y_{pk})^2
$$

$$
\text{RMSE } = \sqrt{\frac{1}{P} \sum_{p = 1}^P \sum_{k = 1}^K (d_{pk} - y_{pk})^2}
$$

**Misclassification Error** for classification.

$$
\text{ME } = \sum_{p = 1}^P 1(d_p \neq y_p)
$$

where $d_p$ is the target and $y_p$ is the predicted output of pattern $p$. $1(\cdot)$ is the indicator function.

## Terminology

- **Apparent Error** or training error is the error on the training data, which is what the learning algorithm tries to optimize.
- **True Error** is the error that will be obtained in use (over the whole sample space). This is what we want to optimize but is unknown.
- **Test Error** or out-of-sample error is an estimate of the true error obtained by testing the network on some independent data. Generally, a large test set helps provide a greater confidence on the accuracy of this estimate.

## Validation

While we want to minimize the error on the entire sample population, this is difficult as the entire sample population is often unavailable. Hence, in real applications, we use **validation**, in which a part of the available data, which is known as the *validation set*, is used to select the model and estimate the error rate.

Validation attempts to solve the following problems:

- The final model tends to *overfit* the training data.
- There is no way of knowing how well the model performs on unseen data.
- The error rate estimate will be overly optimistic (usually lower than the true error rate).

### Validation Methods

An effective approach is to split the entire data into subsets i.e. Training / Validation / Testing datasets. There are a few common validation methods:

1. Holdout (1/3 - 2/3 Rule)
2. Re-Sampling Techniques
    1. Random Subsampling
    2. K-Fold Cross Validation
    3. Leave-One-Out Cross Validation
3. Three-Way Data Split

## Holdout Method

Split entire dataset into two sets:

1. Training Set (2/3), which is used to train the classifier.
2. Testing Set (1/3), which is used to estimate the error rate of the trained classifier on unseen data samples.

### Drawbacks

- In problems where we have a sparse dataset, it may not be possible to set aside a portion of the dataset for testing.
- Since it is a single train-and-test experiment, the holdout estimate of error rate will be misleading if we happen to make an *unlucky split*.

## Re-Sampling Techniques

The drawbacks of holdout can be overcome using re-sampling techniques.

### Random Subsampling (K Data Splits)

- Split entire dataset into K splits where each split randomly selects a (fixed) number of examples.
- For each data split, the classifier is retrained from scratch with the training data.
- Estimate $e_i$ using the test data and compute the average test error:

$$
\frac{1}{K} \sum_{i = 1}^K e_i
$$

### K-Fold Cross Validation

- Split the dataset into K partitions (or folds).
- For each of the K experiments, use K - 1 folds for training and the remaining one fold for testing.
- The average test error is also known as the cross-validation error.
- The advantage of K-fold cross validation is that all the examples in the dataset are eventually used for training and testing.

### Leave-One-Out Cross Validation

- Leave-one-out is the degenerate case of K-fold cross validation, where K is chosen as the total number of examples.
- For a dataset with N examples, perform N experiments i.e. K = N.
- For each experiment, use N - 1 examples for training and the remaining one example for testing.

## Three-Way Data Split

If model selection and true error estimates are to be computed simultaneously, the data needs to be divided into three disjoint sets:

1. Training Set, which is used for learning.
2. Validation Set, which determines the error $J_m$ of different models $m$. For multi-layer perceptrons, the validation set is used to estimate the error rate of the model.
3. Training & Validation Set are combined to re-train the optimal model (i.e. lowest validation error).
4. Test Set, which is used only to assess the performance of the final optimal model.

**Why separate test and validation sets?**

- The error estimate of the final model on validation data will be biased (i.e. smaller than the true error rate) since the validation set is also used in the process of model selection.
- To assess the final model, an independent test set is required to estimate the true performance of the model.

## Model Complexity

**Complex models** are models with many adjustable weights and biases. They will be:

- more likely to be able to solve the required task
- more likely to memorize the training data without solving the task

**Simple models** can learn from the training data and are more likely to *generalize* over the entire sample space, assuming they don't underfit / under-learn.

## Overfitting

Overfitting occurs when the training error of the network is driven to a very small value at the expense of the test error. The network learns to respond correctly to the training inputs but is unable to generalize to produce correct outputs to novel inputs.

### Overcoming Overfitting

#### Early Stopping

The training of the network should be stopped when the test error starts to increase. Early stopping can be used in training with a validation set by stopping when the validation error is minimum.

#### Regularization of Weights

During overfitting, some weights attain large values to reduce the training error, which prevents the model from generalizing. In order to avoid this, a penalty term (i.e. regularization term) is added to the cost function.

$$
J_1(\boldsymbol{W}, \boldsymbol{b}) = J(\boldsymbol{W}, \boldsymbol{b}) + \beta_1 \sum_{i,j} |w_{ij}| + \beta_2 \sum_{i,j} (w_{ij})^2
$$

where $J(\boldsymbol{W}, \boldsymbol{b})$ is the standard cost function (i.e. m.s.e or cross-entropy) and $\beta_1$ & $\beta_2$ are known as $L_1$ & $L_2$ regularization constants respectively. These penalties discourage weights from attaining large values.

$$
\begin{gathered}
L_1 \text{ - norm} = \sum_{i,j} |w_{ij}| \\
L_2 \text{ - norm} = \sum_{i,j} (w_{ij})^2 \\
\end{gathered}
$$

#### L2 Regularization

For neural networks, regularization is usually not applied on bias terms and $L_2$ regularization is most popular.

$$
J_1(\boldsymbol{W}, \boldsymbol{b}) = J(\boldsymbol{W}, \boldsymbol{b}) + \beta_2 \sum_{i,j} (w_{ij})^2
$$

Gradient of the regularized cost w.r.t the weights:

$$
\begin{split}
\frac{\partial J_1}{\partial \boldsymbol{W}}
&= \frac{\partial J}{\partial \boldsymbol{W}} + \beta_2 \frac{\partial (\sum_{i,j} {w_{ij}}^2)}{\partial \boldsymbol{W}} \\
&= \frac{\partial J}{\partial \boldsymbol{W}} + 2 \beta_2 \boldsymbol{W}
\end{split}
$$

Gradient descent learning using the regularized cost function:

$$
\begin{split}
\boldsymbol{W}
&= \boldsymbol{W} - \alpha \frac{\partial J_1}{\partial \boldsymbol{W}} \\
&= \boldsymbol{W} - \alpha \Big(\frac{\partial J}{\partial \boldsymbol{W}} + \beta \boldsymbol{W}\Big) \\
\end{split}
$$

where $\beta = 2 \beta_2$ and is known as the weight decay parameter.

#### Dropouts

Deep neural networks with a large number of parameters are powerful learning machines. However, overfitting is a serious problem in deep neural networks.

The key idea of *dropouts* is to randomly drop neurons (along with their connections) from the network during training. This prevents neurons from co-adapting. The neurons are *present* with a probability $p$ during training and always present during testing.

Training is similar to standard networks, however, for mini-batch training, the training is applied on a *thinned network* with dropped-out units. The gradients of each parameter are averaged over the training cases in each mini-batch.
