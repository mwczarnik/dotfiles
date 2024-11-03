# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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





## GENERAL OPTIONS ##

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

## SMARTER TAB-COMPLETION (Readline bindings) ##

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'history -a'
# Huge history. Doesn't appear to slow things down, so why not?
#HISTSIZE=500000
#HISTFILESIZE=100000

# Avoid duplicate entries
#HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
#export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

# Examples:
# export dotfiles="$HOME/dotfiles"
# export projects="$HOME/projects"
# export documents="$HOME/Documents"
# export dropbox="$HOME/Dropbox"


#VARIABLES AND ALIASES
HISTCONTROL=ignoreboth
HISTSIZE=
HISTFILESIZE=
#export HISTTIMEFORMAT="%s "
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER "$(history 1)" >> ~/.bash_eternal_history'

export PS1='\[\033[37m\]┌─${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u\[\033[01;35m\][\[\033[01;33m\]\W\[\033[35m\]]\[\033[01;00m\] \t \n\[\033[37m\]└─\[\033[01;92m\]➤\[\033[00m\] '
#export PS1='\[\033[37m\]┌─${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u\[\033[01;35m\][\[\033[01;33m\]\W\[\033[35m\]]\[\033[01;00m\] \t \n\[\033[37m\]└─\[\033[01;92m\]\$\[\033[00m\] '
#export PS1='\[\033[37m\]${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u\[\033[01;35m\][\[\033[01;33m\]\W\[\033[35m\]]\[\033[01;00m\] \t \n\[\033[01;92m\]➤\[\033[00m\] '

export PATH=$PATH:/usr/sbin:/usr/local/bin/:$HOME/.local/bin:/usr/local/go/bin
export VISUAL=nvim
export EDITOR=nvim
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}

#APPS variables
export VAGRANT_DEFAULT_PROVIDER="libvirt"
export GOPATH="${HOME}/.gopath"
export K9S_EDITOR=nvim
export KUBE_EDITOR=nvim

HOSTNAME="$(/usr/bin/hostname 2>/dev/null)"

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
      TMUX='' tmux new-session -d -s "$session_name"  #glances
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
    GIT_PROMPT_THEME="Custom"
    GIT_PROMPT_THEME_FILE=${HOME}/.config/bash_git_prompt/bash_git_prompt.bgptheme
    GIT_PROMPT_END="\n${PS1}"

    source $HOME/.bash-git-prompt/gitprompt.sh
fi

# Hashicorp
complete -C /usr/bin/terraform terraform
complete -C /usr/bin/packer packer

#K8S
#kubectl config set-cluster talos-vbox-cluster --insecure-skip-tls-verify=true
source <(kubectl completion bash)
source <(helm completion bash)
alias k=kubectl
complete -o default -F __start_kubectl k


# User specific environment and startup programs
. "$HOME/.cargo/env"

# Yazi 
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

