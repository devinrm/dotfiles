--  ____ ____ ____ ____ ____ ____ ____
-- ||p |||l |||u |||g |||i |||n |||s ||
-- ||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\|

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- Auto compile when there are changes in plugins.lua
vim.cmd "autocmd BufWritePost plugins.lua PackerCompile"

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- === colorscheme(s) ===
  use 'https://github.com/devinrm/the-grey'
  use 'https://github.com/shaunsingh/nord.nvim'

  -- === completion ===
  use 'https://github.com/alexaandru/nvim-lspupdate'
  use {
    'https://github.com/folke/trouble.nvim',
    requires = {'https://github.com/kyazdani42/nvim-web-devicons', opt = true}
  }
  use 'https://github.com/williamboman/nvim-lsp-installer'
  use 'https://github.com/neovim/nvim-lspconfig'
  use 'https://github.com/nvim-lua/plenary.nvim'
  use 'https://github.com/nvim-lua/popup.nvim'
  use { 'https://github.com/ms-jpq/coq_nvim', branch = 'coq' }
  use { 'https://github.com/ms-jpq/coq.artifacts', branch = 'artifacts' }
  use 'https://github.com/ms-jpq/coq.thirdparty'

  -- === experiments ===
  use 'https://gitlab.com/yorickpeterse/nvim-dd.git'
  use 'https://github.com/github/copilot.vim'
  use 'https://github.com/kchmck/vim-coffee-script'
  use 'https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils'

  -- === find ===
  use { 'https://github.com/junegunn/fzf', run ='./install --bin' }
  use 'https://github.com/junegunn/fzf.vim'

  -- === git ===
  use 'https://github.com/junegunn/gv.vim'
  use 'https://github.com/mhinz/vim-signify'

  -- === language plugins ===
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'https://github.com/hail2u/vim-css3-syntax', ft = {'css', 'scss'} }
  use {
    'https://github.com/iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    cmd = 'MarkdownPreview',
    ft = {'markdown'}
  }
  use 'https://github.com/Vimjas/vim-python-pep8-indent'
  use {
    'https://github.com/maxmellon/vim-jsx-pretty',
    ft = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'}
  }
  use {
    'https://github.com/HerringtonDarkholme/yats.vim',
    ft = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'}
  }
  use { 'https://github.com/othree/html5.vim', ft = {'html'} }
  use {
    'https://github.com/yuezk/vim-js',
    ft = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'}
  }
  use { 'https://github.com/rust-lang/rust.vim', ft = {'rust'} }
  use { 'https://github.com/vim-python/python-syntax', ft = {'python'} }

  -- === other ===
  use 'https://github.com/stefandtw/quickfix-reflector.vim'
  use 'https://github.com/norcalli/nvim-colorizer.lua'
  use 'https://github.com/tpope/vim-commentary'
  use 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring'
  use 'https://github.com/rhysd/devdocs.vim'
  use 'https://github.com/tweekmonster/startuptime.vim'
  use 'https://github.com/RRethy/vim-illuminate'
  use 'https://github.com/janko-m/vim-test'
  use 'https://github.com/romainl/vim-cool'
  use 'https://github.com/tpope/vim-fugitive'
  use { 'https://github.com/tpope/vim-rails', ft = {'ruby'} }
  use 'https://github.com/tpope/vim-rhubarb'
  use 'https://github.com/tpope/vim-rsi'
  use {
    'hoob3rt/lualine.nvim',
    requires = {'https://github.com/kyazdani42/nvim-web-devicons', opt = true}
  }
  use 'https://github.com/windwp/nvim-autopairs'
  use {
    'https://github.com/windwp/nvim-ts-autotag',
    ft = {'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'}
  }
end)
