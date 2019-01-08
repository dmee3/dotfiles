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
Plugin 'w0ng/vim-hybrid'
Plugin 'dylanaraps/wal.vim'

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

" NERDTree
" autocmd vimenter * NERDTree " Open automatically on startup
" autocmd vimenter * wincmd w " Switch from NERDTree to opened buffer on startup
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close if last tab open
map <silent> <C-n> :NERDTreeToggle<CR>

" Color scheme
" Hybrid is default, trying wal for custom colorscheme based on wallpaper
set background=dark
" colorscheme hybrid
colorscheme wal

" Wildmenu Vim command autocompletion
set wildmenu

" Autocompletion for code
set omnifunc=syntaxcomplete#Complete

" Source ~/.bash_profile when using the :sh command
set shell=bash\ --login

" Map autocomplete to <C-z>
imap <C-z> <C-x><C-o>

" UI
syntax on
set number                      " Line numbers
set ruler                       " Column number in status bar
set showmatch                   " Highlight matching brackets
set mat=2                       " Tenths of a second to blink matching brackets
set splitright                  " More natural split positions
set splitbelow

" Cursor line
set cursorline
hi CursorLine ctermbg=7 ctermfg=0
hi CursorLineNr ctermbg=7 ctermfg=0

" Status line
set laststatus=2
hi StatusLine ctermfg=black ctermbg=darkblue cterm=none
hi StatusLineNC ctermfg=black ctermbg=darkblue cterm=none
hi User1 ctermfg=darkblue ctermbg=darkgreen
hi User2 ctermfg=black ctermbg=darkgreen
hi User3 ctermfg=darkgreen ctermbg=none
hi User4 ctermfg=white ctermbg=none
hi User5 ctermfg=yellow ctermbg=none
hi User6 ctermfg=black ctermbg=yellow
hi User7 ctermfg=cyan ctermbg=yellow
hi User8 ctermfg=black ctermbg=cyan
set statusline=\                    " Padding
set statusline+=%{ChangeSLColor()}  " Change color by mode
set statusline+=%f                  " Path to the file
set statusline+=\ %1*\ %2*         " Blue-green transition
set statusline+=%y                  " File type
set statusline+=\ %3*\ %4*         " Green-none transition
set statusline+=%m                  " Modified flag
set statusline+=%=                  " Switch to right-side
set statusline+=\ %5*%6*\          " None-yellow transition
set statusline+=%c                  " Current column
set statusline+=\ %7*%8*\          " Yellow-cyan transition
set statusline+=%l\ /\ %L           " Current line / total lines
set statusline+=\                   " Padding

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

" Use fzf and add quick command
let g:fzf_opts = '--preview-window right:70% --preview "highlight -O ansi -l --failsafe {}"'
set rtp+=/usr/local/opt/fzf
command! -bang ZV call fzf#run(fzf#wrap({'sink': 'vs', 'options': fzf_opts}, <bang>0))
command! -bang ZS call fzf#run(fzf#wrap({'sink': 'sp', 'options': fzf_opts}, <bang>0))
command! -bang ZE call fzf#run(fzf#wrap({'sink': 'e', 'options': fzf_opts}, <bang>0))

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
endfunction
nnoremap <c-i> :call PasteToggle()<cr>

" Change status line color by mode
function! ChangeSLColor()
	if (mode() =~# '\v(n|no)')
    exe 'hi! StatusLine ctermfg=black ctermbg=darkblue'
    exe 'hi! User1 ctermfg=darkblue ctermbg=darkgreen'
  elseif (mode() =~# '\v(v|V)')
    exe 'hi! StatusLine ctermfg=black ctermbg=darkyellow'
    exe 'hi! User1 ctermfg=darkyellow ctermbg=darkgreen'
  elseif (mode() ==# 'i')
    exe 'hi! StatusLine ctermfg=black ctermbg=darkred'
    exe 'hi! User1 ctermfg=darkred ctermbg=darkgreen'
  else
    exe 'hi! StatusLine ctermfg=black ctermbg=darkblue'
    exe 'hi! User1 ctermfg=darkblue ctermbg=darkgreen'
  endif

  return ''
endfunction

