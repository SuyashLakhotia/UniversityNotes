# Math Formulae

## Logarithms

$$
\begin{gathered}
\log xy = \log x + \log y \\
\log \frac{x}{y} = \log x - \log y \\
\log^n x = (\log x)^n = n \log x \\
\log_a a = 1 \\
\log_a a^x = x \\
a^{\log_a x} = x \\
a^{(\log_b c)} = c^{(\log_b a)} \\
\log_b a = \frac{\log_c a}{\log_c b} \\
\log_b \Big(\frac{1}{a}\Big) = - \log_b a \\
\log_b a = \frac{1}{\log_a b}
\end{gathered}
$$

## Derivatives

$$
\begin{aligned}
f(x) = c &\implies f'(x) = 0 \\
f(x) = x^n &\implies f'(x) = n \cdot x^{n - 1} \\
f(x) = c \cdot g(x) &\implies f'(x) = c \cdot g'(x) \\
f(x) = g(x) \pm h(x) &\implies f'(x) = g'(x) \pm h'(x) \\
f(x) = g(x)h(x) &\implies f'(x) = g'(x)h(x) + g(x)h'(x) \\
f(x) = \frac{g(x)}{h(x)} &\implies f'(x) = \frac{g'(x)h(x) - g(x)h'(x)}{h(x)^2} \\
f(x) = g(h(x)) &\implies f'(x) = g'(h(x))h'(x)
\end{aligned}
$$

### Trig Derivatives

$$
\begin{aligned}
f(x) = \sin(x) &\implies f'(x) = \cos(x) \\
f(x) = \cos(x) &\implies f'(x) = -\sin(x) \\
f(x) = \tan(x) &\implies f'(x) = \sec^2(x)
\end{aligned}
$$

### Exponential Derivatives

$$
\begin{aligned}
f(x) = a^x &\implies f'(x) = \ln{a} \cdot a^x \\
f(x) = e^x &\implies f'(x) = e^x \\
f(x) = a^{g(x)} &\implies f'(x) = \ln{a} \cdot a^{g(x)} \cdot g'(x) \\
f(x) = e^{g(x)} &\implies f'(x) = e^{g(x)} \cdot g'(x) \\
f(x) = g(x)^{h(x)} &\implies h(x) g(x)^{h(x) - 1} g'(x) + g(x)^{h(x)} \ln{g(x)} h'(x)
\end{aligned}
$$

### Logarithm Derivatives

$$
\begin{aligned}
f(x) = \log_a{x} &\implies f'(x) = \frac{1}{x \cdot \ln{a}} \\
f(x) = \ln{x} &\implies f'(x) = \frac{1}{x} \\
f(x) = \log_a{g(x)} &\implies f'(x) = \frac{g'(x)}{g(x) \ln{a}} \\
f(x) = \ln{g(x)} &\implies f'(x) = \frac{g'(x)}{g(x)}
\end{aligned}
$$

## Arithmetic & Geometric Series

### Sum of Arithmetic Series

$$
S_n = \frac{n}{2} (a + l)
$$

where $a$ is the first term and $l$ is the last (or $n^{\text{th}}$) term.

$$
\therefore S_n = \frac{n}{2} (a + (n - 1)d)
$$

where $d$ is the common difference.

### Sum of Geometric Series

$$
\begin{aligned}
S_n &= \frac{a(r^n - 1)}{r - 1} \quad \text{ if } r > 1 \\
S_n &= \frac{a(1 - r^n)}{1 - r} \quad \text{ if } r < 1
\end{aligned}
$$

where $a$ is the first term, $r$ is the common ratio ($\neq 1$) and $n$ is the number of terms.

#### Convergence

If $|r| < 1$, sum of an infinite series will be:

$$
S_n = \frac{a}{1 - r}
$$

## Limits

#### L'Hopital's Rule

If $\lim_{n \to \infty} f(n) = \lim_{n \to \infty} g(n) = 0, \pm \infty$, and $g'(n) \neq 0$, and also $\lim_{n \to \infty} \frac{f'(n)}{g'(n)}$ exists, then:

$$
\lim_{n \to \infty} \frac{f(n)}{g(n)} = \lim_{n \to \infty} \frac{f'(n)}{g'(n)}
$$
