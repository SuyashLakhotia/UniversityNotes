# Model Evaluation

The most widely-used evaluation metric is:

$$
\begin{split}
\text{Accuracy} &= \frac{\text{Number of Correct Predictions}}{\text{Total Number of Predictions}} \\[3ex]
                &= \frac{\text{TP } + \text{ TN}}{\text{TP } + \text{ FN } + \text{ FP } + \text{ TN}}
\end{split}
$$

$$
\begin{split}
\text{Error Rate} &= \frac{\text{Number of Wrong Predictions}}{\text{Total Number of Predictions}} \\[3ex]
                  &= \frac{\text{FP } + \text{ FN}}{\text{TP } + \text{ FN } + \text{ FP } + \text{ TN}}
\end{split}
$$

However, this metric has limitations. For example, if the training set has 99 examples of Class 0 and 1 example of Class 1, even if the model predicts everything as Class 0, it has an accuracy of 99%, which is misleading.

In many real-world applications, datasets may have imbalanced class distributions. Since accuracy measure treats every class as equally important, it may not be suitable for analyzing imbalanced datasets, especially where the rare class is considered more interesting than the majority class.

For binary classification, the rare class is often denoted as the positive class while the majority class is denoted as the negative class.

**Precision** and **Recall** are two widely used metrics in applications where successful detection of one of the classes is considered more significant than detection of the other classes. A good model should have both high precision and high recall.

## Precision

Precision is to measure among all the predicted positive instances, how many are true positive.

$$
p = \frac{\text{TP}}{\text{TP + FP}}
$$

## Recall

Recall is to measure among all the true positive instances, how many are predicted correctly by the classifier.

$$
r = \frac{\text{TP}}{\text{TP + FN}}
$$

## $F_1$-measure

Recall and Precision can be summarized into another metric known as $F_1$-measure:

$$
F_1 = \frac{2rp}{r + p}
$$

A high value of $F_1$-measure ensures that precision and recall are reasonably high.

\vfill
\begin{center}
P.T.O
\end{center}
\vfill

## Receiver Operating Characteristic (ROC)

ROC is a graphical approach to displaying the tradeoff between true positive rate and false positive rate of a classifier.

$$
\text{True Positive Rate: TPR } = \frac{\text{TP}}{\text{TP + FN}}
$$

$$
\text{False Positive Rate: FPR } = \frac{\text{FP}}{\text{TN + FP}}
$$

The ROC curve graphs (FPR, TPR).

- A value of (0, 0) declares everything to be negative class.
- A value of (1, 1) declares everything to be positive class.
- A value of (0, 1) is ideal.
- A value on the diagonal is random guessing.
- A value below the diagonal means the prediction is the opposite of the true class.

To compare two classifiers using the ROC, the area under the ROC curve must be compared as no classifier consistently outperforms the other. The area under the ROC curve should ideally be 1.

\vfill\eject

![ROC Curve](img/ROC%20Curve.png)
