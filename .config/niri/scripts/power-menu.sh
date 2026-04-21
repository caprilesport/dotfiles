#!/bin/sh

choice="$(
  printf '%s\n' \
    "lock" \
    "logout" \
    "suspend" \
    "reboot" \
    "shutdown" \
  | fuzzel --dmenu \
      --prompt='power> ' \
      --width=24 \
      --lines=5 \
      --horizontal-pad=16 \
      --vertical-pad=12
)"

case "$choice" in
  lock)
    exec swaylock
    ;;
  logout)
    exec niri msg action quit
    ;;
  suspend)
    swaylock && exec systemctl suspend
    ;;
  reboot)
    exec systemctl reboot
    ;;
  shutdown)
    exec systemctl poweroff
    ;;
esac
