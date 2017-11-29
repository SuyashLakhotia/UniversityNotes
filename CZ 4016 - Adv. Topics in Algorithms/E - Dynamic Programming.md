# Dynamic Programming

- Computation method based on sequencing, reuse and recombination of sub-problems.
- DP solution can support analysis of reducible problems.
- Provides first line of defense against complex problems.

## Top-Down (Memoization)

```
F[0] = 0;
F[1] = 1;
F[2...n] = -1;

FibDP(n) {
    if (n == 0 || n == 1)
        return F[n];

    if (F[n] < 0)
        F[n] = FibDP(n - 1) + FibDP(n - 2);

    return F[n];
}
```

## Bottom-Up

```
F[0] = 0;
F[1] = 1;
F[2...n] = -1;

FibDP(n) {
    for (i = 1 to i = n)
        F[i] = F[i - 1] + F[i - 2];

    return F[n];
}
```

## DP Elements

- Optimal sub-structure
- Overlapping sub-problems
- Memoization (trading space for time)
- "Side information" for optimal solution reconstruction

A problem exhibits **optimal sub-structure**, if an optimal solution can be (re)constructed from optimal solutions to sub-problems.

## DP Process

- Characterize the structure of the optimal solution
    - Solution definition by recursion (or iteration)
    - Identify any sharing in recursion (or iteration) steps
    - Optimal sub-structure + overlapping sub-problems
- Recursively/iteratively define the value of an optimal solution
- Compute the value of an optimal solution (exploit implicit DAG)
    - Memoization/Top-Down vs. Bottom-Up approach
- Construct an optimal solution from computed information
    - Extract the solution from the graph's topological order
    - Is there enough "side information" to recover argument of the optimum?

## Examples

See Lecture Notes for example problems solved by dynamic programming.
