#!/bin/bash

CHOSEN=$(printf "  Performance\n  Balanced\n󰌪  Power-saver" | fuzzel --dmenu --prompt="󰓅 : " --width=25 --lines=3)

if [ -n "$CHOSEN" ]; then
    MODE_NAME=$(echo "$CHOSEN" | awk '{print $NF}')
    MODE_LOWER=$(echo "$MODE_NAME" | tr '[:upper:]' '[:lower:]')

    powerprofilesctl set "$MODE_LOWER"

    busctl --user call \
        org.freedesktop.Notifications \
        /org/freedesktop/Notifications \
        org.freedesktop.Notifications \
        Notify \
        susssasa{sv}i \
        "PowerManager" 0 "battery" "Power Plan" "Current：$MODE_NAME" 0 0 3000
fi
