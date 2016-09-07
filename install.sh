#! /usr/bin/env zsh

setopt err_exit
setopt null_glob

inst_file() {
    for n in $*; do
        if [[ -d $n ]]; then
            if [[ -f $n/.linkdir ]]; then
                ln -sf `pwd`/$n ~/$n
            else
                mkdir -p ~/$n
                inst_file $n/{,.}*
            fi
            continue
        fi
        if [[ -f $n ]]; then
            ln -sf `pwd`/$n ~/$n
            continue
        fi
        echo "Skipping special file: files/$n" >&2
    done
}

(cd files && inst_file {,.}*)
