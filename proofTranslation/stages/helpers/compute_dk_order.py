#!/usr/bin/env python3
"""Compute topological order for local DK files."""

from __future__ import annotations

import argparse
import re
from collections import defaultdict, deque
from pathlib import Path


def dk_requires(path: Path) -> list[str]:
    deps: list[str] = []
    for line in path.read_text(encoding="utf-8").splitlines():
        if not line.startswith("#REQUIRE "):
            continue
        match = re.match(r"^#REQUIRE\s+\{\|([^|]+)\|\}\.", line)
        if match:
            deps.append(match.group(1))
            continue
        match = re.match(r"^#REQUIRE\s+([^.]+)\.", line)
        if match:
            deps.append(match.group(1))
    return deps


def compute_order(proof_dir: Path) -> list[Path]:
    modules = {p.stem: p for p in sorted(proof_dir.glob("*.dk"))}
    deps: dict[str, set[str]] = defaultdict(set)
    rev: dict[str, set[str]] = defaultdict(set)

    for mod in modules:
        deps[mod] = set()

    for mod, path in modules.items():
        for dep in dk_requires(path):
            if dep in modules:
                deps[mod].add(dep)
                rev[dep].add(mod)

    indeg = {mod: len(deps[mod]) for mod in modules}
    queue = deque(sorted(mod for mod in modules if indeg[mod] == 0))
    order: list[str] = []

    while queue:
        mod = queue.popleft()
        order.append(mod)
        for nxt in sorted(rev[mod]):
            indeg[nxt] -= 1
            if indeg[nxt] == 0:
                queue.append(nxt)

    if len(order) != len(modules):
        remaining = sorted(mod for mod in modules if indeg[mod] > 0)
        raise SystemExit("Cyclic local DK dependencies: " + ", ".join(remaining))

    return [modules[mod] for mod in order]


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("proof_dir", type=Path)
    args = parser.parse_args()

    for path in compute_order(args.proof_dir.resolve()):
        print(path.name)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
