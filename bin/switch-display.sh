#! /usr/bin/env zsh

xmodmap_defs=()

for n in $*; do
    case $HOST-$n in
        deimos-beamer)
            xrandr \
                --fb 1366x768 \
                --output eDP1 --scale 1x1 \
                --output HDMI1 --auto --scale-from 1366x768 --same-as eDP1 \
                --output VGA1 --off
            xmodmap_defs+=("-DDEIMOS_MOBILE")
            ;;

        deimos-home)
            xrandr \
                --output eDP1 --off \
                --output HDMI1 --off \
                --output VGA1 --auto --primary
            xmodmap_defs+=("-DDEIMOS_HOME")
            ;;

        deimos-mobile)
            xrandr \
                --output eDP1 --auto --primary \
                --output HDMI1 --off \
                --output VGA1 --off
            xmodmap_defs+=("-DDEIMOS_MOBILE")
            ;;
    esac
done

nvidia-settings -l
wacom.sh
cpp -P $xmodmap_defs ~/cfg/my/xmodmap | xmodmap -
xrdb -merge ~/cfg/my/xresources
xset r rate 250 30
xsetroot -cursor_name left_ptr

feh --bg-fill ~/gfx/bgr/current.jpg
