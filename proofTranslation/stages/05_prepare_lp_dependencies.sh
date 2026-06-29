#!/usr/bin/env bash
set -euo pipefail

STDLIB_REPO="${1:?Usage: 05_prepare_lp_dependencies.sh STDLIB_REPO LEO_REPO DEPS_DIR SUPPORT_ROOT}"
LEO_REPO="${2:?Usage: 05_prepare_lp_dependencies.sh STDLIB_REPO LEO_REPO DEPS_DIR SUPPORT_ROOT}"
DEPS_DIR="${3:?Usage: 05_prepare_lp_dependencies.sh STDLIB_REPO LEO_REPO DEPS_DIR SUPPORT_ROOT}"
SUPPORT_ROOT="${4:?Usage: 05_prepare_lp_dependencies.sh STDLIB_REPO LEO_REPO DEPS_DIR SUPPORT_ROOT}"

STDLIB_REPO="$(cd "$STDLIB_REPO" && pwd)"
LEO_REPO="$(cd "$LEO_REPO" && pwd)"
mkdir -p "$DEPS_DIR"
DEPS_DIR="$(cd "$DEPS_DIR" && pwd)"
SUPPORT_ROOT="$(cd "$SUPPORT_ROOT" && pwd)"

STDLIB_OUT="$DEPS_DIR/Stdlib-noOp"
LEO_OUT="$DEPS_DIR/Leo-III-lambdapi-lib-noOp"

copy_lp_package() {
  local src="$1"
  local dst="$2"
  local label="$3"

  if [ ! -f "$src/lambdapi.pkg" ]; then
    echo "Error: $label repository has no lambdapi.pkg: $src" >&2
    exit 2
  fi

  rm -rf "$dst"
  mkdir -p "$dst"
  cp "$src/lambdapi.pkg" "$dst/lambdapi.pkg"

  while IFS= read -r lp_file; do
    cp "$lp_file" "$dst/"
  done < <(find "$src" -maxdepth 1 -type f -name '*.lp' | sort)

  find "$dst" -type f -name '*.lp' -print0 | while IFS= read -r -d '' file; do
    python3 "$SUPPORT_ROOT/helpers/remove_opaque.py" "$file"
  done

  python3 "$SUPPORT_ROOT/helpers/rename2_noOp.py" "$dst"
}

valid_noop_pkg() {
  local dir="$1"
  local expected="$2"
  local pkg="$dir/lambdapi.pkg"

  [ -f "$pkg" ] || return 1
  local root
  root="$(sed -n 's/^[[:space:]]*root_path[[:space:]]*=[[:space:]]*//p' "$pkg" | head -1 | tr -d '[:space:]')"
  [ "$root" = "$expected" ]
}

if [ "${REUSE_DEPS:-0}" = "1" ] \
  && valid_noop_pkg "$STDLIB_OUT" "Stdlib-noOp" \
  && valid_noop_pkg "$LEO_OUT" "Leo-III-lambdapi-lib-noOp"; then
  echo "Reusing prepared non-opaque Lambdapi dependencies in $DEPS_DIR"
else
  echo "Preparing non-opaque Lambdapi dependencies in $DEPS_DIR"
  copy_lp_package "$STDLIB_REPO" "$STDLIB_OUT" "standard-library"
  copy_lp_package "$LEO_REPO" "$LEO_OUT" "Leo-III library"
fi

echo "STDLIB_LP_DIR=$STDLIB_OUT"
echo "LEO_LP_DIR=$LEO_OUT"
