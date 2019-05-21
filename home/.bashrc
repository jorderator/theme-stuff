#
# ~/.bashrc
#

(cat ~/.cache/wal/sequences &)

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
alias screen-lock="i3lock -efc 000000"
alias refresh-pacman="sudo refresh-pacman"
alias feh="feh -."
alias pacman="pacman --color auto"
alias night-mode="redshift -PO 4500K -b 0.7"
alias day-mode="redshift -x"

PS1=' \[\033[1m\][\[\033[0m\]\[\033[33m\]\u@\h \[\033[31m\]\W\[\033[0m\]\[\033[1m\]]\[\033[0m\]\$ '
export TERMINAL="termite"
export EDITOR="vim" 
stty -ixon

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
source /usr/share/bash-completion/completions/pass

archey3 --config=~/.config/archey3.cfg
