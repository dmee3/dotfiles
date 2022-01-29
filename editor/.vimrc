" Grab vim-plug if needed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Use vim-plug for plugin management https://github.com/junegunn/vim-plug/
call plug#begin()

" NERDTree - File explorer
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Language support
Plug 'sheerun/vim-polyglot'

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Distraction-free writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Smooth scrolling
Plug 'psliwka/vim-smoothie'

" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'

" Multi-line comments
Plug 'tpope/vim-commentary'

" Auto-insert matching bracket pair
Plug 'jiangmiao/auto-pairs'

" Color schemes
Plug 'w0ng/vim-hybrid'
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'dylanaraps/wal.vim'
Plug 'joshdick/onedark.vim'
Plug 'sainnhe/forest-night'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'morhetz/gruvbox'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
call plug#end()

" NERDTree
" autocmd vimenter * NERDTree " Open automatically on startup
" autocmd vimenter * wincmd w " Switch from NERDTree to opened buffer on startup
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close if last tab open
map <silent> <C-n> :NERDTreeToggle<CR>

" Color scheme
syntax on
set t_Co=256
set background=dark
colorscheme gruvbox

" Override colorscheme bg color to be the terminal color
hi Normal guibg=NONE ctermbg=NONE
hi nonText guibg=NONE ctermbg=NONE

" Spell check
setlocal spell
set spelllang=en_us

" Use zsh for shell
set shell=zsh\ --login

" UI
set number relativenumber       " Line numbers
set showmatch                   " Highlight matching brackets
set mat=2                       " Tenths of a second to blink matching brackets
set splitright                  " More natural split positions
set splitbelow

" Cursor line
set cursorline

" Vertical guide line
set colorcolumn=100

" Indents
set tabstop=2                   " Use 2 spaces for indentation
set softtabstop=2
set shiftwidth=2
set expandtab
autocmd Filetype php setlocal tabstop=4 shiftwidth=4 " 4-space indentation in PHP

" Other text-related
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

" Enter Goyo with opt+z
nnoremap Ω :Goyo<CR>

" Customize Goyo
"   - 80% width
"   - Use Limelight
"   - Quit if it's the last buffer
let g:goyo_width = '80%'
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Set in case some colorschemes can't calculate dimming color
let g:limelight_conceal_ctermfg = 240

