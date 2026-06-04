#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TRANSLATOR="$ROOT/proofTranslation/translateProof2rocq.sh"

usage() {
  cat <<'EOF'
Usage:
  proofTranslation/translateProofBatch2rocq.sh INPUT_ROOT OUTPUT_ROOT STDLIB_REPO LEO_REPO
  proofTranslation/translateProofBatch2rocq.sh STDLIB_REPO LEO_REPO

Defaults:
  With the two-argument form:
    INPUT_ROOT  = examples/lpFiles
    OUTPUT_ROOT = examples/RocqTranslations

Set VERBOSE=1 to print each proof translation log.
EOF
}

if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
  usage
  exit 0
fi

case "$#" in
  2)
    INPUT_ROOT="$ROOT/examples/lpFiles"
    OUTPUT_ROOT="$ROOT/examples/RocqTranslations"
    STDLIB_REPO="$1"
    LEO_REPO="$2"
    ;;
  4)
    INPUT_ROOT="$1"
    OUTPUT_ROOT="$2"
    STDLIB_REPO="$3"
    LEO_REPO="$4"
    ;;
  *)
    usage >&2
    exit 2
    ;;
esac

INPUT_ROOT="$(cd "$INPUT_ROOT" && pwd)"
mkdir -p "$OUTPUT_ROOT"
OUTPUT_ROOT="$(cd "$OUTPUT_ROOT" && pwd)"
STDLIB_REPO="$(cd "$STDLIB_REPO" && pwd)"
LEO_REPO="$(cd "$LEO_REPO" && pwd)"

if [ ! -x "$TRANSLATOR" ]; then
  echo "Proof translator not executable: $TRANSLATOR" >&2
  exit 2
fi

echo "Translating Leo proof examples"
echo "  input:      $INPUT_ROOT"
echo "  output:     $OUTPUT_ROOT"
echo "  stdlib repo: $STDLIB_REPO"
echo "  leo repo:    $LEO_REPO"
echo

ok=0
fail=0
skip=0

while IFS= read -r proof_dir; do
  name="$(basename "$proof_dir")"

  if [ ! -f "$proof_dir/lambdapi.pkg" ]; then
    echo "SKIP $name (no lambdapi.pkg)"
    skip=$((skip + 1))
    continue
  fi

  out="$OUTPUT_ROOT/$name"
  log="$(mktemp "${TMPDIR:-/tmp}/leo-proof-translation.XXXXXX")"

  printf 'RUN  %s\n' "$name"
  if "$TRANSLATOR" "$proof_dir" "$out" "$STDLIB_REPO" "$LEO_REPO" > "$log" 2>&1; then
    if [ "${VERBOSE:-0}" = "1" ]; then
      cat "$log"
    fi
    echo "OK   $name"
    ok=$((ok + 1))
  else
    echo "FAIL $name"
    if [ "${VERBOSE:-0}" = "1" ]; then
      cat "$log"
    else
      tail -n 40 "$log"
    fi
    fail=$((fail + 1))
  fi

  rm -f "$log"
done < <(find "$INPUT_ROOT" -mindepth 1 -maxdepth 1 -type d | sort)

echo
echo "Summary:"
echo "  ok:      $ok"
echo "  fail:    $fail"
echo "  skipped: $skip"

if [ "$fail" -ne 0 ]; then
  exit 1
fi
