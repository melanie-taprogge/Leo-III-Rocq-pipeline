#!/usr/bin/env bash
set -euo pipefail

PROOF_DIR="${1:?Usage: 35_check_dk.sh PROOF_DIR STDLIB LEOLIB STAGE_ROOT}"
STDLIB="${2:?Usage: 35_check_dk.sh PROOF_DIR STDLIB LEOLIB STAGE_ROOT}"
LEOLIB="${3:?Usage: 35_check_dk.sh PROOF_DIR STDLIB LEOLIB STAGE_ROOT}"
STAGE_ROOT="${4:?Usage: 35_check_dk.sh PROOF_DIR STDLIB LEOLIB STAGE_ROOT}"
DK_BIN="${DK_BIN:-dk}"

PROOF_DIR="$(cd "$PROOF_DIR" && pwd)"
STDLIB="$(cd "$STDLIB" && pwd)"
LEOLIB="$(cd "$LEOLIB" && pwd)"
STAGE_ROOT="$(cd "$STAGE_ROOT" && pwd)"

if ! command -v "$DK_BIN" >/dev/null 2>&1; then
  echo "Error: dk executable not found: $DK_BIN" >&2
  exit 1
fi

echo "Computing DK check order"
order_file="$(mktemp)"
trap 'rm -f "$order_file"' EXIT
python3 "$STAGE_ROOT/helpers/compute_dk_order.py" "$PROOF_DIR" > "$order_file"

echo "Compiling .dk files one by one"
while IFS= read -r file; do
  [ -n "$file" ] || continue
  echo "Compiling: $file"
  (cd "$PROOF_DIR" && "$DK_BIN" check -I "$STDLIB" -I "$LEOLIB" -e "$file")
done < "$order_file"
