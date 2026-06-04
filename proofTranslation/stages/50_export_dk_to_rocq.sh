#!/usr/bin/env bash
set -euo pipefail

PROOF_DIR="${1:?Usage: 50_export_dk_to_rocq.sh PROOF_DIR OUT SUPPORT_ROOT STAGE_ROOT}"
OUT="${2:?Usage: 50_export_dk_to_rocq.sh PROOF_DIR OUT SUPPORT_ROOT STAGE_ROOT}"
SUPPORT_ROOT="${3:?Usage: 50_export_dk_to_rocq.sh PROOF_DIR OUT SUPPORT_ROOT STAGE_ROOT}"
STAGE_ROOT="${4:?Usage: 50_export_dk_to_rocq.sh PROOF_DIR OUT SUPPORT_ROOT STAGE_ROOT}"

PROOF_DIR="$(cd "$PROOF_DIR" && pwd)"
mkdir -p "$OUT"
OUT="$(cd "$OUT" && pwd)"
SUPPORT_ROOT="$(cd "$SUPPORT_ROOT" && pwd)"
STAGE_ROOT="$(cd "$STAGE_ROOT" && pwd)"

source "$STAGE_ROOT/helpers/timing.sh"

DK_TO_ROCQ="$SUPPORT_ROOT/helpers/dk_to_rocq.sh"

export ENCODING="$SUPPORT_ROOT/rocq_files/encoding.lp"
export DROP_IMPORTS_REGEX="${DROP_IMPORTS_REGEX:-Prop|Set|Nat|List}"
export MAPPING="$SUPPORT_ROOT/rocq_files/mappings.lp"

: > "$OUT/order.txt"
found=0

while IFS= read -r dk_file; do
  [ -n "$dk_file" ] || continue
  found=1
  base="$(basename "$dk_file" .dk)"
  echo "Translating proof $dk_file -> $OUT/$base.v"
  phase_start "dk_to_rocq:$base"
  "$DK_TO_ROCQ" "$dk_file" "$OUT/$base.v"
  phase_end
  printf '%s\n' "$base.v" >> "$OUT/order.txt"
done < <(python3 "$STAGE_ROOT/helpers/list_rocq_export_order.py" "$PROOF_DIR")

if [ "$found" -eq 0 ]; then
  echo "No .dk proof files found in $PROOF_DIR" >&2
  exit 1
fi
