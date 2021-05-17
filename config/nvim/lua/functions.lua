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
