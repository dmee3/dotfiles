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
alias glom="git pull origin master"
alias glgg="git log --graph"
alias gp="git push"
alias gpom="git push origin master"
alias gs="git status"

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

# Load machine-specific settings last
source ~/.machine_profile
