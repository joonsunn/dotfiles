-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Monokai (terminal.sexy)'
config.font = wezterm.font("MesloLGM Nerd Font", {weight="Regular", stretch="Normal", style="Normal"})


-- and finally, return the configuration to wezterm
return config
