local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.default_cursor_style = "SteadyBar"
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "RESIZE" -- INTEGRATED_BUTTONS RESIZE
config.check_for_updates = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.font_size = 16
config.initial_cols = 120
config.initial_rows = 35
config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })
config.enable_tab_bar = false
config.window_padding = {
	left = 4,
	right = 1,
	top = 4,
	bottom = 2,
    -- left = 4,
	-- right = 4,
	-- top = 1,
	-- bottom = 2,
}
config.background = {
	{
		source = {
			File = "/Users/" .. os.getenv("USER") .. "/.config/wezterm/makima.png",
		},
		hsb = {
			hue = 1.0,
			saturation = 1.02,
			brightness = 0.25,
		},
		-- attachment = { Parallax = 0.3 },
		-- width = "100%",
		-- height = "100%",
	},
	{
		source = {
			Color = "#282c35",
		},
		width = "100%",
		height = "100%",
		-- opacity = 0.55,
		opacity = 0.85,
		-- opacity = 1,
	},
}
-- config.window_background_opacity = 0.3
-- config.macos_window_background_blur = 20
config.keys = {
    { key = "Enter", mods = "CTRL",  action = wezterm.action.SendString("\x1b[13;5u") },
    { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\x1b[13;2u") },

    -- Option + Arrow: прыжок по словам
    { key = "LeftArrow",  mods = "OPT", action = wezterm.action.SendString("\x1bb") },
    { key = "RightArrow", mods = "OPT", action = wezterm.action.SendString("\x1bf") },

    -- Cmd + Arrow: начало/конец строки
    { key = "LeftArrow",  mods = "CMD", action = wezterm.action.SendString("\x01") },
    { key = "RightArrow", mods = "CMD", action = wezterm.action.SendString("\x05") },

    -- Shift + Arrow: выделение по символам (отправляем стандартные CSI)
    { key = "LeftArrow",  mods = "SHIFT", action = wezterm.action.SendString("\x1b[1;2D") },
    { key = "RightArrow", mods = "SHIFT", action = wezterm.action.SendString("\x1b[1;2C") },

    -- Option + Shift + Arrow: выделение по словам
    { key = "LeftArrow",  mods = "OPT|SHIFT", action = wezterm.action.SendString("\x1b[1;4D") },
    { key = "RightArrow", mods = "OPT|SHIFT", action = wezterm.action.SendString("\x1b[1;4C") },

    -- Cmd + Shift + Arrow: выделение до начала/конца строки
    { key = "LeftArrow",  mods = "CMD|SHIFT", action = wezterm.action.SendString("\x1b[1;2H") },
    { key = "RightArrow", mods = "CMD|SHIFT", action = wezterm.action.SendString("\x1b[1;2F") },
}


-- from: https://akos.ma/blog/adopting-wezterm/
config.hyperlink_rules = {
	-- Matches: a URL in parens: (URL)
	{
		regex = "\\((\\w+://\\S+)\\)",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in brackets: [URL]
	{
		regex = "\\[(\\w+://\\S+)\\]",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in curly braces: {URL}
	{
		regex = "\\{(\\w+://\\S+)\\}",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in angle brackets: <URL>
	{
		regex = "<(\\w+://\\S+)>",
		format = "$1",
		highlight = 1,
	},
	-- Then handle URLs not wrapped in brackets
	{
		regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
		format = "$1",
		highlight = 1,
	},
}
return config
