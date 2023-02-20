local wezterm = require 'wezterm'

return {
  font = wezterm.font("BlexMono Nerd Font"),
  font_size = 14.0,
  -- color_scheme = "Laser",
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
}
