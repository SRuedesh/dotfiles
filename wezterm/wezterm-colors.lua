-- local wezterm = require("wezterm")
-- local color_scheme = wezterm.color.get_builtin_schemes()["rose-pine-moon"]
-- local colors = wezterm.color.get_builtin_schemes()["rose-pine-moon"]
local wezterm = require("wezterm")
local color_scheme = wezterm.color.get_builtin_schemes()["rose-pine-moon"]
local colors = wezterm.color.get_builtin_schemes()["rose-pine-moon"]
-- colors.tab_bar.new_tab.bg_color = color_scheme.tab_bar.inactive_tab.bg_color
-- colors.tab_bar.background = color_scheme.background
-- colors.tab_bar.active_tab.fg_color = color_scheme.tab_bar.active_tab.bg_color
-- colors.tab_bar.active_tab.bg_color = color_scheme.tab_bar.active_tab.fg_color
-- colors.tab_bar.active_tab.fg_color = color_scheme.tab_bar.active_tab.bg_color
-- colors.tab_bar.active_tab.bg_color = color_scheme.tab_bar.active_tab.fg_color
-- colors.tab_bar.inactive_tab_hover.bg_color = color_scheme.selection_bg
-- colors.tab_bar.inactive_tab_edge = color_scheme.selection_bg
colors.tab_bar = {
	background = "none",
	new_tab = {
		bg_color = "none",
		fg_color = "#8985a2",
	},
	inactive_tab = {
		bg_color = "none",
		fg_color = "#8985a2",
	},
	active_tab = {
		bg_color = "none",
		fg_color = "#e0def4",
	},
}

return {
	window_frame = {
		inactive_titlebar_bg = color_scheme.background,
		active_titlebar_bg = color_scheme.background,
		inactive_titlebar_fg = color_scheme.foreground,
		active_titlebar_fg = color_scheme.foreground,
	},
	command_palette_bg_color = color_scheme.background,
	command_palette_fg_color = color_scheme.foreground,
	char_select_bg_color = color_scheme.background,
	-- char_select_fg_color = color_scheme.tab_bar.active_tab.fg_color,
	colors = colors,
}
