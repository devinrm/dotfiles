local wezterm = require 'wezterm'

return {
  font = wezterm.font("BlexMono Nerd Font", { weight = "Medium" }),
  font_size = 14.0,
  color_scheme = "Slate",
  enable_scroll_bar = false,
  enable_tab_bar = false,
  use_fancy_tab_bar = false,
  window_decorations = "RESIZE",
  window_padding = {
    left = 0,
    right = 0,
  },
  underline_position = "-3pt",
  -- leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
  -- keys = {
  --   {
  --     key = '\\',
  --     mods = 'LEADER|SHIFT',
  --     action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  --   },
  --   -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  --   {
  --     key = 'a',
  --     mods = 'LEADER|CTRL',
  --     action = wezterm.action.SendString '\x01',
  --   },
  -- },
}
