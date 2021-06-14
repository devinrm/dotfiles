-- require'lspconfig'.cssls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.solargraph.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.jsonls.setup {
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}
require'lspconfig'.stylelint_lsp.setup {}
require'lspconfig'.diagnosticls.setup{
  filetypes = {
    'javascript',
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
      python = 'pylint',
      ruby = 'rubocop',
      sh = 'shellcheck',
      typescript = 'eslint',
      typescriptreact = 'eslint',
    },
    formatters = {
      prettierEslint = {
        command = 'prettier-eslint',
        args = { '--stdin' },
        rootPatterns = { '.git' },
      },
      prettier = {
        command = 'prettier',
        args = { '--stdin-filepath', '%filename' }
      }
    },
    formatFiletypes = {
      css = 'prettier',
      javascript = 'prettierEslint',
      javascriptreact = 'prettierEslint',
      json = 'prettier',
      python = 'pylint',
      scss = 'prettier',
      typescript = 'prettierEslint',
      typescriptreact = 'prettierEslint'
    }
  }
}
