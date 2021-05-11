local galaxy_line = require('galaxyline')

local colors = {
  bg              = '#25272c',

  giticon         = '#8f6ead',
  gitbg           = '#25272c',
  gittext         = '#666666',

  diagerror       = '#F44747',
  diagwarn        = '#FF8800',
  diaghint        = '#4FC1FF',
  diaginfo        = '#FFCC66',

  lspicon         = '#8f6ead',
  lspbg           = '#25272c',
  lsptext         = '#666666',

  typeicon        = '#8f6ead',
  typebg          = '#25272c',
  typetext        = '#666666',

  statsicon       = '#8f6ead',
  statsbg         = '#25272c',
  statstext       = '#666666',

  shortbg         = '#25272c',
  shorttext       = '#666666',

  shortrighttext  = '#7C4C4E',

  red             = '#D16969',
  green           = '#608B4E',
  blue            = '#8f6ead',
}

local bracket = "░"
local galaxy_line_section = galaxy_line.section
local condition = require('galaxyline.condition')

local increment_section = 1

increment_section = increment_section + 1
galaxy_line_section.left[increment_section] = {
  GitMid = {
    provider = function() return bracket .. ' ' end,
    condition = condition.check_git_workspace,
    highlight = {colors.giticon, colors.gitbg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.left[increment_section] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE', colors.gitbg},
    highlight = {colors.gittext, colors.gitbg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.left[increment_section] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.check_git_workspace,
    icon = '  ',
    highlight = {colors.green, colors.gitbg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.left[increment_section] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.check_git_workspace,
    icon = '  ',
    highlight = {colors.blue, colors.gitbg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.left[increment_section] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.check_git_workspace,
    icon = '  ',
    highlight = {colors.red, colors.gitbg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.left[increment_section] = {
  EndGit = {
    provider = function() return bracket end,
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = {colors.gitbg, colors.bg},
    highlight = {colors.gitbg, colors.bg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.left[increment_section] = {
  LspIcon = {
    provider = function()
        local name = ""

        if galaxy_line.lspclient ~= nil then
            name = galaxy_line.lspclient()
        end

        return name
    end,
    highlight = {colors.lspbg, colors.lspicon}
  }
}

increment_section = increment_section + 1
galaxy_line_section.left[increment_section] = {
  LspMid = {
    provider = function() return bracket .. ' ' end,
    highlight = {colors.lspicon, colors.lspbg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.left[increment_section] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    highlight = {colors.textbg, colors.lspbg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.left[increment_section] = {
  LspSpace4 = {
    provider = function() return ' ' end,
    highlight = {colors.lspicon, colors.lspbg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.left[increment_section] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    separator_highlight = {colors.gitbg, colors.bg},
    highlight = {colors.diagerror, colors.lspbg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.left[increment_section] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.diagwarn, colors.lspbg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.left[increment_section] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {colors.diaghint, colors.lspbg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.left[increment_section] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.diaginfo, colors.lspbg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.left[increment_section] = {
  LspSectionEnd = {
    provider = function() return bracket .. " " end,
    highlight = {colors.lspbg, colors.bg}
  }
}

increment_section = 1

increment_section = increment_section + 1
galaxy_line_section.right[increment_section] = {
  TypeMid = {
    provider = function() return bracket .. ' ' end,
    highlight = {colors.typeicon, colors.typebg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.right[increment_section] = {
  FileName = {
    provider = 'FilePath',
    separator_highlight = {'NONE', colors.typebg},
    highlight = {colors.typetext, colors.typebg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.right[increment_section] = {
  FileSize = {
    provider = 'FileSize',
    separator = ' ',
    separator_highlight = {colors.typeicon, colors.typebg},
    highlight = {colors.typetext, colors.typebg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.right[increment_section] = {
  FileIcon = {
    provider = 'FileIcon',
    highlight = {colors.typeicon, colors.typebg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.right[increment_section] = {
  BufferType = {
    provider = 'FileTypeName',
    highlight = {colors.typetext, colors.typebg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.right[increment_section] = {
  Space = {
    provider = function() return ' ' end,
    highlight = {colors.typebg, colors.bg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.right[increment_section] = {
  VerticalPosAndSize = {
    provider = function()
        return vim.fn.line('.') .. "/" .. vim.fn.line('$')
    end,
    separator = '⇕ ',
    separator_highlight = {colors.statsicon, colors.statsbg},
    highlight = {colors.statstext, colors.statsbg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.right[increment_section] = {
  StatsSpcSectionEnd = {
    provider = function() return bracket .. " " end,
    highlight = {colors.statsbg, colors.bg}
  }
}

increment_section = 1
galaxy_line_section.short_line_left[increment_section] = {
  ShortSectionStart = {
    provider = function() return bracket end,
    highlight = {colors.shortbg, colors.bg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.short_line_left[increment_section] = {
  ShortSectionSpace = {
    provider = function() return " "  end,
    highlight = {colors.shorttext, colors.shortbg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.short_line_left[increment_section] = {
  LeftShortName = {
    provider = 'FileTypeName',
    highlight = {colors.shorttext, colors.shortbg},
  }
}

increment_section = increment_section + 1
galaxy_line_section.short_line_left[increment_section] = {
  ShortSectionMid = {
    provider = function() return " " end,
    highlight = {colors.shortbg, colors.shortbg}
  }
}

increment_section = increment_section + 1
galaxy_line_section.short_line_left[increment_section] = {
  LeftShortFileName = {
    provider = 'SFileName',
    condition = condition.buffer_not_empty,
    separator_highlight = {colors.shorttext, colors.shortbg},
    highlight = {colors.shorttext, colors.shortbg},
  }
}

increment_section = increment_section + 1
galaxy_line_section.short_line_left[increment_section] = {
  ShortSectionEnd = {
    provider = function() return bracket end,
    highlight = {colors.shortbg, colors.bg}
  }
}

increment_section = 1
galaxy_line_section.short_line_right[increment_section] = {
  BufferIcon = {
    provider = 'BufferIcon',
    separator_highlight = {colors.shorttext, colors.bg},
    highlight = {colors.shortrighttext, colors.bg}
  }
}
