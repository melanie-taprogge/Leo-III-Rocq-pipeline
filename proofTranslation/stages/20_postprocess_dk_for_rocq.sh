#!/usr/bin/env bash
set -euo pipefail

PROOF_DIR="${1:?Usage: 20_postprocess_dk_for_rocq.sh PROOF_DIR STDLIB LEOLIB STAGE_ROOT}"
STDLIB="${2:?Usage: 20_postprocess_dk_for_rocq.sh PROOF_DIR STDLIB LEOLIB STAGE_ROOT}"
LEOLIB="${3:?Usage: 20_postprocess_dk_for_rocq.sh PROOF_DIR STDLIB LEOLIB STAGE_ROOT}"
STAGE_ROOT="${4:?Usage: 20_postprocess_dk_for_rocq.sh PROOF_DIR STDLIB LEOLIB STAGE_ROOT}"

PROOF_DIR="$(cd "$PROOF_DIR" && pwd)"
STDLIB="$(cd "$STDLIB" && pwd)"
LEOLIB="$(cd "$LEOLIB" && pwd)"
STAGE_ROOT="$(cd "$STAGE_ROOT" && pwd)"

echo "Post-processing DK files for Rocq export"

python3 "$STAGE_ROOT/helpers/delete_dk_requires.py" \
  "$PROOF_DIR" \
  '#REQUIRE {|Leo-III-lambdapi-lib-noOp_UserTactic|}.' \
  '#REQUIRE UserTactic.'
