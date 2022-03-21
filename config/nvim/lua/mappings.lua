--  ____ ____ ____ ____
-- ||m |||a |||p |||s ||
-- ||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|

-- === zoom a vim pane, <C-w>= to re-balance ===
vim.api.nvim_set_keymap('n', '<Leader>-', ':wincmd _<CR>:wincmd |<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>=', ':wincmd =<CR>', {noremap = true})

-- === terminal mappings ===
vim.api.nvim_set_keymap('t', '<C-w>h', '<C-\\><C-n><C-w>h', {noremap = true})
vim.api.nvim_set_keymap('t', '<C-w>j', '<C-\\><C-n><C-w>j', {noremap = true})
vim.api.nvim_set_keymap('t', '<C-w>k', '<C-\\><C-n><C-w>k', {noremap = true})
vim.api.nvim_set_keymap('t', '<C-w>l', '<C-\\><C-n><C-w>l', {noremap = true})
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true})
vim.api.nvim_set_keymap('t', '<A-[>', '<Esc><Esc>', {noremap = true})
vim.api.nvim_set_keymap('t', '<C-w>-', '<C-\\><C-n>:sp<CR>:terminal<CR>i', {noremap = true})
vim.api.nvim_set_keymap('t', '<C-w>\\', '<C-\\><C-n>:vsp<CR>:terminal<CR>i', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-w>-', ':20sp<CR>:terminal<CR>i', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-w>\\', ':vsp<CR>:terminal<CR>i', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-w>c', ':tabnew<CR>:terminal<CR>i', {noremap = true})

-- === Move up and down by visible lines if current line is wrapped ===
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})

-- === add current word under cursor to :%s ===
vim.api.nvim_set_keymap('n', '<Leader>n', ':%s/\\(<c-r>=expand("<cword>")<CR>\\)/', {noremap = true})

-- === Pre-populate a split command with the current directory ===
vim.api.nvim_set_keymap('n', '<Leader>e', ':vsp <C-r>=expand("%:p:h") . "/" <CR><C-d>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>mv', ':!mv % <C-r>=expand("%:p:h") . "/" <CR><C-d>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>cp', ':!cp % <C-r>=expand("%:p:h") . "/" <CR><C-d>', {noremap = true})

-- === Open dotfiles in new tab ===
vim.api.nvim_set_keymap('n', '<Leader>vi', ':NnnExplorer $HOME/dotfiles/<CR>', {noremap = true})

-- === debugging ===
vim.api.nvim_set_keymap('n', '<Leader>d', ':call InsertDebug()<CR>', {noremap = true})

-- === registers ===
vim.api.nvim_set_keymap('n', "'", ':registers<CR>', {noremap = true})

-- === ripgrep ===
vim.api.nvim_set_keymap('n', '\\', ":Rg<SPACE>-F '' -g '*.'", {noremap = true})

--  ____ ____ ____ ____ ____ ____   ____ ____ ____ ____
-- ||p |||l |||u |||g |||i |||n || ||m |||a |||p |||s ||
-- ||__|||__|||__|||__|||__|||__|| ||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\| |/__\|/__\|/__\|/__\|

-- === nvim-lsp ===
vim.api.nvim_command[[autocmd BufWritePre *.py lua vim.lsp.buf.formatting_seq_sync()]]
vim.api.nvim_command[[autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_seq_sync()]]
vim.api.nvim_command[[autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_seq_sync()]]
vim.api.nvim_command[[autocmd BufWritePre *.rb lua vim.lsp.buf.formatting_seq_sync()]]
vim.api.nvim_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'ge', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})

-- === vim-commentary ===
vim.api.nvim_set_keymap('n', '<C-\\>', 'gcc', {})
vim.api.nvim_set_keymap('x', '<C-\\>', 'gc', {})

-- === devdocs ===
vim.api.nvim_set_keymap('n', 'K', '<Plug>(devdocs-under-cursor)', {silent = true})

-- === telescope ===
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-b>', '<cmd>lua require("telescope.builtin").buffers()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<cmd>lua require("telescope.builtin").registers()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>hi', '<cmd>lua require("telescope.builtin").oldfiles()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>p', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>gc', '<cmd>lua require("telescope.builtin").git_commits()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>bgc', '<cmd>lua require("telescope.builtin").git_bcommits()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>;', '<cmd>lua require("telescope.builtin").live_grep()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").grep_string()<CR>', {noremap = true})

-- === vim-test ===
vim.api.nvim_set_keymap('n', '<Leader>t', ':wa<CR>:TestFile<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>s', ':wa<CR>:TestNearest<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>l', ':wa<CR>:TestLast<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>a', ':wa<CR>:TestSuite<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>gt', ':wa<CR>:TestVisit<CR>', {noremap = true, silent = true})

-- === trouble ===
vim.api.nvim_set_keymap('n', '<Leader>xx', '<cmd>TroubleToggle document_diagnostics<CR>', {noremap = true})

local actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')
local telescope = require('telescope')
telescope.setup {
  defaults = {
    mappings = {
      i = { ['<A-t>'] = trouble.open_with_trouble },
      n = { ['<A-t>'] = trouble.open_with_trouble },
    },
  },
}
