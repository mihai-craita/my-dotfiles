local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Font configuration
config.font = wezterm.font('JetBrains Mono', { weight = 'Regular' })
config.font_size = 16.0

-- Dark gray theme colors
config.colors = {
  -- Background and foreground
  foreground = '#e8e8e8',
  background = '#2d2d2d',

  -- Cursor colors
  cursor_bg = '#e8e8e8',
  cursor_fg = '#2d2d2d',
  cursor_border = '#e8e8e8',

  -- Selection colors
  selection_fg = '#2d2d2d',
  selection_bg = '#5f5f87',

  -- Scrollbar
  scrollbar_thumb = '#5f5f5f',

  -- Split borders
  split = '#5f5f5f',

  -- ANSI colors
  ansi = {
    '#1c1c1c', -- black
    '#d75f5f', -- red
    '#87af87', -- green
    '#ffaf5f', -- yellow
    '#87afd7', -- blue
    '#d787d7', -- magenta
    '#87d7d7', -- cyan
    '#d0d0d0', -- white
  },

  -- Bright ANSI colors
  brights = {
    '#5f5f5f', -- bright black
    '#ff8787', -- bright red
    '#afdfaf', -- bright green
    '#ffd787', -- bright yellow
    '#afd7ff', -- bright blue
    '#ffafff', -- bright magenta
    '#afffff', -- bright cyan
    '#ffffff', -- bright white
  },
}

-- Window appearance
config.window_background_opacity = 0.95
config.text_background_opacity = 1.0
config.window_decorations = "TITLE | RESIZE"
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

-- Tab bar styling
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.colors.tab_bar = {
  background = '#1a1a1a',
  active_tab = {
    bg_color = '#2d2d2d',
    fg_color = '#e8e8e8',
    intensity = 'Normal',
    underline = 'None',
    italic = false,
    strikethrough = false,
  },
  inactive_tab = {
    bg_color = '#1a1a1a',
    fg_color = '#808080',
  },
  inactive_tab_hover = {
    bg_color = '#404040',
    fg_color = '#e8e8e8',
  },
  new_tab = {
    bg_color = '#1a1a1a',
    fg_color = '#808080',
  },
  new_tab_hover = {
    bg_color = '#404040',
    fg_color = '#e8e8e8',
  },
}

-- Disable audible bell
config.audible_bell = "Disabled"

-- Enable scrollback
config.scrollback_lines = 10000

return config