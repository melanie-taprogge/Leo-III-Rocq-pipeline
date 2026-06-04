# Leo-III to Rocq Translation Pipeline

This repository contains the current staged scripts for translating one Leo-III
Lambdapi proof package to Rocq through Dedukti.

The pipeline is intentionally staged. The main proof translator is:

```bash
proofTranslation/translateProof2rocq.sh
```

It translates one proof package:

```bash
proofTranslation/translateProof2rocq.sh \
  /path/to/proof-package \
  /path/to/rocq-output \
  /path/to/lambdapi-stdlib-noOp_R \
  /path/to/Leo-III-lambdapi-lib-noOp_R \
  /path/to/rocq_leo_slice
```

The proof package is expected to contain:

- `lambdapi.pkg`
- a Makefile with `clean`, `dk`, and optionally `install` targets
- `encodedProof.lp`
- optionally `Signature.lp`
- optionally `Formulae.lp`

The output directory contains generated `.v` files, `order.txt`, and a
`_CoqProject` file suitable for VSCode/vscoq and command-line checking.

## Required External Tools

The scripts expect the following commands to be available:

- `lambdapi`
- `coqc` or `rocq compile`
- `dk` only when optional DK checking is enabled
- `python3`

## Repository Layout

```text
proofTranslation/
  translateProof2rocq.sh
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

docs/
  usage.md
  stages.md
  workarounds.md
```

## Current Design Assumption

This repository contains the proof translation pipeline, not translated library
snapshots and not the scripts for translating those libraries. The proof
translator takes the non-opaque Lambdapi stdlib, the non-opaque Leo library, and
the compiled Rocq Leo slice as arguments. In the current workspace that Rocq
slice is produced by the separate Leo-III Lambdapi library Rocq translation
repository.
