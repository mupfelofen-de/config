#! /usr/bin/env zsh

alias adm='sudo /root/cfg/my/bin/adm'
alias cp='cp -i --reflink=auto'
alias dd='dd status=progress bs=1M'
alias defrag='btrfs filesystem defragment -r -t1g'
alias df='df -Th'
alias egrep='egrep --color=auto'
alias em='emacsclient -c -n -q'
alias files='tmsu files'
alias gp='gp -q'
alias grep='grep --color=auto'
alias ls='ls -lh --color=auto --group-directories-first --quoting-style=literal --show-control-chars'
alias m='mpv'
alias ml='mpv --loop-file=inf'
alias mlq='mpv --really-quiet --loop-file=inf'
alias mv='mv -iv'
alias myt='mpv --ytdl --load-unsafe-playlists'
alias qmv='qmv -o tabsize=4'
alias rm='rm -Iv'
alias rsync='rsync -aSP'
alias s='su -l'
alias sc='su -lc "screen -S nevroot -xR"'
alias svc='s6-svc'
alias sysupdate='yaourt -Syu --aur'
alias sysupdate.throttled='yaourt -Syu --aur --config /etc/pacman.conf.throttled'
alias tag='tmsu tag'
alias tags='tmsu tags'
alias timidity='timidity -c ~/inst/eawpats/linuxconfig/timidity.cfg -B8,8 -p32 -EFdelay=d,0 -EFchorus=d,0 -EFreverb=d,0 -Os'
alias trc='transmission-create'
alias trr='transmission-remote'
alias trs='transmission-show'
alias untag='tmsu untag'
alias yta='youtube-dl -x --audio-format=mp3'
alias ytd='youtube-dl -s --get-description'

alias n.list='NIX_PAGER="less -S" nix-env -qa --description'
alias n.meta='nix-env -qa --xml --meta'
alias n.q='nix-env -q'
alias n.r='nix-repl "<nixpkgs>"'


chpwd() {
    if [[ $PWD != $OLDPWD && $PWD != $HOME ]]; then
        echo
        ls -d
        ls
        echo
    fi
}

if whence command-not-found > /dev/null; then
    command_not_found_handler() {
        command command-not-found $*
    }
fi

nohist() {
    unset HISTFILE
    setbgcolor "[80]#555"
    echo "History saving disabled."
}

precmd() {
    hash -d cfg=~/cfg/my
    hash -d pkgs=~/.nix-defexpr/channels/nixos/nixpkgs/pkgs
    hash -d sr=~/snd/music
    hash -d sv=~/cfg/my/services
}

preexec() {
    if [[ $TERM == rxvt* || $TERM == screen ]]; then
        echo -en "\e]0;"
        echo -n "[$2]"
        echo -n " in [`pwd | sed -e "s $HOME ~ "`] at `date "+%y-%m-%d/%u %H:%M:%S"`"
        echo -en "\a"
    fi
}

setbgcolor() {
    if [[ $TERM == rxvt* ]]; then
        echo -en "\e]11;$1\x9C\e]708;$1\x9C"
    fi
}

tea() {
    sleep $1
    mpv --loop-file=inf ~/snd/beep
}

with() {
    export nev_subshell=yes
    nev_with="${nev_with+$nev_with }$*" nix-shell --command zsh -p $*
}


HISTFILE="$HOME/.zsh_history"
HISTSIZE=4096
LISTMAX=1024
POSTEDIT=$'\e[m'
READNULLCMD="cat"
REPORTTIME=15
SAVEHIST=4096
WORDCHARS="*?[];!#~"

PS1=''
[[ -n $nev_with ]] && PS1+=$'%F{white}(+ $nev_with) '
PS1+=$'%B%F{white}%! '
[[ $TERM == rxvt* || $TERM == screen ]] && PS1+=$'%{\e]0;%N: %n@%m in (%~)%(1j; (jobs: %j);)%(0?;; (err: %?%))\a%}'
[[ -n $SSH_CONNECTION ]] && PS1+=$'%F{red}(@%m) '
PS1+=$'%(!;%F{red};%F{green})%n '
PS1+=$'%F{yellow}%1~ '
PS1+=$'%(1_;%F{cyan}+;%(0?;%F{white};%b%F{yellow})%#%B)%f '

RPS1=$'%F{yellow}%~'
RPS1+=$'%(1j; (%jj);)'
RPS1+=$'%(0?;; (%?e%))%B'

PS2=$PS1
RPS2='%_'

TIMEFMT=$'\e[m\e[1m'
TIMEFMT+=$'\e[36m  real \e[32m%*E'
TIMEFMT+=$'\e[36m  user \e[33m%*U'
TIMEFMT+=$'\e[36m  krnl \e[32m%*S'
TIMEFMT+=$'\e[36m  cpu%% \e[32m%P'
TIMEFMT+=$'\e[36m  mem \e[32m%Mm'
TIMEFMT+=$'\e[35m  %J\e[m'

eval $(dircolors ~/cfg/my/dircolors)

umask 022


setopt auto_continue
setopt auto_pushd
setopt brace_ccl
setopt bsd_echo
setopt c_bases
setopt c_precedences
setopt complete_in_word
setopt csh_null_glob
setopt extended_glob
setopt glob_complete
setopt hash_executables_only
setopt hist_allow_clobber
setopt hist_fcntl_lock
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_lex_words
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt interactive_comments
setopt ksh_glob
setopt list_packed
setopt long_list_jobs
setopt magic_equal_subst
setopt monitor
setopt no_auto_remove_slash
setopt no_beep
setopt no_bg_nice
setopt no_clobber
setopt no_eval_lineno
setopt no_flow_control
setopt no_global_export
setopt no_hist_beep
setopt no_list_beep
setopt no_unset
setopt notify
setopt prompt_subst
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home
setopt rc_expand_param
setopt rm_star_silent
# setopt sh_glob
setopt transient_rprompt


bindkey "^I"   complete-word
bindkey "^[Od" emacs-backward-word
bindkey "^[Oc" emacs-forward-word
bindkey "^W"   kill-region


zstyle ':completion:*' completer _expand _complete _ignored _match
zstyle ":completion:*" force-list always
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' menu select
zstyle ":completion:*" special-dirs ".."
zstyle ":completion:*" verbose true

autoload -Uz compinit
compinit


if [[ -z ${nev_subshell-} ]]; then
    #fortune
    #echo
    #tail -n10 /var/log/messages
    #echo

    ibam --percentcharge
    echo
    echo -e $(date)
    echo
    if [ -f .todo ]; then
        todo
        echo
    fi

    if which notmuch &> /dev/null && [[ -f ~/.notmuch-config ]]; then
        mI=`notmuch count not tag:unread and tag:inbox`
        mS=`notmuch count tag:unread and folder:system`
        mU=`notmuch count tag:unread and not folder:system`
        if ((mI > 0 || mS > 0 || mU > 0)); then
            ((mS > 0)) && echo -en "\033[1;31m"
            ((mU > 0)) && echo -en "\033[1;33m"
            echo -e "Mails: $mU unread, $mS system, $mI pending\033[m\n"
        fi
        unset mI
        unset mS
        unset mU
    fi
fi
