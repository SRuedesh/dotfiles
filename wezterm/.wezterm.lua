local wezterm = require("wezterm")

-- helper
local function mergeTables(t1, t2)
	for key, value in pairs(t2) do
		t1[key] = value
	end
end

local config = {
	-- window
	-- no window decorations
	window_decorations = "RESIZE",

	-- default program
	default_prog = { "pwsh.exe" },

	-- appearance
	font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular" }),
	font_size = 18,
	default_cursor_style = "SteadyBlock",
	audible_bell = "Disabled",
	inactive_pane_hsb = {
		brightness = 0.9,
	},
	window_padding = {
		left = 10,
		right = 0,
		top = 10,
		bottom = 0,
	},

	-- scrollbar
	scrollback_lines = 3000,
	enable_scroll_bar = false,

	-- tab bar
	enable_tab_bar = true,
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = false,
	window_background_opacity = 0.7,
	use_fancy_tab_bar = false,

	-- initial size
	initial_rows = 50,
	initial_cols = 200,

	-- using alt keys
	allow_win32_input_mode = false,
	send_composed_key_when_left_alt_is_pressed = false,
}

-- colors
local colors = require("wezterm-colors")
mergeTables(config, colors)

---
-- resurrect
---
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
resurrect.state_manager.periodic_save({
	interval_seconds = 60,
	save_workspace = true,
})

local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.apply_to_config({})

workspace_switcher.workspace_formatter = function(label)
	return wezterm.format({
		{ Attribute = { Italic = true } },
		{ Foreground = { Color = colors.colors.ansi[3] } },
		{ Background = { Color = colors.colors.background } },
		{ Text = "󱂬 : " .. label },
	})
end

wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
	window:gui_window():set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { Color = colors.colors.ansi[5] } },
		{ Text = basename(path) .. "  " },
	}))
	local workspace_state = resurrect.workspace_state

	workspace_state.restore_workspace(resurrect.state_manager.load_state(label, "workspace"), {
		window = window,
		relative = true,
		restore_text = true,

		resize_window = false,
		on_pane_restore = resurrect.tab_state.default_on_pane_restore,
	})
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", function(window, path, label)
	wezterm.log_info(window)
	window:gui_window():set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { Color = colors.colors.ansi[5] } },
		{ Text = basename(path) .. "  " },
	}))
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
	wezterm.log_info(window)
	local workspace_state = resurrect.workspace_state
	resurrect.state_manager.save_state(workspace_state.get_workspace_state())
	resurrect.state_manager.write_current_state(label, "workspace")
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.start", function(window, _)
	wezterm.log_info(window)
end)
wezterm.on("smart_workspace_switcher.workspace_switcher.canceled", function(window, _)
	wezterm.log_info(window)
end)

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

-- key bindings
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = require("wezterm-keybinds")

wezterm.on("augment-command-palette", function(window, pane)
	local workspace_state = resurrect.workspace_state
	return {
		{
			brief = "Window | Workspace: Switch Workspace",
			icon = "md_briefcase_arrow_up_down",
			action = workspace_switcher.switch_workspace(),
		},
		{
			brief = "Window | Workspace: Rename Workspace",
			icon = "md_briefcase_edit",
			action = wezterm.action.PromptInputLine({
				description = "Enter new name for workspace",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
						resurrect.state_manager.save_state(workspace_state.get_workspace_state())
					end
				end),
			}),
		},
	}
end)

wezterm.on("update-right-status", function(window, _)
	local SOLID_LEFT_ARROW = ""
	local ARROW_FOREGROUND = { Foreground = { Color = "#56949f" } }
	local prefix = ""

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x1f30a) -- ocean wave
		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	end

	if window:active_tab():tab_id() ~= 0 then
		ARROW_FOREGROUND = { Foreground = { Color = "#56949f" } }
	end -- arrow color based on if tab is first pane

	window:set_left_status(wezterm.format({
		{ Background = { Color = "#56949f" } },
		{ Text = prefix },
		ARROW_FOREGROUND,
		{ Text = SOLID_LEFT_ARROW },
	}))
end)

wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)
return config
