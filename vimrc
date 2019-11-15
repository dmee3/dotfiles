" Grab vim-plug if needed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Use vim-plug for plugin management https://github.com/junegunn/vim-plug/
call plug#begin('~/.vim/plugged')

" NERDTree - File explorer
Plug 'scrooloose/nerdtree'

" YAML support
Plug 'avakhov/vim-yaml'

" Distraction-free writing
Plug 'junegunn/goyo.vim'

" Color schemes
Plug 'w0ng/vim-hybrid'
Plug 'junegunn/seoul256.vim'
Plug 'dylanaraps/wal.vim'
Plug 'joshdick/onedark.vim'
Plug 'sainnhe/vim-color-forest-night'
Plug 'sainnhe/vim-color-vanilla-cake'
Plug 'sainnhe/vim-color-desert-night'
call plug#end()

" NERDTree
" autocmd vimenter * NERDTree " Open automatically on startup
" autocmd vimenter * wincmd w " Switch from NERDTree to opened buffer on startup
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close if last tab open
map <silent> <C-n> :NERDTreeToggle<CR>

" Color scheme
" Hybrid is my default go-to, trying out seoul
set background=dark
" colo hybrid
colo seoul256

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
set showmatch                   " Highlight matching brackets
set mat=2                       " Tenths of a second to blink matching brackets
set splitright                  " More natural split positions
set splitbelow

" Cursor line
set cursorline
"hi CursorLine ctermbg=15
"hi CursorLineNr ctermbg=7 ctermfg=0

" Status line
set laststatus=2
set statusline=\                   " Padding
"set statusline+=%{ChangeSLColor()} " Color
set statusline+=\ %f               " File
set statusline+=\ %y               " File type
set statusline+=\ %m               " Modified flag
set statusline+=\                  " Padding
"set statusline+=%#CursorColumn#    " Color
set statusline+=%=                 " Switch to right side
set statusline+=\ %p%%             " Percent of file
set statusline+=\ %l:%c            " Line : Column
set statusline+=\                  " Padding

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
    exe 'hi! StatusLine term=bold,reverse cterm=bold,reverse ctermfg=95 ctermbg=187'
  elseif (mode() =~# '\v(v|V)')
    exe 'hi! StatusLine ctermfg=23 ctermbg=187'
  elseif (mode() ==# 'i')
    exe 'hi! StatusLine term=bold ctermfg=131 ctermbg=236'
  else
    exe 'hi! StatusLine term=bold,reverse cterm=bold,reverse ctermfg=95 ctermbg=187'
  endif

  return ''
endfunction

