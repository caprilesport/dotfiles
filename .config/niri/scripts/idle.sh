#!/bin/sh

pkill -x swayidle 2>/dev/null || true

exec swayidle -w \
    timeout 600 'swaylock -f' \
    timeout 1800 'swaylock -f && systemctl suspend' \
    before-sleep 'swaylock -f'
