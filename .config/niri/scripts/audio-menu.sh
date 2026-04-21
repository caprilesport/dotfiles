#!/bin/sh

set -eu

menu() {
  fuzzel --dmenu \
    --prompt="$1" \
    --width=48 \
    --lines=10 \
    --horizontal-pad=16 \
    --vertical-pad=12
}

pick_kind() {
  printf '%s\n' \
    "output" \
    "input" \
  | menu "audio> "
}

pick_device() {
  section="$1"
  next_section="$2"

  wpctl status | awk -v section="$section" -v next_section="$next_section" '
    $0 ~ ("├─ " section ":") || $0 ~ ("└─ " section ":") { in_section=1; next }
    in_section && ($0 ~ ("├─ " next_section ":") || $0 ~ ("└─ " next_section ":")) { in_section=0 }
    in_section && $0 ~ /^[[:space:]]*│/ {
      line = $0
      sub(/^[[:space:]]*│/, "", line)
      if (line ~ /^[[:space:]]*$/) next

      is_default = (line ~ /\*/)
      gsub(/\*/, "", line)
      sub(/^[[:space:]]+/, "", line)

      if (match(line, /^([0-9]+)\. (.*) \[vol: [^]]+\]$/, m)) {
        id = m[1]
        name = m[2]
      } else if (match(line, /^([0-9]+)\. (.*)$/, m)) {
        id = m[1]
        name = m[2]
      } else {
        next
      }

      prefix = is_default ? "* " : "  "
      printf "%s%s\t%s\n", prefix, name, id
    }
  ' | fuzzel --dmenu \
        --prompt="$section> " \
        --width=70 \
        --lines=12 \
        --horizontal-pad=16 \
        --vertical-pad=12 \
        --with-nth=1 \
        --accept-nth=2
}

case "$(pick_kind)" in
  output)
    choice="$(pick_device "Sinks" "Sources" || true)"
    [ -n "${choice:-}" ] && exec wpctl set-default "$choice"
    ;;
  input)
    choice="$(pick_device "Sources" "Filters" || true)"
    [ -n "${choice:-}" ] && exec wpctl set-default "$choice"
    ;;
esac
