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
            xmodmap_defs+=("-DMOBILE")
            ;;

        deimos-home)
            xrandr \
                --output eDP1 --off \
                --output HDMI1 --off \
                --output VGA1 --auto --primary
            ;;

        deimos-mobile)
            xrandr \
                --output eDP1 --auto --primary \
                --output HDMI1 --off \
                --output VGA1 --off
            xmodmap_defs+=("-DMOBILE")
            ;;

        phobos-beamer)
            xrandr \
                --output eDP1 --auto \
                --output DP1 --auto --same-as eDP1 --scale-from 1920x1080 \
                --output DP2 --off \
                --output HDMI1 --off \
                --output HDMI2 --off \
                --output VIRTUAL1 --off
            xmodmap_defs+=("-DMOBILE")
            ;;

        phobos-home)
            xrandr \
                --output eDP1 --auto \
                --output DP1 --auto --left-of eDP1 \
                --output DP2 --off \
                --output HDMI1 --off \
                --output HDMI2 --off \
                --output VIRTUAL1 --off
            ;;

        phobos-mobile)
            xrandr \
                --output eDP1 --auto \
                --output DP1 --off \
                --output DP2 --off \
                --output HDMI1 --off \
                --output HDMI2 --off \
                --output VIRTUAL1 --off
            xmodmap_defs+=("-DMOBILE")
            ;;

        phobos-single)
            xrandr \
                --output eDP1 --auto \
                --output DP1 --off \
                --output DP2 --off \
                --output HDMI1 --off \
                --output HDMI2 --off \
                --output VIRTUAL1 --off
            ;;
    esac
done

# nvidia-settings -l &
wacom.sh &
cpp -P $xmodmap_defs ~/cfg/my/xmodmap | xmodmap - &
xrdb -merge ~/cfg/my/xresources &
xset r rate 250 30 &
xsetroot -cursor_name left_ptr &

bgrscript=~/.fehbg
for n in $*; do
    fn=~/gfx/bgr/configs/$n.sh
    [[ -f $fn && -x $fn ]] && bgrscript=$fn
done
$bgrscript &
