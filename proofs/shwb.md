# The OBDD size of shifted hidden weighted bit at every width

Let $x_1,\ldots,x_n$ be data bits, $z=\sum_{i=1}^n x_i$, and $y_0,\ldots,y_{w-1}$ independent answer bits, $1\le w\le n$. Sawitzki's SHWB graph, using the displayed address convention of the extended paper, accepts exactly when
$$
\forall\,0\le j<w,\qquad y_j=x_{(z+j)\bmod n},\qquad x_0:=0 .
$$
The bit $x_n$ contributes to the weight; address zero always returns the sentinel. Let $B$ be the minimum number of internal vertices of an exact ordinary OBDD, over every permutation of the $n+w$ original variables. Then, uniformly in $n,w$,
$$
\boxed{\log_2(B+2)=\Theta\!\left(w+\frac nw\log_2(w+1)\right).}
$$
The extended paper's Theorem 4 gave a lower bound of order $2^{n/(11w)}$. At $w=\lfloor n^{1/3}\rfloor$ the tight exponent has order $n^{2/3}\log n$. Even the least costly choice of width gives size $2^{\Theta(\sqrt{n\log n})}$. [Sawitzki, extended version, Definition 10 and Theorem 4](https://citeseerx.ist.psu.edu/document?doi=fecf96da588c7b03df786f3f144a5f888873f077&repid=rep1&type=pdf) · [SOFSEM 2005 bibliographic record](https://www.sciweavers.org/publications/lower-bounds-obdd-size-graphs-of-some-popular-functions)

### Proof

**Upper construction.** Read the answer first. For a fixed answer word $y$, lift the $n$ cyclic starts to integer positions and put consecutive starts in cells of width at most $w$. At a prefix of the data order, a start is compatible when all inspected sites of its window agree with $y$. Remember the partial weight and the first and last compatible start in each cell, or empty. Two prefixes with the same endpoints agree at every inspected site in the two extreme windows: the same copy of $y$ prescribes its value there on both prefixes. The two windows cover the whole window of each intermediate start. Thus the same starts survive on both prefixes, even when incompatible starts occur between the extremes. A common completion has the same final weight and acceptance value. Lifting to integers handles wraparound. There are at most $1+w(w+1)/2$ choices per cell. The common-order diagram has at most
$$
2^w-1+2^w n(n+1)[1+w(w+1)/2]^{\lceil n/w\rceil}
$$
internal nodes. This gives the claimed logarithmic upper.

**Data lower bound via an actual cofactor.** Let $N=n-2$, $s=|u|$, and form $x=\operatorname{reverse}(\neg u)\,10$. Fix every $y_j=0$. The new weight is $N+1-s$. If $s\ge w$, the queried bits are the complements of $u_s,\ldots,u_{s-w+1}$. If $s<w$, offset $s$ hits the appended one at site $N+1$, forcing rejection. The cofactor is therefore exactly the predicate that a run of $w$ ones ends at weight $s$. Fixing tests, complementing branches and relabelling leaves size nonincreasing. The all-orders lower bound for this trailing-window predicate gives $\Omega((n/w)\log(w+1))$ for $w\le n-2$ (absolute small sizes absorbed). Its proof uses independently selectable cutoffs in disjoint cells.

**Answer lower bound.** Cut after half the outputs have been read. Choose the side containing more real lookup sites and the outputs on the other side. Each output column reaches every real site as the trial weight $z$ varies. A double count after discarding extreme weights yields one $z$ with $2h$ distinct crossing comparisons in the same direction and $h\le z\le n-h$, where $h=\lfloor w/64\rfloor$. Put $h$ free bits on half those data sites, use the other half to bring their total weight to $h$, and fix $z-h$ ones elsewhere. Each assignment has **the same shift** $z$. Splicing the prefix of one correct input with the suffix of another preserves the data of one and the answers of the other on the selected comparisons. A differing bit forces rejection. Thus $2^h\le B+2$. This supplies the wide-output term, including widths omitted by the cofactor. Taking the maximum of the two lower estimates gives their sum up to an absolute factor.

**Dependency.** The trailing-window theorem is a genuine premise by the displayed substitution. The crossing proof is independent. The tournament classification was the historical starting point for studying responses; it is absent from both reductions.

### Verification

Lean 4.34.1 proves `HWB.AllGraphOrders.optimal_all_widths` for the actual attained minimum. For $H=2^w(w+1)^{\lfloor n/w\rfloor}$ it gives $H\le(B+2)^{1073742208}$ and $B+2\le H^{16}$. Taking binary logs yields the displayed growth rate. The archive includes 51 Lean source modules. Run `python3 replay.py --lean lean`, then `python3 tests/graph.py` and `python3 tests/optima.py` for independent finite checks. [Research map](../README.md)

Companion proof and replay files cited by description are not attached to this page.
