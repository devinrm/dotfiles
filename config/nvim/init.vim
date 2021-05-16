lua << EOF
require('plugins')
require('settings')
require('plugin_settings')
require('mappings')
EOF

let s:darwin = has('mac')
filetype plugin indent on " load indent file for language
filetype plugin on
set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
runtime! macros/matchit.vim " Extended matching with '%'. See :help matchit
if s:darwin
  set shell=/usr/local/bin/zsh
endif
set spellfile=$HOME/.vim-spell-en.utf-8.add " Name of the word list file where words are added for the |zg| and |zw| commands.
set undodir=$HOME/.undodir " directory name for undo file.

"  ____ ____ ____ ____ ____ ____  ____ ____ ___
" ||f |||u |||n |||c |||t |||i |||o |||n |||s ||
" ||__|||__|||__|||__|||__|||__|||__|||__|||__||
" |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler.
augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
augroup END

" Make comments italic
augroup ItalicComments
  autocmd!
  autocmd ColorScheme * highlight Comment gui=italic
  autocmd ColorScheme * highlight Comment cterm=italic
augroup END

" Trim trailing whitespace and extra lines
function! s:TrimTrailingWhitespace()
  let l:pos = getpos('.')
  %s/\s\+$//e
  call setpos('.', l:pos)
endfunction

function! s:TrimBlankLines()
  let l:pos = getpos('.')
  :silent! %s#\($\n\s*\)\+\%$##
  call setpos('.', l:pos)
endfunction

augroup vimTrim
  autocmd!
  autocmd BufWritePre * call s:TrimTrailingWhitespace()
  autocmd BufWritePre * call s:TrimBlankLines()
augroup END

augroup highlight_yank
  autocmd!
  au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=1000, on_visual=false}
augroup END

" === vim-cool ===
let g:CoolTotalMatches = 1

" match fzf colors to colorscheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Exception'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Statement'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" You can pass rg arguments like so: :Rg -F components -g '*jsx'
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --smart-case --color=always '.(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Pass commands to ag by using :Ag command i.e. :Ag --js components
function! s:fzf_ag_raw(cmd)
  call fzf#vim#ag_raw('--noheading '. a:cmd)
endfunction
augroup ag_commands_with_fzf
  autocmd! VimEnter * command! -nargs=* -complete=file Ag :call s:fzf_ag_raw(<q-args>)
augroup END

command! -bang -nargs=* Fg call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

function! FloatingFZF(width, height, border_highlight)
  function! s:create_float(hl, opts)
    let buf = nvim_create_buf(v:false, v:true)
    let opts = extend({'relative': 'editor', 'style': 'minimal'}, a:opts)
    let win = nvim_open_win(buf, v:true, opts)
    call setwinvar(win, '&winhighlight', 'NormalFloat:'.a:hl)
    call setwinvar(win, '&colorcolumn', '')
    return buf
  endfunction

  " Size and position
  let width = float2nr(&columns * a:width)
  let height = float2nr(&lines * a:height)
  let row = float2nr((&lines - height) / 2)
  let col = float2nr((&columns - width) / 2)

  " Border
  let top = '╭' . repeat('─', width - 2) . '╮'
  let mid = '│' . repeat(' ', width - 2) . '│'
  let bot = '╰' . repeat('─', width - 2) . '╯'
  let border = [top] + repeat([mid], height - 2) + [bot]

  " Draw frame
  let s:frame = s:create_float(a:border_highlight, {'row': row, 'col': col, 'width': width, 'height': height})
  call nvim_buf_set_lines(s:frame, 0, -1, v:true, border)

  " Draw viewport
  call s:create_float('Normal', {'row': row + 1, 'col': col + 2, 'width': width - 4, 'height': height - 2})
  autocmd BufWipeout <buffer> execute 'bwipeout' s:frame
endfunction

let g:fzf_layout = { 'window': 'call FloatingFZF(0.9, 0.6, "Comment")' }

" === vim-illuminate ===
let g:Illuminate_delay = 50
hi illuminatedWord guibg=#2c323c gui=NONE

" === netrw ===
" let loaded_netrwPlug = 1
let g:netrw_browse_split = 4
let g:netrw_preview = 1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_dirhistmax = 0

" === vim-signify ===
let g:signify_sign_show_text = 0

" === vim-test ===
function! NeoSplit(cmd) abort
  let opts = {'suffix': ' # vim-test'}
  function! opts.close_terminal()
    if bufnr(self.suffix) != -1
      execute 'bdelete!' bufnr(self.suffix)
    end
  endfunction

  call opts.close_terminal()

  split new

  call termopen(a:cmd . opts.suffix, opts)
  au BufDelete <buffer> wincmd p
  stopinsert
endfunction

let g:test#custom_strategies = {'neosplit': function('NeoSplit')}
let g:test#strategy = 'neosplit'
let g:test#runner_commands = ['Jest', 'RSpec']

"  ____ ____ ____ ____
" ||m |||a |||p |||s ||
" ||__|||__|||__|||__||
" |/__\|/__\|/__\|/__\|

" === automatically rebalance windows on vim resize ===
augroup resize
  autocmd!
  autocmd VimResized * :wincmd =
augroup END

" === debugging ===
let g:loaded_pry = 1
let g:debug_map = {
      \ 'ruby' : 'require "pry"; binding.pry',
      \ 'javascript' : 'debugger;',
      \ 'typescript' : 'debugger;',
      \ 'javascriptreact' : 'debugger;',
      \ 'typescriptreact' : 'debugger;',
      \}

function! InsertDebug()
  if has_key(g:debug_map, &filetype)
    let text = get(g:debug_map, &filetype)
    call feedkeys('o', 'i')
    call feedkeys(text)
    call feedkeys("\<Esc>")
  endif
endfunction

" === terminal mappings ===
augroup TerminalNumbers
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

augroup TerminalExitStatus
  autocmd!
  autocmd TermClose * call feedkeys("\<CR>")
augroup END
