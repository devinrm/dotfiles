require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "css",
    "javascript",
    "json",
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
  }
}
