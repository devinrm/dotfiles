--  ____ ____ ____ ____ ____ ____  ____ ____ ___
-- ||f |||u |||n |||c |||t |||i |||o |||n |||s ||
-- ||__|||__|||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

vim.cmd([[
augroup ItalicComments
  autocmd!
  autocmd ColorScheme * highlight Comment gui=italic
  autocmd ColorScheme * highlight Comment cterm=italic
augroup END
]])

vim.cmd([[
augroup highlight_yank
  autocmd!
  au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=1000, on_visual=false}
augroup END
]])

vim.cmd([[
augroup TerminalNumbers
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END
]])

vim.cmd([[
augroup TerminalExitStatus
  autocmd!
  autocmd TermClose * call feedkeys("\<CR>")
augroup END
]])

-- === automatically rebalance windows on vim resize ===
vim.cmd([[
augroup resize
  autocmd!
  autocmd VimResized * :wincmd =
augroup END
]])

-- When editing a file, always jump to the last known cursor position.
-- Don't do it for commit messages, when the position is invalid, or when
-- inside an event handler.
vim.cmd([[
augroup LastKnownCursorPosition
  autocmd!
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
augroup END
]])

-- Trim trailing whitespace and extra lines
vim.cmd([[
function! s:TrimTrailingWhitespace()
  let l:pos = getpos('.')
  %s/\s\+$//e
  call setpos('.', l:pos)
endfunction

augroup vimTrim
  autocmd!
  autocmd BufWritePre * call s:TrimTrailingWhitespace()
augroup END
]])

-- === vim-test ===
vim.cmd([[
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
let test#ruby#rspec#executable = 'docker-compose exec app bundle exec rspec'
]])

-- === debugging ===
vim.cmd([[
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
]])
