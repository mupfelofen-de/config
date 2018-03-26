#! /usr/bin/env zsh

setpen()    {}
seteraser() {}
settouch()  {}
setpad()    {}

case $HOST in
    deimos) ;&
    phobos)
        setpen()    { xsetwacom set "Wacom BambooPT 2FG Small Pen stylus" $* }
        seteraser() { xsetwacom set "Wacom BambooPT 2FG Small Pen eraser" $* }
        setpad()    { xsetwacom set "Wacom BambooPT 2FG Small Pad pad" $* }
        xinput disable "$(xinput list --id-only "Wacom BambooPT 2FG Small Finger")"
        setpen MapToOutput eDP1
        ;;

    elara)
        setpen() { xsetwacom set "Wacom Intuos S 2 Pen stylus" $* }
        setpad() { xsetwacom set "Wacom Intuos S 2 Pad pad" $* }
        setpen MapToOutput HDMI1
        ;;
esac

setpen Mode "Absolute"
setpen PressureCurve "0 0 100 100"
setpen Rotate "none"
setpen ScrollDistance "0"
setpen Suppress "2"
setpen TabletPCButton "off"
setpen TapTime "250"
setpen Threshold "500"

seteraser MapToOutput eDP1
seteraser Mode "Absolute"
seteraser PressureCurve "0 0 100 100"
seteraser ScrollDistance "0"
seteraser Suppress "2"
seteraser TapTime "250"
seteraser Threshold "500"

setpad "Touch" off
