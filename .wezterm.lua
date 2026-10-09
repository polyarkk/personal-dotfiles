-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- config.hide_tab_bar_if_only_one_tab = true

config.set_environment_variables = {
    WEZ = "true"
}

config.default_prog = {"C:/Users/17811/AppData/Local/Microsoft/WindowsApps/Microsoft.PowerShell_8wekyb3d8bbwe/pwsh.exe",
                       '-NoLogo', "-NoExit"}

-- or, changing the font size and color scheme.
config.font_size = 16
config.font = wezterm.font_with_fallback {'LXGW WenKai Mono'}
config.color_scheme = 'PaulMillr'
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 0.95
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

local act = wezterm.action

config.keys = {{
    key = 'l',
    mods = 'ALT',
    action = act.ShowLauncher
}, {
    key = 't',
    mods = 'ALT',
    action = act.ShowTabNavigator
}}

for i = 1, 8 do
  -- CTRL+ALT + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL|ALT',
    action = act.ActivateTab(i - 1),
  })
end

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
    return tab.active_pane.title
end)

config.window_frame = {
    -- The font used in the tab bar.
    -- Roboto Bold is the default; this font is bundled
    -- with wezterm.
    -- Whatever font is selected here, it will have the
    -- main font setting appended to it to pick up any
    -- fallback fonts you may have used there.
    font = wezterm.font {
        family = 'LXGW WenKai Mono',
        weight = 'Bold'
    },

    -- The size of the font in the tab bar.
    -- Default to 10.0 on Windows but 12.0 on other systems
    font_size = 12.0,

    -- The overall background color of the tab bar when
    -- the window is focused
    active_titlebar_bg = 'rgba(0, 0, 0, 0.95)',

    -- The overall background color of the tab bar when
    -- the window is not focused
    inactive_titlebar_bg = 'rgba(0, 0, 0, 0.95)'
}

config.colors = {
    tab_bar = {
        -- The color of the inactive tab bar edge/divider
        inactive_tab_edge = '#575757'
    }
}

-- Finally, return the configuration to wezterm:
return config
