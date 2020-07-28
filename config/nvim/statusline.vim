" set colors for statusline based on mode
" these are based on palenight.vim
function! ModeColors(mode)
  " Normal mode
  if a:mode == 'n'
    hi SLineAccent ctermfg=0 ctermbg=3
    hi SLSpecialCharAccent ctermfg=3
    hi SLineAccentInverse ctermfg=3 ctermbg=0
  " Insert mode
  elseif a:mode == 'i'
    hi SLineAccent ctermfg=0 ctermbg=5
    hi SLSpecialCharAccent ctermfg=5
    hi SLineAccentInverse ctermfg=5 ctermbg=0
  " Replace mode
  elseif a:mode == 'R'
    hi SLineAccent ctermfg=0 ctermbg=13
    hi SLSpecialCharAccent ctermfg=13
    hi SLineAccentInverse ctermfg=13 ctermbg=0
  " Visual mode
  elseif a:mode == 'v' || a:mode == 'V' || a:mode == ""
    hi SLineAccent ctermfg=0 ctermbg=2
    hi SLSpecialCharAccent ctermfg=2
    hi SLineAccentInverse ctermfg=2 ctermbg=0
  " Command mode
  elseif a:mode == 'c'
    hi SLineAccent ctermfg=0 ctermbg=4
    hi SLSpecialCharAccent ctermfg=4
    hi SLineAccentInverse ctermfg=4 ctermbg=0
  " Terminal mode
  elseif a:mode == 't'
    hi SLineAccent ctermfg=0 ctermbg=6
    hi SLSpecialCharAccent ctermfg=6
    hi SLineAccentInverse ctermfg=6 ctermbg=0
  endif

  " Entering/exiting goyo messes with this, so just set it every time we update
  hi SLineSpecialChar ctermfg=8 ctermbg=NONE
  hi SLine ctermfg=7 ctermbg=8


  " Return empty string so we don't display anything in the statusline
  return ''
endfunction

" Return a nice mode name
function! ModeName(mode)
  if a:mode == 'n'
    return 'NORMAL'
  " Insert mode
  elseif a:mode == 'i'
    return 'INSERT'
  " Replace mode
  elseif a:mode == 'R'
    return 'REPLACE'
  " Visual mode
  elseif a:mode == 'v'
    return 'VISUAL'
  elseif a:mode == 'V'
    return "V-LINE"
  elseif a:mode == ""
    return "V-BLOCK"
  " Command mode
  elseif a:mode == 'c'
    return 'COMMAND'
  " Terminal mode
  elseif a:mode == 't'
    return 'TERMINAL'
  endif
endfunction

function! Modified(modified)
  if a:modified == 1
    return '●'
  else
    return ' '
  endif
endfunction

set noshowmode
set laststatus=2
set statusline=

" Update colors for current mode
set statusline+=%{ModeColors(mode())}

" Mode
set statusline+=%#SLSpecialCharAccent#
set statusline+=%#SLineAccent#%{ModeName(mode())}
set statusline+=\ 

" Filename
set statusline+=%#SLine#\ %.20f
set statusline+=%#SLineSpecialChar#
set statusline+=\ 

" Right Side
set statusline+=%=

" Scroll info
set statusline+=%#SLineSpecialChar#
set statusline+=%#SLine#☰\ %2l\ \/\ %L
set statusline+=%#SLineSpecialChar#
set statusline+=\ 

" Modified
set statusline+=
set statusline+=%#SLineAccentInverse#%{Modified(&modified)}
set statusline+=%#SLineSpecialChar#

