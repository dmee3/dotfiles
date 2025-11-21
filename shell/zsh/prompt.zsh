#!/bin/false

setopt prompt_subst

export PS1='$(prompt_line)$(fancy_dir) $(git_dot)$(chevrons) '
export RPROMPT='$(git_branch)'
