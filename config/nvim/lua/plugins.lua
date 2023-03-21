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
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- === colorscheme(s) ===
    {
      "https://github.com/jesseleite/nvim-noirbuddy",
      lazy = false,
      priority = 1000,
      dependencies = { "https://github.com/tjdevries/colorbuddy.nvim", branch = "dev" },
      config = function()
        require("noirbuddy").setup({
          preset = 'slate',
          styles = {
            italic = true,
            bold = true,
            underline = true,
            undercurl = true,
          },
        })
      end
    },

    -- === completion ===
    {
      'https://github.com/neovim/nvim-lspconfig',
      keys = {
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true }),
        vim.keymap.set('n', 'ge', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true }),
        vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true }),
      },
      config = function()
        vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
      end
    },
    {
      'https://github.com/williamboman/mason.nvim',
      dependencies = 'https://github.com/williamboman/mason-lspconfig.nvim',
    },
    {
      'https://github.com/hrsh7th/nvim-cmp',
      dependencies = {
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
          dependencies = "https://github.com/zbirenbaum/copilot.lua",
          config = function()
            require("copilot_cmp").setup()
          end
        },
      }
    },
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-lua/popup.nvim',
    {
      'https://github.com/zbirenbaum/copilot.lua',
      config = function()
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
          filetypes = {
            yaml = true,
            markdown = true,
          },
        })
      end
    },
    {
      'https://github.com/jose-elias-alvarez/null-ls.nvim',
      dependencies = { 'https://github.com/nvim-lua/plenary.nvim' },
      config = function()
        local null_ls = require('null-ls')
        null_ls.setup({
          sources = {
            null_ls.builtins.code_actions.eslint_d,
            null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.code_actions.proselint,
            null_ls.builtins.diagnostics.proselint,
            null_ls.builtins.diagnostics.hadolint,
            null_ls.builtins.diagnostics.haml_lint,
            null_ls.builtins.diagnostics.jsonlint,
            null_ls.builtins.formatting.prettierd,
            null_ls.builtins.code_actions.refactoring,
            null_ls.builtins.formatting.rustywind.with({
              extra_filetypes = { "erb" }
            }),
            null_ls.builtins.diagnostics.rubocop,
            null_ls.builtins.formatting.rubocop,
            null_ls.builtins.code_actions.shellcheck,
            null_ls.builtins.diagnostics.shellcheck,
            null_ls.builtins.formatting.shellharden,
            null_ls.builtins.diagnostics.stylelint,
            null_ls.builtins.diagnostics.yamllint
          }
        })
      end
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
      config = function()
        require("chafa").setup({
          render = {
            min_padding = 5,
            show_label = true,
          },
          events = {
            update_on_nvim_resize = true,
          },
        })
      end
    },
    {
      'https://github.com/stevearc/aerial.nvim',
      config = function()
        require('aerial').setup({
          on_attach = function(bufnr)
            vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
            vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
          end
        })
      end
    },
    {
      'https://github.com/j-hui/fidget.nvim',
      config = function()
        require('fidget').setup()
      end
    },
    'https://github.com/DanilaMihailov/beacon.nvim',
    {
      'https://github.com/natecraddock/workspaces.nvim',
      config = function()
        local workspaces = require("workspaces")
        workspaces.setup({
          cd_type = "local",
          hooks = { open = { "FzfLua files" } }
        })
      end
    },
    {
      "https://github.com/utilyre/barbecue.nvim",
      name = "barbecue",
      version = "*",
      dependencies = {
        "https://github.com/SmiteshP/nvim-navic",
        "https://github.com/nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("barbecue").setup()
      end,
    },

    -- === find ===
    {
      "https://github.com/nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      dependencies = {
        "https://github.com/nvim-lua/plenary.nvim",
        "https://github.com/nvim-tree/nvim-web-devicons",
        "https://github.com/MunifTanjim/nui.nvim",
      },
      keys = {
        vim.keymap.set('n', '<Leader>vi', ':Neotree $HOME/dotfiles/<CR>', { noremap = true }),
        vim.keymap.set('n', '<Leader>ve', ':NeoTreeRevealToggle<CR>', { noremap = true })
      },
      config = function()
        vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
        require("neo-tree").setup({
          filesystem = {
            filtered_items = {
              hide_dotfiles = false,
              hide_gitignored = false,
            }
          },
          window = {
            mappings = {
              ["-"] = "navigate_up",
            }
          },
        })
      end
    },
    {
      'https://github.com/junegunn/fzf',
      build = './install --bin'
    },
    {
      'https://github.com/ibhagwan/fzf-lua',
      dependencies = { 'https://github.com/nvim-tree/nvim-web-devicons' },
      config = function()
        require('fzf-lua').setup({ 'fzf-native' })
      end,
      keys = {
        vim.keymap.set('n', '<C-p>',
          "<cmd>lua require('fzf-lua').files()<CR>",
          { noremap = true, silent = true }),

        vim.keymap.set('n', '<C-b>',
          "<cmd>lua require('fzf-lua').buffers()<CR>",
          { noremap = true, silent = true }),

        vim.keymap.set('n', '<Leader>p',
          "<cmd>lua require('fzf-lua').blines()<CR>",
          { noremap = true, silent = true }),

        vim.keymap.set('n', '<Leader>gc',
          "<cmd>lua require('fzf-lua').commits()<CR>",
          { noremap = true, silent = true }),

        vim.keymap.set('n', '<Leader>bgc',
          "<cmd>lua require('fzf-lua').bcommits()<CR>",
          { noremap = true, silent = true }),

        vim.keymap.set('n', '<Leader>hi',
          "<cmd>lua require('fzf-lua').oldfiles()<CR>",
          { noremap = true, silent = true }),

        vim.keymap.set('n', 'gr',
          "<cmd>lua require('fzf-lua').grep_cword()<CR>",
          { noremap = true, silent = true }),

        vim.keymap.set('n', '<Leader>;',
          "<cmd>lua require('fzf-lua').live_grep_glob()<CR>",
          { noremap = true, silent = true }),

        vim.keymap.set('n', "'",
          "<cmd>lua require('fzf-lua').registers()<CR>",
          { noremap = true, silent = true }),

        vim.keymap.set('v', '<Leader>ca',
          "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>",
          { noremap = true, silent = true })
      }
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
    {
      'https://github.com/nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      version = false,
      lazy = false,
      dependencies = {
        'https://github.com/RRethy/nvim-treesitter-endwise',
        'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
        {
          'https://github.com/windwp/nvim-autopairs',
          config = function()
            local remap = vim.api.nvim_set_keymap
            local npairs = require('nvim-autopairs')

            npairs.setup({ map_bs = false })

            _G.MUtils = {}

            MUtils.CR = function()
              if vim.fn.pumvisible() ~= 0 then
                if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
                  return npairs.esc('<c-y>')
                else
                  return npairs.esc('<c-e>') .. npairs.autopairs_cr()
                end
              else
                return npairs.autopairs_cr()
              end
            end
            remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

            MUtils.BS = function()
              if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
                return npairs.esc('<c-e>') .. npairs.autopairs_bs()
              else
                return npairs.autopairs_bs()
              end
            end
            remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
          end
        },
        {
          'https://github.com/windwp/nvim-ts-autotag',
          ft = { 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
        },
        {
          'https://github.com/numToStr/Comment.nvim',
          dependencies = 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
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
        { 'https://github.com/kevinhwang91/nvim-ufo', dependencies = 'https://github.com/kevinhwang91/promise-async' },
      },
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = {
            "astro",
            "bash",
            "css",
            "html",
            "javascript",
            "json",
            "lua",
            "python",
            "ruby",
            "rust",
            "scss",
            "tsx",
            "typescript",
            "yaml"
          },
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          indent = {
            enable = true,
          },
          autotag = {
            enable = true
          },
          context_commentstring = {
            enable = true
          },
          endwise = {
            enable = true
          }
        })
        require('ufo').setup({
          provider_selector = function(bufnr, filetype, buftype)
            return { 'treesitter', 'indent' }
          end
        })
      end
    },
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
      'https://github.com/rhysd/devdocs.vim',
      keys = {
        vim.keymap.set('n', 'K', '<Plug>(devdocs-under-cursor)', { silent = true })
      }
    },
    'https://github.com/RRethy/vim-illuminate',
    {
      'https://github.com/janko-m/vim-test',
      keys = {
        vim.keymap.set('n', '<Leader>t', ':wa<CR>:TestFile<CR>', { noremap = true, silent = true }),
        vim.keymap.set('n', '<Leader>s', ':wa<CR>:TestNearest<CR>', { noremap = true, silent = true }),
        vim.keymap.set('n', '<Leader>l', ':wa<CR>:TestLast<CR>', { noremap = true, silent = true }),
        vim.keymap.set('n', '<Leader>a', ':wa<CR>:TestSuite<CR>', { noremap = true, silent = true }),
        vim.keymap.set('n', '<Leader>gt', ':wa<CR>:TestVisit<CR>', { noremap = true, silent = true }),
      }
    },
    'https://github.com/romainl/vim-cool',
    {
      'https://github.com/tpope/vim-fugitive',
      config = function()
        vim.cmd([[ command! -nargs=1 Browse silent exec '!open "<args>"' ]])
      end
    },
    { 'https://github.com/tpope/vim-rails', ft = { 'ruby' } },
    'https://github.com/tpope/vim-rhubarb',
    'https://github.com/tpope/vim-rsi',
    'https://github.com/nvim-tree/nvim-web-devicons',
    {
      'https://github.com/hoob3rt/lualine.nvim',
      dependencies = { 'https://github.com/nvim-tree/nvim-web-devicons', lazy = true }
    },
    {
      "https://github.com/folke/trouble.nvim",
      dependencies = "https://github.com/nvim-tree/nvim-web-devicons",
      config = function()
        require("trouble").setup()
      end,
      keys = {
        vim.keymap.set('n', '<Leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>',
          { silent = true, noremap = true }
        )
      }
    }
  },
  {
    checker = { enabled = true },
    rtp = { disabled_plugins = { "netrwPlugin" } }
  })
