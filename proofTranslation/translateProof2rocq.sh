#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROOF_TRANSLATION_ROOT="$ROOT/proofTranslation"
STAGE_ROOT="$PROOF_TRANSLATION_ROOT/stages"
SUPPORT_ROOT="$PROOF_TRANSLATION_ROOT/support"

PROOF_DIR="${1:-$ROOT/sampleProofs/lpProof_sur_cantor_orig}"
OUT="${2:-$ROOT/rocq_proof_cantor_new}"
STDLIB="${3:-$ROOT/lambdapi-stdlib-noOp_R}"
LEOLIB="${4:-$ROOT/Leo-III-lambdapi-lib-noOp_R}"
ROCQ_LIB="${5:-$ROOT/rocq_leo_slice}"

PROOF_DIR="$(cd "$PROOF_DIR" && pwd)"
mkdir -p "$OUT"
OUT="$(cd "$OUT" && pwd)"
STDLIB="$(cd "$STDLIB" && pwd)"
LEOLIB="$(cd "$LEOLIB" && pwd)"
ROCQ_LIB="$(cd "$ROCQ_LIB" && pwd)"

source "$STAGE_ROOT/helpers/timing.sh"

export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"
export LC_CTYPE="${LC_CTYPE:-en_US.UTF-8}"
if [ "$LANG" = "C.UTF-8" ]; then
  export LANG="en_US.UTF-8"
fi
if [ "$LC_ALL" = "C.UTF-8" ]; then
  export LC_ALL="en_US.UTF-8"
fi
if [ "$LC_CTYPE" = "C.UTF-8" ]; then
  export LC_CTYPE="en_US.UTF-8"
fi

run_phase() {
  local name="$1"
  shift
  phase_start "$name"
  "$@"
  phase_end
}

echo "Translating proof package to Rocq"
echo "  proof:    $PROOF_DIR"
echo "  output:   $OUT"
echo "  stdlib:   $STDLIB"
echo "  leo lib:  $LEOLIB"
echo "  rocq lib: $ROCQ_LIB"

run_phase "lp_prepare" \
  "$STAGE_ROOT/00_prepare_lp_package.sh" "$PROOF_DIR" "$SUPPORT_ROOT"

run_phase "dk_export" \
  "$STAGE_ROOT/10_export_lp_to_dk.sh" "$PROOF_DIR"

run_phase "dk_postprocess_for_rocq" \
  "$STAGE_ROOT/20_postprocess_dk_for_rocq.sh" "$PROOF_DIR" "$STDLIB" "$LEOLIB" "$STAGE_ROOT"

if [ "${SKIP_DK_CHECK:-1}" = "1" ]; then
  echo "Skipping optional DK check because SKIP_DK_CHECK=1"
else
  run_phase "dk_postprocess_for_dkcheck" \
    "$STAGE_ROOT/30_postprocess_dk_for_dkcheck.sh" "$PROOF_DIR"
  run_phase "dk_check" \
    "$STAGE_ROOT/35_check_dk.sh" "$PROOF_DIR" "$STDLIB" "$LEOLIB" "$STAGE_ROOT"
fi

run_phase "collision_rename" \
  "$STAGE_ROOT/40_rename_rocq_collisions.sh" "$PROOF_DIR" "$SUPPORT_ROOT"

echo "Preparing Rocq proof output in $OUT"
run_phase "rocq_export" \
  "$STAGE_ROOT/50_export_dk_to_rocq.sh" "$PROOF_DIR" "$OUT" "$SUPPORT_ROOT" "$STAGE_ROOT"

echo "Checking Rocq files"
run_phase "rocq_check" \
  "$STAGE_ROOT/70_check_rocq.sh" "$OUT" "$ROCQ_LIB"

echo "Rocq proof translation checked successfully in $OUT"
