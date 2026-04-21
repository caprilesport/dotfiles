#!/usr/bin/env bash
set -euo pipefail

direction="${1:-}"

if [[ -z "${direction}" ]]; then
    exit 2
fi

if kitty @ focus-window --match "neighbor:${direction}" >/dev/null 2>&1; then
    exit 0
fi

case "${direction}" in
    left|top)
        kitty @ action previous_tab >/dev/null
        ;;
    right|bottom)
        kitty @ action next_tab >/dev/null
        ;;
    *)
        exit 2
        ;;
esac
