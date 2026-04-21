#!/bin/sh

set -eu

choice="$(
  cliphist list | fuzzel --dmenu \
    --prompt="clip> " \
    --width=80 \
    --lines=14 \
    --horizontal-pad=16 \
    --vertical-pad=12
)"

[ -n "${choice:-}" ] || exit 0
printf '%s' "$choice" | cliphist decode | wl-copy
