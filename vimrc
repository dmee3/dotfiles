set nocompatible " be iMproved, required for Vundle
filetype off " required for Vundle
set rtp+=~/.vim/bundle/Vundle.vim "Set runtime path to include Vundle
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" NERDTree - File explorer
Plugin 'scrooloose/nerdtree'

" Indentation guides - toggle with \ig
Plugin 'nathanaelkane/vim-indent-guides'

" CoffeeScript support
Plugin 'kchmck/vim-coffee-script'

" Elixir support
Plugin 'elixir-lang/vim-elixir'

" YAML support
Plugin 'avakhov/vim-yaml'

" Color schemes
Plugin 'joshdick/onedark.vim'
Plugin 'tomasr/molokai'
Plugin 'chriskempson/base16-vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

call vundle#end()            " required
filetype plugin indent on    " required
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall   - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set rtp+=/usr/local/opt/fzf " Use fzf

" NERDTree
" autocmd vimenter * NERDTree " Open automatically on startup
" autocmd vimenter * wincmd w " Switch from NERDTree to opened buffer on startup
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close if last tab open
map <silent> <C-n> :NERDTreeToggle<CR>

" Colorscheme and related
colorscheme onedark
" let g:molokai_original = 1 " only used for molokai colorscheme
" let g:rehash256 = 1 " only used for molokai colorscheme
syntax on " Syntax highlighting

" Wildmenu Vim command autocompletion
set wildmenu

" Autocompletion for code
set omnifunc=syntaxcomplete#Complete

" Source ~/.bash_profile when using the :sh command
set shell=bash\ --login

" Map autocomplete to <C-z>
imap <C-z> <C-x><C-o>

" UI
set number                      " Line numbers
set ruler                       " Column number in status bar
set cursorline                  " Highlight current line
set showmatch                   " Highlight matching brackets
set mat=2                       " Tenths of a second to blink matching brackets
set splitright                  " More natural split positions
set splitbelow

" Text-related
set tabstop=2                   " Use 2 spaces for indentation
set softtabstop=2
set shiftwidth=2
set expandtab
autocmd Filetype php setlocal tabstop=4 shiftwidth=4 " 4-space indentation in PHP
set ai                          " Auto indent
set si                          " Smart indent
set wrap                        " Wrap lines
set backspace=indent,eol,start  " Allow backspace over autoindent, end of line, and start of insert action
" Set Y to yank until EOL (same behavior as D or C) instead of acting as yy
map Y y$

" Searching
set hlsearch " Highlight search results
set incsearch " Incremental search results

" Movement
" Treat long lines as breaks
map j gj
map k gk

" Relative or absolute number lines
function! NumberToggle()
  if(&rnu == 0)
    set rnu
  else
    set nornu
  endif
endfunction
command NT :call NumberToggle()

" Toggle whether vim will auto-indent pasted content
function! PasteToggle()
  if(&paste == 1)
    set nopaste
  else
    set paste
  endif
endfunc

nnoremap <c-i> :call PasteToggle()<cr>
