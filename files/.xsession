#! /run/current-system/sw/bin/zsh -l

switch-display.sh

setopt no_bg_nice
emacs --daemon &

exec s6-svscan -t0 ~/cfg/my/services
