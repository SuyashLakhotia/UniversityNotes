# Lower Bounds

The objective is to prove that any algorithm for a given problem will have to perform at least $g(n)$ operations.

- $f(n)$ is an **upper bound** to solve $X$, if there is some algorithm with runtime $\leq f(n)$.
- $g(n)$ is a **lower bound** to solve $X$, if any algorithm has runtime $\geq g(n)$.
- An algorithm is **optimal** if its upper bound matches the lower bound of the problem.
    - If $A(n) = O(f(n))$ and any other algorithm $A'(n) = \Omega(f(n))$, then nothing is faster than A.
    - Also means that $g(n)$ is a tight bound since no lower bound can be higher.

## Why lower bounds?

- Stop looking for a better algorithm
- Structural problem analysis
    - Modeling assumption went awry
    - Generic features of hard instance
        - Focus speed-up efforts
        - Identify error tolerance
- Security
    - Cryptosystems
        - Breaking RSA requires efficient factoring of large numbers.
    - Social system manipulations
        - Skew voting results
        - Find triggers for cascade failures

## Examples

See Lecture Notes for example derivations of lower bounds.
