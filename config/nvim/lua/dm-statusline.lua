local lualine = require 'lualine'

local colors = {
  bg = '#121212',
  fg = '#bbc2cf',
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#00b2b1',
  orange = '#FF8800',
  violet = '#d0d0d0',
  magenta = '#b685ff',
  blue = '#76a8f9',
  red = '#ff4e86'
}

local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,

  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end
}

local config = {
  options = {
    component_separators = "░",
    section_separators = "░",
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } }
    }
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_v = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {}
  }
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function() return '▊' end,

  color = { fg = colors.blue }, -- Sets highlighting of component
  left_padding = 0
}

ins_left {
  function()
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red
    }

    vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg)

    return "rock 'n roll"
  end,

  color = "LualineMode",
  left_padding = 0
}

ins_left {
  'branch',
  icon = '',
  condition = conditions.check_git_workspace,
  color = { fg = colors.violet, gui = 'bold' }
}

ins_left {
  'diff',
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  color_added = colors.green,
  color_modified = colors.orange,
  color_removed = colors.red,
  condition = conditions.hide_in_width
}

ins_left {
  'filename',
  condition = conditions.buffer_not_empty,
  color = { fg = colors.blue, gui = 'bold' },
  path = 1,
}

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  color_error = colors.red,
  color_warn = colors.yellow,
  color_info = colors.cyan
}

ins_left { function() return '%=' end }

ins_left {
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()

    if next(clients) == nil then return msg end

    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end

    return msg
  end,

  icon = ' LSP:',
  color = { fg = '#ffffff', gui = 'bold' }
}

ins_right {
  'filetype',
  color = { fg = colors.blue, gui = 'bold' }
}

ins_right {
  'o:encoding',
  upper = true,
  condition = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' }
}

ins_right {
  'fileformat',
  upper = true,
  icons_enabled = true,
  color = { fg = colors.green, gui = 'bold' }
}

ins_right {
  function()
    local function format_file_size(file)
      local size = vim.fn.getfsize(file)

      if size <= 0 then return '' end

      local sufixes = { 'b', 'k', 'm', 'g' }
      local i = 1

      while size > 1024 do
        size = size / 1024
        i = i + 1
      end

      return string.format('%.1f%s', size, sufixes[i])
    end

    local file = vim.fn.expand('%:p')

    if string.len(file) == 0 then return '' end

    return format_file_size(file)
  end,

  condition = conditions.buffer_not_empty
}

ins_right { 'location' }

ins_right { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_right {
  function() return '▊' end,

  color = { fg = colors.blue },
  right_padding = 0
}

lualine.setup(config)
