#!/usr/bin/env bash
STATE_FILE="/tmp/hypr-caffeine-state"

# Status check for Waybar
if [[ "$1" == "--status" ]]; then
    if [[ -f "$STATE_FILE" ]]; then
        echo '{"text": "", "class": "activated", "tooltip": "Caffeine: ON"}'
    else
        echo '{"text": "", "class": "deactivated", "tooltip": "Caffeine: OFF"}'
    fi
    exit 0
fi

# Toggle logic
if [[ -f "$STATE_FILE" ]]; then
    rm "$STATE_FILE"
    # Restart hypridle and MUTE the terminal output
    hypridle > /dev/null 2>&1 & 
    notify-send "☕ Caffeine Disabled" "Idle & sleep enabled."
else
    touch "$STATE_FILE"
    pkill hypridle
    notify-send "☕ Caffeine Enabled" "Sleep disabled."
fi

# Refresh Waybar
pkill -RTMIN+9 waybar
