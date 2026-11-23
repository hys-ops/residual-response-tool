# The OBDD size of shifted indirect storage access

Let $m\ge1$, $n=2^m$, $1\le w\le n$, and $x_0,\ldots,x_{n-1}$ be a circular memory. An external $m$-bit address gives $a$. Reading the same physical memory twice, set
$$
p=\sum_{k=0}^{m-1}2^{m-1-k}x_{(a+k)\bmod n},\qquad
f(x,a,y)=\left[\ \forall\,0\le j<w:\ y_j=x_{(p+j)\bmod n}\ \right].
$$
Here $x_0$ is a real bit. In the free graph all $n+m+w$ inputs may be interleaved in any static order. With an answer word $W$ fixed in advance, only the $n+m$ memory and address bits remain. Size counts internal OBDD vertices. Write $B$ and $B_W$ for the minima over their respective orders. Put
$$
G=\min\{n/m,(n/w)\log_2(w+1)\},\qquad Z=(n/w)\log_2(1+w/m).
$$

| Predicate | Tight exponent |
| --- | --- |
| Free answer | $\log_2(B+2)=\Theta(w+G)$ |
| Easiest fixed answer | $\min_W\log_2(B_W+2)=\Theta(m+Z)$ |
| Hardest fixed answer | $\max_W\log_2(B_W+2)=\Theta(m+G)$ |

Every family of bounded-period words attains the easiest order, with its upper constant allowed to depend on the period bound. One hard word chosen per $w$ works simultaneously for every admissible $n$ and every order. These two extrema leave room for different costs of individual words. [Sawitzki, extended version, Definition 6 and Theorem 3](https://citeseerx.ist.psu.edu/document?doi=fecf96da588c7b03df786f3f144a5f888873f077&repid=rep1&type=pdf) · [SOFSEM 2005 bibliographic record](https://www.sciweavers.org/publications/lower-bounds-obdd-size-graphs-of-some-popular-functions)

### Proof

**Two ways to forget part of the input.** Read the external address and the proposed answer before the data. The short-cell endpoint summary from the [SHWB proof](shwb.md) applies with the observed pointer bits in place of the partial weight. This gives logarithmic cost $O(w+m+(n/w)\log(w+1))$.

For $w\le\sqrt n$ and sufficiently large $m$, take $H$ the largest power of two at most $m/8$, and $D$ the largest power of two at most $\max(w,H)$. Read data by their residues modulo $H$, in physical order within each residue. The first $\alpha=m-\log_2 D$ bits of the pointer determine the start page of length $D$. After $r$ finished residues at least $r$ such bits are known. At most $2^{\alpha-r}$ start pages remain, each with at most two possible successors needed for the word since $w<2D$. At most $(r+1)D/H$ sites per page have been read. The number of retained data bits is thus at most
$$
3\cdot2^{\alpha-r}(r+1)D/H\le 3n/H .
$$
Retain the partial pointer even if its own sites are outside the surviving pages. This yields the other upper bound $O(w+m+n/m)$, hence the minimum defining $G$. When $w>\sqrt n$, the first order suffices. For a period-$p_0$ word, store the extreme disagreement sites for each phase in each surviving page. A query intersects a page in a prefix, suffix or full page in the range where this refinement is needed. Those extremes decide failure. Counting records gives $O(m+p_0Z)$ for fixed $p_0$, using the simpler orders at the two ends of the width range.

**Lower bounds on the actual shared memory.** In an arbitrary order cut just before the last first visit to a complete aligned $m$-bit block $P$. Every other complete block has an observed site. Fix the outer address to $P$'s start. The unread bits of $P$ can later select a physical start. In disjoint packets away from $P$, a guard of length at least $w$ allows windows ending at successive observed markers. Encode an ordered cutoff by making its selected window agree with $W$ and putting the opposite of $W$'s last bit at later markers. For two distinct cutoffs, the suffix that selects and completes the larger one's window separates the prefixes. Packing packets gives $\Omega(Z)$ uniformly up to boundary ranges. Large widths also give $\Omega(m)$ by essential data variables.

For a hard word, $t=\lfloor(\log_2 w)/4\rfloor$ observed sites of the common core of overlapping windows can be prescribed by one translate of $W$. To obtain such a word, randomize its digits. For any $t$ selected sites, at least $\lfloor w/2\rfloor/t^2$ shifts can be chosen with disjoint tested coordinates (up to rounding). Their trials are independent. A union bound over sites and assignments gives a single word covering every prescription for large $w$. Each disjoint packet now programs $\Omega(\min(w/m,\log(w+1)))$ bits in the intermediate range. A common suffix programs the unread pointer to a distinguishing window. This yields $\Omega(G)$ with the endpoint cases in the full proof. Fixing the free answer to this word transfers the bound to the graph. Separately, reserving an $m$-bit pointer and averaging over its possible addresses produces at least $\lfloor w/8\rfloor$ comparisons crossing an answer cut; splicing mismatched answers proves $2^{\lfloor w/8\rfloor}\le B+2$. Together these bounds prove the table.

**Dependency.** The endpoint argument is reused. For SISA the address itself occupies memory also used as queried data. The two uses can overlap. The residue schedule for the upper bound and a physically disjoint, still-programmable pointer for the lower bound address that additional constraint. The numerical SHWB estimate is not a premise.

[Full written proof (PDF)](sisa-widths.pdf) · [Lean sources and replay (ZIP)](SISA_All_Widths_Reproduction.zip)

### Verification

Lean 4.34.1 proves `SISA.Pages.residue_legal` for the actual common-order diagram and `SISA.Profile.word_probe` for a disjoint physical query. For $w=m$, $m\ge4$, `SISA.Pages.diagonal_minimum` returns a least legal $B$ and both
$$
2^{\lfloor n/(4m)\rfloor}\le B+2,\qquad
B\le(2m+n)\,2^{6\cdot2^{m-\lfloor\log_2m\rfloor}+3m}.
$$
They give the diagonal rate $\Theta(n/m)$ after taking logs. The full-width classification and the fixed-word extrema above have written proofs. From the archive run `python3 replay.py --lean lean` and `python3 tests/check.py`. [Fully formalized filtered family](sisa-filtered.md) · [Research map](../README.md)
