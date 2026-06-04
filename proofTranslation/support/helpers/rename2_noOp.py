#!/usr/bin/env python3
from pathlib import Path
import re
import sys

SUFFIX = "-noOp"
ROOT = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(".")

PKG_KEYS = ("package_name", "root_path")


def add_suffix_if_missing(name: str) -> str:
    return name if name.endswith(SUFFIX) else name + SUFFIX


def process_pkg_file(path: Path) -> bool:
    text = path.read_text(encoding="utf-8")
    original = text

    for key in PKG_KEYS:
        pattern = rf"^(\s*{re.escape(key)}\s*=\s*)(\S+)(\s*)$"

        def repl(match: re.Match) -> str:
            prefix, name, suffix_ws = match.groups()
            return f"{prefix}{add_suffix_if_missing(name)}{suffix_ws}"

        text = re.sub(pattern, repl, text, flags=re.MULTILINE)

    if text != original:
        path.write_text(text, encoding="utf-8")
        return True
    return False


def process_lp_file(path: Path) -> bool:
    text = path.read_text(encoding="utf-8")
    original = text

    lines = text.splitlines(keepends=True)
    new_lines = []

    for line in lines:
        stripped = line.lstrip()
        if stripped.startswith("require open ") and ";" in line:
            before_semicolon, sep, after_semicolon = line.partition(";")
            parts = before_semicolon.split()

            # parts should look like:
            # ["require", "open", "Stdlib.HOL"]
            # or ["require", "open", "Stdlib.FunExt", "Stdlib.PropExt"]
            if len(parts) >= 3 and parts[0] == "require" and parts[1] == "open":
                new_imports = []
                for mod in parts[2:]:
                    if "." in mod:
                        pkg, rest = mod.split(".", 1)
                        pkg = add_suffix_if_missing(pkg)
                        new_imports.append(f"{pkg}.{rest}")
                    else:
                        new_imports.append(add_suffix_if_missing(mod))

                indent = line[: len(line) - len(line.lstrip())]
                line = indent + "require open " + " ".join(new_imports) + ";" + after_semicolon

        elif stripped.startswith("require ") and ";" in line:
            before_semicolon, sep, after_semicolon = line.partition(";")
            parts = before_semicolon.split()

            # parts should look like:
            # ["require", "Package.Module", "as", "M"]
            if len(parts) >= 2 and parts[0] == "require":
                mod = parts[1]
                if "." in mod:
                    pkg, rest = mod.split(".", 1)
                    parts[1] = f"{add_suffix_if_missing(pkg)}.{rest}"
                else:
                    parts[1] = add_suffix_if_missing(mod)

                indent = line[: len(line) - len(line.lstrip())]
                line = indent + " ".join(parts) + ";" + after_semicolon

        new_lines.append(line)

    text = "".join(new_lines)

    if text != original:
        path.write_text(text, encoding="utf-8")
        return True
    return False


def main() -> int:
    pkg_files = list(ROOT.rglob("lambdapi.pkg"))
    lp_files = list(ROOT.rglob("*.lp"))

    print("Processing lambdapi.pkg files...")
    for path in pkg_files:
        changed = process_pkg_file(path)
        print(f"{'Updated' if changed else 'Checked'} pkg: {path}")

    print("Processing .lp files...")
    for path in lp_files:
        changed = process_lp_file(path)
        print(f"{'Updated' if changed else 'Checked'} lp:  {path}")

    print("Done.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
