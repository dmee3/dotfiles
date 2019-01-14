if ! ssh-add -L >/dev/null; then
  ssh-add -K
fi

source ~/.bash_scripts/aliases
source ~/.bash_scripts/functions
source ~/.bash_scripts/git_functions

# Format prompt
export PS1="\u:\W\[\033[32m\] \$(parse_git_branch)\[\033[00m\] $ "

# Enable colors and customize ls command colors
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Set up custom agnoster command prompt with arrows
export THEME=$HOME/.bash/themes/agnoster.bash
if [[ -f $THEME ]]; then
  export DEFAULT_USER=`whoami`
  source $THEME
fi

# Override some of the agnoster defaults
prompt_context() {
  prompt_segment black default "$USER"
}
prompt_histdt() { :; }

# Load machine-specific settings last
source ~/.machine_profile
