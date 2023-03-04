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

-- === Open dotfiles in new tab ===
vim.keymap.set('n', '<Leader>vi', ':NvimTreeToggle $HOME/dotfiles/<CR>', { noremap = true })

vim.keymap.set('n', '<Leader>ve', ':NvimTreeFindFileToggle<CR>', { noremap = true })

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

vim.api.nvim_command [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'ge', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })

-- === devdocs ===
vim.keymap.set('n', 'K', '<Plug>(devdocs-under-cursor)', { silent = true })

-- === vim-fugitive ===
vim.cmd([[ command! -nargs=1 Browse silent exec '!open "<args>"' ]])

-- === fzf.lua ===
-- vim.cmd([[ command! -bang -nargs= *Rg  ]])

vim.keymap.set('n', '<C-p>',
  "<cmd>lua require('fzf-lua').files()<CR>",
  { noremap = true, silent = true })

vim.keymap.set('n', '<C-b>',
  "<cmd>lua require('fzf-lua').buffers()<CR>",
  { noremap = true, silent = true })

vim.keymap.set('n', '<Leader>p',
  "<cmd>lua require('fzf-lua').blines()<CR>",
  { noremap = true, silent = true })

vim.keymap.set('n', '<Leader>gc',
  "<cmd>lua require('fzf-lua').commits()<CR>",
  { noremap = true, silent = true })

vim.keymap.set('n', '<Leader>bgc',
  "<cmd>lua require('fzf-lua').bcommits()<CR>",
  { noremap = true, silent = true })

vim.keymap.set('n', '<Leader>hi',
  "<cmd>lua require('fzf-lua').oldfiles()<CR>",
  { noremap = true, silent = true })

vim.keymap.set('n', 'gr',
  "<cmd>lua require('fzf-lua').grep_cword()<CR>",
  { noremap = true, silent = true })

vim.keymap.set('n', '<Leader>;',
  "<cmd>lua require('fzf-lua').live_grep_glob()<CR>",
  { noremap = true, silent = true })

vim.keymap.set('n', "'",
  "<cmd>lua require('fzf-lua').registers()<CR>",
  { noremap = true, silent = true })

vim.keymap.set('v', '<Leader>ca',
  "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>",
  { noremap = true, silent = true })

-- === vim-test ===
vim.keymap.set('n', '<Leader>t', ':wa<CR>:TestFile<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>s', ':wa<CR>:TestNearest<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>l', ':wa<CR>:TestLast<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>a', ':wa<CR>:TestSuite<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>gt', ':wa<CR>:TestVisit<CR>', { noremap = true, silent = true })

-- === trouble.nvim ===
vim.keymap.set('n', '<Leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>',
  { silent = true, noremap = true }
)
