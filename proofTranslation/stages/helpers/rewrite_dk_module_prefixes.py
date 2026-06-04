#!/usr/bin/env python3
"""Strip generated package/library prefixes from local DK module references."""

from __future__ import annotations

import argparse
import re
from pathlib import Path


def read_package_prefix(proof_dir: Path) -> str:
    pkg = proof_dir / "lambdapi.pkg"
    text = pkg.read_text(encoding="utf-8")
    match = re.search(r"^\s*package_name\s*=\s*(\S+)\s*$", text, flags=re.MULTILINE)
    if not match:
        raise SystemExit(f"Could not extract package_name from {pkg}")
    return match.group(1)


def available_modules(directory: Path) -> set[str]:
    try:
        return (
            {p.stem for p in directory.glob("*.lp")}
            | {p.stem for p in directory.glob("*.dk")}
            | {p.stem for p in directory.glob("*.dko")}
        )
    except OSError:
        return set()


def rewrite(proof_dir: Path, stdlib_dir: Path, leo_dir: Path) -> int:
    package_prefix = read_package_prefix(proof_dir)
    print(f"Package prefix: {package_prefix}")

    prefix_dirs = [
        (package_prefix + "_", proof_dir),
        ("Stdlib-noOp_", stdlib_dir),
        ("Stdlib_", stdlib_dir),
        ("Leo-III-lambdapi-lib-noOp_", leo_dir),
        ("Leo-III-lambdapi-lib_", leo_dir),
    ]
    available = {prefix: available_modules(directory) for prefix, directory in prefix_dirs}

    pattern = re.compile(
        r"(\{\|)?("
        + "|".join(re.escape(prefix) for prefix, _ in prefix_dirs)
        + r")([A-Za-z0-9_]+)(\|\})?"
    )

    def replacer(match: re.Match[str]) -> str:
        left_brace = match.group(1) or ""
        prefix = match.group(2)
        mod = match.group(3)
        right_brace = match.group(4) or ""

        if mod in available.get(prefix, set()):
            return f"{left_brace}{mod}{right_brace}"
        return match.group(0)

    for path in sorted(proof_dir.glob("*.dk")):
        text = path.read_text(encoding="utf-8")
        new_text = pattern.sub(replacer, text)
        if new_text != text:
            print(f"Rewriting module references in {path.name}")
            path.write_text(new_text, encoding="utf-8")

    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("proof_dir", type=Path)
    parser.add_argument("stdlib_dir", type=Path)
    parser.add_argument("leo_dir", type=Path)
    args = parser.parse_args()

    return rewrite(args.proof_dir.resolve(), args.stdlib_dir.resolve(), args.leo_dir.resolve())


if __name__ == "__main__":
    raise SystemExit(main())
