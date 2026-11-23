# Which questions can a tournament ask a child?

At depth four the root can ask whether the child's height is 0 or 5. It cannot ask whether the height is exactly 2. This distinction can be read off a single local rule at every depth.

**Theorem.** Take the Boolean root $P_{d,1}$ of the source tournament, $M\ge3$, $d\ge1$, with any of the permitted regular tournaments and any edge labels. In the unrolled tree there is a **fixed, designated** bottom block for which varying the exterior gives exactly the following words on the child's attainable heights $0,\ldots,d+1$:

$$
\mathcal C_d=\{w\in\{0,1\}^{d+2}:w_c=1\Rightarrow w_{c-1}=w_{c+1}=1\},
\qquad c=\lceil d/2\rceil .
$$

At that partition the exact deterministic, fixed-length, one-way communication costs are $\lceil\log_2(d+2)\rceil$ bits from the child to the exterior and $d+2$ bits in reverse. The recipient outputs the answer. These are costs on the full input domain of that root. [Source, §2.1–2.2, eq. (1)](https://github.com/openai/math/tree/4eaee87548250b2682affda7d05d947c05554bae/preprints/A-superquadratic-separation-between-sensitivity-and-block-sensitivity-September-25-2026)

**[Read the complete written proof](tournament-full.md).**

[Read the complete written proof (PDF)](tournament-proof.pdf)

### Proof

**One layer.** A row wins threshold $q>0$ if all its own target children are full (height $Q$) and each gate it tests has height $<Q-q$. Set $H=Q-1$. Keep a child in row $j$ free. Below full height row $j$ cannot win. Of the other full rows at most one can win, since the edge between two candidates would test a full target. If it tests the free child, the variable test gives $q\le H-h$ and the other tests give a cap $D$. At $h=Q$ record the actual height $E$. A positive winner independent of the child stays the unique winner at the endpoint. Zero below the endpoint is the case $D=0$. Thus a section is constant or $R_{D,E}(h)=\min(D,H-h)$ for $h\le H$, with $R_{D,E}(Q)=E$.

**Realizing the sections.** Pick two outneighbors of $i$, ordered $v\to j$. Equal outdegrees imply that some outneighbor $z$ of $j$ points to $i$. Select the child in $j$ tested by $i$. Fill rows $i,j$ to height $Q$ except for this hole. Put blocking heights $H-D$ and $H-E$ at the gates tested by $i$ in $v$ and by $j$ in $z$, respectively. Set remaining unassigned sites to zero. Below $Q$, row $i$ realizes the capped reflection. At $Q$, row $j$ supplies $E$. Filling $z$ instead and giving its gate in $i$ a prescribed blocker realizes a constant, since $z$ has no gate in $j$. There are at least two target children per row. In a bottom Hamming center, freeing $d+1$ of its $d+2$ one-bits gives every height as the weight of the free bits. Full-cap sections then realize every needed parent height. Independent sibling supports let us choose these sections on successive layers of one fixed path. For an arbitrary preselected child only the inclusion in the one-layer description follows from this argument.

**Composition.** Start with $(0,1)$. For a parent word $w_0,\ldots,w_H$ the child word is
$$
t_h=w_{\min(D,H-h)}\quad(0\le h\le H),\qquad t_{H+1}=w_E .
$$
At depth one the possible triples are $000,001,100,101,111$. Capping repeats one symbol past the cap and preserves the middle condition. Reversal takes the center $c$ to $H-c$ and the appended symbol leaves that triple unchanged. Conversely, given a legal next word, reverse the first $H+1$ entries. The resulting word is legal at the old center. With $D=H$ append the desired last symbol by choosing any occurrence as $E$. If that symbol is missing, the initial segment is monochromatic, say $b$. Use the legal predecessor with endpoints $b,1-b$ and zero interior, and take $D=0,E=H$. This proves both inclusions by induction.

**Communication.** The five legal middle triples and the $d-1$ free positions give $5\cdot2^{d-1}$ distinct rows. Any two heights can be separated by a legal word with center zero. Hence there are $d+2$ distinct columns. A fixed-length deterministic message must distinguish the sender's distinct rows (or columns), and sending their index attains the corresponding ceiling of the logarithm. This last argument is standard. The exact matrix comes from the classification.

### Verification

Lean 4.34.1 checks `TournamentLookup.exact_language` for the scalar language (formal index $d-1$), `section_formula` for its two-row arithmetic, and `table_injective` for the corresponding one-bit programs. The passage from raw source clauses to all attainable sections and both communication conclusions have written proofs. Finite raw-clause checks are separate. The source's sensitivity estimates are independent of this argument.

For the public Lean source and replay instructions, see [Lean reproduction](tournament-lean/README.md). The separate Python checks described above are not included in the public Lean materials. [Research map](../README.md)

