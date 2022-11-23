#!/bin/false

# Symlinks
print_header "creating symlinks"

## git
symlink_to_home ~/Stuff/dotfiles/git/.gitconfig
symlink_to_home ~/Stuff/dotfiles/git/.gitignore_global

## shell
symlink_to_home ~/Stuff/dotfiles/shell/.inputrc
symlink_to_home ~/Stuff/dotfiles/shell/.hushlogin

### zsh
symlink_to_home ~/Stuff/dotfiles/shell/zsh/.zprofile
symlink_to_home ~/Stuff/dotfiles/shell/zsh/.zshrc

## editors
symlink_to_home ~/Stuff/dotfiles/editor/.vimrc
