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

state="$(nmcli -t -f WIFI g 2>/dev/null || echo disabled)"

choice="$(
  {
    if [ "$state" = "enabled" ]; then
      printf '%s\n' "disable wifi"
    else
      printf '%s\n' "enable wifi"
    fi
    printf '%s\n' "rescan"
    nmcli -t -f IN-USE,SSID,SIGNAL,SECURITY dev wifi list --rescan no 2>/dev/null \
      | awk -F: '
          {
            inuse=$1
            ssid=$2
            signal=$3
            sec=$4
            if (ssid == "") next
            prefix=(inuse == "*") ? "* " : "  "
            if (sec == "") sec = "open"
            printf "%s%s\t%s%%\t%s\n", prefix, ssid, signal, sec
          }
        '
  } | menu "wifi> "
)"

[ -n "${choice:-}" ] || exit 0

case "$choice" in
  "enable wifi")
    exec nmcli radio wifi on
    ;;
  "disable wifi")
    exec nmcli radio wifi off
    ;;
  "rescan")
    exec nmcli dev wifi rescan
    ;;
esac

ssid="$(printf '%s' "$choice" | cut -f1 | sed 's/^[* ]*//')"
[ -n "$ssid" ] || exit 0

if printf '%s' "$choice" | grep -q '\topen$'; then
  exec nmcli dev wifi connect "$ssid"
fi

password="$(
  printf '' | fuzzel --dmenu \
    --prompt="pass> " \
    --placeholder="Password for $ssid" \
    --password='*' \
    --width=42 \
    --lines=0 \
    --horizontal-pad=16 \
    --vertical-pad=12
)"

[ -n "${password:-}" ] || exit 0
exec nmcli dev wifi connect "$ssid" password "$password"
