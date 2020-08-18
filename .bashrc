# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Use bash completion
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# Make history global
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
shopt -s histappend

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Extra paths
export PATH=$PATH:~/.local/bin

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alFh --group-directories-first'
alias la='ls -A'
alias l='ls -l --group-directories-first'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

# Auto start tmux only on the first terminal window. If in tty do nothing
case "$(ps a)" in
    *tmux*) true ;;
    *)  [ "$DISPLAY" ] && tmux new-session ;;
esac

# Custom dircolors
eval "$(dircolors ~/.dircolors/DIR_COLORS)"

function set_bash_prompt () {
	# Color codes for easy prompt building
	COLOR_DIVIDER="\[\e[30;1m\]"
	COLOR_CMDCOUNT="\[\e[34;1m\]"
	COLOR_USERNAME="\[\e[34;1m\]"
	COLOR_USERHOSTAT="\[\e[35;1m\]"
	COLOR_HOSTNAME="\[\e[36;1m\]"
	COLOR_GITBRANCH="\[\e[33;1m\]"
	COLOR_VENV="\[\e[33;1m\]"
	COLOR_GREEN="\[\e[32;1m\]"
	COLOR_PATH_OK="\[\e[32;1m\]"
	COLOR_PATH_ERR="\[\e[31;1m\]"
	COLOR_NONE="\[\e[0m\]"
	# Change the path color based on return value.
	if test $? -eq 0 ; then
		PATH_COLOR=${COLOR_PATH_OK}
	else
		PATH_COLOR=${COLOR_PATH_ERR}
	fi
	# Set the PS1 to be "[workingdirectory:commandcount"
	PS1="${COLOR_DIVIDER}[${PATH_COLOR}\w${COLOR_DIVIDER}:${COLOR_CMDCOUNT}\#${COLOR_DIVIDER}"
	# Add git branch portion of the prompt, this adds ":branchname"
	if ! git_loc="$(type -p "$git_command_name")" || [ -z "$git_loc" ]; then
		# Git is installed
		if [ -d .git ] || git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
			# Inside of a git repository
			GIT_BRANCH=$(git symbolic-ref --short HEAD)
			PS1="${PS1}:${COLOR_GITBRANCH}${GIT_BRANCH}${COLOR_DIVIDER}"
		fi
	fi
	# Add Python VirtualEnv portion of the prompt, this adds ":venvname"
	if ! test -z "$VIRTUAL_ENV" ; then
		PS1="${PS1}:${COLOR_VENV}`basename \"$VIRTUAL_ENV\"`${COLOR_DIVIDER}"
	fi
	# Close out the prompt, this adds "]\n[username@hostname] "
	PS1="${PS1}]\n${COLOR_DIVIDER}[${COLOR_USERNAME}\u${COLOR_USERHOSTAT}@${COLOR_HOSTNAME}\h${COLOR_DIVIDER}]${COLOR_NONE} "
}

# Tell Bash to run the above function for every prompt

export PROMPT_COMMAND=set_bash_prompt

[ -z "$DISPLAY" ] && startx
