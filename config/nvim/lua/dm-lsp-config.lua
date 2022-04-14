local coq = require 'coq'
local lsp = require 'lspconfig'
local null_ls = require("null-ls")

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
  cmd = { 'docker-compose', 'exec', '-T', 'app', 'solargraph', 'stdio' },
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false,
    require 'illuminate'.on_attach(client)
  end,
  settings = {
    solargraph = {
      diagnostics = false
    }
  }
})

lsp.tsserver.setup(coq.lsp_ensure_capabilities{
  init_options = require('nvim-lsp-ts-utils').init_options,
  on_attach = function(client, bufnr)
    require 'illuminate'.on_attach(client)

    local ts_utils = require('nvim-lsp-ts-utils')

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

-- lsp.tailwindcss.setup(coq.lsp_ensure_capabilities{
--   on_attach = function(client)
--     require 'illuminate'.on_attach(client)
--   end
-- })

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

local null_ls_sources = {
  null_ls.builtins.code_actions.eslint_d,
  null_ls.builtins.diagnostics.eslint_d,
  null_ls.builtins.formatting.eslint_d,
  null_ls.builtins.formatting.prettierd,
  null_ls.builtins.code_actions.refactoring,
  null_ls.builtins.diagnostics.rubocop,
  null_ls.builtins.formatting.rubocop,
  null_ls.builtins.code_actions.shellcheck,
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.diagnostics.stylelint,
  null_ls.builtins.formatting.stylelint
}
null_ls.register(null_ls_sources)
