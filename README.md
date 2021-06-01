# Dotfiles

adapted from https://github.com/adamhollett/dotfiles

## Installation

*Note: You may need to install [Homebrew](https://brew.sh/) and [Powerline Fonts](https://github.com/powerline/fonts)*

After cloning the repo, cd into it with `cd dotfiles` and run

    ./setup.sh

## Notes

## Brew Dependencies
All of these should be handled by `setup.sh`
- bat ([Cat but better](https://github.com/sharkdp/bat))
- fzf ([Fuzzy Finder](https://github.com/junegunn/fzf))
- fff ([Fucking Fast File Manager](https://github.com/dylanaraps/fff))

## Vim Plugins

Vim plugins aren't installed by default, but plugins are referenced in the vimrc file and ready to be managed by Vim-Plug.
To begin, simply open vim and run `:PluginInstall` to download and install all plugins.
