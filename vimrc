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

" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'

" Multi-line comments
Plug 'tpope/vim-commentary'

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

" Configure CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Configure fzf.vim for NeoVim or Vim
let $FZF_DEFAULT_OPTS .= '--color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108 --color info:108,prompt:109,spinner:108,pointer:168,marker:168'
if has('nvim')
  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
  function! FloatingFZF()
    let buf = nvim_create_buf(v:false, v:true)
    call setbufvar(buf, '&signcolumn', 'no')

    let height = float2nr(&lines * 0.5)
    let width = float2nr(&columns * 0.8)
    let col = float2nr((&columns - width) / 2)
    let row = 1

    let opts = {
          \ 'relative': 'editor',
          \ 'row': row,
          \ 'col': col,
          \ 'width': width,
          \ 'height': height
          \ }

    call nvim_open_win(buf, v:true, opts)
  endfunction
else
  let g:fzf_layout = { 'down': '~40%' }
  let g:fzf_opts = '--preview-window right:70% --preview "bat --style=numbers --color=always {} || cat {}"'
endif

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

" Hide mode from bottom of screen
set noshowmode

" Default statusline color
hi StatusLine term=bold,reverse ctermfg=65 ctermbg=236 guifg=#999872 guibg=#565656
hi User1 term=bold,reverse ctermfg=236 ctermbg=101 guifg=#999872 guibg=#565656

" Status line
set laststatus=2
set statusline=
set statusline+=%{ChangeSLColor()}                  " Set current highlight color
set statusline+=\                                   " Padding
set statusline+=%{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=\                                   " Padding
set statusline+=%1*                                 " User color
set statusline+=\ %f                                " File path
set statusline+=\ %y                                " File type
set statusline+=\ %m                                " Modified flag
set statusline+=\                                   " Padding
set statusline+=%=                                  " Switch to right side
set statusline+=%*                                  " Back to StatusLine Color
set statusline+=\ %l/%L\ :\ %c                      " Line/Total : Column
set statusline+=\                                   " Padding

au InsertEnter * call ChangeSLColor()
au InsertLeave * call ChangeSLColor()

let g:currentmode={
   \ 'n'  : 'N ',
   \ 'no' : 'N·Operator Pending ',
   \ 'v'  : 'V ',
   \ 'V'  : 'V·Line ',
   \ 'x22' : 'V·Block ',
   \ 's'  : 'Select ',
   \ 'S'  : 'S·Line ',
   \ 'x19' : 'S·Block ',
   \ 'i'  : 'I ',
   \ 'R'  : 'R ',
   \ 'Rv' : 'V·Replace ',
   \ 'c'  : 'Command ',
   \ 'cv' : 'Vim Ex ',
   \ 'ce' : 'Ex ',
   \ 'r'  : 'Prompt ',
   \ 'rm' : 'More ',
   \ 'r?' : 'Confirm ',
   \ '!'  : 'Shell ',
   \ 't'  : 'Terminal '
   \}

" Change status line color by mode
function! ChangeSLColor()
  if (mode() =~# '\v(n|no)')
    hi StatusLine term=bold,reverse ctermfg=65 ctermbg=236 guifg=#999872 guibg=#565656
    hi User1 term=bold,reverse ctermfg=236 ctermbg=101 guifg=#999872 guibg=#565656
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
    hi StatusLine term=bold,reverse ctermfg=37 ctermbg=236 gui=bold guifg=#6FBCBD guibg=#3F3F3F
    hi User1 term=bold,reverse ctermfg=236 ctermbg=73 guifg=#999872 guibg=#565656
  elseif (mode() ==# 'i')
    hi StatusLine term=bold,reverse ctermfg=131 ctermbg=236 gui=bold guifg=#BE7572 guibg=#3F3F3F
    hi User1 term=bold,reverse ctermfg=236 ctermbg=95 guifg=#999872 guibg=#565656
  else
    hi StatusLine term=bold,reverse ctermfg=65 ctermbg=236 guifg=#999872 guibg=#565656
    hi User1 term=bold,reverse ctermfg=236 ctermbg=101 guifg=#999872 guibg=#565656
  endif
  return ''
endfunction

