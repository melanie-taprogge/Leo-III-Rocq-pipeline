#!/usr/bin/env bash
set -euo pipefail

PROOF_DIR="${1:?Usage: 10_export_lp_to_dk.sh PROOF_DIR [STDLIB_LP_DIR LEO_LP_DIR]}"
STDLIB_LP_DIR="${2:-}"
LEO_LP_DIR="${3:-}"
SKIP_PROOF_INSTALL="${SKIP_PROOF_INSTALL:-1}"

PROOF_DIR="$(cd "$PROOF_DIR" && pwd)"
if [ -n "$STDLIB_LP_DIR" ]; then
  STDLIB_LP_DIR="$(cd "$STDLIB_LP_DIR" && pwd)"
fi
if [ -n "$LEO_LP_DIR" ]; then
  LEO_LP_DIR="$(cd "$LEO_LP_DIR" && pwd)"
fi

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

  if [ "${LP_EXPORT_USE_MAKE:-0}" = "1" ] || [ -z "$STDLIB_LP_DIR" ] || [ -z "$LEO_LP_DIR" ]; then
    echo "running 'make dk' to export proof files to Dedukti"
    make dk
    exit
  fi

  echo "exporting proof files to Dedukti with explicit dependency map-dirs"

  lp_files=()
  for fixed in Signature.lp Formulae.lp; do
    if [ -f "$fixed" ]; then
      lp_files+=("$fixed")
    fi
  done

  while IFS= read -r path; do
    file="${path#./}"
    case "$file" in
      Signature.lp|Formulae.lp|encodedProof.lp|encoding.lp|mappings.lp)
        ;;
      *)
        lp_files+=("$file")
        ;;
    esac
  done < <(find . -maxdepth 1 -type f -name '*.lp' | sort)

  if [ -f encodedProof.lp ]; then
    lp_files+=("encodedProof.lp")
  fi

  for file in "${lp_files[@]}"; do
    dk_file="${file%.lp}.dk"
    tmp_file="$dk_file.tmp"
    find . -name '*.lpo' -delete
    echo "lambdapi export -o dk --map-dir=Stdlib-noOp:$STDLIB_LP_DIR --map-dir=Leo-III-lambdapi-lib-noOp:$LEO_LP_DIR $file > $dk_file"
    lambdapi export -o dk \
      "--map-dir=Stdlib-noOp:$STDLIB_LP_DIR" \
      "--map-dir=Leo-III-lambdapi-lib-noOp:$LEO_LP_DIR" \
      "$file" > "$tmp_file"
    mv "$tmp_file" "$dk_file"
  done
)
