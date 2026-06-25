#!/usr/bin/env bash
set -euo pipefail

IN="${1:?Usage: ./dk_to_rocq.sh input.dk output.v}"
OUT="${2:?Usage: ./dk_to_rocq.sh input.dk output.v}"

ENCODING="${ENCODING:-encoding.lp}"
MAPPING="${MAPPING:-mappings.lp}"
MAPPINGS_MODULE="${MAPPINGS_MODULE:-mappings}"
DROP_IMPORTS_REGEX="${DROP_IMPORTS_REGEX:-Prop|Set}"

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

tmpdk="$tmpdir/$(basename "$IN")"
tmpencoding="$tmpdir/encoding.lp"
tmpmapping="$tmpdir/mappings.lp"
tmprenaming="$tmpdir/renamings.lp"
all_imports="$tmpdir/all-imports.v"
imports="$tmpdir/imports.v"
body="$tmpdir/body.v"

echo "Translating $IN -> $OUT"

# Extract DK requires and convert them to Rocq imports.
grep '^#REQUIRE ' "$IN" 2>/dev/null | \
  sed -E \
    -e 's/^#REQUIRE[[:space:]]+\{\|([^|]+)\|\}\./Require Import \1./' \
    -e 's/^#REQUIRE[[:space:]]+([^.]+)\./Require Import \1./' \
  > "$all_imports" || true

grep -Ev "^Require Import (${DROP_IMPORTS_REGEX})\\.$" "$all_imports" \
  > "$imports" || true

# Reject imports Rocq cannot parse directly.
if grep -q 'Require Import .*-' "$imports"; then
  echo "Error: generated Rocq import contains a hyphenated module name:" >&2
  grep 'Require Import .*-' "$imports" >&2
  exit 1
fi

# Remove DK require lines and rules.
python3 - "$IN" "$tmpdk" <<'PY'
import re
import sys
from pathlib import Path

src = Path(sys.argv[1])
dst = Path(sys.argv[2])

out = []
for line in src.read_text(encoding="utf-8").splitlines():
    s = line.lstrip()

    # Drop Dedukti imports; we reconstruct them as Rocq Require Import.
    if s.startswith("#REQUIRE "):
        continue

    # Drop rewrite rules. Rocq has no matching import mechanism for DK rewrite
    # rules, so the translated files rely on mapped definitions and shim lemmas
    # for computations that were definitional in DK.
    # Examples:
    #   [x0,x1] f x0 --> x1.
    #   [] f --> g.
    if re.match(r"^\[[^\]]*\]\s+.*-->", s):
        continue

    out.append(line)

dst.write_text("\n".join(out) + "\n", encoding="utf-8")
PY

# Remove module qualifiers from the temporary DK file.
# Example:
#   {|Set|}.{|τ|}  -> {|τ|}
#   {|Prop|}.Prop -> Prop
python3 - "$tmpdk" "$all_imports" <<'PY'
import re
import sys
from pathlib import Path

dk_path = Path(sys.argv[1])
imports_path = Path(sys.argv[2])

text = dk_path.read_text(encoding="utf-8")

modules = []
for line in imports_path.read_text(encoding="utf-8").splitlines():
    m = re.match(r"Require Import\s+([A-Za-z0-9_']+)\.", line)
    if m:
        modules.append(m.group(1))

for mod in sorted(set(modules), key=len, reverse=True):
    # {|Set|}.{|τ|}  -> {|τ|}
    text = re.sub(
        r"\{\|" + re.escape(mod) + r"\|\}\.(\{\|[^|]+\|\})",
        r"\1",
        text,
    )

    # {|Set|}.Set -> Set
    # {|Prop|}.Prop -> Prop
    # {|Eq|}.eq_refl -> eq_refl
    text = re.sub(
        r"\{\|" + re.escape(mod) + r"\|\}\.([A-Za-z_][A-Za-z0-9_']*)",
        r"\1",
        text,
    )

    # Plain Module.symbol -> symbol, but only for actual identifiers after the dot.
    # This avoids turning "bool : Set." into "bool : ".
    text = re.sub(
        r"\b" + re.escape(mod) + r"\.([A-Za-z_][A-Za-z0-9_']*)",
        r"\1",
        text,
    )

    # Plain Module.{|symbol|} -> {|symbol|}
    text = re.sub(
        r"\b" + re.escape(mod) + r"\.(\{\|[^|]+\|\})",
        r"\1",
        text,
    )

dk_path.write_text(text, encoding="utf-8")
PY

# Current Lambdapi can match quoted DK identifiers directly in mapping and
# renaming files. Keep the support files unchanged and provide explicit
# renamings for unmapped DK identifiers that Rocq cannot parse directly.
cp "$ENCODING" "$tmpencoding"
cp "$MAPPING" "$tmpmapping"
python3 - "$tmpdk" "$tmpmapping" "$tmprenaming" <<'PY'
import re
import sys
import unicodedata
from pathlib import Path

dk_path = Path(sys.argv[1])
mapping_path = Path(sys.argv[2])
renaming_path = Path(sys.argv[3])

known = {
    "#admit": "lp_hash_admit",
    "#apply": "lp_hash_apply",
    "#assume": "lp_hash_assume",
    "#fail": "lp_hash_fail",
    "#generalize": "lp_hash_generalize",
    "#have": "lp_hash_have",
    "#induction": "lp_hash_induction",
    "#orelse": "lp_hash_orelse",
    "#refine": "lp_hash_refine",
    "#reflexivity": "lp_hash_reflexivity",
    "#remove": "lp_hash_remove",
    "#repeat": "lp_hash_repeat",
    "#rewrite": "lp_hash_rewrite",
    "#set": "lp_hash_set",
    "#simplify": "lp_hash_simplify",
    "#simplify_beta": "lp_hash_simplify_beta",
    "#solve": "lp_hash_solve",
    "#symmetry": "lp_hash_symmetry",
    "#try": "lp_hash_try",
    "#why3": "lp_hash_why3",
}

def sanitize(name: str) -> str:
    if name in known:
        return known[name]

    out = []
    for ch in unicodedata.normalize("NFC", name):
        if ch.isascii() and (ch.isalnum() or ch == "_"):
            out.append(ch)
        elif ch == "'":
            out.append("_prime")
        else:
            out.append(f"_u{ord(ch):04x}_")

    ident = "".join(out)
    ident = re.sub(r"_+", "_", ident).strip("_")
    if not ident or not (ident[0].isalpha() or ident[0] == "_"):
        ident = "lp_" + ident
    elif not ident.startswith("lp_"):
        ident = "lp_" + ident
    return ident

def is_rocq_plain_ident(name: str) -> bool:
    if not name:
        return False
    first = name[0]
    if not (first == "_" or unicodedata.category(first).startswith("L")):
        return False
    for ch in name[1:]:
        cat = unicodedata.category(ch)
        if ch in "_'" or cat.startswith("L") or cat.startswith("N"):
            continue
        return False
    return name != "_"

def needs_renaming(name: str, quoted: bool) -> bool:
    # Since Lambdapi #1397, stt_coq fails fast on identifiers it cannot
    # guarantee are legal Rocq identifiers. Quoted DK names and non-ASCII names
    # therefore need explicit renaming unless they are already mapped.
    return quoted or not is_rocq_plain_ident(name) or not name.isascii()

def target_name(name: str) -> str:
    if is_rocq_plain_ident(name) and name.isascii():
        return name
    return sanitize(name)

def unquote(name: str) -> str:
    if name.startswith("{|") and name.endswith("|}"):
        return name[2:-2]
    return name

mapped_sources = set()
for line in mapping_path.read_text(encoding="utf-8").splitlines():
    m = re.search(r"≔\s*([^;]+?)\s*;", line)
    if not m:
        continue
    src = m.group(1).strip()
    mapped_sources.add(src)

renamings = {}
used_targets = set()

def add_renaming(source: str) -> None:
    if source in renamings:
        return
    quoted = source.startswith("{|") and source.endswith("|}")
    raw = unquote(source)
    if source in mapped_sources:
        return
    if not needs_renaming(raw, quoted):
        return

    base = target_name(raw)
    candidate = base
    i = 2
    while candidate in used_targets:
        candidate = f"{base}_{i}"
        i += 1
    used_targets.add(candidate)
    renamings[source] = candidate

text = dk_path.read_text(encoding="utf-8")

# Quoted identifiers can occur as imported constants or constructors, not just
# as declarations. If they are not covered by mappings.lp, give stt_coq an
# explicit Rocq spelling.
for m in re.finditer(r"\{\|[^|]+\|\}", text):
    add_renaming(m.group(0))

# Also catch unquoted declaration names that are legal DK identifiers but not
# legal Rocq identifiers, e.g. TPTP premise names starting with digits.
decl_re = re.compile(r"(?m)^\s*(?:def\s+|injective\s+)?([^\s:]+)\s*:")
for m in decl_re.finditer(text):
    add_renaming(m.group(1))

# Catch invalid components in qualified imported references as well.
# Example: Formulae.1_p0 should use the same generated renaming as a local
# declaration 1_p0, so stt_coq can print Formulae.lp_1_p0.
qualified_re = re.compile(r"\b[A-Za-z_][A-Za-z0-9_']*\.([^\s()\[\]{}:;,]+)")
for m in qualified_re.finditer(text):
    add_renaming(m.group(1).rstrip("."))

renaming_path.write_text(
    "".join(f'builtin "{target}" ≔ {source};\n' for source, target in sorted(renamings.items())),
    encoding="utf-8",
)
PY

# debugging: show stripped file:
#echo "dk file without imports, module references and rules:"
#cat "$tmpdk"

# Export stripped and de-qualified DK file to Rocq.
if [ -s "$tmprenaming" ]; then
  lambdapi export -o stt_coq \
    --encoding "$tmpencoding" \
    --use-notations \
    --mapping "$tmpmapping" \
    --renaming "$tmprenaming" \
    "$tmpdk" > "$body"
else
  lambdapi export -o stt_coq \
    --encoding "$tmpencoding" \
    --use-notations \
    --mapping "$tmpmapping" \
    "$tmpdk" > "$body"
fi

# Apply targeted Rocq-side cleanups.
python3 - "$body" "$OUT" <<'PY'
import re
import sys
from pathlib import Path

path = Path(sys.argv[1])
out_path = Path(sys.argv[2])
text = path.read_text(encoding="utf-8")

text = text.replace("@conj ", "@Logic.conj ")

# The Lambdapi Nat library has both the exponentiation symbol and a theorem
# named expn. After mapping the symbol to the Rocq-side expn operation, the
# exporter renames the theorem to expn__alt__ and emits the original proof
# term. That proof relies on DK/Lambdapi rewrite rules for multiplication by
# zero, so replace it with the shim lemma proved in mappings.v.
text = re.sub(
    r"^Definition expn__alt__ : .*$",
    "Definition expn__alt__ : forall n : nat', expn n (S O) = n := expn1.",
    text,
    flags=re.MULTILINE,
)

list_collision_defs = {
    "list": "Definition list : Type' -> Type' := list_type.",
    "last": "Definition last : forall a : Type', a -> 𝕃 a -> a := lp_last.",
    "nth": "Definition nth : forall a : Type', a -> 𝕃 a -> nat -> a := lp_nth.",
    "all": "Definition all : forall a : Type', (a -> bool') -> 𝕃 a -> bool' := list_all.",
    "filter": "Definition filter : forall a : Type', (a -> bool') -> 𝕃 a -> 𝕃 a := lp_filter.",
    "map": "Definition map : forall a b : Type', (a -> b) -> 𝕃 a -> 𝕃 b := lp_map.",
}
for name, replacement in list_collision_defs.items():
    text = re.sub(
        r"^Axiom " + re.escape(name) + r" : .*$",
        replacement,
        text,
        flags=re.MULTILINE,
    )

path.write_text(text, encoding="utf-8")
PY

{
  cat "$imports"
  echo "Require Import $MAPPINGS_MODULE."
  cat "$body"
} > "$OUT"
