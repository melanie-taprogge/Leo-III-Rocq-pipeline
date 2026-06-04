#!/usr/bin/env python3
"""List local DK files in the current Rocq proof export order."""

from __future__ import annotations

import argparse
from pathlib import Path


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("proof_dir", type=Path)
    args = parser.parse_args()

    proof_dir = args.proof_dir.resolve()
    emitted: set[str] = set()

    for name in ("Signature.dk", "Formulae.dk"):
        path = proof_dir / name
        if path.exists():
            print(path)
            emitted.add(name)

    for path in sorted(proof_dir.glob("*.dk")):
        if path.name in emitted or path.name == "encodedProof.dk":
            continue
        print(path)
        emitted.add(path.name)

    encoded = proof_dir / "encodedProof.dk"
    if encoded.exists():
        print(encoded)
        emitted.add(encoded.name)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
