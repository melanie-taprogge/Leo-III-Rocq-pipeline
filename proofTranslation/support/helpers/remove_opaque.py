#!/usr/bin/env python3
"""Remove opaque modifiers from Lambdapi source files."""

from __future__ import annotations

import re
import sys
from pathlib import Path


OPAQUE_SYMBOL = re.compile(r"\bopaque([ \t\r\n]+symbol\b)")


def main() -> int:
    if len(sys.argv) != 2:
        print("Usage: remove_opaque.py FILE", file=sys.stderr)
        return 2

    path = Path(sys.argv[1])
    text = path.read_text(encoding="utf-8")
    updated = OPAQUE_SYMBOL.sub(r"\1", text)
    if updated != text:
        path.write_text(updated, encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
