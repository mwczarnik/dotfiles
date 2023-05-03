# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


shopt -s checkwinsize
shopt -s histappend

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # ADD ls DEFAULT FORMAT
    alias ls='ls -l --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# BASH COMPLETION
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#################################PERSONAL SETUP####################################################

#VARIABLES AND ALIASES
#export PS1="\e[1;35m[\e[m\e[01;36m\u@\e[01;36m\h\e[m \e[01;33m\W\e[m\e[1;35m]\e[m\e[01;37m\$\e[m "
#export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u\[\033[01;33m\]@\[\033[01;35m\]\h\[\033[00m\][\[\033[01;32m\]\W\[\033[00m\]]\$ '

HISTCONTROL=ignoreboth
HISTSIZE=
HISTFILESIZE=

export PS1='\[\033[37m\]┌─${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u\[\033[01;35m\][\[\033[01;33m\]\W\[\033[35m\]]\n\[\033[37m\]└─\[\033[01;92m\]\$\[\033[00m\] '
export PATH=$PATH:/usr/sbin:/usr/local/bin/:$HOME/.local/bin:/usr/local/go/bin
export VISUAL=nvim
export EDITOR="$VISUAL"

#APPS variables
export VAGRANT_DEFAULT_PROVIDER="libvirt"
export GOPATH="${HOME}/.gopath"
export K9S_EDITOR=nvim
export KUBE_EDITOR=nvim

alias gnome-reset="killall -9 gnome-shell"
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CFl'
#alias set-env="set -a; . $1 ;set +a"
alias vim='nvim'
alias vi='nvim'

function set-env() {
    set -a
    . $1
    set +a
}

#alias f_sync ='rsync -vrPacu /media/veracrypt1/coding_stuff /coding_stuff/'


#TMUX ON TERMINAL STARTUP
session_name=$USER

#check if teminal belongs to vscode
TTY_PPID=$(ps -o ppid= -p  $$ )
IF_VSCODE=$(ps aux | grep $TTY_PPID | grep -v grep | grep code > /dev/null ;echo $?)

# If tty is inside vscode, then skip further processing
if [[ '1' == $IF_VSCODE ]]; then
    # First you check if a tmux session exists with a given name.
    tmux has-session -t=$session_name 2> /dev/null

    # Create the session if it doesn't exists.
    if [[ $? -ne 0 ]]; then
      TMUX='' tmux new-session -d -s "$session_name"
    fi

    # Attach if outside of tmux, switch if you're in tmux.
    if [[ -z "$TMUX" ]]; then
      tmux attach -t "$session_name"
    else
      tmux switch-client -t "$session_name"
    fi
fi

    
# GIT CONFIG
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

# Hashicorp
complete -C /usr/bin/terraform terraform
complete -C /usr/bin/packer packer

#K8s
#kubectl config set-cluster talos-vbox-cluster --insecure-skip-tls-verify=true
source <(kubectl completion bash)
source <(helm completion bash)
alias k=kubectl
complete -o default -F __start_kubectl k

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


#if [ -z "$SSH_AUTH_SOCK" ] ; then
#    eval `ssh-agent -s`
#    ssh-add
#fi

#. "$HOME/.cargo/env"
