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
  It is important that the proof package, the stdlib dependency, and the Leo
  dependency agree on these roots. In particular, mixing `Stdlib` and
  `Stdlib-noOp` gives two different copies of symbols such as list `𝕃`, which
  can surface as Lambdapi unification failures during DK export.
  The stdlib repository keeps upstream files at top level and stores the
  non-opaque `Stdlib-noOp` source copy in `lambdapi-noOp/`.


## Dedukti Detour Artifacts

- DK quoted identifiers such as `{|π|}` do not directly match the Rocq mapping
  and encoding files.
  `dk_to_rocq.sh` temporarily rewrites quoted identifiers to ASCII names for
  Lambdapi export, then restores Rocq-parseable Unicode names after export.

- DK `#REQUIRE` lines are reconstructed as Rocq `Require Import` lines.
  The pipeline extracts DK requires before `stt_coq`, removes them from the
  temporary DK file, and prepends the corresponding Rocq imports after export.
  This lets the pipeline drop imports for library modules that are not meant to
  exist as generated Rocq files, such as `Prop` and `Set`, because those are
  handled by native Rocq and the shared `mappings` support file. It also lets
  the pipeline consistently add `Require Import mappings.` to every generated
  Rocq file. In addition, DK require statements can contain quoted module names
  such as `{|Stdlib-noOp_Nat|}` because the hyphenated package prefix is not a
  plain DK identifier. These quoted module names are another reason to
  reconstruct imports explicitly instead of relying on the raw `stt_coq`
  translation of the require lines.

- DK rewrite rules are dropped before Rocq export.
  Rocq does not import these rewrite rules as definitional computation, and
  some rewrite-rule shapes make the DK-to-Rocq exporter fail.

- Module qualifiers introduced by the DK detour are stripped after imports have
  been reconstructed.
  This is required for modules whose symbols are mapped to native/global Rocq
  definitions or to the shared shim file. A qualified DK reference such as
  `Nat.N`, `Eq.eq`, or `{|Nat|}.{|ℕ|}` must become a bare source symbol before
  `mappings.lp` can redirect it to the intended Rocq definition.
  Otherwise `stt_coq` can preserve the module qualification in a way that does
  not interact with the mapping layer: if a DK symbol `Nat.N` is mapped to
  native Rocq `nat`, then a reference printed as `Nat.nat` is wrong, because
  the generated/imported `Nat.v` does not define a field named `nat`.

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

- DK export uses explicit Lambdapi `--map-dir` bindings for the non-opaque
  stdlib and Leo dependency repositories.
  This prevents the export step from accidentally picking up a globally
  installed package with the same root.

- `UserTactic` DK requires are removed.
  Tactic files are consumed during Lambdapi checking/export and are not Rocq
  translation targets in this route.

- Generated proof/stdlib/Leo module prefixes are stripped when the unprefixed
  target module exists.
  Rocq module names cannot use package names with hyphens in the same way.
  The quoted module names seen after DK export are often a consequence of these
  hyphenated package roots. For example, `Stdlib-noOp_Nat` is not a plain DK
  identifier because of the hyphen, so DK writes it as
  `{|Stdlib-noOp_Nat|}`. After prefix stripping this can leave quoted short
  module names such as `{|Nat|}` even though `Nat` itself would not need
  quoting. This quoting is therefore mostly an artifact of using renamed
  non-opaque package copies plus a postprocessing step that shortens module
  names.

## Local/Global Name Collisions

The exporter and mapping layer can otherwise confuse a local proof symbol with a
global stdlib/Rocq mapping. The collision renamer:

- scans generated DK files for local declarations,
- compares them with globally mapped names and known Rocq constructors,
- renames local declarations consistently across the proof package.

This is a local workaround for namespace flattening during export.

For Leo-generated proof packages, the better long-term fix is to avoid emitting
local problem symbols whose source names are already reserved by the imported
libraries or by `mappings.lp`. For example, if the mapping layer says that the
source name `comp` denotes the stdlib comparison carrier, then a generated
problem signature should not also declare a local symbol named `comp`. That is a
Leo file-generation issue rather than a Lambdapi bug: the translation is doing
what the mapping file asked it to do.

This is separate from collisions with the Rocq target name. In a small test, if
a local DK file declares a symbol already named `comparison'` while another
symbol is mapped to Rocq `comparison'`, the exporter renames the local symbol to
`comparison'__alt__`. The problematic case for this pipeline is therefore the
source-side collision with globally mapped names, not ordinary reuse of a Rocq
target identifier.

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
-Q /path/to/Leo-III-lambdapi-lib-rocq/rocq/partial_stdlib ""
-Q /path/to/Leo-III-lambdapi-lib-rocq/rocq/leo_lib ""
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
