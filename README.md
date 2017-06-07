# dotfiles
Collection of files containing settings for various programs

## Installation

After cloning the repo, cd into it with `cd dotfiles` and run

    bundle install

Then, clone included files to the home directory

**WARNING: THIS WILL OVERWRITE CURRENT FILES**

    bundle exec curate -v

Custom, machine-specific settings can be stored in `~/.machine_profile` and will be auto-loaded by `~/.bash_profile`.


## Vim Plugins

Vim plugins aren't installed by default, but plugins are referenced in the vimrc file and ready to be managed by Vundle.
To begin, run

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Once the Vundle repo is cloned, open Vim and run `:PluginInstall` to download and install all plugins.
`:PluginUpdate` may need to be run as well.
