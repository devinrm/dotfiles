local lsp = require 'lspconfig'
local coq = require 'coq'

lsp.cssls.setup(coq.lsp_ensure_capabilities{
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.html.setup(coq.lsp_ensure_capabilities{
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.pyright.setup(coq.lsp_ensure_capabilities{
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.solargraph.setup(coq.lsp_ensure_capabilities{
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.tsserver.setup(coq.lsp_ensure_capabilities{
  init_options = require("nvim-lsp-ts-utils").init_options,
  on_attach = function(client, bufnr)
    require 'illuminate'.on_attach(client)

    local ts_utils = require("nvim-lsp-ts-utils")

    ts_utils.setup({
      debug = false,
      disable_commands = false,
      enable_import_on_completion = false,

      import_all_timeout = 5000,
      import_all_priorities = {
        same_file = 1, -- add to existing import statement
        local_files = 2, -- git files or files with relative path markers
        buffer_content = 3, -- loaded buffer content
        buffers = 4, -- loaded buffer names
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,

      filter_out_diagnostics_by_severity = {},
      filter_out_diagnostics_by_code = {},

      auto_inlay_hints = true,
      inlay_hints_highlight = "Comment",

      update_imports_on_move = false,
      require_confirmation_on_move = false,
      watch_dir = nil,
    })

    ts_utils.setup_client(client)

    local opts = { silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "tlo", ":TSLspOrganize<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "tlr", ":TSLspRenameFile<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "tli", ":TSLspImportAll<CR>", opts)
  end
})

lsp.tailwindcss.setup(coq.lsp_ensure_capabilities{
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.jsonls.setup(coq.lsp_ensure_capabilities{
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
})

lsp.stylelint_lsp.setup(coq.lsp_ensure_capabilities{
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.diagnosticls.setup(coq.lsp_ensure_capabilities{
  filetypes = {
    'javascript',
    'javascriptreact',
    'python',
    'ruby',
    'sh',
    'typescript',
    'typescriptreact',
  },
  init_options = {
    linters = {
      eslint = {
        command = 'eslint_d',
        rootPatterns = { '.git' },
        debounce = 100,
        args = {
          '--cache',
          '--stdin',
          '--stdin-filename',
          '%filepath',
          '--format',
          'json'
        },
        sourceName = 'eslint',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
      flake8 = {
        command = 'flake8',
        debounce = 100,
        args = { '--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s, -' },
        offsetLine = 0,
        offsetColumn = 0,
        sourceName = 'flake8',
        formatLines = 1,
        formatPattern = {
          '(\\d+),(\\d+),([A-Z]),(.*)(\\r|\\n)*$',
          {
            line = 1,
            column = 2,
            security = 3,
            message = 4
          }
        },
        securities = {
          W = 'warning',
          E = 'error',
          F = 'error',
          C = 'error',
          N = 'error',
        }
      },
      pylint = {
        sourceName = 'pylint',
        command = 'pylint',
        args = {
          '--output-format',
          'text',
          '--score',
          'no',
          '--msg-template',
          '"{line}:{column}:{category}:{msg} ({msg_id}:{symbol})"',
          '%file'
        },
        formatPattern = {
          '^(\\d+?):(\\d+?):([a-z]+?):(.*)$',
          {
            line = 1,
            column = 2,
            security = 3,
            message = 4
          }
        },
        rootPatterns = {'.git', 'pyproject.toml', 'setup.py'},
        securities = {
          informational = 'hint',
          refactor = 'info',
          convention = 'info',
          warning = 'warning',
          error = 'error',
          fatal = 'error'
        },
        offsetColumn = 1,
        formatLines = 1
      },
      rubocop = {
        command = 'bundle',
        sourceName = 'rubocop',
        rootPatterns = { '.git' },
        debounce = 100,
        args = {
          'exec',
          'rubocop',
          '--format',
          'json',
          '--force-exclusion',
          '--stdin',
          '%filepath'
        },
        parseJson = {
          errorsRoot = 'files[0].offenses',
          line = 'location.start_line',
          endLine = 'location.last_line',
          column = 'location.start_column',
          endColumn = 'location.end_column',
          message = '[${cop_name}] ${message}',
          security = 'severity'
        },
        securities = {
          fatal = 'error',
          error = 'error',
          warning = 'warning',
          convention = 'info',
          refactor = 'info',
          info = 'info'
        }
      },
      shellcheck = {
        command = 'shellcheck',
        debounce = 100,
        args = {
          '--format',
          'json',
          '-'
        },
        sourceName = 'shellcheck',
        parseJson = {
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '${message} [${code}]',
          security = 'level'
        },
        securities = {
          error = 'error',
          warning = 'warning',
          info = 'info',
          style = 'hint'
        }
      }
    },
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      python = { 'pylint', 'flake8' },
      ruby = 'rubocop',
      sh = 'shellcheck',
      typescript = 'eslint',
      typescriptreact = 'eslint',
    },
    formatters = {
      prettier = {
        command = 'prettier',
        args = { '--stdin-filepath', '%filename' }
      },
      yapf = {
        command = 'yapf',
        args = { '--quiet' },
      },
      isort = {
        command = 'isort',
        args = { '--quiet', '-' }
      },
    },
    formatFiletypes = {
      css = 'prettier',
      javascript = 'prettier',
      javascriptreact = 'prettier',
      json = 'prettier',
      python = { 'yapf', 'isort' },
      ruby = 'rubocop',
      scss = 'prettier',
      typescript = 'prettier',
      typescriptreact = 'prettier'
    }
  }
})
