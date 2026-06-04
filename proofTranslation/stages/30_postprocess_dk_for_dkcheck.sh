#!/usr/bin/env bash
set -euo pipefail

PROOF_DIR="${1:?Usage: 30_postprocess_dk_for_dkcheck.sh PROOF_DIR}"
PROOF_DIR="$(cd "$PROOF_DIR" && pwd)"

echo "No DK-check-only post-processing is currently required for $PROOF_DIR"
