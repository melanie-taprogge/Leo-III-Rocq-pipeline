#!/usr/bin/env bash
set -euo pipefail

OUT="${1:?Usage: 70_check_rocq.sh OUT ROCQ_LIB}"
ROCQ_LIB="${2:?Usage: 70_check_rocq.sh OUT ROCQ_LIB}"

OUT="$(cd "$OUT" && pwd)"
ROCQ_LIB="$(cd "$ROCQ_LIB" && pwd)"

declare -a ROQ_LOAD_PATH_ARGS
declare -a COQPROJECT_LOAD_PATH_LINES

if [ -f "$ROCQ_LIB/mappings.vo" ]; then
  ROQ_LOAD_PATH_ARGS=(-Q "$ROCQ_LIB" "")
  COQPROJECT_LOAD_PATH_LINES=("-Q $ROCQ_LIB \"\"")
elif [ -f "$ROCQ_LIB/partial_stdlib/mappings.vo" ] && [ -d "$ROCQ_LIB/leo_lib" ]; then
  ROQ_LOAD_PATH_ARGS=(-Q "$ROCQ_LIB/partial_stdlib" "" -Q "$ROCQ_LIB/leo_lib" "")
  COQPROJECT_LOAD_PATH_LINES=(
    "-Q $ROCQ_LIB/partial_stdlib \"\""
    "-Q $ROCQ_LIB/leo_lib \"\""
  )
else
  echo "Compiled Rocq library not found in $ROCQ_LIB" >&2
  echo "Expected either:" >&2
  echo "  $ROCQ_LIB/mappings.vo" >&2
  echo "or:" >&2
  echo "  $ROCQ_LIB/partial_stdlib/mappings.vo and $ROCQ_LIB/leo_lib/" >&2
  exit 1
fi

if [ ! -f "$OUT/order.txt" ]; then
  echo "Rocq order file not found: $OUT/order.txt" >&2
  exit 1
fi

{
  printf '%s\n' '-Q . ""'
  printf '%s\n' "${COQPROJECT_LOAD_PATH_LINES[@]}"
  cat "$OUT/order.txt"
} > "$OUT/_CoqProject"

(
  cd "$OUT"
  while IFS= read -r rocq_file; do
    [ -n "$rocq_file" ] || continue
    coqc -Q . '' "${ROQ_LOAD_PATH_ARGS[@]}" "$rocq_file"
  done < order.txt
)
