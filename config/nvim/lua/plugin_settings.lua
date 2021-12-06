--  ____ ____ ____ ____ ____ ____   ____ ____ ____ ____ ____ ____ ____ ____
-- ||p |||l |||u |||g |||i |||n || ||s |||e |||t |||t |||i |||n |||g |||s ||
-- ||__|||__|||__|||__|||__|||__|| ||__|||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\| |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

-- === autopairs ===
require('dm-autopairs')

-- === statusline ===
require('dm-statusline')

-- === nvim-lsp ===
require('dm-lsp-config')

vim.api.nvim_command[[autocmd BufWritePre *.py lua vim.lsp.buf.formatting_seq_sync()]]
vim.api.nvim_command[[autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_seq_sync()]]
vim.api.nvim_command[[autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_seq_sync()]]
vim.api.nvim_command[[autocmd BufWritePre *.rb lua vim.lsp.buf.formatting_seq_sync()]]
vim.api.nvim_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'ge', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})

-- === nvim-colorizer ===
require 'colorizer'.setup()

-- === vim-commentary ===
vim.api.nvim_set_keymap('n', '<C-\\>', 'gcc', {})
vim.api.nvim_set_keymap('x', '<C-\\>', 'gc', {})

-- === devdocs ===
vim.api.nvim_set_keymap('n', 'K', '<Plug>(devdocs-under-cursor)', {silent = true})

-- === fzf.vim ===
vim.api.nvim_set_keymap('n', '<C-b>', ':wa<CR>:Buffers<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-p>', ':wa<CR>:Files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>p', ':wa<CR>:BLines<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>gc', ':wa<CR>:Commits<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>bgc', ':wa<CR>:BCommits<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '\\', ":Rg<SPACE>-F '' -g '*.'", {noremap = true})
-- grep the word under the cursor
vim.api.nvim_set_keymap('n', 'gr', ':Rg <C-R><C-W><CR>', {noremap = true})
-- Press ; and then start typing to fzf search the whole project for a word or string
vim.api.nvim_set_keymap('n', '<Leader>;', ':Fg<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>hi', ':wa<CR>:History<CR>', {noremap = true})

-- === vim-test ===
vim.api.nvim_set_keymap('n', '<Leader>t', ':wa<CR>:TestFile<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>s', ':wa<CR>:TestNearest<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>l', ':wa<CR>:TestLast<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>a', ':wa<CR>:TestSuite<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>gt', ':wa<CR>:TestVisit<CR>', {noremap = true, silent = true})

-- === nvim-treesitter
require('dm-treesitter')

-- === trouble ===
require('trouble').setup {}
vim.api.nvim_set_keymap('n', '<Leader>xx', '<cmd>LspTroubleToggle lsp_document_diagnostics<CR>', {noremap = true})

-- === nvim-dd ===
require('dd').setup()

vim.api.nvim_command [[ hi def link LspReferenceText CursorLine ]]
vim.api.nvim_command [[ hi def link LspReferenceWrite CursorLine ]]
vim.api.nvim_command [[ hi def link LspReferenceRead CursorLine ]]
