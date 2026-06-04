# Pipeline Stages

The main orchestrator is:

```text
proofTranslation/translateProof2rocq.sh
```

It calls the following stages.

## `00_prepare_lp_package.sh`

Checks that the proof package provides a Makefile, removes `opaque` modifiers
from local `.lp` files, and rewrites package names/imports to the `-noOp`
variants with `rename2_noOp.py`.

The `opaque` removal is implemented in Python rather than via `perl -i`, so it
does not depend on platform-specific in-place editing behavior or locale quirks.

## `10_export_lp_to_dk.sh`

Runs `make clean`, optionally runs `make install`, and then runs `make dk`.

By default `SKIP_PROOF_INSTALL=1`, so the initial install pass is skipped.
Lambdapi still checks source files during DK export.

## `20_postprocess_dk_for_rocq.sh`

Performs DK cleanup needed for Rocq export:

- removes `UserTactic` DK requires,
- strips generated proof/stdlib/Leo module prefixes when the unprefixed target
  module exists.

## `30_postprocess_dk_for_dkcheck.sh`

Reserved for DK-check-only cleanup. No extra DK-check-only transformation is
currently required.

## `35_check_dk.sh`

Optional Dedukti checking stage. It computes local DK dependency order and runs
`dk check` with the stdlib and Leo library paths.

This stage is skipped unless `SKIP_DK_CHECK=0`.

## `40_rename_rocq_collisions.sh`

Calls `rename_local_collisions.py`.

This scans local DK declarations and renames any proof-local symbol whose name
would collide with a globally mapped Rocq/stdlib name. The purpose is to
preserve the proof-local declaration, not to use the global Rocq mapping.

For example, if a proof declares its own local symbol named `comp`, that symbol
must be translated as a local proof symbol. Without this renaming pass, the
global stdlib mapping for `Comp.comp` can accidentally capture the local name
and rewrite it to the unrelated Rocq comparison carrier. The helper therefore
renames the local declaration consistently across the proof package, for
example `comp -> lp_local_comp`, while leaving genuine stdlib references free
to use the global mapping.

## `50_export_dk_to_rocq.sh`

Exports DK files to Rocq in proof-package order:

```text
Signature.dk
Formulae.dk
other local DK files
encodedProof.dk
```

For each file it calls `dk_to_rocq.sh`, which invokes Lambdapi's `stt_coq`
exporter and applies the current Rocq postprocessing fixes.

The stage writes `order.txt`.

## `70_check_rocq.sh`

Writes `_CoqProject` for the generated proof package and checks generated Rocq
files with:

```bash
coqc -Q . "" -Q ROCQ_LEO_SLICE "" FILE.v
```

The local `-Q . ""` binding is needed so generated files can import local
modules such as `Signature` and `Formulae` in VSCode/vscoq and at the command
line.
