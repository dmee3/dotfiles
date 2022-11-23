"
" ---- Basic Settings ---------------------------------------------------------
"
syntax enable                            " syntax highlighting
filetype plugin indent on                " set filetype and load plugins/indentation
set updatetime=30                        " time before updates
set number relativenumber                " relative line numbers
set showmatch                            " highlight matching brackets
set mat=2                                " tenths of a second to blink matching brackets
set splitright splitbelow                " more natural split positions
setlocal spell                           " spellcheck
set spelllang=en_us                      " spellcheck in English
set cursorline                           " highlight current line
set colorcolumn=100                      " vertical guideline at column 100
set signcolumn=yes numberwidth=6         " signcolumn and available width
set tabstop=2 softtabstop=2              " use 2 spaces for indentation
set expandtab shiftwidth=2
set ai                                   " auto indent
set si                                   " smart indent
set wrap                                 " wrap lines
set backspace=indent,eol,start           " allow backspace over autoindent, EOL, & start of insert
set showcmd                              " keystrokes in command line
set wildmenu wildmode=longest:full,full  " command autocomplete
set hlsearch                             " highlight search results
set incsearch                            " incremental search results
if has("nvim")
  set termguicolors                      " better colors
endif


"
" ---- Plugins ----------------------------------------------------------------
"
" Grab vim-plug if needed https://github.com/junegunn/vim-plug/
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
  " NERDTree
  Plug 'scrooloose/nerdtree'      " file explorer window
  Plug 'ryanoasis/vim-devicons'   " fancy icons

  " Status bar
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Intellisense
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Distraction-free writing
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'

  " Git
  Plug 'tpope/vim-fugitive'       " git inside vim
  Plug 'airblade/vim-gitgutter'   " show changes in signcolumn

  " Tags
  Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }

  " fuzzy finders {
  if has("nvim")
    Plug 'nvim-lua/plenary.nvim'                " dependency for treesittetelescope
    Plug 'nvim-telescope/telescope.nvim'        " search files within vim
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  endif
  Plug 'ctrlpvim/ctrlp.vim'

  " Quality of Life
  Plug 'tpope/vim-commentary'     " better comment support
  Plug 'jiangmiao/auto-pairs'     " auto-insert matching bracket pair
  Plug 'psliwka/vim-smoothie'     " smoother scrolling

  " Visuals
  Plug 'sheerun/vim-polyglot'     " syntax highlighting
  Plug 'w0ng/vim-hybrid'          " color scheme
  Plug 'junegunn/seoul256.vim'
  Plug 'morhetz/gruvbox'
  Plug 'joshdick/onedark.vim'
  Plug 'sainnhe/forest-night'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
call plug#end()


"
" ---- Plugin Settings -------------------------------------------------------
"
"  airline {
  " stops other insert modes from showing
  let g:airline_mode_map = {}
  let g:airline_mode_map['ic'] = 'INSERT'
  " display all buffers if one tab open
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_min_count =2 " auto hide tab bar when only 1 buffer open
  let g:airline#extensions#tabline#tab_nr_type = 1  " buffer/tab number
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  " how file paths are shown (they're not)
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline_powerline_fonts = 1             " powerline integration
  let g:airline_theme='bubblegum'               " status bar theme
  let g:airline#extensions#tagbar#enabled = 1   " show where in file you are
  let g:airline#extensions#tagbar#flags = 'f'
  let g:airline#extensions#coc#enabled = 1
  let g:airline_detect_modified = 0             " stop color change of filepath
  let g:airline_detect_spell=0                  " hide spelling/language
  let g:airline_skip_empty_sections = 1         " remove separators for empty sections

  " config for specific sections
  let g:airline_section_c = airline#section#create(["%{expand('%:p:~:h:h:t')}/%{expand('%:p:h:t')}/%{expand('%:t')}"])
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif 
  let g:airline_symbols.modified = ''
  let g:airline_section_y=''                    " remove the encoding section
" }

" NERDTree {
  " autocmd vimenter * NERDTree " Open automatically on startup
  " autocmd vimenter * wincmd w " Switch from NERDTree to opened buffer on startup
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close if last tab open
  map <silent> <C-n> :NERDTreeToggle<CR>
" }

" CtrlP {
  " ignore files in git and gitignore
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'
" }

" Goyo/Limelight {
  autocmd! User GoyoEnter call <SID>goyo_enter()
  autocmd! User GoyoLeave call <SID>goyo_leave()
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!

  " Set in case some colorschemes can't calculate dimming color
  let g:limelight_conceal_ctermfg = 240

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
" }


"
" ---- Keybindings -----------------------------------------------------------
"
" Set Y to yank until EOL (same behavior as D or C) instead of acting as yy
map Y y$


" Treat long lines as breaks
map j gj
map k gk


"
" ---- Extra Settings --------------------------------------------------------
"

" change cursor shape
let &t_SI = "\<Esc>[6 q"               " insert mode, vertical bar
let &t_SR = "\<Esc>[4 q"               " replace mode, underscore
let &t_EI = "\<Esc>[2 q"               " normal mode, block

" Color scheme
set t_Co=256
set background=dark
colorscheme gruvbox

" Override colorscheme bg color to be the terminal color
hi Normal guibg=NONE ctermbg=NONE
hi nonText guibg=NONE ctermbg=NONE

" Language-specific settings
autocmd Filetype php setlocal tabstop=4 shiftwidth=4 " 4-space indentation in PHP


"
" ---- Mappings --------------------------------------------------------------
"

" autocomplete pop-up menu more natural {
  inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
  inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
  inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
  inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
  inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
  inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
" }

" telescope {
  nnoremap ff :Telescope find_files<cr>
  nnoremap fg :Telescope live_grep<cr>
  nnoremap fb :Telescope buffers<cr>
  nnoremap fh :Telescope help_tags<cr>
" }

" gitgutter {
  nnoremap diff :GitGutterDiffOrig<cr>
  " cycle continuously through single files
  nnoremap <silent> <Leader>nh :call GitGutterNextHunkCycle()<CR>
  nnoremap <silent> <Leader>ph :call GitGutterPrevHunkCycle()<CR>
  " cycle through multiple files
  nnoremap <silent> ]c :call NextHunkAllBuffers()<CR>
  nnoremap <silent> [c :call PrevHunkAllBuffers()<CR>
" }

" Goyo - enter with opt+z or gy {
  nnoremap Ω :Goyo<CR>
  nnoremap <silent> gy :Goyo<CR>
  nnoremap <silent> gy! :Goyo!<CR>
" }

" Tagbar {
  nnoremap <Leader>tt :TagbarToggle<CR>
" }


"
"
" ---- Functions -------------------------------------------------------------
"

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

" cycle between hunks
function! GitGutterNextHunkCycle()
  let line = line('.')
  silent! GitGutterNextHunk
  if line('.') == line
    1
    GitGutterNextHunk
  endif
endfunction

function! GitGutterPrevHunkCycle()
  let line = line('.')
  silent! GitGutterPrevHunk
  if line('.') == line
    normal! G
    GitGutterPrevHunk
  endif
endfunction

function! NextHunkAllBuffers()
  let line = line('.')
  GitGutterNextHunk
  if line('.') != line
    return
  endif
  let bufnr = bufnr('')
  while 1
    bnext
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      1
      GitGutterNextHunk
      return
    endif
  endwhile
endfunction

function! PrevHunkAllBuffers()
  let line = line('.')
  GitGutterPrevHunk
  if line('.') != line
    return
  endif
  let bufnr = bufnr('')
  while 1
    bprevious
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      normal! G
      GitGutterPrevHunk
      return
    endif
  endwhile
endfunction

