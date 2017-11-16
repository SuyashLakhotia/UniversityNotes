# Search Techniques

Problem: Tree of possible sub-solutions to a problem may be huge, potentially infinite.

Solution: Build the tree as you search but stop building branches that are a priori bad.

## Smarter Search

- $S$: State space of partial solutions
    - $s_0 \in S$: Initial (empty) solution
- $g : S \rightarrow \{0, 1\}$: Goal function
    - Is $s \in S$ a complete, legal, feasible solution?
- $g : S \rightarrow 2^S$: Expansion function
    - How can a partial solution be expanded?

## Search (after construction)

![Search (after construction)](img/Search%20(after%20construction).png){width=250px}

Problem: Constructing the graph may go on indefinitely.

## Search (during construction)

![Search (during construction)](img/Search%20(during%20construction).png){width=250px}

## Search (background construction)

![Search (background construction)](img/Search%20(background%20construction).png){width=250px}

## Even Smarter Search

Let $W$ be an **ordered** set, a queue. Choosing $w \in W$ by removing the queue head:

- BFS Merge: $W = (W, f(W))$
- DFS Merge: $W = (f(W), W)$

## Backtracking

But Merge and $f$ can also **loose** some elements!

- Backtrack: Drop $w' \in f(w)$ if its subtree has no goal state.

### Domain Formulation Requirement

Merge drops expansion from $w$ if its subtree does not have the goal.

- $F_0(w) = \{w\}$, $F_{i + 1}(w) = \bigcup_{s \in F_i(w)} f(s)$
- $F^*(w) = \bigcup_{i = 0}^{\infty} F_i$
- If $g(s) == 0$ for all $s \in F^*(w)$, then Merge$(W, f(W)) = W$.

Alternatively,

- $F_0(w) = \{w\}$, $F_{i + 1}(w) = \bigcup_{s \in F_i(w)} f(s)$
- $F^*(w) = \bigcup_{i = 0}^{\infty} F_i$
- $H(s) == 0 \Longleftrightarrow \forall s \in F^*(w) \enspace g(s) == 0$

where $H$ is a heuristic function that can tell us if a goal does not exist in the extensions of a partial solution (i.e. the subtree of that partial solution). If $H(w) \enspace != 0$, we merge.

## Branch-and-Bound

For a generic goal function, $g : S \rightarrow \mathbb{R} \enspace \bigcup \enspace \{\infty\}$ (i.e. optimization), two conditions need to be fulfilled:

1. Do not stop for any complete solution.
2. Instead of checking goal reachability, check a bound on its quality.

Assume that $g(w) = \infty$ means it is an infeasible solution.

Redefining $H$ for minimization:

- $F_0(w) = \{w\}$, $F_{i + 1}(w) = \bigcup_{s \in F_i(w)} f(s)$
- $F^*(w) = \bigcup_{i = 0}^{\infty} F_i$
- $H(s) < \text{inf}\{g(s) | s \in F^*(w)\}$

where $H$ is the heuristic function that can determine the lower bound of all the solutions in the subtree to be expanded. The best possible solution thus far needs to be kept track of and we only merge if $H(w) < g(best)$.
