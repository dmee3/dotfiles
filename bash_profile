if ! ssh-add -L >/dev/null; then
  ssh-add -K
fi

# Aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias h="history"
alias l="ls -lah"

# Git aliases
alias g="git"
alias ga="git add"
alias gc="git commit"
alias gl="git pull"
alias glgg="git log --graph"
alias gp="git push"
alias gs="git status"

# Check ~/.inputrc for incremental search commands, allowing you to type
# say, "ls", then scroll through history of all ls commands with up/down
# arrows.  Ctrl-r accomplishes similar task, but you can only scroll by
# pressing ctrl-r again.  Also, start tagging commands that may be useful
# with #<tag>, allowing you to search by that tag (works because # in
# bash is a comment indicator).

# Enable colors
export CLICOLOR=1

# Customize ls command colors
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Git branch in prompt
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Change prompt
export PS1="\u:\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# Uncomment if using rbenv to manage Ruby versions
# if which rbenv > /dev/null; then
#  eval "$(rbenv init -)";
# fi

# Agnoster theme - https://github.com/speedenator/agnoster-bash
# Uncomment to use theme, must be placed in folder shown below
# export THEME=$HOME/.bash/themes/agnoster.bash
# if [[ -f $THEME ]]; then
#   export DEFAULT_USER=`whoami`
#   source $THEME
# fi
#  Overrides for prompt
# prompt_context() {
#   prompt_segment black default "$USER"
# }
# prompt_histdt () { :; }

# Load machine-specific settings last
source ~/.machine_profile
