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

# fzf key bindings and fuzzy completion.
# `fzf --zsh` needs fzf >= 0.48 (Homebrew is current); Debian bookworm ships
# 0.38 and installs the shell files under /usr/share/doc/fzf/examples instead.
if command -v fzf >/dev/null 2>&1; then
  if fzf --zsh >/dev/null 2>&1; then
    source <(fzf --zsh)
  else
    for _fzf_dir in /usr/share/doc/fzf/examples /usr/share/fzf; do
      [[ -f "$_fzf_dir/key-bindings.zsh" ]] && source "$_fzf_dir/key-bindings.zsh"
      [[ -f "$_fzf_dir/completion.zsh" ]]   && source "$_fzf_dir/completion.zsh"
    done
    unset _fzf_dir
  fi
fi

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

# Toolchains.
#
# Each block is guarded so this file works on a machine where the toolchain is
# not installed yet. Without the guards, every shell opened before
# bootstrap.sh's `langs` step finishes prints errors, and anything that sources
# this file under `set -e` aborts outright.

# Rust
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# Node.js and nvm
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
  # --silent: this runs on every shell and is otherwise chatty.
  nvm use --lts --silent
fi

# Micromamba
export MAMBA_ROOT_PREFIX="$HOME/micromamba"
export PATH="$MAMBA_ROOT_PREFIX/bin:$PATH"
if command -v micromamba >/dev/null 2>&1; then
  eval "$(micromamba shell hook --shell=zsh)"
  micromamba activate standard 2>/dev/null
fi

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

# Ensure rustup's toolchain shims take precedence over Homebrew's rust
export PATH="$HOME/.cargo/bin:$PATH"
