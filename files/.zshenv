#! /usr/bin/env zsh

export ALTERNATE_EDITOR=""
#export BROWSER="palemoon"
export BROWSER="firefox"
export CHICKEN_DOC_REPOSITORY=~/.chicken/chicken-doc
export CHICKEN_INSTALL_PREFIX=~/.chicken
export CHICKEN_REPOSITORY=~/.chicken/eggs
export COPYRIGHT="2018 Michael Fitzmayer"
export EDITOR="emacsclient -c -q"
export EMAIL="Michael Fitzmayer <mail@michael-fitzmayer.de>"
export LANG=en_GB.UTF-8
export LC_COLLATE=POSIX
export LC_CTYPE=de_DE.UTF-8
export LESS="-iMR -j2 -x2 -z-4 --shift=2 -PM ?f%f:<pipe>. ?e(EOF) .?m(%i/%m) .[%Pt\% %lt/%L] [%c] [%pt\% %bt/%B] ?x-> %x ."
export MPD_HOST=~/.mpd/socket
export NCURSES_ASSUMED_COLORS="7,-1"
export NIX_PAGER="cat"
export PAGER="less"
export PGDATA=~/db/postgres

NIX_PATH="nixpkgs=/nix/var/nix/profiles/per-user/$USER/channels/nixos/nixpkgs"
NIX_PATH+=":nixos-config=/etc/nixos/configuration.nix"
NIX_PATH+=":/nix/var/nix/profiles/per-user/$USER/channels"
NIX_PATH+=":ertes-src=$HOME/src"
NIX_PATH+=":channels=$HOME/channels"

path=(${path:#/run/current-system/sw/bin})
path+=(/run/current-system/sw/bin)

path=(${path:#/home/micha/cfg/my/bin})
path+=(~/cfg/my/bin)

path=(${path:#/home/micha/bin})
path+=(~/bin)

manpath=(
    /run/current-system/sw/share/man
    ~/.nix-profile/share/man
)
