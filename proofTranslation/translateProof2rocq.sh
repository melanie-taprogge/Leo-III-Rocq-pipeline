#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROOF_TRANSLATION_ROOT="$ROOT/proofTranslation"
STAGE_ROOT="$PROOF_TRANSLATION_ROOT/stages"
SUPPORT_ROOT="$PROOF_TRANSLATION_ROOT/support"

usage() {
  cat <<'EOF'
Usage:
  proofTranslation/translateProof2rocq.sh PROOF_DIR ROCQ_OUT STDLIB_REPO LEO_REPO

Arguments:
  PROOF_DIR    Lambdapi proof package directory.
  ROCQ_OUT     Output directory for generated Rocq files.
  STDLIB_REPO  Lambdapi standard-library Rocq-translation repository.
  LEO_REPO     Leo-III Lambdapi library repository with checked Rocq output
               under LEO_REPO/rocq.

Environment overrides for nonstandard repository layouts:
  STDLIB_LP_DIR  Non-opaque Lambdapi stdlib source/DK path. Defaults to
                 STDLIB_REPO/lambdapi-noOp when present, otherwise STDLIB_REPO.
  LEO_LP_DIR     Lambdapi Leo library source/DK path. Defaults to LEO_REPO.
  LEO_ROCQ_DIR   Compiled Rocq Leo library path. Defaults to LEO_REPO/rocq.
EOF
}

if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
  usage
  exit 0
fi

if [ "$#" -lt 4 ]; then
  usage >&2
  exit 2
fi

SOURCE_PROOF_DIR="$1"
OUT="$2"
STDLIB_REPO="$3"
LEO_REPO="$4"
STDLIB_LP_DIR="${STDLIB_LP_DIR:-}"
LEO_LP_DIR="${LEO_LP_DIR:-$LEO_REPO}"
LEO_ROCQ_DIR="${LEO_ROCQ_DIR:-$LEO_REPO/rocq}"

SOURCE_PROOF_DIR="$(cd "$SOURCE_PROOF_DIR" && pwd)"
mkdir -p "$OUT"
OUT="$(cd "$OUT" && pwd)"
STDLIB_REPO="$(cd "$STDLIB_REPO" && pwd)"
LEO_REPO="$(cd "$LEO_REPO" && pwd)"
if [ -z "$STDLIB_LP_DIR" ]; then
  if [ -f "$STDLIB_REPO/lambdapi-noOp/lambdapi.pkg" ]; then
    STDLIB_LP_DIR="$STDLIB_REPO/lambdapi-noOp"
  else
    STDLIB_LP_DIR="$STDLIB_REPO"
  fi
fi
STDLIB_LP_DIR="$(cd "$STDLIB_LP_DIR" && pwd)"
LEO_LP_DIR="$(cd "$LEO_LP_DIR" && pwd)"
LEO_ROCQ_DIR="$(cd "$LEO_ROCQ_DIR" && pwd)"

WORK_DIR="${WORK_DIR:-$OUT/_work}"
if [ "${LP_TRANSLATION_IN_PLACE:-0}" = "1" ]; then
  PROOF_DIR="$SOURCE_PROOF_DIR"
else
  WORK_PARENT="$(mkdir -p "$(dirname "$WORK_DIR")" && cd "$(dirname "$WORK_DIR")" && pwd)"
  WORK_DIR="$WORK_PARENT/$(basename "$WORK_DIR")"
  if [ "$WORK_DIR" = "$SOURCE_PROOF_DIR" ]; then
    echo "Error: WORK_DIR must differ from PROOF_DIR unless LP_TRANSLATION_IN_PLACE=1" >&2
    exit 2
  fi
  rm -rf "$WORK_DIR"
  mkdir -p "$WORK_DIR"
  cp -R "$SOURCE_PROOF_DIR/." "$WORK_DIR/"
  PROOF_DIR="$WORK_DIR"
fi

source "$STAGE_ROOT/helpers/timing.sh"
source "$STAGE_ROOT/helpers/locale.sh"
export_utf8_locale

require_pkg_root() {
  local dir="$1"
  local expected="$2"
  local label="$3"
  local pkg="$dir/lambdapi.pkg"

  if [ ! -f "$pkg" ]; then
    echo "Error: $label has no lambdapi.pkg: $dir" >&2
    exit 2
  fi

  local root
  root="$(sed -n 's/^[[:space:]]*root_path[[:space:]]*=[[:space:]]*//p' "$pkg" | head -1 | tr -d '[:space:]')"
  if [ "$root" != "$expected" ]; then
    echo "Error: $label must have root_path = $expected for this pipeline." >&2
    echo "       Found root_path = ${root:-<missing>} in $pkg" >&2
    echo "       This proof pipeline rewrites imports to the non-opaque -noOp packages." >&2
    exit 2
  fi
}

require_pkg_root "$STDLIB_LP_DIR" "Stdlib-noOp" "standard-library Lambdapi source"
require_pkg_root "$LEO_LP_DIR" "Leo-III-lambdapi-lib-noOp" "Leo-III Lambdapi source"

run_phase() {
  local name="$1"
  shift
  phase_start "$name"
  "$@"
  phase_end
}

echo "Translating proof package to Rocq"
echo "  proof:        $SOURCE_PROOF_DIR"
echo "  work:         $PROOF_DIR"
echo "  output:       $OUT"
echo "  stdlib repo:  $STDLIB_REPO"
echo "  leo repo:     $LEO_REPO"
echo "  stdlib LP:    $STDLIB_LP_DIR"
echo "  leo LP:       $LEO_LP_DIR"
echo "  leo Rocq dir: $LEO_ROCQ_DIR"

run_phase "lp_prepare" \
  "$STAGE_ROOT/00_prepare_lp_package.sh" "$PROOF_DIR" "$SUPPORT_ROOT"

run_phase "dk_export" \
  "$STAGE_ROOT/10_export_lp_to_dk.sh" "$PROOF_DIR" "$STDLIB_LP_DIR" "$LEO_LP_DIR"

run_phase "dk_postprocess_for_rocq" \
  "$STAGE_ROOT/20_postprocess_dk_for_rocq.sh" "$PROOF_DIR" "$STDLIB_LP_DIR" "$LEO_LP_DIR" "$STAGE_ROOT"

if [ "${SKIP_DK_CHECK:-1}" = "1" ]; then
  echo "Skipping optional DK check because SKIP_DK_CHECK=1"
else
  run_phase "dk_postprocess_for_dkcheck" \
    "$STAGE_ROOT/30_postprocess_dk_for_dkcheck.sh" "$PROOF_DIR"
  run_phase "dk_check" \
    "$STAGE_ROOT/35_check_dk.sh" "$PROOF_DIR" "$STDLIB_LP_DIR" "$LEO_LP_DIR" "$STAGE_ROOT"
fi

run_phase "collision_rename" \
  "$STAGE_ROOT/40_rename_rocq_collisions.sh" "$PROOF_DIR" "$SUPPORT_ROOT"

echo "Preparing Rocq proof output in $OUT"
run_phase "rocq_export" \
  "$STAGE_ROOT/50_export_dk_to_rocq.sh" "$PROOF_DIR" "$OUT" "$SUPPORT_ROOT" "$STAGE_ROOT"

echo "Checking Rocq files"
run_phase "rocq_check" \
  "$STAGE_ROOT/70_check_rocq.sh" "$OUT" "$LEO_ROCQ_DIR"

echo "Rocq proof translation checked successfully in $OUT"
