" set colors for statusline based on mode
" these are based on palenight.vim
function! ModeColors(mode)
  " Normal mode
  if a:mode == 'n'
    hi fgc ctermfg=0 ctermbg=5
    hi powerline ctermfg=5
    hi fgc_b ctermfg=5 ctermbg=8
  " Insert mode
  elseif a:mode == 'i'
    hi fgc ctermfg=0 ctermbg=3
    hi powerline ctermfg=3
    hi fgc_b ctermfg=3 ctermbg=8
  " Replace mode
  elseif a:mode == 'R'
    hi fgc ctermfg=0 ctermbg=13
    hi powerline ctermfg=13
    hi fgc_b ctermfg=13 ctermbg=8
  " Visual mode
  elseif a:mode == 'v' || a:mode == 'V' || a:mode == ""
    hi fgc ctermfg=0 ctermbg=1
    hi powerline ctermfg=1
    hi fgc_b ctermfg=1 ctermbg=8
  " Command mode
  elseif a:mode == 'c'
    hi fgc ctermfg=0 ctermbg=4 
    hi powerline ctermfg=4 
    hi fgc_b ctermfg=4 ctermbg=8
  " Terminal mode
  elseif a:mode == 't'
    hi fgc ctermfg=0 ctermbg=6
    hi powerline ctermfg=6 
    hi fgc_b ctermfg=6 ctermbg=8
  endif

  " entering and exiting out of goyo messes with this so I just set it every time
  hi powerline_b ctermfg=8 ctermbg=NONE " termsp=NONE term=NONE cterm=NONE

  " Return empty string so as not to display anything in the statusline
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

hi modified_powerline_b ctermfg=0
hi modified_fgc ctermfg=0 ctermbg=8
function! Modified(modified)
  if a:modified == 1
    hi modified_powerline_b ctermfg=8 ctermbg=NONE
    hi modified_fgc ctermfg=1 ctermbg=8
  else
    hi modified_powerline_b ctermfg=0 ctermbg=NONE
    hi modified_fgc ctermfg=0 ctermbg=0
  endif
  return '●'
endfunction

function! BufNum()
  return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

set noshowmode
set laststatus=2
set statusline=

" Update colors when ya do
set statusline+=%{ModeColors(mode())}

" Mode
set statusline+=%#powerline#%#fgc#%{ModeName(mode())}%#powerline#
set statusline+=\ 

" Filename
set statusline+=%#powerline_b#%#fgc_b#%.20f%#powerline_b#
set statusline+=\ 

" Right Side
set statusline+=%=

" Modified 
set statusline+=%#modified_powerline_b#%#modified_fgc#%{Modified(&modified)}%#modified_powerline_b#
set statusline+=\ 

" Number of buffers
set statusline+=%#powerline#%#fgc#%{BufNum()}%#powerline#
