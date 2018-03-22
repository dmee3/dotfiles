if ! ssh-add -L >/dev/null; then
  ssh-add -K
fi

source ~/.bashrc_files/aliases
source ~/.bashrc_files/functions
source ~/.bashrc_files/git_functions

# Format prompt
export PS1="\u:\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# Enable colors and customize ls command colors
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Load machine-specific settings last
source ~/.machine_profile
