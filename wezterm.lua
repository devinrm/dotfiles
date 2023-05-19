local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}
config = wezterm.config_builder()

config = {
  colors = {
    tab_bar = {
      active_tab = {
        bg_color = '#dc69aa',
        fg_color = '#1e1e1e',
      }
    }
  },
  color_scheme = 'GitHub Dark',
  enable_scroll_bar = false,
  enable_tab_bar = true,
  font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" }),
  font_size = 14.0,
  hide_tab_bar_if_only_one_tab = true,
  scrollback_lines = 100000,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = true,
  underline_position = "-3pt",
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  window_frame = {
    active_titlebar_bg = '#1e1e1e',
    inactive_titlebar_bg = '#1e1e1e',
  },
  window_padding = {
    bottom = '0',
    left = 0,
    right = 0,
    top = 0,
  },
  leader = { key = 's', mods = 'CTRL', timeout_milliseconds = 2000 },
  keys = {
    {
      key = '[',
      mods = 'LEADER',
      action = act.ActivateCopyMode,
    },
    {
      key = 'h',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'l',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Right',
    },
    {
      key = 'k',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'j',
      mods = 'LEADER',
      action = act.ActivatePaneDirection 'Down',
    },
    {
      key = 'LeftArrow',
      mods = 'SHIFT',
      action = act.AdjustPaneSize { 'Left', 1 },
    },
    {
      key = 'DownArrow',
      mods = 'SHIFT',
      action = act.AdjustPaneSize { 'Down', 1 },
    },
    {
      key = 'UpArrow',
      mods = 'SHIFT',
      action = act.AdjustPaneSize { 'Up', 1 },
    },
    {
      key = 'RightArrow',
      mods = 'SHIFT',
      action = act.AdjustPaneSize { 'Right', 1 },
    },
    {
      key = 'r',
      mods = 'LEADER',
      action = act.ReloadConfiguration,
    },
    {
      key = 'f',
      mods = 'LEADER',
      action = act.ShowLauncherArgs {
        flags = 'FUZZY|WORKSPACES',
      },
    },
    {
      key = 'c',
      mods = 'LEADER',
      action = act.SpawnTab 'CurrentPaneDomain',
    },
    {
      key = '\\',
      mods = 'LEADER',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '-',
      mods = 'LEADER',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
  },
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
    },
  },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = act.ActivateTab(i - 1),
  })
end

return config;
