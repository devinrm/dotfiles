--  ____ ____ ____ ____ ____ ____   ____ ____ ____ ____ ____ ____ ____ ____
-- ||p |||l |||u |||g |||i |||n || ||s |||e |||t |||t |||i |||n |||g |||s ||
-- ||__|||__|||__|||__|||__|||__|| ||__|||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\| |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

-- === autopairs ===
require('dm-autopairs')

-- === galaxyline ===
require('dm-statusline')

-- === nvim-lsp ===
require('dm-lsp-config')

vim.api.nvim_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>ge', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>gh', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})

-- === nvim-colorizer ===
require 'colorizer'.setup()

-- === nvim-compe ===
require('dm-nvim-compe')

vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', {expr = true, noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<CR>', "compe#confirm('<CR>')", {expr = true, noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-e>', "compe#close('<C-e>')", {expr = true, noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-f>', "compe#scroll({ 'delta': +4 })", {expr = true, noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-d>', "compe#scroll({ 'delta': -4 })", {expr = true, noremap = true, silent = true})

-- === kommentary ===
vim.g.kommentary_create_default_mappings = false
vim.api.nvim_set_keymap('n', '<C-\\>', '<Plug>kommentary_line_default', {})
vim.api.nvim_set_keymap('x', '<C-\\>', '<Plug>kommentary_visual_default', {})

-- === lspsaga ===
local saga = require 'lspsaga'
saga.init_lsp_saga()

vim.api.nvim_set_keymap('n', 'gh', '<cmd> lua require("lspsaga.provider").lsp_finder()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gs', '<cmd> lua require("lspsaga.signaturehelp").signature_help()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'rg', '<cmd> lua require("lspsaga.rename").rename()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gd', '<cmd> lua require("lspsaga.provider").preview_definition()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>cd', '<cmd> lua require("lspsaga.diagnostic").show_line_diagnostics()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>ca', '<cmd> lua require("lspsaga.codeaction").code_action()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<Leader>ca', '<cmd> lua require("lspsaga.codeaction").range_code_action()<CR>', {noremap = true, silent = true})

-- === devdocs ===
vim.api.nvim_set_keymap('n', 'K', '<Plug>(devdocs-under-cursor)', {silent = true})

-- === diffview ===
require('dm-diffview')

-- === fzf.vim ===
vim.api.nvim_set_keymap('n', '<C-b>', ':wa<CR>:Buffers<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '\\', ":Rg<SPACE>-F '' -g '*.'", {noremap = true})
-- grep the word under the cursor
vim.api.nvim_set_keymap('n', 'gr', ':Rg <C-R><C-W><CR>', {noremap = true})
-- Press ; and then start typing to fzf search the whole project for a word or string
vim.api.nvim_set_keymap('n', '<Leader>;', ':Fg<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>hi', ':wa<CR>:History<CR>', {noremap = true})

-- === telescope ===
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<CR>', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<C-b>', '<cmd>lua require("telescope.builtin").buffers()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<cmd>lua require("telescope.builtin").registers()<CR>', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<Leader>hi', '<cmd>lua require("telescope.builtin").oldfiles()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>p', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>gc', '<cmd>lua require("telescope.builtin").git_commits()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>bgc', '<cmd>lua require("telescope.builtin").git_bcommits()<CR>', {noremap = true})

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
