lua << EOF
require('plugins')
require('settings')
require('plugin_settings')
require('mappings')
require('functions')
EOF

let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
  augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
  augroup END
endif

let g:python3_host_prog = '$HOME/.asdf/shims/python'

"  ____ ____ ____ ____ ____ ____  ____ ____ ___
" ||f |||u |||n |||c |||t |||i |||o |||n |||s ||
" ||__|||__|||__|||__|||__|||__|||__|||__|||__||
" |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler.
augroup LastKnownCursorPosition
  autocmd!
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
augroup END

" Trim trailing whitespace and extra lines
function! s:TrimTrailingWhitespace()
  let l:pos = getpos('.')
  %s/\s\+$//e
  call setpos('.', l:pos)
endfunction

augroup vimTrim
  autocmd!
  autocmd BufWritePre * call s:TrimTrailingWhitespace()
augroup END

" === vim-cool ===
let g:CoolTotalMatches = 1

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
  let top = '???' . repeat('???', width - 2) . '???'
  let mid = '???' . repeat(' ', width - 2) . '???'
  let bot = '???' . repeat('???', width - 2) . '???'
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

" === debugging ===
let g:loaded_pry = 1
let g:debug_map = {
      \ 'ruby' : 'require "pry"; binding.pry',
      \ 'javascript' : 'debugger;',
      \ 'typescript' : 'debugger;',
      \ 'javascriptreact' : 'debugger;',
      \ 'typescriptreact' : 'debugger;',
      \ 'python': 'import pdb; pdb.set_trace()'
      \}

function! InsertDebug()
  if has_key(g:debug_map, &filetype)
    let text = get(g:debug_map, &filetype)
    call feedkeys('o', 'i')
    call feedkeys(text)
    call feedkeys("\<Esc>")
  endif
endfunction
