# What one and two adjacent compressed decisions buy for ordinary HWB

For the $n$ original input bits put $a=|x|$ and $\mathrm{HWB}_n(x)=x_a$, with $x_0=0$. Let $S_1(n)$ minimize wires over a compressed root split with shared ordered binary decision diagrams (OBDDs) on the two sides. Let $S_2(n)$ allow one further **adjacent** compressed split per branch over OBDD leaves. Every circuit uses one common binary variable tree. Different subcircuits can share gates and skip ordered tests. There are no auxiliary input variables. Then
$$
\log_2 S_1(n)=\Theta(\sqrt n),\qquad
\log_2 S_2(n)=\Theta\!\left(n^{1/3}(\log_2 n)^{2/3}\right).
$$

**Full proofs and verification** · [Complete focused proofs (PDF)](ordinary-hwb-restricted-proof.pdf) · [Combined manuscript, §§2–3 (PDF)](Ordinary_HWB_From_One_Split_to_All_Vtrees.pdf) · [Lean source and replay scripts (ZIP)](ordinary-hwb-restricted-lean.zip)

The second model counts levels on a path. Many distinct decisions can occupy the same level. These results measure the benefit of a second split, and expose the operation used later in the [all-vtree proof](hwb-all-vtrees.md).

### One split

Let $B$ be the right labels, $|B|=k$, with remaining labels $A$. On a left assignment of weight $a$ the residual on the right layer of weight $s$ reads the physical label $a+s$. If $a+s\in A$ it returns an assigned bit; if $a+s\in B$ it is that right coordinate; at zero it returns zero. Take $k=\lceil\sqrt{n+1}\rceil$ and choose spaced right labels so each left weight has some right marker strictly between $a$ and $a+k$. On that interior layer its nonconstant coordinate projection distinguishes $a$ from any other left weight. At the same weight the response is determined by the $A$ bits in $[a,a+k]$. Its prime is an exact-weight test with those literals. Counters and OBDDs on the two sides, even after paying for every prime and sub, give $2^{O(\sqrt n)}$ wires.

For a balanced split, a window at a fixed feasible left weight exposes $\Omega(\min(|A|,|B|))$ independently programmable left bits. For small $A$ a long consecutive run in $B$ yields an ordinary HWB cofactor in a selected right OBDD. For small $B$ use the forced left prime
$$
P_{\mathbf1}(u)=[\,\forall v\in\{0,1\}^{B},\ \mathrm{HWB}_n(u,v)=1\,].
$$
Place message bits at disjoint windows $[j,j+k]$ avoiding $B$ in an arbitrary order of the left OBDD. Fix a common prefix weight. One suffix brings the left weight to $j$ and fills the rest of that window with ones. The entire right response is then constant one exactly when the chosen message bit is one. The three cases jointly force $2^{\Omega(\sqrt n)}$ wires.

### Two splits

For the upper bound set aside the first $k$ physical labels. Away from exceptional low weights, the right response is constant on each weight layer $0,\ldots,k$. Thus its forced left prime tests occurrence of a specified **word of length $w=k+1$** at the left weight. The exceptional primes are exact-weight tests with a few literals. Split the left side once more using spaced movable blocks. A weight-preserving swap with a spare bit separates different left weights. At a known weight, store the first and last matching start in each short cell plus the match information at block boundaries. This yields a logarithmic wire budget of order $k+\sqrt{n/(k+1)}\log(k+2)+\log n$ at the balancing scale. Taking $k$ of order $n^{1/3}(\log n)^{2/3}$ gives the upper.

For the lower put $K=n^{1/3}(\log_2 n)^{2/3}$. Balanced outer cuts already expose $\Omega(K)$ independent bits. A small left side can be read as an ordered prefix; the one-level lower after that prefix still dominates $K$. With $k=|B|=O(K)$ the prime $P_{\mathbf1}$ actually occurs. A left weight $j$ whose $[j,j+k]$ avoids $B$ tests that whole window. Within its inner split, pack independent ordered cutoff positions into separated cells and use a common completion to test one chosen marker. This yields a logarithmic cost $\Omega(\sqrt{n/w}\log(w+1))$. For a thin inner right side $Q$ the simple clean-window argument can fail: one $Q$ label every $w$ sites hits every window. The proof permits a positive $Q$ weight on a shifted window and places zeros so every later cutoff still has a rejecting completion. This repairs the lower bound for scattered physical labels. For $w\le n^{1/4}$ the square-root term alone dominates $K$; for larger $w=O(K)$ the logarithmic factor gives $\Omega(K)$.

**Dependency.** The identity “a compressed prime is the entire fiber of one attainable right function” is used twice. The source tournament inspired this question. Its exact language, the auxiliary coding theorem and the physical control counts are independent of these proofs.

### Verification

Lean 4.34.1 checks the **one-level minimum and both bounds** in `HWB.ordinary_HWB_certified`. For two adjacent levels, `HWB.Exact.all_large_n` establishes the lower bound for all sufficiently large $n$ in the formal certificate class, including the logarithmic factor. The written comparison in §3 of the companion transfers that bound to physical wire counts. Section 3.1 gives the written construction for the two-level upper bound, which remains outside the end-to-end Lean verification.

The archive contains 52 Lean source modules. From the extracted archive, run the following command.

```sh
python3 replay.py --lean "$(elan which lean)"
```

[Research map](../README.md)
