# Analysis

## Growth of Functions

**Assumption:** All functions are non-negative.

### O-Notation

$$
\begin{split}
O(g(n)) = \{f(n) \enspace | \enspace \exists c > 0, \exists n_0 \text{ s.t. } \forall n > n_0 : \\ 0 \leq f(n) \leq cg(n)\}
\end{split}
$$

We say that $f(n)$ is **asymptotically upper bound** by $g(n)$, when $f(n) \in O(g(n))$ (also written as $f(n) = O(g(n))$).

### $\Omega$-Notation

$$
\begin{split}
\Omega(g(n)) = \{f(n) \enspace | \enspace \exists c > 0, \exists n_0 \text{ s.t. } \forall n > n_0 : \\ 0 \leq cg(n) \leq f(n)\}
\end{split}
$$

We say that $f(n)$ is **asymptotically lower bound** by $g(n)$, when $f(n) \in \Omega(g(n))$ (also written as $f(n) = \Omega(g(n))$).

### $\Theta$-Notation

$$
\begin{split}
\Theta(g(n)) = \{f(n) \enspace | \enspace \exists c > 0, \exists n_0 \text{ s.t. } \forall n > n_0 : \\ 0 \leq c_1 g(n) \leq f(n) \leq c_2 g(n)\}
\end{split}
$$

We say that $f(n)$ is **asymptotically tight bound** by $g(n)$, when $f(n) \in \Theta(g(n))$ (also written as $f(n) = \Theta(g(n))$).

$$
f(n) = \Theta(g(n)) \implies f(n) = O(g(n)) \text{ and } f(n) = \Omega(g(n))
$$

## Alternative Notation

### O-Notation

$$
O(g(n)) = \Bigg\{f(n) \enspace | \enspace \limsup_{n \to \infty} \frac{f(n)}{g(n)} = \lim_{n \to \infty} \sup_{m > n} \frac{f(m)}{g(m)} < \infty \Bigg\}
$$

### $\Omega$-Notation

$$
\Omega(g(n)) = \Bigg\{f(n) \enspace | \enspace \liminf_{n \to \infty} \frac{f(n)}{g(n)} = \lim_{n \to \infty} \inf_{m > n} \frac{f(m)}{g(m)} > 0 \Bigg\}
$$

### Simplification

If $\lim_{n \to \infty} \frac{f(n)}{g(n)}$ exists, no need for $\sup$ and $\inf$.

#### Corollary

If $\lim_{n \to \infty} \frac{f(n)}{g(n)}$ is well-defined and equals $\xi$, then:

- if $\xi < \infty$, then $f(n) = O(g(n))$
- if $\xi > 0$, then $f(n) = \Omega(g(n))$
- if $0 < \xi < \infty$, then $f(n) = \Theta(g(n))$

## Comparing Functions

### Transitivity

$$
\begin{split}
f(n) = O(g(n)) \text{ and } g(n) = O(h(n)) &\implies f(n) = O(h(n)) \\
f(n) = \Omega(g(n)) \text{ and } g(n) = \Omega(h(n)) &\implies f(n) = \Omega(h(n)) \\
f(n) = \Theta(g(n)) \text{ and } g(n) = \Theta(h(n)) &\implies f(n) = \Theta(h(n))
\end{split}
$$

### Reflexivity

$$
\begin{split}
f(n) &= O(f(n)) \\
f(n) &= \Omega(f(n)) \\
f(n) &= \Theta(f(n))
\end{split}
$$

### Symmetry

$$
f(n) = \Theta(g(n)) \text { iff } g(n) = \Theta(f(n))
$$

### Transpose Symmetry

$$
f(n) = O(g(n)) \text { iff } g(n) = \Omega(f(n))
$$

## Chaining & Composing Algorithms

### Big-O

Let $f_1(n) = O(g_1(n))$ and $f_2(n) = O(g_2(n))$, then:

$$
\begin{gathered}
f_1(n) + f_2(n) = O(g_1(n) + g_2(n)) = O(\max(g_1(n), g_2(n))) \\
f_1(n) \cdot f_2(n) = O(g_1(n) \cdot g_2(n))
\end{gathered}
$$

### Big-$\Theta$

Let $f_1(n) = \Theta(g_1(n))$ and $f_2(n) = \Theta(g_2(n))$, then:

$$
\begin{gathered}
f_1(n) + f_2(n) = \Theta(g_1(n) + g_2(n)) = \Theta(\max(g_1(n), g_2(n))) \\
f_1(n) \cdot f_2(n) = \Theta(g_1(n) \cdot g_2(n))
\end{gathered}
$$

## Recurrence

### Generic Substitution Method

Solve for $T(n) = T(n_1) + T(n_2) + T(n_3) + \hdots + T(n_k) + g(n)$, where $n_i < n$ and $g(n)$ is a known function.

Method: Guess a function, $T(n) = f(n)$ and substitute it into the recurrence step.

If $f(n)$ is too **high order**, then for large $n$, the l.h.s grows much faster than the r.h.s.

$$
f(n) \gg f(n_1) + \hdots + f(n_k) + g(n)
$$

If $f(n)$ is too **low order**, then for large $n$, the l.h.s grows much slower than the r.h.s.

$$
f(n) \ll f(n_1) + \hdots + f(n_k) + g(n)
$$

Correct $f(n)$ will **balance**:

$$
f(n) \approx f(n_1) + \hdots + f(n_k) + g(n)
$$

### Iteration Method

Expand the recurrence steps and collapse to a form that incorporates the base step on the r.h.s. Then, simplify and conclude.

### Master Method

Operates on any recurrence of the form:

$$
T(n) = a \cdot T \Bigg(\frac{n}{b} \Bigg) + f(n)
$$

- $a \geq 1$ and $b > 1$ are constants.
- $f(n)$ represents the cost of dividing the problem and/or combining the results of subproblems.
- $a \cdot T(\frac{n}{b})$ is the cost of solving a subproblem of size $\frac{n}{b}$ (floor or ceiling of this value i.e. an integer).

#### Theorem

- If $f(n) = O(n^{\log_b a - \epsilon})$ for some constant $\epsilon > 0$, $T(n) = \Theta({n^{\log_b a}})$.
- If $f(n) = \Theta(n^{\log_b a})$, $T(n) = \Theta({n^{\log_b a}} \lg n)$.
- If $f(n) = \Omega(n^{\log_b a + \epsilon})$ for some constant $\epsilon > 0$, and if $af(n / b) \leq cf(n)$ for some $c < 1$ and all $n > n_0$, $T(n) = \Theta(f(n))$.

![Master Theorem](img/Master%20Theorem.png)

## Examples

See Lecture Notes for examples.
