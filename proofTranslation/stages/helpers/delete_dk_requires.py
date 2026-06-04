#!/usr/bin/env python3
"""Delete selected #REQUIRE lines from local DK files."""

from __future__ import annotations

import argparse
from pathlib import Path


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("proof_dir", type=Path)
    parser.add_argument("require_line", nargs="+")
    args = parser.parse_args()

    proof_dir = args.proof_dir.resolve()
    targets = set(args.require_line)

    for path in sorted(proof_dir.glob("*.dk")):
        lines = path.read_text(encoding="utf-8").splitlines()
        new_lines = [line for line in lines if line not in targets]
        if new_lines != lines:
            path.write_text("\n".join(new_lines) + "\n", encoding="utf-8")
            print(f"Cleaned: {path}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
