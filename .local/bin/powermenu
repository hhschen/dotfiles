#!/bin/sh

SELECTIONS="󰐥 Shutdown\n󰜉 Reboot\n󰍃 Logout\n󰏥 Suspend\n Lock"

choice=$(printf "$SELECTIONS" | fuzzel --dmenu \
    --prompt=" " \
    --border-width=2 \
    --width=18 \
    --lines=5 \
    --vertical-pad=10 \
    --inner-pad=10 \
    --horizontal-pad=20 \
)

[ -z "$choice" ] && exit 0

case "$choice" in
    *Shutdown) systemctl poweroff ;;
    *Reboot)   systemctl reboot ;;
    *Logout)   loginctl terminate-user "$USER" ;;
    *Suspend)  systemctl suspend ;;
    *Lock)     swaylock;;
esac
