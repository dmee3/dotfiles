# Dotfiles

adapted from https://github.com/adamhollett/dotfiles

## Installation

*Note: You may need to install the following dependencies by hand:*
- *[Homebrew](https://brew.sh/)*

After cloning the repo, cd into it with `cd dotfiles` and run

    ./setup.sh

## Notes

## Brew Dependencies
All of these should be handled by `setup.sh`
- asdf ([ASDF](https://github.com/asdf-vm/asdf))
- bat ([Cat but better](https://github.com/sharkdp/bat))
- [Curlie](https://github.com/rs/curlie)
- fzf ([Fuzzy Finder](https://github.com/junegunn/fzf))
- fff ([Fucking Fast File Manager](https://github.com/dylanaraps/fff))
- git-delta ([Delta](https://github.com/dandavison/delta))
- Hack ([Nerd Font](https://github.com/ryanoasis/nerd-fonts#patched-fonts)) *Note: used by LSDeluxe*
- lsd ([LSDeluxe](https://github.com/Peltoche/lsd))
- neovim ([NeoVim](https://neovim.io/))
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

## Vim Plugins

Vim plugins aren't installed by default, but plugins are referenced in the vimrc file and ready to be managed by Vim-Plug.
To begin, simply open vim and run `:PluginInstall` to download and install all plugins.
