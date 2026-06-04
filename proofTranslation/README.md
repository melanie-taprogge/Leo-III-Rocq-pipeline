# Staged Leo Proof Translation Pipeline

This directory contains the staged proof translation pipeline used by this
repository.

## Main Entry Point

```bash
proofTranslation/translateProof2rocq.sh \
  PROOF_DIR \
  ROCQ_OUT \
  STDLIB_REPO \
  LEO_REPO
```

For the example proof directory, a minimal batch wrapper is available:

```bash
proofTranslation/translateProofBatch2rocq.sh STDLIB_REPO LEO_REPO
```

By default it translates `examples/lpFiles/*` to `examples/RocqTranslations/*`
and prints only per-proof status plus a final summary. Use `VERBOSE=1` to show
the underlying translator output.

Derived paths:

```text
STDLIB_LP_DIR = STDLIB_REPO/lambdapi-noOp, when present
LEO_LP_DIR    = LEO_REPO
LEO_ROCQ_DIR  = LEO_REPO/rocq
```

Otherwise `STDLIB_LP_DIR` falls back to `STDLIB_REPO`. Override these with
environment variables if a local checkout uses a different layout.

The translator copies `PROOF_DIR` to `ROCQ_OUT/_work` before preprocessing by
default. This keeps the original proof package unchanged. Set
`WORK_DIR=/path/to/work` to choose a different work directory, or
`LP_TRANSLATION_IN_PLACE=1` if the caller already provides a disposable copy.

`rename2_noOp.py` rewrites package/import roots to their `-noOp` variants by
default, including `Stdlib -> Stdlib-noOp`. This is required because the
translated Leo library imports the non-opaque standard-library package.

Set `LP_NOOP_REWRITE_EXCLUDE=PackageName` only for a package that must keep its
original root path.

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
  to DK with explicit `--map-dir` bindings for the stdlib and Leo dependency
  repositories. `SKIP_PROOF_INSTALL=1` is the default. Set
  `LP_EXPORT_USE_MAKE=1` to fall back to the proof package's `make dk` target.

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
  Rocq files with `coqc -Q . ''` plus the compiled library load paths. For the
  translated Leo repository layout, these are `LEO_ROCQ_DIR/partial_stdlib` and
  `LEO_ROCQ_DIR/leo_lib`.

## Notes

The Rocq export stage delegates to `support/helpers/dk_to_rocq.sh`, which
contains both the Lambdapi `stt_coq` call and the Rocq postprocessing fixes.

The orchestrator emits `PHASE_TIME` lines for per-stage timing.
