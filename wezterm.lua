local wezterm = require 'wezterm'

return {
  font = wezterm.font("BlexMono Nerd Font", { weight = "Medium" }),
  font_size = 14.0,
  color_scheme = "Slate",
  enable_scroll_bar = false,
  enable_tab_bar = false,
  use_fancy_tab_bar = true,
  window_decorations = "RESIZE",
  window_padding = {
    left = 0,
    right = 0,
  },
  underline_position = "-3pt",
  -- leader = { key = 's', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = {
    -- {
      -- key = 's',
      -- mods = 'LEADER|CTRL',
      -- action = wezterm.action.SendString '\x01',
    -- },
    -- {
      -- key = '\\',
      -- mods = 'CMD',
      -- action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    -- },
    -- {
      -- key = '-',
      -- mods = 'CMD',
      -- action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    -- },
    -- { key = 'f', mods = 'LEADER', action = wezterm.action.SwitchToWorkspace },
    -- {
      -- key = 'n',
      -- mods = 'LEADER',
      -- action = wezterm.action.ShowLauncherArgs {
        -- flags = 'FUZZY|WORKSPACES',
      -- },
    -- },
  },
}
