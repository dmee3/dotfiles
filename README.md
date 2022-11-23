# Dotfiles

adapted from https://github.com/adamhollett/dotfiles

## Installation

After cloning the repo, cd into it with `cd dotfiles` and run

    ./setup.sh

## Notes

## Brew Dependencies
All of these should be handled by `setup.sh`
- [asdf](https://github.com/asdf-vm/asdf)
- bat ([cat but better](https://github.com/sharkdp/bat))
- [brew](https://brew.sh/))
- [curlie](https://github.com/rs/curlie)
- fzf ([Fuzzy Finder](https://github.com/junegunn/fzf))
- fff ([Fucking Fast File Manager](https://github.com/dylanaraps/fff))
- git-delta ([Delta](https://github.com/dandavison/delta))
- hack ([Nerd Font](https://github.com/ryanoasis/nerd-fonts#patched-fonts)) *Note: used by LSDeluxe*
- lsd ([LSDeluxe](https://github.com/Peltoche/lsd))
- [neovim](https://neovim.io/)
- [sketchybar](https://felixkratz.github.io/SketchyBar)
- [universal-ctags](https://github.com/universal-ctags/ctags)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

## Vim Plugins

Vim plugins aren't installed by default, but plugins are referenced in the vimrc file and ready to be managed by Vim-Plug.
To begin, simply open vim and run `:PluginInstall` to download and install all plugins.

## SketchyBar
SketchyBar depends on the Hack Nerd Font by default. It should automatically run at startup. If not, run

```
brew services start sketchybar
```

You will also need to hide the default macOS menu bar in *System Preferences -> Dock & Menu Bar*

