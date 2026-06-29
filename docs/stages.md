# Pipeline Stages

The main orchestrator is:

```text
proofTranslation/translateProof2rocq.sh
```

Documentation of the various workarounds the pipeline performs is given [here](workarounds.md).

It calls the following stages.

## `00_prepare_lp_package.sh`

Checks that the proof package provides a Makefile, removes `opaque` modifiers
from local `.lp` files, and rewrites package names/imports to the `-noOp`
variants with `rename2_noOp.py`.

`Stdlib` imports are rewritten to `Stdlib-noOp`, and Leo library imports are
rewritten to `Leo-III-lambdapi-lib-noOp`. This avoids loading two distinct
copies of the standard library in one proof package.

The `opaque` removal is implemented in Python rather than via `perl -i`, so it
does not depend on platform-specific in-place editing behavior or locale quirks.

## `05_prepare_lp_dependencies.sh`

Creates non-opaque Lambdapi dependency copies from the two companion
repositories:

```text
DEPS_DIR/Stdlib-noOp
DEPS_DIR/Leo-III-lambdapi-lib-noOp
```

The stage copies `*.lp` files and `lambdapi.pkg`, removes `opaque` modifiers,
and rewrites package roots/imports to `-noOp`. In batch mode this stage runs
once before the proof loop, so all proofs share the same prepared dependencies.
Set `REUSE_DEPS=1` to reuse an existing valid dependency cache.

## `10_export_lp_to_dk.sh`

Runs `make clean`, optionally runs `make install`, and then exports the proof
package `.lp` files to `.dk`.

By default this stage calls `lambdapi export` directly with explicit dependency
bindings:

```text
--map-dir=Stdlib-noOp:STDLIB_LP_DIR
--map-dir=Leo-III-lambdapi-lib-noOp:LEO_LP_DIR
```

This avoids accidentally resolving `Stdlib-noOp` or the Leo package through a
globally installed package instead of the repository paths passed to the
pipeline. Set `LP_EXPORT_USE_MAKE=1` to use the proof package's `make dk`
target instead.

By default `SKIP_PROOF_INSTALL=1`, so the initial install pass is skipped.
Lambdapi still checks source files during DK export.

## `20_postprocess_dk_for_rocq.sh`

Performs DK cleanup needed for Rocq export:

- removes `UserTactic` DK requires.

Current Lambdapi emits DK module names with the expected unprefixed target names,
so the old module-prefix rewrite is no longer part of this stage.

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

In the future, this step can be avoided by improving Leo-III proof generation.

## `50_export_dk_to_rocq.sh`

Exports DK files to Rocq in proof-package order:

```text
Signature.dk
Formulae.dk
other local DK files
encodedProof.dk
```

For each file it calls `dk_to_rocq.sh`, which reconstructs Rocq imports,
dequalifies mapped DK module references, generates temporary renamings for
unmapped DK identifiers that Rocq cannot parse directly, invokes Lambdapi's
`stt_coq` exporter, and applies the remaining targeted Rocq postprocessing
fixes. The generated renaming file covers both local declarations and invalid
components in qualified imported references, for example `Formulae.1_p0`.

The stage writes `order.txt`.

## `70_check_rocq.sh`

Writes `_CoqProject` for the generated proof package and checks generated Rocq
files with:

```bash
coqc -Q . "" -Q LEO_ROCQ_DIR/partial_stdlib "" -Q LEO_ROCQ_DIR/leo_lib "" FILE.v
```

The local `-Q . ""` binding is needed so generated files can import local
modules such as `Signature` and `Formulae` in VSCode/vscoq and at the command
line.

In the public translator interface, this Rocq directory is derived as
`LEO_REPO/rocq` and can be overridden with `LEO_ROCQ_DIR`. The stage also still
accepts the older flat layout where `mappings.vo` is directly in `LEO_ROCQ_DIR`.
