#!/bin/false

print_header "setting up macOS"

brew install asdf
brew install bat
brew install curlie
brew install fff
brew install fzf
brew install git-delta
brew install lsd
brew install neovim
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

# Symlinks

## config
symlink_to_home ~/Stuff/dotfiles/.config
