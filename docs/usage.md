# Usage

## Translate One Proof Package

```bash
proofTranslation/translateProof2rocq.sh \
  PROOF_DIR \
  ROCQ_OUT \
  STDLIB_REPO \
  LEO_REPO
```

Arguments:

```text
PROOF_DIR   Lambdapi proof package directory
ROCQ_OUT    output directory for generated Rocq files
STDLIB_REPO Lambdapi standard-library Rocq-translation repository
LEO_REPO    Leo-III Lambdapi library repository; LEO_REPO/rocq is used by coqc
```

Default environment:

```text
SKIP_PROOF_INSTALL=1
SKIP_DK_CHECK=1
DROP_IMPORTS_REGEX=Prop|Set|Nat|List
LP_ROCQ_LOCALE=<auto-detected UTF-8 locale>
STDLIB_LP_DIR=STDLIB_REPO/lambdapi-noOp if present, otherwise STDLIB_REPO
LEO_LP_DIR=LEO_REPO
LEO_ROCQ_DIR=LEO_REPO/rocq
LP_NOOP_REWRITE_EXCLUDE=<empty>
WORK_DIR=ROCQ_OUT/_work
LP_TRANSLATION_IN_PLACE=0
LP_EXPORT_USE_MAKE=0
```

`SKIP_PROOF_INSTALL=1` avoids a duplicate package install/check pass before DK
export. Lambdapi still checks the source files during `make dk`.

Set `SKIP_DK_CHECK=0` to run the optional Dedukti check stage.

The DK export stage uses explicit `--map-dir` bindings for `STDLIB_LP_DIR` and
`LEO_LP_DIR` by default. Set `LP_EXPORT_USE_MAKE=1` only when you intentionally
want to delegate DK export to the proof package's `make dk` target and accept
that dependency lookup is then controlled by that Makefile/Lambdapi environment.

The translator detects a usable UTF-8 locale instead of hard-coding a
platform-specific one. Override it with `LP_ROCQ_LOCALE` if needed.

The two repository arguments are the intended public interface. The `*_DIR`
environment variables are only for nonstandard local layouts.

`STDLIB_REPO` should point at the standard-library translation repository root.
The root may keep the upstream `Stdlib` package. For proof export, the
translator automatically uses `STDLIB_REPO/lambdapi-noOp` when that directory
contains `lambdapi.pkg`; this subdirectory must have `root_path = Stdlib-noOp`.

`LEO_REPO` must point at the translated Leo library repository root. It must
contain `lambdapi.pkg` with `root_path = Leo-III-lambdapi-lib-noOp`.

The direct proof translator does not mutate `PROOF_DIR` by default. It copies
the package to `WORK_DIR`, which defaults to `ROCQ_OUT/_work`, and performs LP
preparation and DK export there. Set `LP_TRANSLATION_IN_PLACE=1` only if the
caller already copied the proof package to a disposable work directory.

During proof preparation, imports are rewritten to the `-noOp` Leo package
layout used by the translated Leo repository. `Stdlib` imports are also
rewritten to `Stdlib-noOp`, because the Leo library imports the non-opaque
standard-library package. Mixing `Stdlib` and `Stdlib-noOp` in one proof package
creates distinct copies of standard-library symbols such as `𝕃`.

Set `LP_NOOP_REWRITE_EXCLUDE=PackageName` only for a package that must keep its
original root path.
