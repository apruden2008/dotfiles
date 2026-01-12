# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Cross-platform PATH additions
export PATH="$HOME/bin:$PATH"
[[ -d "/usr/local/bin" ]] && export PATH="/usr/local/bin:$PATH"
[[ -d "/opt/homebrew/bin" ]] && export PATH="/opt/homebrew/bin:$PATH"

export EDITOR=vim
export VISUAL=vim  # Ensures Vim is used for GUI apps too

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

COMPLETION_WAITING_DOTS="true"

plugins=(
  git 
  fzf
)

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Set default FZF command to rg
export FZF_DEFAULT_COMMAND='rg'
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh

# 1. First, handle all potential console output
{
    # Load completions only if directories exist
    if [[ -d /usr/local/share/zsh/site-functions ]]; then
        FPATH="/usr/local/share/zsh/site-functions:${FPATH}"
    elif [[ -d /opt/homebrew/share/zsh/site-functions ]]; then
        FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
    fi

    # Initialize completion system
    autoload -Uz compinit
    compinit -C -d "${ZSH_COMPDUMP:-${ZDOTDIR:-$HOME}/.zcompdump}"
} &>/dev/null

# 2. Then, instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 3. Then, all environment variables and non-output commands
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/bin:$PATH"
[[ -d "/usr/local/bin" ]] && export PATH="/usr/local/bin:$PATH"
[[ -d "/opt/homebrew/bin" ]] && export PATH="/opt/homebrew/bin:$PATH"

# 4. Theme setting (before oh-my-zsh.sh)
ZSH_THEME="powerlevel10k/powerlevel10k"

# 5. Plugin declarations
plugins=(git fzf)

# 6. Source oh-my-zsh (potential source of output)
{
    source $ZSH/oh-my-zsh.sh
} &>/dev/null

# User configuration

# Manually define the path to man pages (usually not needed)
# export MANPATH="/usr/local/man:$MANPATH"

# Set terminal color
export TERM="xterm-256color"

# Language settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Custom Aliases - using command checks
alias todo="$EDITOR ~/vimwiki/Tasks.md"
alias tk="tmux kill-server"
alias config="$(which git) --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias ctags='$(brew --prefix)/bin/ctags' # replace BSD default with universal ctags

# Rust configuration
. "$HOME/.cargo/env"

# Node.js and nvm configuration
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set default Node.js version
nvm use --lts

# Micromamba configuration
export MAMBA_ROOT_PREFIX="$HOME/micromamba"
export PATH="$MAMBA_ROOT_PREFIX/bin:$PATH"
eval "$(micromamba shell hook --shell=zsh)"
micromamba activate standard

# Package manager configuration
if [[ "$(uname)" == "Darwin" ]]; then
    # macOS: Use Homebrew
    if [[ -x "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x "/usr/local/bin/brew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

# Ensure unique paths
typeset -U path fpath

# 8. Finally, source p10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$HOME/.local/bin:$PATH"
