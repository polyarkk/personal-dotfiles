-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

config.hide_tab_bar_if_only_one_tab = true

config.set_environment_variables = {
    WEZ = "true"
}

config.default_prog = {
    "C:/Users/17811/AppData/Local/Microsoft/WindowsApps/Microsoft.PowerShell_8wekyb3d8bbwe/pwsh.exe",
    '-NoLogo', "-NoExit", 
}

-- or, changing the font size and color scheme.
config.font_size = 16
config.font = wezterm.font_with_fallback {'LXGW WenKai Mono'}
config.color_scheme = 'PaulMillr'

if config.win32_system_backdrop then
    config.window_background_opacity = 0.95
end

-- Finally, return the configuration to wezterm:
return config
