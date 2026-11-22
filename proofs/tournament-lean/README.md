# Reproduce the Lean check for the tournament response words

From this directory, with Elan installed, run:

```sh
lean --version
lean Lookup.lean
```

The pinned toolchain is Lean 4.34.1. The source imports only `Std`.
The recorded run reported `propext`, `Classical.choice` and `Quot.sound` for `TournamentLookup.exact_language`.

The declaration verifies the abstract response-word classification in §3 of the full written proof. Its stage index equals the tournament depth minus one. The scalar and decoding lemmas cover selected supporting steps. It does not formalize the translation from the original raw tournament clauses in §2 or the end-to-end communication and other applications in §4.
