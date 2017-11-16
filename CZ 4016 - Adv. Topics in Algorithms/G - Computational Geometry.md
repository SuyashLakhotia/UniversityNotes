# Computational Geometry

- A branch of computer science that studies algorithms for solving geometric problems.

Used for:

- Computer Graphics: hidden line removal, solid modeling
- Robotics: path planning, collision-avoidance
- VLSI Design: intersection detection
- Mobile Communications: mobile ad hoc routing, triangulation
- Geographic Information Systems, CAD/CAM, Statistics, Linguistic Analysis etc.

How to study it?

- Top-down w/ Memoization
    - Decompose a large problem and study individual components, until you understand the whole.
- Bottom-up
    - Study elementary (but initially boring) components and then keep combining them into infinitely more interesting problems.

## Vectors, Segments, Planes & Turns

- **Point** $p = (x, y) \in \mathbb{R}^2$
- **Segment** between two points $\overline{p_1 p_2}$
- **Directed Segment** from $p_0$ to $p_1$: $\overrightarrow{p_0 p_1}$
    - A **vector** $\overrightarrow{p} = \overrightarrow{(x, y)}$ is a directed segment from point $(0, 0)$ to point $p = (x, y)$.
- A **convex combination** of points $p_1, \cdots, p_n$ is any point of the form:

$$
p = \sum_{i = 1}^n \alpha_i p_i \text{, where } \alpha_i \geq 0 \text { and } \sum_{i = 1}^n \alpha_i = 1
$$

- A **line** is given by an equation of the form $ax + by + c = 0$.
    - Positive half-plane are all points that satisfy $ax + by + c > 0$
    - Negative half-plane are all points that satisfy $ax + by + c < 0$

- **Cross Product** of vectors $\overrightarrow{p_1}$ and $\overrightarrow{p_2}$:
    - If $p_1 \times p_2 > 0$, then $p_1$ is clockwise from $p_2$ w.r.t $(0, 0)$.
    - If $p_1 \times p_2 < 0$, then $p_1$ is counter-clockwise from $p_2$ w.r.t $(0, 0)$.
    - If $p_1 \times p_2 = 0$, then $p_1$ and $p_2$ are colinear.
    - The magnitude of the cross product can be interpreted as the positive area of the parallelogram contained by $\overrightarrow{p_1}$ and $\overrightarrow{p_2}$.

$$
\begin{split}
p_1 \times p_2
&= \text{det} \begin{pmatrix} x_1 & x_2 \\ y_1 & y_2 \end{pmatrix} \\
&= \begin{vmatrix} x_1 & x_2 \\ y_1 & y_2 \end{vmatrix} \\
&= x_1 y_2 - x_2 y_1 \\
&= -p_2 \times p_1
\end{split}
$$

## Convex Hull

### Convex Set

A set $C \subseteq \mathbb{R}^2$ is **convex** if for any $p_1, p_2 \in C$ holds $\overline{p_1 p_2} \subseteq C$.

### Convex Hull

A **convex hull** of a set of points $S \subseteq \mathbb{R}^n$ is:

- the smallest convex set that includes $S$
- the intersection of all convex sets that include $S$
- the set of all convex combinations of points in $S$

### Theorem 1 - Convex Polyhedra

For a finite $S$, the convex hull of $S$ is a polyhedron and its vertices are a subset of $S$.

### Corollary 2 - Caratheodory Theorem

Let $S$ be a finite set in $\mathbb{R}^n$. For any $p \in CH(S)$, there is a subset $S' \subset S$ of size $|S'| = n + 1$ so that $p \in CH(S')$.

### Lemma 3 - Compound Convex Hull

Given two finite sets $S_1, S_2 \in \mathbb{R}^n$, holds $CH(S_1 \cup S_2) = CH(CH(S_1) \cup CH(S_2))$.

Proof is given in the Lecture Notes.

## Finding Convex Hulls

Refer to Lecture Notes for algorithms to find $CH(S)$ for finite $S \in \mathbb{R}^2$ and their respective proofs.

## Path Planning

Refer to Lecture Notes.

## Finding Closest Points

Refer to Lecture Notes.
