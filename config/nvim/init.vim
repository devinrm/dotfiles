lua << EOF
require('plugins')
require('settings')
require('dm-autopairs')
require('dm-statusline')
require('dm-lsp-config')
require('dm-treesitter')
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

" === fzf ===
" You can pass rg arguments like so: :Rg -F components -g '*jsx'
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --smart-case --color=always '.(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" === netrw ===
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
" let g:netrw_browse_split = 4
" let g:netrw_preview = 1
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
" let g:netrw_dirhistmax = 0

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
let test#ruby#rspec#executable = 'docker compose run --rm app bundle exec rspec'

" === debugging ===
let g:loaded_pry = 1
let g:debug_map = {
      \ 'ruby' : 'require "pry"; binding.pry',
      \ 'javascript' : 'debugger;',
      \ 'typescript' : 'debugger;',
      \ 'javascriptreact' : 'debugger;',
      \ 'typescriptreact' : 'debugger;',
      \ 'python': 'import ipdb; ipdb.set_trace()'
      \}

function! InsertDebug()
  if has_key(g:debug_map, &filetype)
    let text = get(g:debug_map, &filetype)
    call feedkeys('o', 'i')
    call feedkeys(text)
    call feedkeys("\<Esc>")
  endif
endfunction
