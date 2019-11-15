# Save history to ~/.zsh_history
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

# Enable correction of tpyos
setopt CORRECT
setopt CORRECT_ALL

# Enable colors and customize ls command colors
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Make up and down arrows search command histor
bindkey $'^[[A' up-line-or-search    # up arrow
bindkey $'^[[B' down-line-or-search  # down arrow

# Enable colors and prompt substitution
setopt prompt_subst
autoload -U colors && colors

# Echoes information about Git repository status when inside a Git repository
git_info() {

  # Exit if not inside a Git repository
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  # Git branch/tag, or name-rev if on detached head
  local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

  # Dot colored green for clean, yellow for dirty
  local GIT_DOT="%{$fg[green]%}●%{$reset_color%}"
  if [[ -n $(git status -s 2> /dev/null | tail -n 1) ]]; then
    GIT_DOT="%{$fg[yellow]%}●%{$reset_color%}"
  fi

  # Build git info
  local -a GIT_INFO
  GIT_INFO+=( "$GIT_LOCATION $GIT_DOT%{$reset_color%}" )
  echo "${(j: :)GIT_INFO} "
}

# Build command line
PS1='%B%F{240}%1~%f%b $(git_info)%% '

# aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias h="history"
alias l="ls -lah"
alias chrome="open -a /Applications/Google\ Chrome.app"

# Ruby/Rails aliases
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
