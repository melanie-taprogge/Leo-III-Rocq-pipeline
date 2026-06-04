#!/usr/bin/env bash
set -euo pipefail

OUT="${1:?Usage: 70_check_rocq.sh OUT ROCQ_LIB}"
ROCQ_LIB="${2:?Usage: 70_check_rocq.sh OUT ROCQ_LIB}"

OUT="$(cd "$OUT" && pwd)"
ROCQ_LIB="$(cd "$ROCQ_LIB" && pwd)"

if [ ! -f "$ROCQ_LIB/mappings.vo" ]; then
  echo "Compiled Rocq library slice not found in $ROCQ_LIB" >&2
  echo "Expected at least $ROCQ_LIB/mappings.vo" >&2
  exit 1
fi

if [ ! -f "$OUT/order.txt" ]; then
  echo "Rocq order file not found: $OUT/order.txt" >&2
  exit 1
fi

{
  printf '%s\n' '-Q . ""'
  printf '%s\n' "-Q $ROCQ_LIB \"\""
  cat "$OUT/order.txt"
} > "$OUT/_CoqProject"

(
  cd "$OUT"
  while IFS= read -r rocq_file; do
    [ -n "$rocq_file" ] || continue
    coqc -Q . '' -Q "$ROCQ_LIB" '' "$rocq_file"
  done < order.txt
)
