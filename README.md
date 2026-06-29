# Leo-III to Rocq Translation Pipeline

This repository contains the current staged scripts for translating one Leo-III
Lambdapi proof package to Rocq through Dedukti. 
It also contains some documentation, and some example Leo-III files and their translations. 

The pipeline is intentionally staged, a description can be found in [here](./docs/stages.md). The main proof translator is:

```bash
proofTranslation/translateProof2rocq.sh
```

## Quickstart

After cloning this repository and the two companion library repositories, run
the bundled example translations with:

```bash
proofTranslation/translateProofBatch2rocq.sh \
  /path/to/lambdapi-stdlib-rocq \
  /path/to/Leo-III-lambdapi-lib-rocq
```

This translates proof packages from:

```text
examples/lpFiles
```

to:

```text
examples/RocqTranslations
```

Use `VERBOSE=1` to print the full log for each proof.

It translates one proof package:

```bash
proofTranslation/translateProof2rocq.sh \
  /path/to/proof-package \
  /path/to/rocq-output \
  /path/to/lambdapi-stdlib-rocq \
  /path/to/Leo-III-lambdapi-lib-rocq
```

For details, refer to the [usage.md](./docs/usage.md).

The proof package is expected to contain:

- `lambdapi.pkg`
- a Makefile with `clean`, `dk`, and optionally `install` targets
- `encodedProof.lp`
- optionally `Signature.lp`
- optionally `Formulae.lp`

The output directory contains generated `.v` files, `order.txt`, and a
`_CoqProject` file suitable for VSCode/vscoq and command-line checking.

## Dependency Repositories

This pipeline expects two companion repositories:

- Lambdapi standard-library Rocq translation:
  `https://github.com/melanie-taprogge/lambdapi-stdlib/tree/extended_stdlib_encoding`
- Leo-III Lambdapi library Rocq translation:
  `https://github.com/melanie-taprogge/Leo-III-lambdapi-lib-rocq/tree/mainL`

The standard-library repository is used on the Lambdapi/DK side. Its root may
keep the upstream standard-library package root `Stdlib`. For proof export, the
pipeline creates a temporary non-opaque dependency copy with package root
`Stdlib-noOp`.

In batch mode this copy is shared by all proofs in the batch under
`OUTPUT_ROOT/_deps/Stdlib-noOp`. In single-proof mode it is created under
`ROCQ_OUT/_deps/Stdlib-noOp` unless `STDLIB_LP_DIR` is set explicitly.

The Leo-III library repository is used on both sides:

- a temporary non-opaque copy of its root source is used as the Lambdapi/DK
  dependency for Leo library imports;
- its `rocq/` subdirectory is used as the compiled Rocq library dependency when
  checking generated proof files.

The generated temporary Leo dependency has package root
`Leo-III-lambdapi-lib-noOp`.

If your local checkout uses a different layout, keep the same command-line
arguments and override the derived paths with:

```bash
STDLIB_LP_DIR=/path/to/stdlib-lp \
LEO_LP_DIR=/path/to/leo-lp \
LEO_ROCQ_DIR=/path/to/leo-rocq \
proofTranslation/translateProof2rocq.sh PROOF_DIR ROCQ_OUT STDLIB_REPO LEO_REPO
```

For repeated runs over the same batch output directory, set `REUSE_DEPS=1` to
reuse an existing valid `OUTPUT_ROOT/_deps` cache.

## Required External Tools

The scripts expect the following commands to be available:

- `lambdapi`
- `coqc` or `rocq compile`
- `dk` only when optional DK checking is enabled
- `python3`

The scripts are written for `bash` and are intended to run on both macOS and
Linux. The proof translator detects a usable UTF-8 locale at runtime. If the
host has an unusual locale setup, set `LP_ROCQ_LOCALE` to a valid UTF-8 locale,
for example `C.UTF-8` on many Linux systems or `en_US.UTF-8` on macOS.

## Repository Layout

```text
proofTranslation/
  translateProof2rocq.sh
  stages/
    00_prepare_lp_package.sh
    05_prepare_lp_dependencies.sh
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
snapshots and not the scripts for translating those libraries. It relies on the
two companion repositories above for Lambdapi/DK dependencies and for the
compiled Rocq library used during proof checking.
