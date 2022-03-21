require'nvim-treesitter.configs'.setup {
  ensure_installed = {
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
    enable = true
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
}
