if ! ssh-add -L >/dev/null; then
  ssh-add -K
fi

source ~/.bash_scripts/aliases
source ~/.bash_scripts/functions
source ~/.bash_scripts/git_functions

# Enable colors and customize ls command colors
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Format prompt with directory and git info (if possible)
set_bash_prompt() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    branch_name=" $(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/') "
  else
    branch_name=" "
  fi

  if [[ -n $(git status -s 2> /dev/null | tail -n 1) ]]; then
    branch_color="\[\e[1;33m\]" # Yellow
  else
    branch_color="\[\e[1;32m\]" # Green
  fi

  PS1="\W${branch_color}${branch_name}\[\e[0m\]$ "
}
PROMPT_COMMAND=set_bash_prompt

# Load machine-specific settings last
source ~/.machine_profile

