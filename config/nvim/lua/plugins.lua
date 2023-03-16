--  ____ ____ ____ ____ ____ ____ ____
-- ||p |||l |||u |||g |||i |||n |||s ||
-- ||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\|

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- === colorscheme(s) ===
  {
    "https://github.com/jesseleite/nvim-noirbuddy",
    dependencies = { "https://github.com/tjdevries/colorbuddy.nvim", branch = "dev" }
  },

  -- === completion ===
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/williamboman/mason-lspconfig.nvim',
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/saadparwaiz1/cmp_luasnip',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-nvim-lua',
  'https://github.com/hrsh7th/cmp-cmdline',
  'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/rafamadriz/friendly-snippets',

  {
    "https://github.com/zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end
  },

  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-lua/popup.nvim',
  'https://github.com/zbirenbaum/copilot.lua',
  'https://github.com/RRethy/nvim-treesitter-endwise',
  {
    'https://github.com/jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'https://github.com/nvim-lua/plenary.nvim' },
  },

  -- === experiments ===
  {
    "https://github.com/jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "https://github.com/MunifTanjim/nui.nvim",
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/nvim-telescope/telescope.nvim"
    }
  },
  {
    "https://github.com/princejoogie/chafa.nvim",
    dependencies = {
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/m00qek/baleia.nvim"
    },
  },
  'https://github.com/stevearc/aerial.nvim',
  {
    'https://github.com/j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end
  },
  'https://github.com/DanilaMihailov/beacon.nvim',

  -- === find ===
  {
    'https://github.com/nvim-tree/nvim-tree.lua',
    dependencies = {
      'https://github.com/nvim-tree/nvim-web-devicons',
    },
    version = 'nightly'
  },
  {
    'https://github.com/junegunn/fzf',
    build = './install --bin'
  },
  {
    'https://github.com/ibhagwan/fzf-lua',
    dependencies = { 'https://github.com/nvim-tree/nvim-web-devicons' },
    config = function() require('fzf-lua').setup({ 'fzf-native' }) end
  },

  -- === git ===
  {
    'https://github.com/lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },

  -- === language plugins ===
  'https://github.com/wuelnerdotexe/vim-astro',
  'https://github.com/hashivim/vim-terraform',
  { 'https://github.com/nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  {
    'https://github.com/iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    cmd = 'MarkdownPreview',
    ft = { 'markdown' }
  },
  'https://github.com/Vimjas/vim-python-pep8-indent',
  {
    'https://github.com/rust-lang/rust.vim',
    ft = { 'rust' }
  },

  -- === other ===
  'https://github.com/stefandtw/quickfix-reflector.vim',
  {
    'https://github.com/norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end
  },
  {
    'https://github.com/numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        toggler = {
          line = "<C-\\>",
        },
        opleader = {
          block = '<C-\\>',
        },
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end
  },
  'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
  'https://github.com/rhysd/devdocs.vim',
  'https://github.com/RRethy/vim-illuminate',
  'https://github.com/janko-m/vim-test',
  'https://github.com/romainl/vim-cool',
  'https://github.com/tpope/vim-fugitive',
  { 'https://github.com/tpope/vim-rails',                 ft = { 'ruby' } },
  'https://github.com/tpope/vim-rhubarb',
  'https://github.com/tpope/vim-rsi',
  'https://github.com/nvim-tree/nvim-web-devicons',
  {
    'https://github.com/hoob3rt/lualine.nvim',
    dependencies = { 'https://github.com/nvim-tree/nvim-web-devicons', lazy = true }
  },
  'https://github.com/windwp/nvim-autopairs',
  {
    'https://github.com/windwp/nvim-ts-autotag',
    ft = { 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
  },
  {
    "https://github.com/folke/trouble.nvim",
    dependencies = "https://github.com/nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end
  }
},
  {
    defaults = { lazy = true },
    checker = { enabled = true },
    rtp = { disabled_plugins = { "netrwPlugin" } }
  })
