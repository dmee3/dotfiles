if ! ssh-add -L >/dev/null; then
  ssh-add -K
fi

# Aliases
alias h="history"
alias ..="cd .."
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias ..4="cd ../../../../"

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gl="git log --graph"

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

# Change prompt
# default is PS1="\h:\W \u\$"
export PS1="\u:\W $ "

# Load rbenv
if which rbenv > /dev/null; then
  eval "$(rbenv init -)";
fi
