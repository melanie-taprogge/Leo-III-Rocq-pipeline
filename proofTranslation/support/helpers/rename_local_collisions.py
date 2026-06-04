#!/usr/bin/env python3
"""Rename local proof DK symbols that collide with global Rocq mappings."""

from __future__ import annotations

import argparse
import re
from pathlib import Path


IDENT = r"[A-Za-z_][A-Za-z0-9_']*"


def unquote(name: str) -> str:
    if name.startswith("{|") and name.endswith("|}"):
        return name[2:-2]
    return name


def qname(name: str) -> str:
    return "{|" + name + "|}"


def collect_global_names(mapping_lp: Path, mappings_v: Path) -> set[str]:
    names: set[str] = {
        # Imported Rocq constructors/constants that can be captured even when
        # they are not defined explicitly in mappings.v.
        "nil",
        "cons",
        "list",
        "map",
        "filter",
        "app",
    }

    for line in mapping_lp.read_text(encoding="utf-8").splitlines():
        m_lhs = re.search(r'builtin\s+"([^"]+)"\s*≔', line)
        if m_lhs:
            lhs = unquote(m_lhs.group(1).strip())
            if re.fullmatch(IDENT, lhs):
                names.add(lhs)

        m = re.search(r"≔\s*([^;]+)\s*;", line)
        if not m:
            continue
        rhs = unquote(m.group(1).strip())
        if re.fullmatch(IDENT, rhs):
            names.add(rhs)

    for m in re.finditer(
        r"^\s*(?:Definition|Lemma|Theorem|Axiom|Fixpoint|Inductive|CoInductive)\s+("
        + IDENT
        + r")\b",
        mappings_v.read_text(encoding="utf-8"),
        flags=re.MULTILINE,
    ):
        names.add(m.group(1))

    return names


def collect_local_decls(dk_path: Path) -> set[str]:
    decls: set[str] = set()
    for line in dk_path.read_text(encoding="utf-8").splitlines():
        stripped = line.lstrip()
        if not stripped or stripped.startswith("#REQUIRE") or stripped.startswith("["):
            continue
        m = re.match(r"(?:def\s+)?(\{\|[^|]+\|\}|" + IDENT + r")\s*:", stripped)
        if m:
            decls.add(unquote(m.group(1)))
    return decls


def replacement_name(name: str, used_names: set[str], global_names: set[str]) -> str:
    base = "lp_local_" + re.sub(r"[^A-Za-z0-9_']", "_", name)
    if not re.match(r"[A-Za-z_]", base):
        base = "lp_local_" + base
    candidate = base
    i = 2
    while candidate in used_names or candidate in global_names:
        candidate = f"{base}_{i}"
        i += 1
    return candidate


def rename_collisions(proof_dir: Path, mapping_lp: Path, mappings_v: Path) -> int:
    dk_files = sorted(proof_dir.glob("*.dk"))
    if not dk_files:
        return 0

    global_names = collect_global_names(mapping_lp, mappings_v)
    module_names = {p.stem for p in dk_files}
    local_by_module = {p.stem: collect_local_decls(p) for p in dk_files}
    all_local = set().union(*local_by_module.values()) if local_by_module else set()

    renames: dict[tuple[str, str], str] = {}
    used_names = set(all_local)
    for module, decls in local_by_module.items():
        for name in sorted(decls):
            if name in global_names:
                new = replacement_name(name, used_names, global_names)
                renames[(module, name)] = new
                used_names.add(new)

    if not renames:
        print("No local/global name collisions detected.")
        return 0

    for (module, old), new in sorted(renames.items()):
        print(f"Renaming local symbol {module}.{old} -> {new}")

    for path in dk_files:
        module = path.stem
        text = path.read_text(encoding="utf-8")

        # Rename declarations in their defining module.
        for (decl_module, old), new in renames.items():
            if decl_module != module:
                continue
            text = re.sub(
                r"(?m)^(\s*(?:def\s+)?)" + re.escape(qname(old)) + r"(?=\s*:)",
                r"\1" + qname(new),
                text,
            )
            text = re.sub(
                r"(?m)^(\s*(?:def\s+)?)" + re.escape(old) + r"(?=\s*:)",
                r"\1" + new,
                text,
            )

        # Rename qualified local references in every local DK file. References
        # to imported modules with the same symbol name are intentionally left.
        for (decl_module, old), new in renames.items():
            if decl_module not in module_names:
                continue
            for mod_spelling in (decl_module, qname(decl_module)):
                text = re.sub(
                    re.escape(mod_spelling) + r"\." + re.escape(qname(old)),
                    mod_spelling + "." + qname(new),
                    text,
                )
                text = re.sub(
                    re.escape(mod_spelling)
                    + r"\."
                    + re.escape(old)
                    + r"(?![A-Za-z0-9_'])",
                    mod_spelling + "." + new,
                    text,
                )

        # Rename unqualified self-references only inside the defining module.
        for (decl_module, old), new in renames.items():
            if decl_module != module:
                continue
            text = re.sub(
                r"(?<![A-Za-z0-9_'.])"
                + re.escape(qname(old))
                + r"(?![A-Za-z0-9_'])",
                qname(new),
                text,
            )
            text = re.sub(
                r"(?<![A-Za-z0-9_'.])"
                + re.escape(old)
                + r"(?![A-Za-z0-9_'])",
                new,
                text,
            )

        path.write_text(text, encoding="utf-8")

    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("proof_dir", type=Path)
    parser.add_argument("mapping_lp", type=Path)
    parser.add_argument("mappings_v", type=Path)
    args = parser.parse_args()

    return rename_collisions(
        args.proof_dir.resolve(),
        args.mapping_lp.resolve(),
        args.mappings_v.resolve(),
    )


if __name__ == "__main__":
    raise SystemExit(main())
