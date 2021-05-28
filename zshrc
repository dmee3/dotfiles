# Save history to ~/.zsh_history
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

# Automatically run the ssh agent
if ! ssh-add -L >/dev/null; then
  ssh-add -K
fi

# Enable correction of tpyos
setopt CORRECT
setopt CORRECT_ALL

# Enable colors and customize ls command colors
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Make up and down arrows search command histor
bindkey $'^[[A' up-line-or-search    # up arrow
bindkey $'^[[B' down-line-or-search  # down arrow

# aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias h="history"
alias l="ls -lah"
alias chrome="open -a /Applications/Google\ Chrome.app"

# Tool replacements
alias cat="bat"
alias vim="nvim"

# Ruby/Rails aliases
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias s="bundle exec rspec"
alias berc="bundle exec rails c"
alias bers="bundle exec rails s"

# The following lines were added by compinstall
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/Users/Dan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Auto-suggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlight command line
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ASDF config
. $(brew --prefix asdf)/asdf.sh

eval "$(starship init zsh)"

# Store custom, device-specific configuration in ~/.machine-profile
. ~/.machine_profile

# Custom functions
. ~/.zsh_scripts
