local lsp = require('lspconfig')
local null_ls = require('null-ls')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local cmp = require('cmp')
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local luasnip = require("luasnip")

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
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'copilot', group_index = 2 },
    { name = 'nvim_lua' }
  }, {
    { name = 'buffer' },
    { name = 'path' }
  })
})

lsp.astro.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
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
      diagnostics = false
    }
  }
})

lsp.sqlls.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end
})

lsp.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = function(client)
    require 'illuminate'.on_attach(client)
  end,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
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

local null_ls_sources = {
  null_ls.builtins.code_actions.eslint_d.with({
    extra_filetypes = { "astro" }
  }),
  null_ls.builtins.diagnostics.eslint_d.with({
    extra_filetypes = { "astro" }
  }),
  null_ls.builtins.diagnostics.hadolint,
  null_ls.builtins.diagnostics.haml_lint,
  null_ls.builtins.diagnostics.jsonlint,
  null_ls.builtins.formatting.prettierd.with({
    extra_filetypes = { "astro" }
  }),
  null_ls.builtins.formatting.eslint_d.with({
    extra_filetypes = { "astro" }
  }),
  null_ls.builtins.code_actions.refactoring,
  null_ls.builtins.diagnostics.rubocop,
  null_ls.builtins.formatting.rubocop,
  null_ls.builtins.formatting.rustywind.with({
    extra_filetypes = { "erb" }
  }),
  null_ls.builtins.code_actions.shellcheck,
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.diagnostics.stylelint,
  null_ls.builtins.diagnostics.yamllint,
}

null_ls.register(null_ls_sources)
