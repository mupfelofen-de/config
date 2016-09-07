#! /usr/bin/env zsh

alias cp='cp -i --reflink=auto'
alias defrag='btrfs filesystem defragment -rt 128m'
alias df='df -Th'
alias egrep='egrep --color=auto'
alias em=$EDITOR
alias files='tmsu files'
alias gp='gp -q'
alias grep='grep --color=auto'
alias ls='ls -lh --color=auto --group-directories-first --quoting-style=literal --show-control-chars'
alias m='mpv'
alias mlf='mpv --really-quiet --loop-file=inf'
alias mv='mv -iv'
alias myt='mpv --ytdl'
alias qmv='qmv -o tabsize=4'
alias rm='rm -Iv'
alias rsync='rsync -aSP'
alias s='su -l'
alias sc='su -lc "screen -S nevroot -xR"'
alias tag='tmsu tag'
alias tags='tmsu tags'
alias timidity='timidity -c ~/inst/eawpats/linuxconfig/timidity.cfg -B8,8 -p32 -EFdelay=d,0 -EFchorus=d,0 -EFreverb=d,0 -Os'
alias untag='tmsu untag'
alias yta='youtube-dl -x --audio-format=mp3'

alias n.list='NIX_PAGER="less -S" nix-env -qa --description'
alias n.meta='nix-env -qa --xml --meta'
alias n.q='nix-env -q'


chpwd() {
    if [[ $PWD != $OLDPWD && $PWD != $HOME ]]; then
        echo
        ls -d
        ls
        echo
    fi
}

command_not_found_handler() {
    command-not-found $*
    true
}

nohist() {
    unset HISTFILE
    echo -en "\e]11;[90]#555\x9C\e]708;[90]#555\x9C"
    echo "History saving disabled."
}

precmd() {
    hash -d pkgs=~/.nix-defexpr/channels/nixos/nixpkgs/pkgs
    hash -d sr=~/snd/music
}

preexec() {
    if [[ $TERM == rxvt* || $TERM == screen ]]; then
        echo -en "\e]0;"
        echo -n "[$2]"
        echo -n " in [`pwd | sed -e "s $HOME ~ "`] at `date "+%y-%m-%d/%u %H:%M:%S"`"
        echo -en "\a"
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


# directories
setopt \
    auto_pushd \
    pushd_ignore_dups \
    pushd_silent \
    pushd_to_home

# completion
setopt \
    no_auto_remove_slash \
    complete_in_word \
    glob_complete \
    no_list_beep \
    list_packed

# expansion and globbing
setopt \
    brace_ccl \
    csh_null_glob \
    extended_glob \
    ksh_glob \
    magic_equal_subst \
    rc_expand_param \
    rm_star_silent \
    sh_glob \
    no_unset

# history
setopt \
    extended_history \
    hist_allow_clobber \
    no_hist_beep \
    hist_fcntl_lock \
    hist_ignore_all_dups \
    hist_ignore_space \
    hist_lex_words \
    hist_no_store \
    hist_reduce_blanks \
    hist_save_no_dups \
    hist_verify \
    inc_append_history

# init
setopt \
    no_global_export

# input/output
setopt \
    interactive_comments \
    no_clobber \
    no_flow_control \
    rm_star_silent

# job control
setopt \
    auto_continue \
    no_bg_nice \
    long_list_jobs \
    monitor \
    notify

# prompting
setopt \
    rm_star_silent \
    prompt_subst \
    transient_rprompt

# scripts and functions
setopt \
    c_bases \
    c_precedences \
    no_eval_lineno

# shell emulation
setopt \
    bsd_echo

# zle
setopt \
    no_beep


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
    fortune
    echo
    tail -n10 /var/log/messages
    echo

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
