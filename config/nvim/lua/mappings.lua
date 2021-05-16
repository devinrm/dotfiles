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
vim.api.nvim_set_keymap('n', '<Leader>vi', ':tabe $HOME/dotfiles/config/nvim/<CR>', {noremap = true})

-- === debugging ===
vim.api.nvim_set_keymap('n', '<Leader>d', ':call InsertDebug()<CR>', {noremap = true})
