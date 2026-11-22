# Why consulting the selected input bit costs a cubic number of wires

Use $n$ physical bits $X$, $n+1$ physical bits $Y$, $i=|X|$ and $x_0=0$. Minimize directed wires in a shared compressed SDD whose vtree root is $X\mid Y$, allowing every order and subtree shape on the two sides. On this class of trees the two optimal sizes are
$$
[y_i=x_i]:\quad\Theta(n^3),\qquad y_i:\quad\Theta(n^2).
$$
The first predicate is the **original** generalized HWB on its full domain. Its upper bound on one such vtree is Bova's. The cubic lower holds on every such vtree. [Bova, eq. (7) and Lemma 1](https://cdn.aaai.org/ojs/10107/10107-13-13635-1-2-20201228.pdf)

### Proof

A compressed decision has exactly one left prime for each attainable right function. At the root the positive response $y_i$ for $0<i<n$ forces the prime $[|X|=i]x_i$. For a subtree of labels $W$ write $m=|W|$, $E_t^W=[|X_W|=t]$ and $G^W_{i,t}=x_i E_t^W$. If $i\in W$, $1\le t<m$ and $0\le i-t\le n-m$, the circuit must contain $G^W_{i,t}$. To descend, choose an exterior assignment of the required weight. Where the mark goes right, a fixed left weight selects exactly the corresponding marked right sub. Where it goes left, the nonzero right response at the chosen right weight has exactly the marked left fiber. Feasibility keeps the mark and an available zero in the subtree, so the needed nonconstant gate cannot disappear.

At $W=L\sqcup R$ put $p=|L|$, $s=|R|$, $p'=p-[i\in L]$, $s'=s-[i\in R]$. Fixing $x_i=1$ and splitting $t-1$ remaining ones across the two capacities gives at least
$$
1+\min(p',s',t-1,m-t)
$$
distinct nonzero right responses. Each costs an incoming wire. Different interior targets have disjoint nonempty supports. At one target, a set of $t$ positions containing one mark and omitting another separates their functions. Each gate depends on every bit of $W$, so charges at different subtrees also go to distinct gates. This counts wires in the shared DAG itself.

For $n\ge128$ set $u=\lfloor n/64\rfloor$. Follow larger children, counting from the first node of size at most $3n/4$ until the size first falls below $n/4$ (exclude that last node). The smaller-child sizes $\delta$ sum to more than $n/8$. Each counted node contains at least $8u$ labels in $[4u,n-4u]$. Each such mark has at least $2u$ feasible targets in $[u,m-u]$: the full feasible interval has $1+\min(i,n-i,m,n-m)\ge4u+1$ targets. Each retained pair costs at least $\min(\delta,u)\ge u\delta/n$. Summing gives at least $2u^3$ wires, as required.

For $y_i$ alone the marks disappear. Every exact-weight predicate is forced at each subtree. Across its gates the feasible child weight pairs give at least $(p+1)(s+1)$ incoming wires. Each pair of leaves has one lowest common ancestor, so $\sum ps=\binom n2$. A right-linear tree shares the exact-weight predicates for every suffix and remaining count in $O(n^2)$ wires, proving the matching comparison.

**Dependency.** The proof uses forced fibers, marked-weight transport and charging a physical gate once. The [tournament theorem](tournament.md) motivated the response-table viewpoint. Neither its word classification nor the [smaller coded witness](generalized-code.md) enters the lower bound.

### Full proof and verification

[Complete written proof (PDF)](separated-vtree-proof.pdf) · [Lean source and replay instructions (ZIP)](separated-vtree-lean.zip)

`SelectionCost.lean` checks local forced-class, marked-weight and counting lemmas. Propagation through the shared DAG and the global cubic and quadratic wire bounds are written proofs.

From the extracted directory with the pinned Lean 4.34.1 toolchain, run:

```sh
sha256sum -c SHA256SUMS
lean SelectionCost.lean
```

[Research map](../README.md)
