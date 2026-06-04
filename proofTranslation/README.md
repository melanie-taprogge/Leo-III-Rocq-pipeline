# Staged Leo Proof Translation Pipeline

This directory contains the staged proof translation pipeline used by this
repository.

## Main Entry Point

```bash
proofTranslation/translateProof2rocq.sh \
  PROOF_DIR \
  ROCQ_OUT \
  STDLIB \
  LEOLIB \
  ROCQ_LIB
```

Defaults:

```text
PROOF_DIR  = sampleProofs/lpProof_sur_cantor_orig
ROCQ_OUT   = rocq_proof_cantor_new
STDLIB     = lambdapi-stdlib-noOp_R
LEOLIB     = Leo-III-lambdapi-lib-noOp_R
ROCQ_LIB   = rocq_leo_slice
```

## Stage Layout

```text
stages/
  00_prepare_lp_package.sh
  10_export_lp_to_dk.sh
  20_postprocess_dk_for_rocq.sh
  30_postprocess_dk_for_dkcheck.sh
  35_check_dk.sh
  40_rename_rocq_collisions.sh
  50_export_dk_to_rocq.sh
  70_check_rocq.sh
  helpers/

support/
  helpers/
    dk_to_rocq.sh
    rename2_noOp.py
    rename_local_collisions.py
  rocq_files/
    encoding.lp
    mappings.lp
    mappings.v
```

Current phase meaning:

- `00_prepare_lp_package.sh`
  Verifies that the proof package provides a Makefile, removes `opaque`
  modifiers from local proof LP files, and rewrites package/import names to the
  `-noOp` copies. It no longer replaces package Makefiles.

- `10_export_lp_to_dk.sh`
  Runs `make clean`, optionally runs `make install`, then exports local LP files
  to DK. `SKIP_PROOF_INSTALL=1` is the default.

- `20_postprocess_dk_for_rocq.sh`
  Removes tactic-only DK requires and strips generated package/library prefixes
  from DK module references when the unprefixed target module exists.

- `30_postprocess_dk_for_dkcheck.sh`
  Placeholder for DK-check-only cleanup. No extra DK-check-only rewrite is
  currently required.

- `35_check_dk.sh`
  Optional DK compilation/checking. The main orchestrator runs this only when
  `SKIP_DK_CHECK=0`.

- `40_rename_rocq_collisions.sh`
  Renames local proof DK declarations whose names collide with globally mapped
  Rocq names. This preserves the proof-local declarations and prevents them
  from being accidentally captured by unrelated stdlib/Rocq mappings.

- `50_export_dk_to_rocq.sh`
  Exports DK files to Rocq using the local `support/helpers/dk_to_rocq.sh`
  helper and writes
  `order.txt`.

- `70_check_rocq.sh`
  Writes `_CoqProject` for the generated proof package and checks the generated
  Rocq files with `coqc -Q . '' -Q ROCQ_LIB ''`.

## Notes

The Rocq export stage delegates to `support/helpers/dk_to_rocq.sh`, which
contains both the Lambdapi `stt_coq` call and the Rocq postprocessing fixes.

The orchestrator emits `PHASE_TIME` lines for per-stage timing.
