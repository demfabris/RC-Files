# Auto start tmux only on the first terminal window. If in tty do nothing
# Must run before p10k
case "$(ps a)" in
    *tmux*) true ;;
    *)  [ "$DISPLAY" ] && tmux new-session ;;
esac

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Extra path
export PATH=$PATH:~/.local/bin

# Truecolor
export COLORTERM=truecolor

# Path to your oh-my-zsh installation.
export ZSH="/home/fabricio7p/.config/oh-my-zsh"

# Current theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty. 
DISABLE_UNTRACKED_FILES_DIRTY="true"

# DOTNET DEV
export ASPNETCORE_ENVIRONMENT=development

###### Plugins
plugins=(git pipenv)

# Oh my zush
source $ZSH/oh-my-zsh.sh

###### User configuration
#
export LANG=pt_BR.UTF-8
export EDITOR=nvim
export BROWSER=google-chrome-stable
alias vim="nvim"

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d '~/.config/zsh/zcompdump'
_comp_options+=(globdots)

# Instant complete menu
setopt menu_complete

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.config/zsh/histfile

# Cool aliases
alias autoremove="sudo pacman -Rsn $(pacman -Qdtq)";
alias trab="cd ~/Documents/Projects/Development ; ll";
alias tst="cd ~/Documents/Projects/Testing ; ll"; 

# Show all available colors
function term256colors () {
  for i in {0..255}
    do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
  done
} 

# Git aliases
alias gl="git log --oneline --decorate --graph --all"
alias gb="git branch -av"
alias gs="git status"
alias gc="git commit --verbose -m $1"

export myrepo="https://github.com/fabricio7p/"

function fetch_repo () {
    [ -z $1 ] && echo "Usage: fetch_repo <repository_name>" && return
    echo $(git clone $myrepo$1.git $inplace)
}

# Navigation aliases
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'

# Some more ls aliases
alias ll='lsd -lAhS --blocks permission,group,size,date,name  --date relative --group-dirs first'
alias l='lsd -lSh --group-dirs first'

# Dircolors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors/DIR_COLORS)" || eval "$(dircolors -b)"
fi


# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# 2>/dev/null

# fzf key bindings
source /usr/share/fzf/key-bindings.zsh
# export FZF_DEFAULT_COMMAND=ag
source /usr/share/fzf/completion.zsh



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
