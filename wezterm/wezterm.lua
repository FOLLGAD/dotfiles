-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- config.color_scheme = 'Ayu Mirage'
-- config.color_scheme = 'Ciapre'
-- config.color_scheme = 'Popping and Locking'
-- config.color_scheme = 'Aurora' -- super nice
config.color_scheme = 'Nature Suede (terminal.sexy)' -- gnome maxxing
-- config.color_scheme = 'Atelier Estuary (base16)' -- nature theme good
config.default_cursor_style = 'BlinkingBar'
config.cursor_thickness = 2
config.cursor_blink_ease_out = {CubicBezier={1.0, 1.0, 1.0, 1.0}}
config.cursor_blink_ease_in = 'EaseOut'

-- macos gpu
config.front_end = "WebGpu"

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- config.enable_scroll_bar = true

-- no borders
config.window_decorations = "RESIZE"

-- for swedish keyboard, left alt should be a composite key
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- beep the screen on error instead of annoying bell sound
config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 15,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 250,
}
config.colors = {
  visual_bell = 'rgb(50, 25, 25)',
}

-- config.window_background_opacity = 0.8

-- window background
config.background = {
{
	source={File='/Users/emil/.config/wezterm/hans-isaacson-ed01m0a8nbQ-unsplash.jpg'},
	vertical_align="Middle",
	horizontal_align="Center",
	hsb = {
		-- Darken the background image by reducing it to 1/3rd
		brightness = 0.03,

		-- You can adjust the hue by scaling its value.
		-- a multiplier of 1.0 leaves the value unchanged.
		hue = 1.0,

		-- You can adjust the saturation also.
		saturation = 0.8,
	},
},
}

-- for dark mode!
function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Builtin Solarized Dark'
  else
    return 'Builtin Solarized Light'
  end
end

-- config.color_scheme = scheme_for_appearance(get_appearance())

-- and finally, return the configuration to wezterm
return config
