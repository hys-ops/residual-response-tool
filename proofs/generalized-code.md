# How many logical inputs suffice for Bova's witness?

Let $X=(x_1,\ldots,x_n)$, $Y=(y_0,\ldots,y_n)$, $i=|X|$ and $x_0=0$. Bova's generalized hidden weighted bit is $F_n(X,Y)=[x_i=y_i]$. Setting every $y_i=1$ recovers ordinary HWB. Keep Bova's $2n$ left primes: the extreme weights, and for each $0<i<n$ the two classes of inputs of weight $i$ distinguished by $x_i$. Require distinct right responses and a designated setting giving ordinary HWB. **For $n\ge2$, the minimum number of logical auxiliary bits in such a recoding is**
$$
q=\left\lceil\log_2\bigl(1+\lceil\log_2 n\rceil\bigr)\right\rceil .
$$
This recodes the auxiliary input on a smaller domain. The original function still has $n+1$ independently assignable $Y$ coordinates. [Bova, AAAI 2016, eq. (7), Lemmas 1–2 and Theorem 4](https://cdn.aaai.org/ojs/10107/10107-13-13635-1-2-20201228.pdf)

### Proof

A response to $q$ logical bits is a truth table of length $2^q$. Exactly $2^{2^q-1}$ such tables take a prescribed value at one designated setting. There are $n$ primes of each designated sign. Hence $2^{2^q-1}\ge n$ is necessary. More generally, at $r$ distinct prescribed settings the exact condition is $2^q\ge r$ and $2^{2^q-r}\ge m$, where $m$ is the largest number of primes sharing the same prescribed signature. Assign different suffixes to the members of each signature class to attain it.

Here is an explicit substitution attaining the one-setting bound. Give the $n-1$ interior weights distinct binary codes of length $\lceil\log_2 n\rceil$, and give the two extreme weights one further, shared code. Let $C_i(0)=1$. At addresses $1,\ldots,\lceil\log_2 n\rceil$ let $C_i$ return the corresponding code digit; use 1 at spare addresses. On input $(X,z)$ compute
$$
\widetilde F_n(X,z)=[x_{|X|}=C_{|X|}(z)] .
$$
The right functions are $C_i$ and their complements as selected by the prime. The designated setting separates the two signs. Distinct codes distinguish same-sign responses. The two endpoints sharing a code have opposite signs because $x_0=0$ and $|X|=n$ forces $x_n=1$. The root is therefore compressed.

Use Bova's left prime circuits verbatim. A truth table for each right sub costs $O(2^q)$ wires on a common order, giving $O(n^3+n2^q)=O(n^3)$ compressed-SDD wires. Conditioning $z=0$ preserves an ordinary HWB cofactor, so every OBDD has $2^{\Omega(n)}$ size. These are Bova's separation rates. The improvement concerns the exact auxiliary dimension under the stated requirements.

**Where the tournament is actually used.** At depth $d=n-1$, give the interior weight $\lceil d/2\rceil$ the all-zero code. Every digit row now has center zero, and the other rows are all ones. The tournament classification proves that **each** code row can be produced by an exterior assignment. The coding theorem itself follows from table capacity. A single set of raw wires implementing the rows jointly requires a further theorem. At $n=128$ the logical budget is three. [Tournament classification](tournament.md) · [Joint raw implementation](raw-controls.md)

### Full proof and verification

[Complete written proof (PDF)](generalized-code-proof.pdf) · [Lean source and replay instructions (ZIP)](generalized-code-lean.zip)

`TagCapacity.lean` checks finite response capacity with a prescribed Boolean entry, including the three-versus-two case at $n=128$. The substituted circuit and OBDD restriction argument are written proofs.

From the extracted directory with the pinned Lean 4.34.1 toolchain, run:

```sh
sha256sum -c SHA256SUMS
lake update
lake exe cache get
lake env lean TagCapacity.lean
```

[Research map](../README.md)
