#!/usr/bin/env bash
# Emits "VOL%" or " muted" whenever volume/mute changes. Requires pamixer + pactl.

if ! command -v pamixer >/dev/null 2>&1; then
    echo "no pamixer"
    exit 0
fi

print_vol() {
    if pamixer --get-mute 2>/dev/null | grep -q true; then
        echo " muted"
    else
        vol=$(pamixer --get-volume 2>/dev/null || echo 0)
        echo " ${vol}%"
    fi
}

print_vol

pactl subscribe 2>/dev/null | grep --line-buffered "on sink" | while read -r _; do
    print_vol
done
