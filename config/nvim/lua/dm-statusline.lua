-- local noirbuddy_lualine = require('noirbuddy.plugins.lualine')

local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end
}

local colors = {
  red = '#ff005c',
  grey = '#949494',
  black = '#1c1c1c',
  white = '#f3f3f3',
  green = '#7cb0b0',
  orange = '#ff9400',
  yellow = '#ECBE7B',
  cyan = '#334040',
  violet = '#5f5f8a',
}

local theme = {
  normal = {
    a = { fg = colors.violet, bg = colors.cyan },
    b = { bg = colors.black },
    c = { fg = colors.violet, bg = colors.cyan },
    x = { fg = colors.violet, bg = colors.cyan },
    y = { fg = colors.violet, bg = colors.cyan },
    z = { fg = colors.violet, bg = colors.cyan },
  },
  insert = {
    a = { fg = colors.cyan, bg = colors.violet },
    b = { bg = colors.black },
    c = { fg = colors.cyan, bg = colors.violet },
  },
  visual = {
    a = { fg = colors.white, bg = colors.orange },
    b = { bg = colors.black },
    c = { fg = colors.white, bg = colors.orange },
  },
  replace = {
    a = { fg = colors.white, bg = colors.red },
    b = { bg = colors.black },
    c = { fg = colors.white, bg = colors.red },
  },
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
    for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
      table.insert(section, pos * 2, { empty, color = { fg = colors.red, bg = colors.black } })
    end
    for id, comp in ipairs(section) do
      if type(comp) ~= 'table' then
        comp = { comp }
        section[id] = comp
      end
      comp.separator = left and { right = '' } or { left = '' }
    end
  end
  return sections
end

local function search_result()
  if vim.v.hlsearch == 0 then
    return ''
  end
  local last_search = vim.fn.getreg('/')
  if not last_search or last_search == '' then
    return ''
  end
  local searchcount = vim.fn.searchcount { maxcount = 9999 }
  return last_search .. ' (' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

require('lualine').setup({
  options = {
    -- theme = noirbuddy_lualine.theme,
    theme = theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = process_sections {
    lualine_a = {
      {
        'branch',
        icon = '',
        condition = conditions.check_git_workspace,
        color = { gui = 'bold' }
      }
    },
    lualine_b = {
      {
        'diff',
        symbols = { added = ' ', modified = '柳', removed = ' ' },
        color_added = colors.green,
        color_modified = colors.orange,
        color_removed = colors.red,
        condition = conditions.hide_in_width
      },
    },
    lualine_c = {
      {
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
        icon = '  LSP:',
        color = { gui = 'bold' },
      },
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
        color_error = colors.red,
        color_warn = colors.yellow,
        color_info = colors.cyan
      },
    },
    lualine_x = {
      { search_result, color = { fg = colors.white, bg = colors.red } },
    },
    lualine_y = {},
    lualine_z = {
      {
        'filename',
        condition = conditions.buffer_not_empty,
        color = { gui = 'bold' },
        file_status = true,
        path = 1,
      },
      { 'filetype', color = { bg = colors.black, gui = 'bold' } },
      '%l:%c / %p%% / LL:%L'
    },
  },
  inactive_sections = {
    lualine_c = { '%f %y %m' },
    lualine_x = {},
  },
})
