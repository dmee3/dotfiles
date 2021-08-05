#!/bin/false

print_header "setting up macOS"

brew install bat
brew install fff
brew install fzf
brew install git-delta
brew install lsd
brew install neovim

# Symlinks

## config
symlink_to_home ~/Stuff/dotfiles/.config
