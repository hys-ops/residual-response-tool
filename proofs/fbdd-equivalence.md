# Deterministic equivalence of free binary decision diagrams

**hys-ops · Paper 1 · Public research manuscript**

[Full manuscript (PDF)](../docs/files/FBDD_Equivalence_Manuscript.pdf) · [LaTeX and Lean source (ZIP)](../docs/files/FBDD_Equivalence_Source.zip) · [SHA-256 checksums](../docs/files/SHA256SUMS)

Two arbitrary FBDDs need not have the same variable order, even on different paths in an individual diagram. With $N$ total nodes and $n$ queried names, the manuscript gives a deterministic equivalence test in
$\operatorname{poly}(N)\min\{2^n,2^{O(N^{2/3}\log(N+2))}\}$ bit operations. Inequivalent inputs yield a Boolean disagreement witness.

The key is to fix variables outside a block and build a common list of tests for the remaining triangular recurrences. The quadratic local list bound is sharp. The matching global output bound applies only to two specified Cartesian-product output rules, not to arbitrary FBDD equivalence algorithms. A deterministic quasipolynomial algorithm remains a separate question.

The Lean 4.19.0 companion checks correctness, witness recovery, local sharpness, and cost components. Full bit-machine accounting and the assembly for the restricted output theorem are written arguments; see Appendix C for the distinction. No independent human review is recorded.

## Research contributions and AI use

hys-ops directed the research, starting from the question of what the rest of a computation can learn about a block of unfixed input. ChatGPT and Codex contributed to developing the mathematical arguments, drafting the manuscript, and writing the Lean formalization. The earlier [residual-response work](../README.md) motivated the question; it is not a theorem dependency.
