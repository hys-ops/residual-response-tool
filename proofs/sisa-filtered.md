# An explicit indirect-address word hard in every variable order

This result fixes both the answer word and a filter on allowed inner addresses. On this one family we can give an order achieving the upper bound and prove the matching lower bound against **all** orders of exactly the same physical variables.

### Function and theorem

For an integer $d$ tending to infinity, set $b=2^d$, $m=2^b$, $n=2^m$. There are $n$ circular memory bits and $m$ external address bits. The external address selects $m$ consecutive memory bits, interpreted big-endian as $z$. Accept exactly if $z=pm+a$ with $0\le p<m$ and $0\le a<b$, and the $m$ memory bits starting at $z$ equal the following fixed word $W$. All other inner addresses reject. Index positions and blocks from zero.

* Begin with $0^{m/2}1^{m/2}$. Set position $4bt$ to one for $0\le t<8d$.
* Group $j$ begins at $m/2+32bj$ for $0\le j<d$. In its $b$-bit blocks numbered $4,5,12,16$, set positions $0,g_j$ to zero, where $g_0=d^2+d$ and $g_j=d^2+j$ for $1\le j<d$.

Let $B_*$ be the minimum internal OBDD size over all orders of the $n+m$ inputs, including interleavings of address and memory. Put $h=\lfloor\log_2\lfloor\log_2\lfloor\log_2 d\rfloor\rfloor\rfloor$. For $h\ge10$ the formal theorem gives
$$
n^h\le B_*^{128},\qquad B_*\le n^{6h}.
$$
In particular, for every fixed $c$, eventually $B_*>(n+m)^c$. The growth in the exponent is extremely slow. The value of the result is that the constructive order and the lower bound meet for a fully specified function.

### Why every order pays

Treat the first $m$ pages of $m$ physical sites as banks of four consecutive pages. In each bank use its second page as a candidate. In the adjoining two edited blocks, an observed site at position $x$ relative to their start demands zero for offset $a$ exactly when
$$
x\in\{a,a+g,a+b,a+b+g\}.
$$
Consequently one observed row touches at most two offsets; when there are two, their circular distance determines $g$. Monitor how many offsets a prefix touches on each candidate page and near the two ends of the offset range. Stop just before the last page meets either threshold. All other pages are ready; reserve that last bank to hold the pointer.

Here is the counting step that keeps the pointer programmable. With $L$ the total-offset threshold, $K$ the end-offset threshold and $2^s$ the end-tile width, observed middle pairs can rule out at most $L^2$ gaps. At most $(K+1)Ks$ more gaps prevent the companion offset field from keeping its low $s$ bits unread: there are at most $K+1$ boundary positions, $K$ observed labels and $s$ low-bit positions. Choosing $L^2+(K+1)Ks<d$ leaves a band in which **all page bits** and the required low offset bits are still free. Fix the outer address so the original pointer occupies that band.

On a ready page, $A$ touched offsets yield at least $A/2$ different vectors of required values on inspected sites, since a shared zero belongs to at most two offsets. Keep pages with compatible observed pointer bits. Independently choose one of their distinct vectors on each retained page. To distinguish two choices, one common suffix sets the reserved pointer to a differing page and offset and completes its window. One prefix accepts and the other already disagrees at a read site. With $s$ of order $\log d$, $K$ of order $\log\log d$ and $L$ of order $d^{1/4}$, the budget holds and this forces $n^{\Omega(\log\log\log d)}$ states. The finite floors and both threshold cases are in the full proof.

### An order attaining the same rate

The upper order reveals selected residues of page and high offset bits early. In later phases it rotates the residue inspected from page to page. For a fixed observed header let $P$ count surviving pages, $X$ potentially exceptional surviving pages, $e,v$ known page and high offset bits, and $J$ distinct late residues already seen. The physical schedule gives $P2^e\le m$, $X\le P$, $X2^v\le4mJ$ and $J\le4(e+1)$. The number of data records per header is at most
$$
[\,2(2+6(2k+1))\,]^m\,2^{3JP}[\,2+J(d+1)\,]^X,
$$
where $k=8(\lfloor\log_2\lfloor\log_2 d\rfloor\rfloor+4)$ sets the early scan length. Thus the exceptional-page term is paid only on the pages that can contribute it. Counting headers and layers, and compiling equal residuals into a real ordered DAG, gives $n^{O(h)}$ internal nodes. The exact finite lower and upper concern the same predicate `SISA.FixedWord.fixedAt`.

**Dependency.** This reuses programmable-pointer probes and residual counting. The unfiltered [SISA width theorem](sisa.md) identifies the question. Fixing $W$ and rejecting disallowed addresses can destroy its hard witnesses, so a separate proof on this family is essential.

[Written lower-bound proof (PDF)](sisa-cluster-lower.pdf) · [Written upper-bound proof (PDF)](sisa-cluster-upper.pdf) · [Complete Lean replay (ZIP)](SISA_Optimal_Order_Lean_Reproduction.zip)

### Verification

`SISA.Rate.optimal_rate` proves the two displayed finite inequalities and `SISA.Rate.superpolynomial_total` proves the statement in total input length. Lean 4.34.1 checks 60 modules, including 43 inherited source modules. The audit reports `propext`, `Classical.choice` and `Quot.sound` for both declarations. The final archive supersedes the verification status recorded in the earlier lower-bound PDF. Run `sha256sum -c SHA256SUMS` and `python3 replay.py --lean lean` at the ZIP root. [Research map](../README.md)
