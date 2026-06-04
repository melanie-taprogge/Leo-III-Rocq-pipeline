#!/usr/bin/env bash
set -euo pipefail

PROOF_DIR="${1:?Usage: 40_rename_rocq_collisions.sh PROOF_DIR SUPPORT_ROOT}"
SUPPORT_ROOT="${2:?Usage: 40_rename_rocq_collisions.sh PROOF_DIR SUPPORT_ROOT}"

PROOF_DIR="$(cd "$PROOF_DIR" && pwd)"
SUPPORT_ROOT="$(cd "$SUPPORT_ROOT" && pwd)"

python3 "$SUPPORT_ROOT/helpers/rename_local_collisions.py" \
  "$PROOF_DIR" \
  "$SUPPORT_ROOT/rocq_files/mappings.lp" \
  "$SUPPORT_ROOT/rocq_files/mappings.v"
