# Additional Notes for Multi-Class Classification Problems

Given a 3-class classification problem &mdash; $C_1$, $C_2$ & $C_3$, the following binary classifications can be performed:

1. Binary Classification 1: Positive ($C_1$) v.s. Negative ($C_2$ & $C_3$)
2. Binary Classification 2: Positive ($C_2$) v.s. Negative ($C_1$ & $C_3$)
3. Binary Classification 3: Positive ($C_3$) v.s. Negative ($C_1$ & $C_2$)

For a test instance $\boldsymbol{x^*}$, the results of each binary classification need to be combined to make a final prediction.

- Case 1: Suppose $f_i$ is a probabilistic model that outputs how likely an instance belongs to class $C_i$.
    - The final prediction will be based on which $f_i$ had the highest probability output.
- Case 2: Suppose $f_i$ only generates 0/1.
    - A voting table needs to be generated from the results of each $f_i$ and the class with the most votes is chosen.
    - Each $f_i$ will either generate a vote for $C_i$ or a vote for every class except $C_i$.
