# Usage

## Translate One Proof Package

```bash
proofTranslation/translateProof2rocq.sh \
  PROOF_DIR \
  ROCQ_OUT \
  STDLIB_NOOP_DIR \
  LEOLIB_NOOP_DIR \
  ROCQ_LEO_SLICE
```

Arguments:

```text
PROOF_DIR       Lambdapi proof package directory
ROCQ_OUT        output directory for generated Rocq files
STDLIB_NOOP_DIR non-opaque Lambdapi stdlib source/DK directory
LEOLIB_NOOP_DIR non-opaque Leo Lambdapi library source/DK directory
ROCQ_LEO_SLICE  compiled Rocq library slice used by coqc
```

Default environment:

```text
SKIP_PROOF_INSTALL=1
SKIP_DK_CHECK=1
DROP_IMPORTS_REGEX=Prop|Set|Nat|List
```

`SKIP_PROOF_INSTALL=1` avoids a duplicate package install/check pass before DK
export. Lambdapi still checks the source files during `make dk`.

Set `SKIP_DK_CHECK=0` to run the optional Dedukti check stage.
