--  ____ ____ ____ ____
-- ||m |||a |||p |||s ||
-- ||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|

-- === zoom a vim pane, <C-w>= to re-balance ===
vim.keymap.set('n', '<Leader>-', ':wincmd _<CR>:wincmd |<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>=', ':wincmd =<CR>', { noremap = true })

-- === terminal mappings ===
vim.keymap.set('t', '<C-w>h', '<C-\\><C-n><C-w>h', { noremap = true })
vim.keymap.set('t', '<C-w>j', '<C-\\><C-n><C-w>j', { noremap = true })
vim.keymap.set('t', '<C-w>k', '<C-\\><C-n><C-w>k', { noremap = true })
vim.keymap.set('t', '<C-w>l', '<C-\\><C-n><C-w>l', { noremap = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.keymap.set('t', '<A-[>', '<Esc><Esc>', { noremap = true })
vim.keymap.set('t', '<C-w>-', '<C-\\><C-n>:sp<CR>:terminal<CR>i', { noremap = true })
vim.keymap.set('t', '<C-w>\\', '<C-\\><C-n>:vsp<CR>:terminal<CR>i', { noremap = true })
vim.keymap.set('n', '<C-w>-', ':20sp<CR>:terminal<CR>i', { noremap = true })
vim.keymap.set('n', '<C-w>\\', ':vsp<CR>:terminal<CR>i', { noremap = true })
vim.keymap.set('n', '<C-w>c', ':tabnew<CR>:terminal<CR>i', { noremap = true })

-- === Move up and down by visible lines if current line is wrapped ===
vim.keymap.set('n', 'j', 'gj', { noremap = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true })

-- === add current word under cursor to :%s ===
vim.keymap.set('n', '<Leader>n', ':%s/\\(<c-r>=expand("<cword>")<CR>\\)/', { noremap = true })

-- === Pre-populate a split command with the current directory ===
vim.keymap.set('n', '<Leader>e', ':vsp <C-r>=expand("%:p:h") . "/" <CR><C-d>', { noremap = true })
vim.keymap.set('n', '<Leader>mv', ':!mv % <C-r>=expand("%:p:h") . "/" <CR><C-d>', { noremap = true })
vim.keymap.set('n', '<Leader>cp', ':!cp % <C-r>=expand("%:p:h") . "/" <CR><C-d>', { noremap = true })

-- === debugging ===
vim.keymap.set('n', '<Leader>d', ':call InsertDebug()<CR>', { noremap = true })

-- === ripgrep ===
vim.keymap.set('n', '\\', ":Rg<SPACE>-F '' -g '*.'", { noremap = true })

-- === reload init ===
vim.keymap.set('n', '<Leader>so', ':source $MYVIMRC<CR>', { noremap = true })

--  ____ ____ ____ ____ ____ ____   ____ ____ ____ ____
-- ||p |||l |||u |||g |||i |||n || ||m |||a |||p |||s ||
-- ||__|||__|||__|||__|||__|||__|| ||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\| |/__\|/__\|/__\|/__\|

-- === fzf.lua ===
-- vim.cmd([[ command! -bang -nargs= *Rg  ]])
