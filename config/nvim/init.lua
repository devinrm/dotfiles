--  ____ ____ ____ ____ ____ ____ ____ ____
-- ||s |||e |||t |||t |||i |||n |||g |||s ||
-- ||__|||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
vim.loader.enable()

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.skip_ts_context_commentstring_module = true
vim.o.termguicolors = true
vim.opt.background = 'dark'
vim.opt.spellfile = os.getenv("HOME") .. "/.vim-spell-en.utf-8.add"
vim.g.is_posix = 1 -- When the type of shell script is /bin/sh, assume a POSIX-compatible shell for syntax highlighting purposes.
vim.g.mapleader = ' ' -- Set Leader key to <Space> bar
vim.g.python3_host_prog = (vim.env.HOME .. '/.asdf/shims/python')
vim.o.autowriteall = true
vim.o.backspace = '2' -- Backspace deletes like most programs in insert mode
vim.o.backup = false -- Don't make a backup before overwriting a file
vim.o.backupcopy = 'yes'
vim.o.clipboard = 'unnamedplus' -- copy paste to system clipboard
vim.o.expandtab = true -- Use the appropriate number of spaces to insert a <Tab>.
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵]]
vim.o.foldcolumn = '0'
vim.o.foldenable = false
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.formatprg = 'fmt'
vim.o.gdefault = true -- Replace all matches on a line instead of just the first
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.grepprg =
    'rg --vimgrep --no-heading --smart-case --column --with-filename --line-number'
vim.o.ignorecase = true -- case insensitive pattern matching
vim.o.inccommand = 'split' -- this is necessary for using this %s with a quickfix window in nvim
vim.o.joinspaces = false -- Insert one space after a '.', '?' and '!' with a join command.
vim.o.matchtime = 0 -- Speed up escape after (){} chars
vim.o.pumheight = 10 -- limit size of popup menu
vim.o.pumblend = 20
vim.o.scrolloff = 3 -- show 3 lines above and below cursor
vim.o.shiftround = true -- Round indent to multiple of 'shiftwidth'.
vim.o.shiftwidth = 2 -- Returns the effective value of 'shiftwidth'
vim.o.showmode = false -- If in Insert, Replace or Visual mode don't put a message on the last line.
vim.o.showtabline = 0
vim.o.smartcase = true -- overrides ignorecase if pattern contains upcase
vim.o.spelllang = 'en_us' -- Set region to US English
vim.o.splitbelow = true -- When on, splitting a window will put the new window below the current one.
vim.o.splitright = true -- When on, splitting a window will put the new window right of the current one.
vim.o.swapfile = false -- Do not create a swapfile for a new buffer.
vim.o.synmaxcol = 200
vim.o.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for.
vim.o.textwidth = 120 -- Maximum width of text that is being inserted. A longer line will be broken after white space to get this width.
vim.o.undofile = true -- Automatically saves undo history to an undo file when writing a buffer to a file, and restores undo history from the same file on buffer read.
vim.o.undolevels = 500
vim.o.undoreload = 500
vim.o.updatetime = 100
vim.o.wildignore = 'tmp/**' -- Ignore stuff that can't be opened
vim.o.wildmode = 'list:longest,list:full'
vim.o.writebackup = false -- Don't make a backup before overwriting a file.
vim.opt.colorcolumn = '+1' -- highlight column after 'textwidth
vim.opt.diffopt:append({'vertical'}) -- Start diff mode with vertical splits
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.path:append({'.,,', 'node_modules'})
vim.opt.shortmess = 'fxtToOFc' -- vim default with 'c' appended (don't give |ins-completion-menu| messages)
vim.wo.cursorline = false
vim.wo.number = true -- Turn on line numbers
vim.wo.numberwidth = 1 -- Minimal number of columns to use for the line number.
vim.wo.signcolumn = 'yes' -- Leave signcolumn enabled otherwise it's a little jarring
vim.wo.wrap = false -- Don't wrap lines longer than the width of the window
vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    update_in_insert = false,
    severity_sort = true
})

--  ____ ____ ____ ____ ____ ____ ____
-- ||p |||l |||u |||g |||i |||n |||s ||
-- ||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\|

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- === colorscheme(s) ===
    {
        'https://github.com/projekt0n/github-nvim-theme',
        branch = '0.0.x',
        lazy = false,
        priority = 1000,
        config = function()
            require('github-theme').setup()

            vim.cmd('colorscheme github_dark')
        end
    }, -- === core ===
    {
        'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
        lazy = true
    }, {
        'https://github.com/nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        version = false,
        event = {"BufReadPost", "BufNewFile"},
        dependencies = {
            {'https://github.com/RRethy/nvim-treesitter-endwise'}, {
                'https://github.com/windwp/nvim-autopairs',
                config = function()
                    local remap = vim.api.nvim_set_keymap
                    local npairs = require('nvim-autopairs')

                    npairs.setup({map_bs = false})

                    _G.MUtils = {}

                    MUtils.CR = function()
                        if vim.fn.pumvisible() ~= 0 then
                            if vim.fn.complete_info({'selected'}).selected ~= -1 then
                                return npairs.esc('<c-y>')
                            else
                                return npairs.esc('<c-e>') ..
                                           npairs.autopairs_cr()
                            end
                        else
                            return npairs.autopairs_cr()
                        end
                    end
                    remap('i', '<cr>', 'v:lua.MUtils.CR()',
                          {expr = true, noremap = true})

                    MUtils.BS = function()
                        if vim.fn.pumvisible() ~= 0 and
                            vim.fn.complete_info({'mode'}).mode == 'eval' then
                            return npairs.esc('<c-e>') .. npairs.autopairs_bs()
                        else
                            return npairs.autopairs_bs()
                        end
                    end
                    remap('i', '<bs>', 'v:lua.MUtils.BS()',
                          {expr = true, noremap = true})
                end
            }, {
                'https://github.com/windwp/nvim-ts-autotag',
                ft = {
                    'astro', 'html', 'javascript', 'javascriptreact',
                    'typescript', 'typescriptreact'
                }
            }, {
                'https://github.com/kevinhwang91/nvim-ufo',
                dependencies = 'https://github.com/kevinhwang91/promise-async'
            }, {'https://github.com/nvim-treesitter/nvim-treesitter-refactor'}
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = false,
                disable = function(buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat,
                                            vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                ensure_installed = {
                    "bash", "comment", "css", "dockerfile", "git_config",
                    "git_rebase", "gitattributes", "gitcommit", "gitignore",
                    "go", "graphql", "html", "http", "javascript", "jsdoc",
                    "json", "json5", "jsonc", "kdl", "lua", "luadoc", "luap",
                    "make", "markdown", "markdown_inline", "prisma", "python",
                    "regex", "ruby", "rust", "scss", "sql", "swift",
                    "terraform", "todotxt", "tsx", "typescript", "vim",
                    "vimdoc", "yaml"
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },
                indent = {enable = true},
                autotag = {enable = true},
                endwise = {enable = true},
                refactor = {enable = true, clear_on_cursor_move = false}
            })

            require('ufo').setup({
                provider_selector = function()
                    return {'treesitter', 'indent'}
                end
            })
        end
    }, {
        'https://github.com/neovim/nvim-lspconfig',
        event = {"BufReadPre", "BufNewFile"},
        keys = {
            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>',
                           {noremap = true, silent = true}),
            vim.keymap.set('n', 'ge', '<cmd>lua vim.lsp.buf.definition()<CR>',
                           {noremap = true, silent = true}),
            vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>',
                           {noremap = true, silent = true})
        },
        dependencies = {
            "https://github.com/folke/neodev.nvim",
            "https://github.com/williamboman/mason.nvim",
            "https://github.com/williamboman/mason-lspconfig.nvim",
            "https://github.com/hrsh7th/cmp-nvim-lsp"
        }
    }, {'https://github.com/nvim-lua/plenary.nvim', lazy = true},

    {'https://github.com/nvim-lua/popup.nvim'}, -- === completion ===
    {
        'https://github.com/williamboman/mason.nvim',
        build = ":MasonUpdate",
        dependencies = {
            'https://github.com/williamboman/mason-lspconfig.nvim',
            config = function()
                require("neodev").setup()
                require('mason').setup()

                local mason_lspconfig = require("mason-lspconfig")
                local lsp = require('lspconfig')
                local capabilities =
                    require('cmp_nvim_lsp').default_capabilities()

                mason_lspconfig.setup({
                    ensure_installed = {
                        "astro", "bashls", "codeqlls", "cssls", "cssmodules_ls",
                        "dockerls", "docker_compose_language_service", "eslint",
                        "graphql", "html", "jsonls", "marksman", "prismals",
                        "pyright", "ruby_ls", "rust_analyzer", "sqlls",
                        "stylelint_lsp", "lua_ls", "tailwindcss", "terraformls",
                        "tflint", "tsserver", "yamlls"
                    },
                    automatic_installation = true
                })

                mason_lspconfig.setup_handlers({
                    lsp.astro.setup({capabilities = capabilities}),
                    lsp.bashls.setup({capabilities = capabilities}),
                    lsp.codeqlls.setup({capabilities = capabilities}),
                    lsp.cssls.setup({capabilities = capabilities}),
                    lsp.cssmodules_ls.setup({capabilities = capabilities}),
                    lsp.dockerls.setup({capabilities = capabilities}),
                    lsp.docker_compose_language_service
                        .setup({capabilities = capabilities}),
                    lsp.eslint.setup({capabilities = capabilities}),
                    lsp.graphql.setup({capabilities = capabilities}),
                    lsp.html.setup({capabilities = capabilities}),
                    lsp.jsonls.setup({capabilities = capabilities}),

                    lsp.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = {version = 'LuaJIT'},
                                diagnostics = {globals = {'vim'}},
                                workspace = {
                                    library = vim.api.nvim_get_runtime_file("",
                                                                            true),
                                    checkThirdParty = false
                                },
                                telemetry = {enable = false}
                            }
                        }
                    }), lsp.marksman.setup({capabilities = capabilities}),
                    lsp.prismals.setup({capabilities = capabilities}),
                    lsp.pyright.setup({capabilities = capabilities}),
                    lsp.ruby_ls.setup({capabilities = capabilities}),
                    lsp.rust_analyzer.setup({capabilities = capabilities}),
                    lsp.sqlls.setup({capabilities = capabilities}),
                    lsp.stylelint_lsp.setup({capabilities = capabilities}),
                    lsp.tailwindcss.setup({capabilities = capabilities}),
                    lsp.terraformls.setup({capabilities = capabilities}),
                    lsp.tflint.setup({capabilities = capabilities}),
                    lsp.yamlls.setup({capabilities = capabilities})
                })
            end
        }
    }, {
        'https://github.com/hrsh7th/nvim-cmp',
        version = false,
        dependencies = {
            'https://github.com/hrsh7th/cmp-buffer',
            'https://github.com/hrsh7th/cmp-path',
            'https://github.com/saadparwaiz1/cmp_luasnip',
            'https://github.com/hrsh7th/cmp-nvim-lsp',
            'https://github.com/hrsh7th/cmp-nvim-lua',
            'https://github.com/hrsh7th/cmp-cmdline',
            'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help', {
                'https://github.com/L3MON4D3/LuaSnip',
                dependencies = 'https://github.com/rafamadriz/friendly-snippets',
                opts = {history = true, delete_check_events = "TextChanged"}
            }, {
                "https://github.com/zbirenbaum/copilot-cmp",
                dependencies = "https://github.com/zbirenbaum/copilot.lua",
                config = function()
                    require("copilot_cmp").setup()
                end
            }
        },
        opts = function()
            local cmp = require('cmp')

            local has_words_before = function()
                unpack = unpack
                if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
                    return false
                end
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                           vim.api
                               .nvim_buf_get_text(0, line - 1, 0, line - 1, col,
                                                  {})[1]:match("^%s*$") == nil
            end

            return {
                completion = {completeopt = "menu,menuone,noinsert"},
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    }),
                    ['<Tab>'] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_next_item({
                                behavior = cmp.SelectBehavior.Select
                            })
                        else
                            fallback()
                        end
                    end),
                    ['<S-Tab>'] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_prev_item({
                                behavior = cmp.SelectBehavior.Select
                            })
                        else
                            fallback()
                        end
                    end)
                }),
                sources = cmp.config.sources({
                    {name = 'copilot', group_index = 2},
                    {name = 'nvim_lsp', group_index = 2},
                    {name = 'nvim_lsp_signature_help', group_index = 2},
                    {name = 'luasnip', group_index = 2},
                    {name = 'nvim_lua', group_index = 2},
                    {name = 'buffer', group_index = 2},
                    {name = 'path', group_index = 2}
                }),
                experimental = {ghost_text = {hl_group = "Comment"}}
            }
        end
    }, {
        'https://github.com/jose-elias-alvarez/null-ls.nvim',
        dependencies = {
            'https://github.com/nvim-lua/plenary.nvim',
            'https://github.com/williamboman/mason.nvim'
        },
        event = {"BufReadPre", "BufNewFile"},
        opts = function()
            local null_ls = require('null-ls')
            local augroup = vim.api.nvim_create_augroup("lsp_formatting", {})

            return {
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr
                        })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({
                                    bufnr = bufnr,
                                    timeout_ms = 2000
                                })
                            end
                        })
                    end
                end,
                root_dir = require("null-ls.utils").root_pattern(
                    ".null-ls-root", ".neoconf.json", "Makefile", ".git"),
                sources = {
                    null_ls.builtins.code_actions.proselint,
                    null_ls.builtins.diagnostics.proselint,
                    null_ls.builtins.diagnostics.hadolint,
                    null_ls.builtins.diagnostics.haml_lint,
                    null_ls.builtins.diagnostics.jsonlint,
                    null_ls.builtins.formatting.lua_format,
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.rustfmt,
                    null_ls.builtins.formatting.rustywind
                        .with({extra_filetypes = {"erb"}}),
                    -- null_ls.builtins.formatting.rubocop,
                    null_ls.builtins.diagnostics.rubocop,
                    null_ls.builtins.code_actions.shellcheck,
                    null_ls.builtins.diagnostics.shellcheck,
                    null_ls.builtins.formatting.shellharden,
                    null_ls.builtins.diagnostics.yamllint
                }
            }
        end
    }, {
        "https://github.com/zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {suggestion = {enabled = false}, panel = {enabled = false}}
    }, -- === experiments ===
    {
        "https://github.com/stevearc/dressing.nvim",
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({plugins = {"dressing.nvim"}})
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({plugins = {"dressing.nvim"}})
                return vim.ui.input(...)
            end
        end
    }, {
        'https://github.com/natecraddock/workspaces.nvim',
        event = "VeryLazy",
        opts = {cd_type = "local", hooks = {open = {"Telescope find_files"}}}
    }, {
        'https://github.com/stevearc/overseer.nvim',
        event = "VeryLazy",
        config = function() require('overseer').setup() end
    }, {
        "https://github.com/pmizio/typescript-tools.nvim",
        dependencies = {
            "https://github.com/nvim-lua/plenary.nvim",
            "https://github.com/neovim/nvim-lspconfig"
        },
        opts = {}
    }, -- === find ===
    {'https://github.com/junegunn/fzf', build = './install --bin'},

    {"https://github.com/nvim-tree/nvim-web-devicons", lazy = true}, {
        "https://github.com/nvim-telescope/telescope.nvim",
        branch = '0.1.x',
        dependencies = {
            "https://github.com/nvim-lua/plenary.nvim",
            "https://github.com/debugloop/telescope-undo.nvim",
            "https://github.com/nvim-treesitter/nvim-treesitter",
            "https://github.com/nvim-tree/nvim-web-devicons",
            "https://github.com/nvim-telescope/telescope-dap.nvim",
            {
                "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
                build = "make"
            }
        },
        opts = {
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case"
                },
                undo = {
                    side_by_side = true,
                    layout_strategy = "vertical",
                    layout_config = {preview_height = 0.8}
                },
                dap = {}
            }
        },
        config = function()
            local telescope = require("telescope")

            telescope.load_extension("fzf")
            telescope.load_extension("undo")
        end,
        keys = {
            vim.keymap.set("n", "<Leader>u", "<cmd>Telescope undo<CR>",
                           {noremap = true, silent = true}),

            vim.keymap.set('n', '<C-p>', "<cmd>Telescope find_files<CR>",
                           {noremap = true, silent = true}),

            vim.keymap.set('n', '<C-b>', "<cmd>Telescope buffers<CR>",
                           {noremap = true, silent = true}),

            vim.keymap.set('n', '<Leader>p',
                           "<cmd>Telescope current_buffer_fuzzy_find<CR>",
                           {noremap = true, silent = true}),

            vim.keymap.set('n', '<Leader>gc', "<cmd>Telescope git_commits<CR>",
                           {noremap = true, silent = true}),

            vim.keymap
                .set('n', '<Leader>bgc', "<cmd>Telescope git_bcommits<CR>",
                     {noremap = true, silent = true}),

            vim.keymap.set('n', '<Leader>hi', "<cmd>Telescope oldfiles<CR>",
                           {noremap = true, silent = true}),

            vim.keymap.set('n', 'gw', "<cmd>Telescope grep_string<CR>",
                           {noremap = true, silent = true}),

            vim.keymap.set('n', '<Leader>;', "<cmd>Telescope live_grep<CR>",
                           {noremap = true, silent = true}),

            vim.keymap.set('n', "'", "<cmd>Telescope registers<CR>",
                           {noremap = true, silent = true})
        }
    }, -- === git ===
    {
        'https://github.com/tpope/vim-fugitive',
        config = function()
            vim.cmd("command! -nargs=1 Browse silent exec '!open \"<args>\"'")
        end
    }, {
        'https://github.com/lewis6991/gitsigns.nvim',
        event = {"BufReadPre", "BufNewFile"},
        config = function() require('gitsigns').setup() end
    }, -- === mini ===
    {
        'https://github.com/echasnovski/mini.comment',
        event = "VeryLazy",
        opts = {
            mappings = {comment_line = "<C-\\>", comment_visual = '<C-\\>'},
            hooks = {
                pre = function()
                    require("ts_context_commentstring.internal").update_commentstring(
                        {})
                end
            }
        },
        config = function(_, opts) require("mini.comment").setup(opts) end
    }, {
        'https://github.com/echasnovski/mini.cursorword',
        event = "VeryLazy",
        config = function() require("mini.cursorword").setup() end
    }, {
        'https://github.com/echasnovski/mini.bufremove',
        event = "VeryLazy",
        config = function() require("mini.bufremove").setup() end
    }, {
        'https://github.com/echasnovski/mini.animate',
        event = "VeryLazy",
        opts = function()
            -- don't use animate when scrolling with the mouse
            local mouse_scrolled = false
            for _, scroll in ipairs({"Up", "Down"}) do
                local key = "<ScrollWheel" .. scroll .. ">"
                vim.keymap.set({"", "i"}, key, function()
                    mouse_scrolled = true
                    return key
                end, {expr = true})
            end

            local animate = require("mini.animate")
            return {
                resize = {
                    timing = animate.gen_timing.linear({
                        duration = 100,
                        unit = "total"
                    })
                },
                scroll = {
                    timing = animate.gen_timing.linear({
                        duration = 150,
                        unit = "total"
                    }),
                    subscroll = animate.gen_subscroll.equal({
                        predicate = function(total_scroll)
                            if mouse_scrolled then
                                mouse_scrolled = false
                                return false
                            end
                            return total_scroll > 1
                        end
                    })
                }
            }
        end,
        config = function(_, opts) require("mini.animate").setup(opts) end
    }, {
        "https://github.com/nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = false,
        dependencies = {
            "https://github.com/nvim-lua/plenary.nvim",
            "https://github.com/nvim-tree/nvim-web-devicons",
            "https://github.com/MunifTanjim/nui.nvim",
            "https://github.com/3rd/image.nvim", {
                'https://github.com/s1n7ax/nvim-window-picker',
                version = '2.*',
                config = function()
                    require'window-picker'.setup({
                        filter_rules = {
                            include_current_win = false,
                            autoselect_one = true,
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = {
                                    'neo-tree', "neo-tree-popup", "notify"
                                },
                                -- if the buffer type is one of following, the window will be ignored
                                buftype = {'terminal', "quickfix"}
                            }
                        }
                    })
                end
            }
        },
        keys = {
            vim.keymap
                .set('n', '-', '<cmd>Neotree toggle<CR>', {noremap = true})
        }
    }, {
        'https://github.com/echasnovski/mini.trailspace',
        event = "VeryLazy",
        config = function()
            local mini_trailspace = require("mini.trailspace")
            mini_trailspace.setup()

            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("vim_trim", {clear = true}),
                callback = function() mini_trailspace.trim() end
            })
        end
    }, -- === language plugins ===
    {'https://github.com/wuelnerdotexe/vim-astro', ft = 'astro'},

    {'https://github.com/hashivim/vim-terraform', ft = 'terraform'}, {
        'https://github.com/iamcco/markdown-preview.nvim',
        build = "cd app && npm install",
        config = function() vim.g.mkdp_filetypes = {"markdown"} end,
        ft = {"markdown"}
    }, {'https://github.com/Vimjas/vim-python-pep8-indent', ft = {'python'}},

    {'https://github.com/rust-lang/rust.vim', ft = {'rust'}}, -- === other ===
    {
        "https://github.com/jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        opts = {
            openai_params = {
                model = "gpt-4",
                frequency_penalty = 0,
                presence_penalty = 0,
                max_tokens = 300,
                temperature = 0,
                top_p = 1,
                n = 1
            }
        },
        dependencies = {
            "https://github.com/MunifTanjim/nui.nvim",
            "https://github.com/nvim-lua/plenary.nvim",
            "https://github.com/nvim-telescope/telescope.nvim"
        }
    }, {
        'https://github.com/stevearc/aerial.nvim',
        event = {"BufReadPre"},
        opts = {
            on_attach = function(bufnr)
                vim.keymap
                    .set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
                vim.keymap
                    .set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
            end
        }
    }, {'https://github.com/DanilaMihailov/beacon.nvim', event = "VeryLazy"},

    {"https://github.com/chrishrb/gx.nvim", event = {"BufEnter"}, config = true},

    {
        'https://github.com/laytan/cloak.nvim',
        event = {"BufReadPre"},
        ft = {'sh'},
        config = function() require('cloak').setup() end
    },

    {'https://github.com/stefandtw/quickfix-reflector.vim', event = "VeryLazy"},

    {
        'https://github.com/norcalli/nvim-colorizer.lua',
        event = "VeryLazy",
        config = function() require('colorizer').setup() end
    }, {
        'https://github.com/rhysd/devdocs.vim',
        event = "VeryLazy",
        keys = {
            vim.keymap.set('n', 'K', '<Plug>(devdocs-under-cursor)',
                           {silent = true})
        }
    }, {
        'https://github.com/janko-m/vim-test',
        event = "VeryLazy",
        keys = {
            vim.keymap.set('n', '<Leader>t', ':wa<CR>:TestFile<CR>',
                           {noremap = true, silent = true}),
            vim.keymap.set('n', '<Leader>s', ':wa<CR>:TestNearest<CR>',
                           {noremap = true, silent = true}),
            vim.keymap.set('n', '<Leader>l', ':wa<CR>:TestLast<CR>',
                           {noremap = true, silent = true}),
            vim.keymap.set('n', '<Leader>a', ':wa<CR>:TestSuite<CR>',
                           {noremap = true, silent = true}),
            vim.keymap.set('n', '<Leader>gt', ':wa<CR>:TestVisit<CR>',
                           {noremap = true, silent = true})
        }
    }, {
        "https://github.com/folke/neodev.nvim",
        config = function()
            require("neodev").setup({
                library = {plugins = {"nvim-dap-ui"}, types = true}
            })
        end
    }, {"https://github.com/mfussenegger/nvim-dap"}, {
        "https://github.com/rcarriga/nvim-dap-ui",
        dependencies = {"https://github.com/mfussenegger/nvim-dap"},
        config = function() require("dapui").setup() end
    }, {'https://github.com/romainl/vim-cool'},

    {'https://github.com/tpope/vim-rails', ft = {'ruby'}},

    {'https://github.com/tpope/vim-rhubarb'},

    {'https://github.com/tpope/vim-rsi'}, -- === UI ===
    {
        'https://github.com/hoob3rt/lualine.nvim',
        event = "VeryLazy",
        dependencies = {'https://github.com/nvim-tree/nvim-web-devicons'},
        config = function()
            local conditions = {
                buffer_not_empty = function()
                    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
                end,
                hide_in_width = function()
                    return vim.fn.winwidth(0) > 80
                end,
                check_git_workspace = function()
                    local filepath = vim.fn.expand('%:p:h')
                    local gitdir = vim.fn.finddir('.git', filepath .. ';')
                    return gitdir and #gitdir > 0 and #gitdir < #filepath
                end
            }

            local colors = {
                red = '#ff0167',
                grey = '#949494',
                black = '#1c1c1c',
                white = '#f3f3f3',
                green = '#22bac5',
                orange = '#f39e8c',
                yellow = '#ecbe7b',
                cyan = '#334040',
                violet = '#dc69aa'
            }

            local theme = {
                normal = {
                    a = {fg = colors.violet, bg = colors.cyan},
                    b = {bg = colors.black},
                    c = {fg = colors.violet, bg = colors.cyan},
                    x = {fg = colors.violet, bg = colors.cyan},
                    y = {fg = colors.violet, bg = colors.cyan},
                    z = {fg = colors.violet, bg = colors.cyan}
                },
                insert = {
                    a = {fg = colors.cyan, bg = colors.violet},
                    b = {bg = colors.black},
                    c = {fg = colors.cyan, bg = colors.violet}
                },
                visual = {
                    a = {fg = colors.white, bg = colors.orange},
                    b = {bg = colors.black},
                    c = {fg = colors.white, bg = colors.orange}
                },
                replace = {
                    a = {fg = colors.white, bg = colors.red},
                    b = {bg = colors.black},
                    c = {fg = colors.white, bg = colors.red}
                }
            }

            local empty = require('lualine.component'):extend()
            function empty:draw(default_highlight)
                self.status = ''
                self.applied_separator = ''
                self:apply_highlights(default_highlight)
                self:apply_section_separators()
                return self.status
            end

            local function process_sections(sections)
                for name, section in pairs(sections) do
                    local left = name:sub(9, 10) < 'x'
                    for pos = 1, name ~= 'lualine_z' and #section or #section -
                        1 do
                        table.insert(section, pos * 2, {
                            empty,
                            color = {fg = colors.red, bg = colors.black}
                        })
                    end
                    for id, comp in ipairs(section) do
                        if type(comp) ~= 'table' then
                            comp = {comp}
                            section[id] = comp
                        end
                        comp.separator =
                            left and {right = ''} or {left = ''}
                    end
                end
                return sections
            end

            local function search_result()
                if vim.v.hlsearch == 0 then return '' end
                local last_search = vim.fn.getreg('/')
                if not last_search or last_search == '' then
                    return ''
                end
                local searchcount = vim.fn.searchcount {maxcount = 9999}
                return last_search .. ' (' .. searchcount.current .. '/' ..
                           searchcount.total .. ')'
            end

            require('lualine').setup({
                options = {
                    theme = theme,
                    component_separators = '',
                    section_separators = {left = '', right = ''}
                },
                extensions = {
                    'aerial', 'fugitive', 'fzf', 'lazy', 'man', 'neo-tree',
                    'overseer', 'quickfix', 'trouble'
                },
                tabline = {
                    lualine_a = {'filename'},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {'tabs'}
                },
                sections = process_sections {
                    lualine_a = {
                        {
                            'branch',
                            icon = '',
                            condition = conditions.check_git_workspace,
                            color = {gui = 'bold'}
                        }
                    },
                    lualine_b = {
                        {
                            'diff',
                            symbols = {
                                added = ' ',
                                modified = '柳',
                                removed = ' '
                            },
                            color_added = colors.green,
                            color_modified = colors.orange,
                            color_removed = colors.red,
                            condition = conditions.hide_in_width
                        }
                    },
                    lualine_c = {
                        {
                            function()
                                local msg = 'No Active Lsp'
                                local buf_ft =
                                    vim.api.nvim_buf_get_option(0, 'filetype')
                                local clients = vim.lsp.get_active_clients()

                                if next(clients) == nil then
                                    return msg
                                end

                                for _, client in ipairs(clients) do
                                    local filetypes = client.config.filetypes
                                    if filetypes and
                                        vim.fn.index(filetypes, buf_ft) ~= -1 then
                                        return client.name
                                    end
                                end

                                return msg
                            end,
                            icon = '  LSP:',
                            color = {gui = 'bold'}
                        }, {
                            'diagnostics',
                            sources = {'nvim_diagnostic'},
                            symbols = {
                                error = ' ',
                                warn = ' ',
                                info = ' '
                            },
                            color_error = colors.red,
                            color_warn = colors.yellow,
                            color_info = colors.cyan
                        }
                    },
                    lualine_x = {
                        {
                            search_result,
                            color = {fg = colors.white, bg = colors.red}
                        }
                    },
                    lualine_y = {},
                    lualine_z = {
                        {
                            'filename',
                            condition = conditions.buffer_not_empty,
                            color = {gui = 'bold'},
                            file_status = true,
                            path = 1
                        },
                        {'filetype', color = {bg = colors.black, gui = 'bold'}},
                        '%l:%c ┉ %p%% ┉ LL:%L'
                    }
                },
                inactive_sections = {lualine_c = {'%f %y %m'}, lualine_x = {}}
            })
        end
    }, {
        "https://github.com/folke/trouble.nvim",
        dependencies = "https://github.com/nvim-tree/nvim-web-devicons",
        cmd = {"TroubleToggle", "Trouble"},
        opts = {auto_close = true, use_diagnostic_signs = true},
        keys = {
            vim.keymap.set('n', '<Leader>xx',
                           '<cmd>TroubleToggle document_diagnostics<cr>',
                           {silent = true, noremap = true})
        }
    }, {
        "https://github.com/folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true
                }
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = true
            }
        },
        dependencies = {
            "https://github.com/MunifTanjim/nui.nvim",
            "https://github.com/rcarriga/nvim-notify"
        }
    }, {
        "https://github.com/rcarriga/nvim-notify",
        opts = {
            timeout = 1000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end
        }
    }, {
        'https://github.com/tzachar/highlight-undo.nvim',
        config = function()
            require('highlight-undo').setup({duration = 2000})
        end
    }
}, {checker = {enabled = false}, rtp = {disabled_plugins = {"netrwPlugin"}}})

--  ____ ____ ____ ____ ____ ____  ____ ____ ___
-- ||f |||u |||n |||c |||t |||i |||o |||n |||s ||
-- ||__|||__|||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

local function augroup(name)
    return vim.api.nvim_create_augroup("devinnvim_" .. name, {clear = true})
end

vim.api.nvim_create_autocmd("CursorHold", {
    group = augroup("show_diagnostics"),
    callback = function()
        local opts = {
            focusable = false,
            close_events = {
                "BufLeave", "CursorMoved", "InsertEnter", "FocusLost"
            },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor'
        }

        local _, winnr = vim.diagnostic.open_float(nil, opts)
        if winnr then vim.api.nvim_win_set_option(winnr, "winblend", 10) end
    end
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function() vim.highlight.on_yank({timeout = 250}) end
})

vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup("no_terminal_numbers"),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end
})

vim.api.nvim_create_autocmd("TermClose", {
    group = augroup("terminal_exit_status"),
    callback = function()
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true)
    end
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+://") then return end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end
})

-- === vim-test ===
vim.cmd([[
function! NeoSplit(cmd) abort
  let opts = {'suffix': ' # vim-test'}
  function! opts.close_terminal()
    if bufnr(self.suffix) != -1
      execute 'bdelete!' bufnr(self.suffix)
    end
  endfunction

  call opts.close_terminal()

  split new

  call termopen(a:cmd . opts.suffix, opts)
  au BufDelete <buffer> wincmd p
  stopinsert
endfunction

let g:test#custom_strategies = {'neosplit': function('NeoSplit')}
let g:test#strategy = 'neosplit'
let test#ruby#rspec#executable = 'docker-compose exec app bundle exec rspec'
]])

-- === debugging ===
vim.g.loaded_pry = 1
vim.g.debug_map = {
    ['ruby'] = 'require "pry"; binding.pry',
    ['javascript'] = 'debugger;',
    ['typescript'] = 'debugger;',
    ['javascriptreact'] = 'debugger;',
    ['typescriptreact'] = 'debugger;',
    ['python'] = 'import ipdb; ipdb.set_trace()'
}

vim.cmd([[
function! InsertDebug()
  if has_key(g:debug_map, &filetype)
    let text = get(g:debug_map, &filetype)
    call feedkeys('o', 'i')
    call feedkeys(text)
    call feedkeys("\<Esc>")
  endif
endfunction
]])

--  ____ ____ ____ ____
-- ||m |||a |||p |||s ||
-- ||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|

-- === zoom a vim pane ===
vim.keymap.set('n', '<Leader>-', ':wincmd _<CR>:wincmd |<CR>', {noremap = true})
vim.keymap.set('n', '<Leader>=', ':wincmd =<CR>', {noremap = true})

-- === terminal mappings ===
vim.keymap.set('t', '<C-w>h', '<C-\\><C-n><C-w>h', {noremap = true})
vim.keymap.set('t', '<C-w>j', '<C-\\><C-n><C-w>j', {noremap = true})
vim.keymap.set('t', '<C-w>k', '<C-\\><C-n><C-w>k', {noremap = true})
vim.keymap.set('t', '<C-w>l', '<C-\\><C-n><C-w>l', {noremap = true})
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {noremap = true})
vim.keymap.set('t', '<A-[>', '<Esc><Esc>', {noremap = true})
vim.keymap.set('t', '<C-w>-', '<C-\\><C-n>:sp<CR>:terminal<CR>i',
               {noremap = true})
vim.keymap.set('t', '<C-w>\\', '<C-\\><C-n>:vsp<CR>:terminal<CR>i',
               {noremap = true})
vim.keymap.set('n', '<C-w>-', ':20sp<CR>:terminal<CR>i', {noremap = true})
vim.keymap.set('n', '<C-w>\\', ':vsp<CR>:terminal<CR>i', {noremap = true})
vim.keymap.set('n', '<C-w>c', ':tabnew<CR>:terminal<CR>i', {noremap = true})

-- === Move up and down by visible lines if current line is wrapped ===
vim.keymap.set({"n", "x"}, "j", "v:count == 0 ? 'gj' : 'j'",
               {expr = true, silent = true})
vim.keymap.set({"n", "x"}, "k", "v:count == 0 ? 'gk' : 'k'",
               {expr = true, silent = true})

-- === add current word under cursor to :%s ===
vim.keymap.set('n', '<Leader>n', ':%s/\\(<c-r>=expand("<cword>")<CR>\\)/',
               {noremap = true})

-- === Pre-populate a split command with the current directory ===
vim.keymap.set('n', '<Leader>e', ':vsp <C-r>=expand("%:p:h") . "/" <CR><C-d>',
               {noremap = true})
vim.keymap.set('n', '<Leader>mv',
               ':!mv % <C-r>=expand("%:p:h") . "/" <CR><C-d>', {noremap = true})
vim.keymap.set('n', '<Leader>cp',
               ':!cp % <C-r>=expand("%:p:h") . "/" <CR><C-d>', {noremap = true})

-- === debugging ===
vim.keymap.set('n', '<Leader>d', ':call InsertDebug()<CR>', {noremap = true})

-- === better indenting ===
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
