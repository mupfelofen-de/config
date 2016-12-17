#! /run/current-system/sw/bin/zsh -l

switch-display.sh

setopt no_bg_nice
emacs --daemon &

xset +dpms
xset dpms 0 0 7200
xset s off

exec s6-svscan -t0 ~/cfg/my/services
