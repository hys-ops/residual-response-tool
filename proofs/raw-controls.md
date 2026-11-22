# Programming many responses with actual tournament input bits

Take $P_{d,1}$, $M\ge3$, and a bottom address block. Fix every exterior bit except $q$ individual **original coordinates**, $z=(z_1,\ldots,z_q)$. Bits specifying an address cannot depend on $z$. At height $h$ the root now computes a tag $C_h(z)$. All tags counted below must be 1 at the same setting $z_*$.

**Theorem.** For any bottom block and any depth, at most $2^{q+1}-1$ distinct positive-at-$z_*$ tags occur. Conversely, for $q\ge1$, $n=2^q$, a designated block in any allowed regular tournament with any labels realizes all $n$ conjunctions of the $q$ coordinates, in any requested order at heights $0,\ldots,n-1$, with the first repeated at $n$. Depth $d=4n+3q$ suffices; the $n$ address bits and $q$ controls each occupy their own raw coordinate. Consequently exactly $q$ raw controls are necessary and sufficient for $2^q$ distinct anchored tags when depth can be chosen.

### Proof

**A limit that holds at arbitrary depth.** Read the [one-child sections](tournament.md) from root to address. Let $K$ count the distinct table entries so far after adjoining both constant functions. A layer introducing $g>0$ fresh bits gives $p=2^g$ section choices. Order settings by putting constant sections first and then by increasing cap. At reflected height $u=H-h$, all sections whose cap has passed have a fixed value for that setting. All remaining sections have the *same* live value $T(u)$. A tuple of ordinary outputs is thus a prefix of a fixed tuple followed by one repeated symbol. Among $K$ symbols there are $1+p(K-1)$ candidates: besides the fixed tuple, specify the first mismatch and its symbol. Full height adds at most one exceptional tuple. The candidates include the constant diagonals, hence
$$
K'\le 2+2^g(K-1)\le 2^gK .
$$
A layer with no new controls cannot increase $K$. Distinct sibling subtrees account for each exterior coordinate once. Starting at $K=2$ gives $K\le2^{q+1}$. The zero function cannot be positive at $z_*$.

**A matching program for a power-of-two target.** Store false and the empty conjunction. A full-cap layer reverses the table and appends a chosen old symbol. Two such layers prepend a desired symbol, preserve the old table, and append a filler. To introduce a new bit $b$, copy the needed old conjunctions and a false entry at a selected cap $D$, keeping another copy of each beyond $D$. Use cap $D$ at $b=0$, full cap at $b=1$, and a false endpoint. Past $D$ the output becomes $b\land T(u)$; the earlier entries preserve the old conjunctions. Iteration supplies every subset mask $S$ with tag $\bigwedge_{j\in S}z_j$.

The same sibling must implement both caps. In the four-row construction for a section, move its cap-blocking height between $H-D$ and zero. A non-base sibling realizes this using one raw bit: switch a child from one below full to full through a full-cap section with prescribed endpoint. Adjacent heights occur along actual Hamming-cube edges at the base and transport through a reflected gate at higher levels. Each newly controlled blocker is in its own subtree. For a list of $N$ desired masks, if $P_j$ is its set of distinct prefixes of length $j$, the program uses $2\sum_{j<q}|P_j|+3q+2N$ layers. Taking all masks and the repeated endpoint gives $N=n+1$ and the stated $4n+3q$. A Hamming center supplies the requested physical weight address.

**Three logical bits and seven physical controls.** At $n=128$, six exterior positions allow at most 127 anchored tags. Seven suffice at depth 533. Decode eight logical settings by setting all seven wires high at setting 0, and lowering only wire $j$ at setting $j=1,\ldots,7$. The 128 conjunctions have distinct failure sets on the seven nonzero settings. Attaching Bova's signed comparison gives 256 distinct responses. This is a simultaneous realization in one fixed host. The depth-533 claim is an existence bound. [Logical coding theorem](generalized-code.md)

**Communication corollary.** One party locally sets the address to a subset $S$; the other supplies the exterior zeros $Z$. The conjunction is true exactly when $S\cap Z=\varnothing$. This embeds ordinary set disjointness with these physical exterior bits, giving $\Omega(q)$ bounded-error randomized communication even with interaction by the classical disjointness theorem. The reduction is downstream of the raw compiler. [Kalyanasundaram and Schnitger, 1992](https://doi.org/10.1137/0405044)

### Full proof and verification

[Complete written proof (PDF)](raw-controls-proof.pdf) · [Lean source and replay instructions (ZIP)](raw-controls-lean.zip)

`PrefixWords.lean` checks the scalar prefix bound, freezing and recurrence, and selected local compiler identities. The physical-coordinate realization, whole-family extremal result and communication reduction are written proofs.

From the extracted directory with the pinned Lean 4.34.1 toolchain, run:

```sh
sha256sum -c SHA256SUMS
lake update
lake exe cache get
lake env lean PrefixWords.lean
```

[Research map](../README.md)
