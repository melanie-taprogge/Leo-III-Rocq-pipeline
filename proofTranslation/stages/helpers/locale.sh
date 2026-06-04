choose_utf8_locale() {
  local cand
  for cand in "${LP_ROCQ_LOCALE:-}" "${LC_ALL:-}" "${LC_CTYPE:-}" "${LANG:-}" C.UTF-8 C.utf8 en_US.UTF-8 en_US.utf8; do
    [ -n "$cand" ] || continue
    case "$cand" in
      *UTF-8*|*utf8*) ;;
      *) continue ;;
    esac
    if LC_ALL="$cand" locale charmap >/dev/null 2>&1; then
      printf '%s\n' "$cand"
      return 0
    fi
  done

  echo "Error: no usable UTF-8 locale found." >&2
  echo "Set LP_ROCQ_LOCALE to a valid UTF-8 locale for this machine." >&2
  return 1
}

export_utf8_locale() {
  local loc
  loc="$(choose_utf8_locale)"
  export LANG="$loc"
  export LC_ALL="$loc"
  export LC_CTYPE="$loc"
}
