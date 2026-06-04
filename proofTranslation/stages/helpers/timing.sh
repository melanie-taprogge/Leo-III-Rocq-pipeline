#!/usr/bin/env bash

timer_now() {
  python3 -c 'import time; print(f"{time.time():.6f}")'
}

phase_start() {
  __phase_name="$1"
  __phase_start="$(timer_now)"
}

phase_end() {
  local end elapsed
  end="$(timer_now)"
  elapsed="$(python3 - "$__phase_start" "$end" <<'PY'
import sys
print(f"{float(sys.argv[2]) - float(sys.argv[1]):.6f}")
PY
)"
  printf 'PHASE_TIME %s %s\n' "$__phase_name" "$elapsed"
}
