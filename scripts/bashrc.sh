function quickfind()
{
  find ./ -name "$1" -exec grep "$2" {} \; -print
}

function set_colors {
    # Set colors
    COLOR_NONE="\033[0m"
    COLOR_BLACK="\033[0;30m"
    COLOR_GRAY="\033[1;30m"
    COLOR_BLUE="\033[0;34m"
    COLOR_LIGHT_BLUE="\033[1;34m"
    COLOR_GREEN="\033[0;32m"
    COLOR_LIGHT_GREEN="\033[1;32m"
    COLOR_CYAN="\033[0;36m"
    COLOR_TEAL="\033[1;36m"
    COLOR_RED="\033[0;31m"
    COLOR_LIGHT_RED="\033[1;31m";
    COLOR_PINK="\033[1;31m"
    COLOR_PURPLE="\033[0;35m"
    COLOR_LIGHT_PURPLE="\033[1;35m"
    COLOR_BROWN="\033[0;33m"
    COLOR_YELLOW="\033[1;33m"
    COLOR_LIGHT_GRAY="\033[0;37m"
    COLOR_WHITE="\033[1;37m"
}  


set_colors

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias topmem='ps -axo pid,rsz,vsz,cmd,args | sort -n -k2 | tail -20'
alias topdisk='topdisk.sh'
alias qf=quickfind

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Set environment variables

# Set Editor
export EDITOR=vim

# Set Third Party Tools
export TPS=$HOME/tps

# Set Java
export JAVA_HOME=$TPS/jdk/jdk1.7.0_15

# Set Eclipse Home
export ECLIPSE_HOME=$TPS/eclipse

# Set Sun Studio Analyzer
export SSA_HOME=$TPS/solarisstudio/solarisstudio12.3

# Set Environment name
export ENVIRONMENT_NAME=${ENVIRONMENT_NAME:-`whoami`}
export HOST=${HOST:-`hostname`}

export PATH=$PATH:$JAVA_HOME/bin:$ECLIPSE_HOME/eclipse-SDK-4.2.1-linux-gtk-x86_64:$ECLIPSE_HOME/MemoryAnalyzer-1.2.1.20121105-linux:$SSA_HOME/bin


PS1="`echo ${COLOR_CYAN}`${ENVIRONMENT_NAME}.${HOST}`echo ${COLOR_YELLOW}`[\t] `echo ${COLOR_NONE}`> "'($PWD)
$ '; export PS1
