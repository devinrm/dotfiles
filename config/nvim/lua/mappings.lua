--  ____ ____ ____ ____
-- ||m |||a |||p |||s ||
-- ||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|

-- === zoom a vim pane, <C-w>= to re-balance ===
vim.api.nvim_set_keymap('n', '<Leader>-', ':wincmd _<CR>:wincmd |<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>=', ':wincmd =<CR>', { noremap = true })

-- === terminal mappings ===
vim.api.nvim_set_keymap('t', '<C-w>h', '<C-\\><C-n><C-w>h', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-w>j', '<C-\\><C-n><C-w>j', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-w>k', '<C-\\><C-n><C-w>k', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-w>l', '<C-\\><C-n><C-w>l', { noremap = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.api.nvim_set_keymap('t', '<A-[>', '<Esc><Esc>', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-w>-', '<C-\\><C-n>:sp<CR>:terminal<CR>i', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-w>\\', '<C-\\><C-n>:vsp<CR>:terminal<CR>i', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-w>-', ':20sp<CR>:terminal<CR>i', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-w>\\', ':vsp<CR>:terminal<CR>i', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-w>c', ':tabnew<CR>:terminal<CR>i', { noremap = true })

-- === Move up and down by visible lines if current line is wrapped ===
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })

-- === add current word under cursor to :%s ===
vim.api.nvim_set_keymap('n', '<Leader>n', ':%s/\\(<c-r>=expand("<cword>")<CR>\\)/', { noremap = true })

-- === Pre-populate a split command with the current directory ===
vim.api.nvim_set_keymap('n', '<Leader>e', ':vsp <C-r>=expand("%:p:h") . "/" <CR><C-d>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>mv', ':!mv % <C-r>=expand("%:p:h") . "/" <CR><C-d>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>cp', ':!cp % <C-r>=expand("%:p:h") . "/" <CR><C-d>', { noremap = true })

-- === Open dotfiles in new tab ===
vim.api.nvim_set_keymap('n', '<Leader>vi', ':NnnExplorer $HOME/dotfiles/<CR>', { noremap = true })

-- === debugging ===
vim.api.nvim_set_keymap('n', '<Leader>d', ':call InsertDebug()<CR>', { noremap = true })

-- === ripgrep ===
vim.api.nvim_set_keymap('n', '\\', ":Rg<SPACE>-F '' -g '*.'", { noremap = true })

-- === reload init ===
vim.api.nvim_set_keymap('n', '<Leader>so', ':source $MYVIMRC<CR>', { noremap = true })

--  ____ ____ ____ ____ ____ ____   ____ ____ ____ ____
-- ||p |||l |||u |||g |||i |||n || ||m |||a |||p |||s ||
-- ||__|||__|||__|||__|||__|||__|| ||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\| |/__\|/__\|/__\|/__\|

vim.api.nvim_command [[autocmd BufWritePre *.rb lua vim.lsp.buf.format({ async = true })]]
vim.api.nvim_command [[autocmd BufWritePre *.ts lua vim.lsp.buf.format()]]
vim.api.nvim_command [[autocmd BufWritePre *.tsx lua vim.lsp.buf.format()]]
vim.api.nvim_command [[autocmd BufWritePre *.js lua vim.lsp.buf.format()]]
vim.api.nvim_command [[autocmd BufWritePre *.jsx lua vim.lsp.buf.format()]]
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ge', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })

-- === vim-commentary ===
vim.api.nvim_set_keymap('n', '<C-\\>', 'gcc', {})
vim.api.nvim_set_keymap('x', '<C-\\>', 'gc', {})

-- === devdocs ===
vim.api.nvim_set_keymap('n', 'K', '<Plug>(devdocs-under-cursor)', { silent = true })

-- === vim-fugitive ===
vim.cmd([[ command! -nargs=1 Browse silent exec '!open "<args>"' ]])

-- === fzf.lua ===
vim.api.nvim_set_keymap('n', '<C-p>',
"<cmd>lua require('fzf-lua').files()<CR>",
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-b>',
"<cmd>lua require('fzf-lua').buffers()<CR>",
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>p',
"<cmd>lua require('fzf-lua').blines()<CR>",
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>gc',
"<cmd>lua require('fzf-lua').commits()<CR>",
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>bgc',
"<cmd>lua require('fzf-lua').bcommits()<CR>",
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>hi',
"<cmd>lua require('fzf-lua').oldfiles()<CR>",
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'gr',
"<cmd>lua require('fzf-lua').grep_cword()<CR>",
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>;',
"<cmd>lua require('fzf-lua').live_grep_glob()<CR>",
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', "'",
"<cmd>lua require('fzf-lua').registers()<CR>",
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('v', '<Leader>ca',
"<cmd>lua require('fzf-lua').lsp_code_actions()<CR>",
{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>xx',
"<cmd>lua require('fzf-lua').diagnostics_document()<CR>",
{ noremap = true, silent = true })

-- === vim-test ===
vim.api.nvim_set_keymap('n', '<Leader>t', ':wa<CR>:TestFile<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>s', ':wa<CR>:TestNearest<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>l', ':wa<CR>:TestLast<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>a', ':wa<CR>:TestSuite<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gt', ':wa<CR>:TestVisit<CR>', { noremap = true, silent = true })
