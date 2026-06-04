# Workarounds And Translation Notes

This document lists the current nontrivial preprocessing/postprocessing steps
in the Leo-III Lambdapi-to-Rocq proof pipeline.

## Source Preparation

- `opaque` modifiers are removed from local proof package files.
  This is required because the DK route needs proofs to be materialized as proof
  terms rather than hidden behind opacity.

- Package names/imports are rewritten to `-noOp` variants.
  The current translation uses non-opaque stdlib and Leo library copies so that
  definitions needed by proofs can unfold before DK/Rocq export.


## Dedukti Detour Artifacts

- DK quoted identifiers such as `{|π|}` do not directly match the Rocq mapping
  and encoding files.
  `dk_to_rocq.sh` temporarily rewrites quoted identifiers to ASCII names for
  Lambdapi export, then restores Rocq-parseable Unicode names after export.

- DK `#REQUIRE` lines are reconstructed as Rocq `Require Import` lines.

- DK rewrite rules are dropped before Rocq export.
  Rocq does not import these rewrite rules as definitional computation, and
  some rewrite-rule shapes make the DK-to-Rocq exporter fail.

- Module qualifiers introduced by the DK detour are stripped after imports have
  been reconstructed.

## Rocq Mapping And Shim Layer

- `proofTranslation/support/rocq_files/mappings.v` provides the
  Rocq-side support layer.
  It maps core Lambdapi symbols to native Rocq propositions, equality, Bool,
  Nat, and list support where appropriate.

- `proofTranslation/support/rocq_files/mappings.lp` tells
  Lambdapi's Rocq exporter which symbols should be mapped to these Rocq
  definitions.

- Some theorem proof terms are replaced by already checked Rocq shim lemmas.
  This is necessary when Lambdapi/Dedukti rewrite rules made a fact
  definitional, but native Rocq computation does not.

## Proof-Package DK Cleanup

- `UserTactic` DK requires are removed.
  Tactic files are consumed during Lambdapi checking/export and are not Rocq
  translation targets in this route.

- Generated proof/stdlib/Leo module prefixes are stripped when the unprefixed
  target module exists.
  Rocq module names cannot use package names with hyphens in the same way.

## Local/Global Name Collisions

The exporter and mapping layer can otherwise confuse a local proof symbol with a
global stdlib/Rocq mapping. The collision renamer:

- scans generated DK files for local declarations,
- compares them with globally mapped names and known Rocq constructors,
- renames local declarations consistently across the proof package.

This is a local workaround for namespace flattening during export.

## Equality Printing Fixes

`dk_to_rocq.sh` rewrites several generated equality forms to explicit native
Rocq equality, for example:

```coq
(eq nat)        -> (@eq nat)
(eq (nat -> o)) -> (@eq (nat -> o))
```

It also rewrites malformed partially-applied equality predicates to explicit
lambda predicates in cases observed in Leo proof packages.

## Generated Rocq Project Files

Each generated proof package gets:

```text
_CoqProject
order.txt
```

The `_CoqProject` file contains:

```text
-Q . ""
-Q /path/to/rocq_leo_slice ""
...
```

The local `-Q . ""` binding is needed for local imports such as `Formulae` and
`Signature`.

## Optional DK Checking

The default proof path skips DK object checking:

```text
SKIP_DK_CHECK=1
```

This does not skip Lambdapi source checking: Lambdapi rechecks files during DK
export. DK checking is optional because current exported DK libraries can expose
rewrite-rule/static-symbol issues that are not needed for the Rocq proof
checking path.
