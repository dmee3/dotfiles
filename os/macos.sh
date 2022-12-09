#!/bin/false

print_header "setting up macOS"

brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

# For sketchybar
brew tap FelixKratz/formulae
brew install --cask sf-symbols

brew install asdf
brew install bat
brew install curlie
brew install fff
brew install fzf
brew install git-delta
brew install lsd
brew install neovim
brew install sketchybar
# brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

# Symlinks

## config
symlink_to_home ~/Stuff/dotfiles/.config
