#! /run/current-system/sw/bin/zsh -l

switch-display.sh

setopt no_bg_nice
emacs --daemon &

~/cfg/my/bin/update-xorg-services.sh
exec s6-svscan -t0 ~/cfg/run/xorg
