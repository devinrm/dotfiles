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
    top = 0,
    bottom = 0,
  },
  underline_position = "-3pt"
}
