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
alias chrome="open -a /Applications/Google\ Chrome.app"

# Git aliases
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcom="git checkout master"
alias gl="git pull"
alias glom="git pull origin master"
alias glgg="git log --graph"
alias gp="git push"
alias gpom="git push origin master"
alias gs="git status"
alias grhh="git reset --hard HEAD"

# Git functions
gpob() {
  cmd="git push origin "
  echo -e "\033[0;36mEXECUTING COMMAND:\033[0m $cmd$(parse_git_branch)"
  eval "$cmd$(parse_git_branch)"
}
glob() {
  cmd="git pull origin "
  echo -e "\033[0;36mEXECUTING COMMAND:\033[0m $cmd$(parse_git_branch)"
  eval "$cmd$(parse_git_branch)"
}

# Enable colors
export CLICOLOR=1

# Customize ls command colors
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Git branch in prompt
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# Change prompt
export PS1="\u:\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# Sometimes you just need to vent
fuck() {
  ruby ~/.fun/swearjar.rb fuck "$@"
}
shit() {
  ruby ~/.fun/swearjar.rb shit "$@"
}

# Load machine-specific settings last
source ~/.machine_profile
