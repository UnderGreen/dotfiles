#!/bin/bash

if [[ -z $@ ]]; then
    echo -e "LCD only\nExternal only\nTwo Monitors\n"
else
    function set_mode() {
        case $1 in
            "LCD only")
                xrandr \
                    --output HDMI1 --off \
                    --output eDP1 --mode 1600x900 --rotate normal --primary \
                    --output VGA1 --off \
                    --output DP1 --off
                ;;
            "External only")
                xrandr \
                    --output HDMI1 --mode 1920x1200 --rotate normal --primary \
                    --output VIRTUAL1 --off \
                    --output DP1 --off \
                    --output eDP1 --off \
                    --output VGA1 --off
                ;;
            "Two Monitors")
                xrandr \
                    --output HDMI1 --mode 1920x1200 --above eDP1 \
                    --output eDP1 --mode 1600x900 --rotate normal --primary \
                    --output DP1 --off \
                    --output VGA1 --off
                ;;
        esac
        feh --bg-scale ~/.config/i3/bg.jpg
    }
    set_mode "$1"
fi
