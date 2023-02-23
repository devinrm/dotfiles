local lsp = require('lspconfig')
local null_ls = require('null-ls')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local cmp = require('cmp')
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end
local luasnip = require("luasnip")



-- local lsp_formatting = function(bufnr)
--   vim.lsp.buf.format({
--     filter = function(client)
--       -- apply whatever logic you want (in this example, we'll only use null-ls)
--       return client.name == "null-ls"
--     end,
--     bufnr = bufnr,
--   })
-- end

-- -- if you want to set up formatting on save, you can use this as a callback
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- -- add to your shared on_attach callback
-- local on_attach = function(client, bufnr)
--   if client.supports_method("textDocument/formatting") then
--     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       group = augroup,
--       buffer = bufnr,
--       callback = function()
--         lsp_formatting(bufnr)
--       end,
--     })
--   end
-- end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs( -4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ['<Tab>'] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
    ['<S-Tab>'] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
  }),
  sources = cmp.config.sources({
    { name = 'copilot',  group_index = 2 },
    { name = 'nvim_lsp', group_index = 2 },
    { name = 'luasnip',  group_index = 2 },
    { name = 'nvim_lua', group_index = 2 },
    { name = 'buffer', group_index = 2 },
    { name = 'path',   group_index = 2 }
  })
})

lsp.bashls.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.codeqlls.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.cssls.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.dockerls.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.graphql.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.html.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.jsonls.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end,
  commands = {
    Format = {
      function()
        vim.lsp.formatexpr({}, { 0, 0 }, { vim.fn.line("$"), 0 })
      end
    }
  }
})

lsp.marksman.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.pyright.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.solargraph.setup({
  capabilities = capabilities,
  cmd = { 'docker-compose', 'exec', '-T', 'app', 'solargraph', 'stdio' },
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
  settings = {
    solargraph = {
      formatting = false,
      completion = true,
      diagnostics = false,
      references = true,
      rename = true,
      symbols = true,
      useLibraryCode = true
    }
  }
})

lsp.sqlls.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.lua_ls.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

lsp.tailwindcss.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

require('typescript').setup({
  capabilities = capabilities,
  server = {
    on_attach = function(client)
      require 'illuminate'.on_attach(client)
    end,
  }
})

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,
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
    null_ls.builtins.diagnostics.stylelint,
    null_ls.builtins.diagnostics.yamllint
  }
})
