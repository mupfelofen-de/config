#! /usr/bin/env zsh

setopt err_exit

myself=$0
putHelp() {
    echo "Usage: $myself [-ht] [-s TYPE]"
    echo "  -h       This help"
    echo "  -s TYPE  Suspend to {disk|ram}."
    echo "  -t       Transparent lock screen"
}

unset susp
unset trans

while getopts hs:t opt; do
    case $opt in
        h) putHelp; exit;;
        s) case $OPTARG in
               disk) susp=disk;;
               ram) susp=ram;;
               *) putHelp; exit 1;;
           esac;;
        t) trans=1;;
        *) putHelp; exit 1;;
    esac
done

if [[ -n $trans ]]; then
    xtrlock-pam -b none &
else
    feh --no-fehbg --bg-center ~/gfx/bgr/lock-screen.png
    xtrlock-pam -b bg
    ~/.fehbg
fi

if [[ -n $susp ]]; then
    sleep 1
    case $susp in
        disk) systemctl hibernate;;
        ram)  systemctl suspend;;
        *)    echo "Unknown suspension type (this is a bug)." 1>&2
              exit 1
    esac
fi
