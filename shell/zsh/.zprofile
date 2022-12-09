#!/usr/bin/env zsh

# .zprofile is the user-specific initialization file for zsh, and is read
# by both login and interactive shells, unlike .zshrc.

# Brew
# Note - this path works for Monterey, not sure if it will work for older MacOS versions
eval "$(/opt/homebrew/bin/brew shellenv)"

source ~/Stuff/dotfiles/shell/common.sh
source ~/Stuff/dotfiles/shell/zsh/functions.zsh
source ~/Stuff/dotfiles/shell/zsh/prompt.zsh

autoload -Uz compinit promptinit
compinit -i
promptinit

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Auto-suggestions
source `brew --prefix`/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlight command line
source `brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Incremental search with arrows
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# ASDF config
. $(brew --prefix asdf)/libexec/asdf.sh
