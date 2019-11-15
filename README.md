# dotfiles
Collection of files containing settings for various programs

## Installation

*Note: You may need to install [Homebrew](https://brew.sh/) and [Powerline Fonts](https://github.com/powerline/fonts)*

After cloning the repo, cd into it with `cd dotfiles` and run

    ruby initialize.rb

This should take care of everything for you.  It's jank as hell so results may vary.  Good luck!

## Notes

- Custom, machine-specific settings can be stored in `~/.machine_profile` and will be auto-loaded by `~/.bash_profile`.

## Brew Dependencies
All of these should be handled by `initialize.rb`
- bat ([Cat but better](https://github.com/sharkdp/bat))
- fzf ([Fuzzy Finder](https://github.com/junegunn/fzf))
- fff ([Fucking Fast File Manager](https://github.com/dylanaraps/fff))
- ~chunkwm ([Window manager](https://github.com/koekeishiya/chunkwm))~
- ~skhd ([Shortcuts for chunkwm](https://github.com/koekeishiya/skhd))~

## Vim Plugins

Vim plugins aren't installed by default, but plugins are referenced in the vimrc file and ready to be managed by Vim-Plug.
To begin, simply open vim and run `:PluginInstall` to download and install all plugins.

