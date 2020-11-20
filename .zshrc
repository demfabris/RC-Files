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

###### Plugins
plugins=(git pipenv fzf-tab)

# Oh my zush
source $ZSH/oh-my-zsh.sh

###### User configuration
#
export LANG=pt_BR.UTF-8
export EDITOR=nvim
export BROWSER=firefox-developer-edition
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

# Git aliases
alias gl="git log --oneline --decorate --graph --all"
alias gb="git branch -av"
alias gs="git status"
alias gc="git commit --verbose -m $1"

# Navigation aliases
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'

# ls aliases
alias ll='lsd -lAhS --blocks permission,group,size,date,name  --date relative --group-dirs first'
alias l='lsd -lSh --group-dirs first'

# Dircolors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors/DIR_COLORS)" || eval "$(dircolors -b)"
fi

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# FZF
# keybindings
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# NNN Configs
[[ -a $XDG_CONFIG_HOME/nnn/config.sh ]] && source $XDG_CONFIG_HOME/nnn/config.sh

# Gruvbox colorscheme
export FZF_DEFAULT_OPTS='
  --color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
  --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
'
export FZF_CTRL_T_COMMAND='ag --hidden --ignore .git --ignore node_modules --ignore Library -g "" 2> /dev/null'

export FZF_ALT_C_COMMAND="find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' -o -name node_modules \\) -prune \
    -o -type d -print 2> /dev/null | cut -b3-"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Source goto
[[ -s "/usr/local/share/goto.sh" ]] && source /usr/local/share/goto.sh

