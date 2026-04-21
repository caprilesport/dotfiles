#!/bin/sh

active_line=$(/usr/bin/niri msg keyboard-layouts 2>/dev/null | grep '^[[:space:]]*\*' | head -n 1 | sed 's/^[[:space:]]*\*[[:space:]]*[0-9][0-9]*[[:space:]]*//')

if [ -z "$active_line" ]; then
    printf '{"text":"??","tooltip":"Keyboard layout unavailable"}\n'
    exit 0
fi

case "$active_line" in
    *"no dead keys"*)
        short="BrNDK"
        ;;
    *"Portuguese (Brazil)"*)
        short="Br"
        ;;
    *)
        short="$active_line"
        ;;
esac

escaped_tooltip=$(printf '%s' "$active_line" | sed 's/\\/\\\\/g; s/"/\\"/g')
printf '{"text":"%s","tooltip":"%s"}\n' "$short" "$escaped_tooltip"
