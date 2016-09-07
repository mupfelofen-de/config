#! /usr/bin/env zsh

setopt err_exit

for n in $*; do
    ext="`basename $n | egrep -o '[A-Za-z]+$'`"
    tmpfile="`mktemp -p . --suffix=."$ext"`"
    echo "$n" >&2
    unsetopt err_exit
    gm convert -background white -extent 0x0 +matte "$n" "$tmpfile" &&
        mv "$tmpfile" "$n"
    setopt err_exit
done
