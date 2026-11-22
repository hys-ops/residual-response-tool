# The lookup tables inside a sensitivity construction

*An exact classification of one-child restrictions of the tournament predicates*

[Overview](tournament.md) · [Research map](../README.md)

## 1. What the surrounding inputs can request

Take the regular tournament construction in OpenAI’s September 25, 2026 manuscript \[1, §2.1–2.2, (1)\]. Fix a depth $d\ge1$ and $M\ge3$. In the unrolled tree for its Boolean root $P_{d,1}$, select one particular level-zero child as specified in §2. Fix every raw input bit outside that child. All that the root can see of the child is its largest true threshold index, its *height* $h\in\{0,\dots,d+1\}$, defined to be zero if no predicate holds. A fixed outside assignment thus produces a binary word $w=(w_0,\dots,w_{d+1})$, with root value $w_h$.

**Theorem.** For each allowed regular tournament, for this child and every choice of edge labels, the set of words obtained as the outside assignment varies is exactly

$$
\boxed{\mathcal C_d=\lbrace w\in\lbrace 0,1\rbrace ^{d+2}:\ w_c=1\ \Longrightarrow\
                     w_{c-1}=w_{c+1}=1\rbrace ,\qquad c=\lceil d/2\rceil.}
$$

Consequently there are $5\cdot 2^{d-1}$ distinct queries. For the source’s OR seed the same family occurs with all other copies fixed to zero. With those copies unrestricted they can add only the already present constant-one word.

At $d=4$, the six positions are $0,1,2,3,4,5$. A query may accept heights $0$ and $5$ alone. A query accepting height $2$ must also accept $1$ and $3$. The five allowed patterns at positions $1,2,3$ can each be paired with any of the eight assignments at $0,4,5$. There are 40 possible queries.

**A different question answered by the same calculation.** Give one party all raw bits in the selected child and the other party all remaining bits. In the deterministic, fixed-length, one-way model, the exact worst-case message lengths are

$$
\text{child to surroundings: }\lceil\log_2(d+2)\rceil,\qquad
   \text{surroundings to child: }d+2.
$$

These are costs for the original root on its full input domain and this particular partition. The proof is in §4.

**Where this sits.** The source bounds single-bit and joint threshold changes to separate sensitivity and block sensitivity \[1, Prop. 3.1, Cor. 4.3\]. Its estimates serve a different purpose. The calculation here starts directly from its predicate definition. It classifies every Boolean test on one child’s height induced by the rest of the computation. We report no improvement to the source’s separation exponent or manuscript length.

## 2. Replace a layer of clauses by a unary map

Write $Q$ for the largest child threshold; the largest parent threshold is $H=Q-1$. A row wins at index $q$ if its $r$ children all have height $Q$ and each outgoing gate points to a child of height $<Q-q$. A row with all target heights equal to $Q$ is called full. The parent height is the largest $q$ for which some row wins.

**One-layer rule.** Hold all children fixed except one child in row $j$, whose height is $h$. Every resulting map is constant or has the form

$$
R_{D,E}(h)=\min(D,Q-1-h)\quad(0\le h<Q).
$$

At full height,

$$
R_{D,E}(Q)=E\quad(0\le D,E\le Q-1).\tag{1}
$$

For a suitable, fixed child in every regular tournament of outdegree at least two, every map in (1) and every constant is realizable. This statement requires independent child inputs.

*Upper inclusion.* Among the other full rows a row can win only if it has no outgoing edge to any of those full rows. A tournament has at most one such row $i$. Row $j$ is inactive for $h<Q$. If there is no candidate $i$, the height below $Q$ is zero. If $i$ tests $h$, its other gates set a cap $D$, and the variable gate requires $q\le Q-1-h$. At the endpoint $h=Q$, record the actual height $E$. If $i$ does not test $h$, its contribution is constant. When this constant is positive, it still wins at threshold one when $h=Q$. Row $j$ cannot then win even at one, since the edge between two winning rows would point to a full target. The parent is constant. A zero constant below $Q$ is covered by $D=0$.

*Lower inclusion.* Choose two outneighbours of a vertex $i$ and call them $v,j$ with $v\to j$. Some outneighbour $z$ of $j$ points to $i$: otherwise all outneighbours of $j$ would also be outneighbours of $i$, yet $i$ has the additional outneighbour $j$ and the two degrees are equal. We have $i\to j\to z\to i$ and $i\to v\to j$, with four distinct vertices. In the source’s cyclic example one may take $(i,j,z,v)=(0,M^2,M^2+1,1)$. The selected child is the one tested by $i\to j$. Give all other targets in $i,j$ height $Q$. In row $v$, give the child tested by $i$ height $Q-1-D$; in row $z$, give the child tested by $j$ height $Q-1-E$. Give all remaining children height zero. Both blocking rows are inactive. For $h<Q$ only $i$ can win and its two caps give (1). At $Q$ row $i$ fails and $j$ attains $E$. Labels never cause a collision between distinct rows. To realize a constant $C$, fill row $z$, place its cap $Q-1-C$ at its gate in row $i$ and set the remaining heights except the selected child to zero. Row $j$ has another zero target ($r\ge2$), and $z$ has no gate in $j$.

*Raw realizability.* At level zero take a source centre and free $d+1$ of its $d+2$ one-bits, leaving the last one fixed. At every assignment the nearest centre is the chosen one: if its distance is $s\le d+1$, each other centre has distance $2(d+2)-s>s$. The height is the number of free bits set to one. At higher levels (1) with $D=Q-1$ realizes every parent height as $h$ ranges from 0 to $Q-1$. Induction and disjoint child supports realize all the assignments above. Choose the indicated child at every layer along one path and then keep this path fixed.

## 3. Compose the unary maps and classify their queries

If the current word is $w_0\dots w_H$ with $H=Q-1$, then the word after one more layer is read backwards with a cap, and a chosen entry is appended:

$$
t_h=w_{\min(D,H-h)}\quad(0\le h\le H),\qquad
      t_{H+1}=w_E .                                                 \tag{2}
$$

A constant section instead produces a constant word. Start at the Boolean root with $(0,1)$ and move towards the designated child. By §2 every local choice is available independently at every stage: siblings used to program different layers are disjoint. Thus (2) with constants generates exactly the words in question.

For one layer, direct substitution into (2) gives the four words $000,001,100,101$. A constant section adds $111$. These are exactly the triples $(a,b,e)$ satisfying $b=1\Rightarrow a=e=1$.

*Necessity.* Suppose the old middle is $c$, with $0<c<H$. Replacing every old entry past position $D$ by $w_D$ preserves the middle condition. If $D<c$, the middle triple is constant. If $D=c$, its right neighbour now equals its centre; its left neighbour already satisfies the condition. If $D>c$, its three entries are unchanged. Reversal takes the centre to $H-c$ and interchanges its neighbours. Appending at the far right leaves that triple in place. Constants satisfy the condition. Going from depth $d$ to $d+1$ uses $H=d+1$, hence $H-\lceil d/2\rceil=\lceil(d+1)/2\rceil$.

*Sufficiency.* Let a desired word $t$ of length $H+2$ satisfy the condition at $H-c$. Reverse its first $H+1$ entries to obtain $w$. Its middle triple satisfies the old condition at $c$. If the desired last bit occurs anywhere in $w$, take $D=H$ and point $E$ at an occurrence. Equation (2) returns $t$.

Otherwise the first $H+1$ entries of $t$ all equal one bit $b$, and the desired last bit is $1-b$. Choose an old word with $w_0=b$, $w_H=1-b$ and every interior entry zero. Its middle satisfies the condition, even when $H=2$. Now take $D=0$, $E=H$. This reproduces the entire target word. The exceptional case matters because an everywhere constant word cannot supply the opposite last bit.

There are five admissible triples and $d-1$ other free bits. This proves the count and both directions of the theorem. The identified class has VC dimension exactly $d+1$ on the height domain: omit the middle position, whose value can be set to zero, and all remaining assignments extend. All $d+2$ positions cannot be shattered.

**Check on the need for the endpoint.** If every layer were forced to use $D=H$ and a fixed $E$ with all surrounding controls fixed, (2) would determine a single word at each depth. Reversal by itself supplies no independently programmable entry. The exceptional endpoint in (1) is the consequence of the second full target row becoming eligible.

## 4. What the classification buys

**An exact one-way communication calculation.** For a deterministic fixed-length message, different residual functions of the recipient’s input require different messages; an index for those functions attains this lower bound. Every child height occurs. Consequently distinct outside words yield distinct rows of the communication matrix. There are $5\cdot 2^{d-1}$ such rows, requiring $\lceil\log_2(5\cdot 2^{d-1})\rceil=d+2$ bits. Sending the whole word attains the bound.

In the other direction, every two distinct heights are distinguishable. For two noncentral heights set the middle to zero and choose their entries differently. To separate the middle from another height, set the middle to zero and the other height to one. There are precisely $d+2$ distinct columns, and the child can send its height. The row/column counting principle is standard \[2\]. The exact matrix for this partition comes from the tournament calculation.

**A lookup controlled by individual raw bits.** With $D=H$ at each layer, mark the inherited positions of the original entries zero and one. Reversal preserves their adjacency. By choosing $E$ to be one marked position or the other, a new independent bit is appended:

$$
w\longmapsto \operatorname{rev}(w)\,b.
$$

This choice needs only one actual raw input bit per layer. Indeed every adjacent pair of heights is attainable at the endpoints of an edge of the raw input cube. At the base use adjacent Hamming weights in the free centre. For the induction, use a full row $i$ and its variable gate in row $j$, keeping another target of $j$ zero. Then the height is $H-h$ on $0\le h\le H$, transporting adjacent child heights to adjacent parent heights. In the two-blocker construction the height required of row $z$ is $H-E$, so switching the adjacent marks requires one raw bit. Its polarity can be either sign, fixed in advance. These bits lie in disjoint siblings, and are disjoint from the $d+1$ raw address bits of the base child. The word is evaluated at their Hamming weight. For example, at $d=4$ successive controls $b_1,b_2,b_3,b_4$ yield the word $(b_3,b_1,0,1,b_2,b_4)$.

**A family of ordinary restrictions.** Every symmetric Boolean function $g$ on $m\ge1$ bits is a restriction of this root whenever $d\ge2m+1$. Set $s=d+1-m$, fix $s$ address bits to one, and keep the remaining $m$ free. The attainable heights are precisely $s,\ldots,s+m$. Since $s>\lceil d/2\rceil$, prescribe $w_{s+t}=g(x)$ for $\operatorname{wt}(x)=t$ and choose $w_c=0$. The theorem supplies a single outside assignment realizing that whole truth table. This uniformly embeds, for example, parity, majority and every exact-weight test. It does not improve the known complexity of those functions.

**Scope.** Depth $d$ is the source’s recursion depth, not its total input length. The communication costs apply to this specific partition, without an arbitrary-partition or all-variable-orders lower bound. Enumerating every induced query incurs exponential cost in $d$; (2) is a short symbolic description and the count gives no barrier to other compact representations.

## 5. Provenance and verification

**Source correspondence.** The original parameters are $L=d+2$, $k=2M^2+1$, $r=\lceil\sqrt M\rceil$, $H_\ell=d+1-\ell$. The theorem covers every regular tournament allowed by \[1, §2\] and every labelling, including the admissible labels used for separation. More generally §§2–3 require only the four indicated edges and the diagonal $i\to j$ at each layer, attainable heights, and independent child inputs. For an arbitrarily preselected child we assert only the one-layer upper inclusion. Source Lemma 2.1 controls labels for a different estimate. Lemma 2.2 bounds ordinary and joint base sensitivities; the Hamming calculation here instead realizes heights on actual cube edges. Proposition 3.1 and Lemma 4.1 concern sensitivities. Neither is needed for the present theorem.

The original preprint is dated September 25, 2026. The local TeX and PDF match the preprint directory in the repository snapshot below.

Pinned commit: `4eaee87548250b2682affda7d05d947c05554bae`

Construction TeX blob: `de207d277f48fef7956018d61b26038580c0d19a`

Paper PDF blob: `cb4d5ce13bc8697206f0adb5e0f9bb756722c39a`

**Verification record.**

- The written argument proves the classification on raw assignments at all depths and the two applications. No independent human review has been obtained.

- `verify.py` builds the original base Hamming predicates and evaluates every threshold in the original tournament clauses on an explicit restriction. At $M=3$ and depths 1–5 it exhausts all $2^{2d+1}$ assignments to the surviving physical bits for each of three label assignments (8,184 checks altogether). This tests the one-bit controls and counts each physical variable’s occurrences.

- `contexts.py` checks the upper inclusion over 35,136 fixed contexts/label combinations of a smaller directed triangle, all cap/endpoint cases tested on the 19-row source gate (4,860 input heights), and equality of the generated and predicted whole word sets up to depth 12.

- Lean checks the exact classification of the abstract word language at all depths, its centre index, the two-active-row threshold arithmetic, and decoding of the independent controls. In Lean 4.34.1, `TournamentLookup.exact_language` gives the abstract classification, and `middle_value`, `preserve_middle`, `realize_middle`, `section_formula`, `decode_table` and `table_injective` cover the index, scalar arithmetic and decoding. The recorded Lean checks use only standard Lean axioms. The full source tournament restriction and the one-way communication theorem have written proofs; these have not been checked end to end in Lean.

**Related work.** The reviewed source, the linked exponent-improvement campaign and Paradigma’s writeup \[3,4\] concern separation and sensitivity estimates. Lookup functions and the communication argument are classical \[2\]. The claim of interest here is their precise realization, together with the one forbidden local pattern in the source construction. This limited comparison does not establish priority.

\[1\] OpenAI, [*A superquadratic separation between sensitivity and block sensitivity*](https://github.com/openai/math/tree/4eaee87548250b2682affda7d05d947c05554bae/preprints/A-superquadratic-separation-between-sensitivity-and-block-sensitivity-September-25-2026), Sept. 2026, §2, eq. (1), Prop. 3.1, Cor. 4.3.

\[2\] T. Roughgarden, [*Communication Complexity*, Lecture 2](https://theory.stanford.edu/~tim/w15/l/l2.pdf), one-way protocols and Index.

\[3\] [Community notes for the OpenAI manuscript](https://mathcommunity.github.io/oai-math-revised/papers/A-superquadratic-separation-between-sensitivity-and-block-sensitivity-September-25-2026/), links to exponent follow-ups.

\[4\] Paradigma, [*Building a Field-scale Flywheel graph for mathematics*](https://www.paradigma.inc/blog/field-scale-research/), sensitivity writeup.
