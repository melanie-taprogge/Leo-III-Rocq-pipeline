#!/usr/bin/env bash
set -euo pipefail

PROOF_DIR="${1:?Usage: 10_export_lp_to_dk.sh PROOF_DIR}"
SKIP_PROOF_INSTALL="${SKIP_PROOF_INSTALL:-1}"

PROOF_DIR="$(cd "$PROOF_DIR" && pwd)"

echo "Exporting Lambdapi proof package to Dedukti in $PROOF_DIR"

(
  cd "$PROOF_DIR"
  make clean

  if [ "$SKIP_PROOF_INSTALL" = "1" ]; then
    echo "skipping initial 'make install' for proof package (SKIP_PROOF_INSTALL=1)"
    echo "DK export will recheck source files directly"
  else
    echo "running 'make install' to compile the lp files"
    make install
  fi

  echo "running 'make dk' to export proof files to Dedukti"
  make dk
)
