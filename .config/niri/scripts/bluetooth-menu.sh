#!/bin/sh

set -eu

menu() {
  fuzzel --dmenu \
    --prompt="$1" \
    --width=60 \
    --lines=14 \
    --horizontal-pad=16 \
    --vertical-pad=12
}

powered="$(bluetoothctl show | awk -F': ' '/Powered:/ {print $2; exit}')"

choice="$(
  {
    if [ "$powered" = "yes" ]; then
      printf '%s\n' "power off"
    else
      printf '%s\n' "power on"
    fi
    printf '%s\n' "scan"

    bluetoothctl devices | while read -r _ mac name_rest; do
      [ -n "${mac:-}" ] || continue
      name="${name_rest:-Unknown device}"

      if bluetoothctl info "$mac" 2>/dev/null | grep -q 'Connected: yes'; then
        state="connected"
      elif bluetoothctl info "$mac" 2>/dev/null | grep -q 'Paired: yes'; then
        state="paired"
      else
        state="seen"
      fi

      printf '%s\t%s\t%s\n' "$name" "$state" "$mac"
    done
  } | menu "bt> "
)"

[ -n "${choice:-}" ] || exit 0

case "$choice" in
  "power on")
    exec bluetoothctl power on
    ;;
  "power off")
    exec bluetoothctl power off
    ;;
  "scan")
    bluetoothctl scan on >/dev/null 2>&1 &
    exit 0
    ;;
esac

mac="$(printf '%s' "$choice" | awk -F'\t' '{print $3}')"
[ -n "${mac:-}" ] || exit 0

if bluetoothctl info "$mac" 2>/dev/null | grep -q 'Connected: yes'; then
  exec bluetoothctl disconnect "$mac"
fi

if ! bluetoothctl info "$mac" 2>/dev/null | grep -q 'Paired: yes'; then
  bluetoothctl pair "$mac"
fi

bluetoothctl trust "$mac" >/dev/null 2>&1 || true
exec bluetoothctl connect "$mac"
