#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export NNN_TMPFILE="/tmp/nnn"
n()
{
        nnn "$@"

        if [ -f $NNN_TMPFILE ]; then
                . $NNN_TMPFILE
                rm -f $NNN_TMPFILE > /dev/null
        fi
}

alias ls='ls --color=auto'
alias dus='du --summarize -ch'
alias wp='hsetroot -full'
alias screen-lock="i3lock -efc 000000"
alias refresh-pacman="sudo refresh-pacman"
alias feh="feh -."
alias pacman="pacman --color auto"
PS1='[\u@\h \W]\$ '
TERMINAL=termite
export EDITOR="vim" 
stty -ixon

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

(cat ~/.cache/wal/sequences &)

archey3 --config=~/.config/archey3.cfg
