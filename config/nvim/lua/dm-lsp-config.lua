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
    client.server_capabilities.documentFormattingProvider = false,
    require 'illuminate'.on_attach(client)
  end,
  settings = {
    solargraph = {
      diagnostics = false
    }
  }
})

lsp.tsserver.setup(coq.lsp_ensure_capabilities{
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
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
  null_ls.builtins.diagnostics.hadolint,
  null_ls.builtins.diagnostics.haml_lint,
  null_ls.builtins.diagnostics.jsonlint,
  null_ls.builtins.formatting.prettierd,
  null_ls.builtins.code_actions.refactoring,
  null_ls.builtins.diagnostics.rubocop,
  null_ls.builtins.formatting.rubocop,
  null_ls.builtins.code_actions.shellcheck,
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.diagnostics.stylelint,
  null_ls.builtins.diagnostics.yamllint,
}

null_ls.register(null_ls_sources)
