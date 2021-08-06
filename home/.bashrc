#
# ~/.bashrc
#

# Apply generated colour schemes
(cat ~/.cache/wal/sequences &)

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Allow nnn to exit to new directory
export NNN_TMPFILE="/tmp/nnn"
n()
{
        nnn "$@"

        if [ -f $NNN_TMPFILE ]; then
                . $NNN_TMPFILE
                rm -f $NNN_TMPFILE > /dev/null
        fi
}

# Command aliases, colour etc + shortcuts
alias ls='ls --color=auto'
alias dus='du --summarize -ch'
alias screen-lock="i3lock -efc 000000"
alias refresh-pacman="sudo refresh-pacman"
alias feh="feh -."
alias pacman="pacman --color auto"
alias yay="yay --color auto"
alias night-mode="redshift -PO 4500K -b 0.7"
alias day-mode="redshift -x"
alias usb-mount="sudo mount -o uid=1000,gid=1000,dmask=022,fmask=133,exec"
alias gotop="gotop -ps"

# Setting variables, first for prompt, then functionality
PS1=' \[\e[1m\][\[\e[0m\]\[\e[33m\]\u@\h \[\e[31m\]\W\[\e[0m\]\[\e[1m\]]\[\e[0m\]\$ '
#PS1=' \[\033[1m\][\[\033[0m\]\[\033[33m\]\u@\h \[\033[31m\]\W\[\033[0m\]\[\033[1m\]]\[\033[0m\]\$ '
export TERMINAL="alacritty"
export EDITOR="vim" 
eval "$(luarocks path)"
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
stty -ixon

# Imports for completion
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
source /usr/share/bash-completion/completions/pass
source /usr/share/git/completion/git-completion.bash

# Import for time printing
# this must be the last import
source ~/.bash-preexec.sh

# setup for time printing
preexec() { echo $'  \e[2m\e[4m'$(date +"%b %d; %H:%M:%S")$'\e[m'; }
#precmd() { echo $'  \e[2m\e[4m'$(date +"%b %d; %H:%M:%S")$'\e[m'; }

# Stuff to print at terminal start
echo ""
neofetch --disable gpu #--ip_host "https://myexternalip.com/raw/" --ip_timeout 3  --disk_show '/' --gpu_type dedicated
