#!/usr/bin/env bash
set -euo pipefail

PROOF_DIR="${1:?Usage: 00_prepare_lp_package.sh PROOF_DIR SUPPORT_ROOT}"
SUPPORT_ROOT="${2:?Usage: 00_prepare_lp_package.sh PROOF_DIR SUPPORT_ROOT}"

PROOF_DIR="$(cd "$PROOF_DIR" && pwd)"
SUPPORT_ROOT="$(cd "$SUPPORT_ROOT" && pwd)"

echo "Preparing Lambdapi proof package in $PROOF_DIR"

if [ ! -f "$PROOF_DIR/Makefile" ]; then
  echo "Error: proof package has no Makefile: $PROOF_DIR" >&2
  exit 1
fi

find "$PROOF_DIR" -type f -name "*.lp" -print0 | while IFS= read -r -d '' file; do
  python3 "$SUPPORT_ROOT/helpers/remove_opaque.py" "$file"
  echo "Processed: $file"
done

python3 "$SUPPORT_ROOT/helpers/rename2_noOp.py" "$PROOF_DIR"
