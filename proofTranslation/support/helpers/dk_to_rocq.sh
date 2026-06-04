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
restore_names="$tmpdir/restore-names.tsv"
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

    # Drop rewrite rules. stt_coq ignores rules anyway, and [] rules crash parsing.
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

## Lambdapi's Coq exporter does not match DK quoted identifiers like {|π|}
## against mapping/encoding config entries. Rewrite quoted identifiers to
## regular ASCII identifiers in both the temporary DK file and the config files.
#python3 - "$tmpdk" "$ENCODING" "$tmpencoding" "$MAPPING" "$tmpmapping" <<'PY'
#import re
#import sys
#import unicodedata
#from pathlib import Path
#
#dk_path = Path(sys.argv[1])
#encoding_in = Path(sys.argv[2])
#encoding_out = Path(sys.argv[3])
#mapping_in = Path(sys.argv[4])
#mapping_out = Path(sys.argv[5])
#
#known = {
#    "#admit": "lp_hash_admit",
#    "#apply": "lp_hash_apply",
#    "#assume": "lp_hash_assume",
#    "#fail": "lp_hash_fail",
#    "#generalize": "lp_hash_generalize",
#    "#have": "lp_hash_have",
#    "#induction": "lp_hash_induction",
#    "#orelse": "lp_hash_orelse",
#    "#refine": "lp_hash_refine",
#    "#reflexivity": "lp_hash_reflexivity",
#    "#remove": "lp_hash_remove",
#    "#repeat": "lp_hash_repeat",
#    "#rewrite": "lp_hash_rewrite",
#    "#set": "lp_hash_set",
#    "#simplify": "lp_hash_simplify",
#    "#simplify_beta": "lp_hash_simplify_beta",
#    "#solve": "lp_hash_solve",
#    "#symmetry": "lp_hash_symmetry",
#    "#try": "lp_hash_try",
#    "#why3": "lp_hash_why3",
#}
#
#def sanitize(name: str) -> str:
#    if name in known:
#        return known[name]
#
#    out = []
#    for ch in unicodedata.normalize("NFC", name):
#        if ch.isascii() and (ch.isalnum() or ch == "_"):
#            out.append(ch)
#        elif ch == "'":
#            out.append("_prime")
#        else:
#            out.append(f"_u{ord(ch):04x}_")
#
#    ident = "".join(out)
#    ident = re.sub(r"_+", "_", ident).strip("_")
#    if not ident or not (ident[0].isalpha() or ident[0] == "_"):
#        ident = "lp_" + ident
#    elif not ident.startswith("lp_"):
#        ident = "lp_" + ident
#    return ident
#
#def rewrite_quoted(text: str) -> str:
#    return re.sub(r"\{\|([^|]+)\|\}", lambda m: sanitize(m.group(1)), text)
#
#dk_path.write_text(rewrite_quoted(dk_path.read_text(encoding="utf-8")), encoding="utf-8")
#encoding_out.write_text(rewrite_quoted(encoding_in.read_text(encoding="utf-8")), encoding="utf-8")
#mapping_out.write_text(rewrite_quoted(mapping_in.read_text(encoding="utf-8")), encoding="utf-8")
#PY

# Lambdapi's Coq exporter does not match DK quoted identifiers like {|π|}
# against mapping/encoding config entries. Bare Unicode/operator names are not
# all accepted by Lambdapi either, so rewrite quoted identifiers to ASCII in
# the temporary DK/config files and remember readable Rocq-safe names to restore.
python3 - "$tmpdk" "$ENCODING" "$tmpencoding" "$MAPPING" "$tmpmapping" "$restore_names" <<'PY'
import re
import sys
import unicodedata
from pathlib import Path

dk_path = Path(sys.argv[1])
encoding_in = Path(sys.argv[2])
encoding_out = Path(sys.argv[3])
mapping_in = Path(sys.argv[4])
mapping_out = Path(sys.argv[5])
restore_path = Path(sys.argv[6])

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
    return True

restore = {}

def rewrite_quoted(text: str) -> str:
    def repl(m):
        original = m.group(1)
        ident = sanitize(original)
        if original != ident and is_rocq_plain_ident(original):
            restore[ident] = original
        return ident
    return re.sub(r"\{\|([^|]+)\|\}", repl, text)

dk_path.write_text(rewrite_quoted(dk_path.read_text(encoding="utf-8")), encoding="utf-8")
encoding_out.write_text(rewrite_quoted(encoding_in.read_text(encoding="utf-8")), encoding="utf-8")
mapping_out.write_text(rewrite_quoted(mapping_in.read_text(encoding="utf-8")), encoding="utf-8")
restore_path.write_text(
    "".join(f"{k}\t{v}\n" for k, v in sorted(restore.items(), key=lambda kv: len(kv[0]), reverse=True)),
    encoding="utf-8",
)
PY

## Remove Dedukti/Lambdapi quoted identifier braces from the temporary DK file.
## Example:
##   {|ι|}       -> ι
##   {|ind_𝔹|}   -> ind_𝔹
##   {|∨ᵢ₁|}    -> ∨ᵢ₁
#python3 - "$tmpdk" <<'PY'
#import re
#import sys
#from pathlib import Path
#
#path = Path(sys.argv[1])
#text = path.read_text(encoding="utf-8")
#
#text = re.sub(r"\{\|([^|]+)\|\}", r"\1", text)
#
#path.write_text(text, encoding="utf-8")
#PY

# debugging: show stripped file:
#echo "dk file without imports, module references and rules:"
#cat "$tmpdk"

# Export stripped and de-qualified DK file to Rocq.
lambdapi export -o stt_coq \
  --encoding "$tmpencoding" \
  --use-notations \
  --mapping "$tmpmapping" \
  "$tmpdk" > "$body"

# Rocq cannot parse Dedukti/Lambdapi quoted identifiers. The mapped symbols
# should already have been rewritten by Lambdapi; any remaining quoted names
# are local library symbols, so give them stable ASCII Rocq identifiers.
#python3 - "$body" <<'PY'
#import re
#import sys
#import unicodedata
#from pathlib import Path
#
#path = Path(sys.argv[1])
#text = path.read_text(encoding="utf-8")
#
#known = {
#    "#admit": "lp_hash_admit",
#    "#apply": "lp_hash_apply",
#    "#assume": "lp_hash_assume",
#    "#fail": "lp_hash_fail",
#    "#generalize": "lp_hash_generalize",
#    "#have": "lp_hash_have",
#    "#induction": "lp_hash_induction",
#    "#orelse": "lp_hash_orelse",
#    "#refine": "lp_hash_refine",
#    "#reflexivity": "lp_hash_reflexivity",
#    "#remove": "lp_hash_remove",
#    "#repeat": "lp_hash_repeat",
#    "#rewrite": "lp_hash_rewrite",
#    "#set": "lp_hash_set",
#    "#simplify": "lp_hash_simplify",
#    "#simplify_beta": "lp_hash_simplify_beta",
#    "#solve": "lp_hash_solve",
#    "#symmetry": "lp_hash_symmetry",
#    "#try": "lp_hash_try",
#    "#why3": "lp_hash_why3",
#}
#
#def sanitize(name: str) -> str:
#    if name in known:
#        return known[name]
#
#    out = []
#    for ch in unicodedata.normalize("NFC", name):
#        if ch.isascii() and (ch.isalnum() or ch == "_"):
#            out.append(ch)
#        elif ch == "'":
#            out.append("_prime")
#        else:
#            out.append(f"_u{ord(ch):04x}_")
#
#    ident = "".join(out)
#    ident = re.sub(r"_+", "_", ident).strip("_")
#    if not ident or not (ident[0].isalpha() or ident[0] == "_"):
#        ident = "lp_" + ident
#    elif not ident.startswith("lp_"):
#        ident = "lp_" + ident
#    return ident
#
#text = re.sub(r"\{\|([^|]+)\|\}", lambda m: sanitize(m.group(1)), text)
#path.write_text(text, encoding="utf-8")
#PY

# Restore Rocq-parseable Unicode names that were only hidden from Lambdapi's
# parser. Operator-like names stay ASCII because Rocq rejects them as idents.
python3 - "$body" "$restore_names" "$OUT" <<'PY'
import re
import sys
from pathlib import Path

path = Path(sys.argv[1])
restore_path = Path(sys.argv[2])
out_path = Path(sys.argv[3])
text = path.read_text(encoding="utf-8")

text = re.sub(r"\{\|([^|]+)\|\}", r"\1", text)
if restore_path.exists():
    for line in restore_path.read_text(encoding="utf-8").splitlines():
        if not line:
            continue
        ascii_name, unicode_name = line.split("\t", 1)
        text = re.sub(
            r"(?<![A-Za-z0-9_'])" + re.escape(ascii_name) + r"(?![A-Za-z0-9_'])",
            unicode_name,
            text,
        )

text = text.replace("@conj ", "@Logic.conj ")

# Rocq identifiers cannot start with a digit. Some TPTP premise names do,
# for example "1_p0"; prefix only digit-starting identifiers that contain an
# underscore, leaving ordinary numeric literals untouched.
text = re.sub(
    r"(?<![A-Za-z0-9_'])([0-9][A-Za-z0-9_']*_[A-Za-z0-9_']*)(?![A-Za-z0-9_'])",
    r"lp_\1",
    text,
)

# When Lambdapi/DK equality is used as a first-class term, stt_coq sometimes
# prints Rocq's native equality in a form that is valid only if the type
# argument were explicit. In Rocq it is implicit, so `eq nat` means partial
# equality at the object `nat : Set`, not equality over naturals. Likewise
# `a = x` appears for partially applied equality when `a : Type'`.
ident = r"[A-Za-z_][A-Za-z0-9_']*"
type_names = {"nat", "o", "bool"}
type_decl_re = re.compile(r"^\s*Axiom\s+(" + ident + r")\s*:\s*Type'\s*\.", flags=re.MULTILINE)
for source in [text]:
    for m in type_decl_re.finditer(source):
        type_names.add(m.group(1))
for sibling in out_path.parent.glob("*.v"):
    if sibling == out_path:
        continue
    try:
        source = sibling.read_text(encoding="utf-8")
    except OSError:
        continue
    for m in type_decl_re.finditer(source):
        type_names.add(m.group(1))

arrow_type = r"\([^()]+(?:\s*->\s*[^()]+)+\)"
text = re.sub(r"\(eq (" + ident + r")\)", r"(@eq \1)", text)
text = re.sub(r"\(eq (" + arrow_type + r")\)", r"(@eq \1)", text)

simple_term = ident + r"(?:\s+" + ident + r")*"
for ty in sorted(type_names, key=len, reverse=True):
    qty = re.escape(ty)
    text = re.sub(
        r"\b" + qty + r" = \((" + ident + r"\s+\([^()]+\)\s+" + simple_term + r")\)",
        lambda m, ty=ty: f"(fun lp_eq_arg__ : {ty} => {m.group(1)} = lp_eq_arg__)",
        text,
    )
    text = re.sub(
        r"\b" + qty + r" = \((" + ident + r"\s+\([^()]+\))\)",
        lambda m, ty=ty: f"(fun lp_eq_arg__ : {ty} => {m.group(1)} = lp_eq_arg__)",
        text,
    )
    text = re.sub(
        r"\b" + qty + r" = \((" + simple_term + r")\)",
        lambda m, ty=ty: f"(fun lp_eq_arg__ : {ty} => {m.group(1)} = lp_eq_arg__)",
        text,
    )
    text = re.sub(
        r"\(" + qty + r" = (" + ident + r")\)",
        lambda m, ty=ty: f"(fun lp_eq_arg__ : {ty} => {m.group(1)} = lp_eq_arg__)",
        text,
    )

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
