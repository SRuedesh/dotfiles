-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local home_dir = os.getenv("HOME") or os.getenv("USERPROFILE")
if home_dir and home_dir:sub(1, 2):upper() == "D:" then
	config.prefer_egl = true
end

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

-- fast quitting
-- config.window_close_confirmation = "NeverPrompt"
-- config.default_workspace = "obsidian"

config.default_prog = { "pwsh.exe", "-NoLogo" }

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular" })
config.font_size = 15

-- scrollbar
config.scrollback_lines = 3000
config.enable_scroll_bar = false
config.default_cursor_style = "SteadyBlock"

-- tmuxing
-- config.enable_tab_bar = true
-- config.tab_bar_at_bottom = true
-- config.hide_tab_bar_if_only_one_tab = false
-- tmux status
-- wezterm.on("update-right-status", function(window, _)
-- 	local SOLID_LEFT_ARROW = ""
-- 	local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
-- 	local prefix = ""
--
-- 	if window:leader_is_active() then
-- 		prefix = " " .. utf8.char(0x1f30a) -- ocean wave
-- 		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
-- 	end
--
-- 	if window:active_tab():tab_id() ~= 0 then
-- 		ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
-- 	end -- arrow color based on if tab is first pane
--
-- 	window:set_left_status(wezterm.format({
-- 		{ Background = { Color = "#b7bdf8" } },
-- 		{ Text = prefix },
-- 		ARROW_FOREGROUND,
-- 		{ Text = SOLID_LEFT_ARROW },
-- 	}))
-- end)

-- background image
config.window_background_opacity = 0.7

-- initial size
config.initial_rows = 50
config.initial_cols = 200

-- using alt keys
config.allow_win32_input_mode = false
config.send_composed_key_when_left_alt_is_pressed = false

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

-- key bindings
config.leader = { key = "k", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- WORKSPACES
	-- search workspace
	-- {
	-- 	key = "s",
	-- 	mods = "LEADER",
	-- 	action = act.ShowLauncherArgs({
	-- 		flags = "FUZZY|WORKSPACES",
	-- 	}),
	-- },
	-- -- new workspace
	-- {
	-- 	key = "n",
	-- 	mods = "LEADER",
	-- 	action = act.PromptInputLine({
	-- 		description = wezterm.format({
	-- 			{ Attribute = { Intensity = "Bold" } },
	-- 			{ Foreground = { AnsiColor = "Fuchsia" } },
	-- 			{ Text = "Enter name for new workspace" },
	-- 		}),
	-- 		action = wezterm.action_callback(function(window, pane, line)
	-- 			-- line will be `nil` if they hit escape without entering anything
	-- 			-- An empty string if they just hit enter
	-- 			-- Or the actual line of text they wrote
	-- 			if line then
	-- 				window:perform_action(
	-- 					act.SwitchToWorkspace({
	-- 						name = line,
	-- 					}),
	-- 					pane
	-- 				)
	-- 			end
	-- 		end),
	-- 	}),
	-- },
	-- -- kill tab
	-- {
	-- 	key = "x",
	-- 	mods = "LEADER",
	-- 	action = act.CloseCurrentTab({ confirm = true }),
	-- },
	-- -- new tab (named)
	-- {
	-- 	key = "t",
	-- 	mods = "LEADER",
	-- 	action = act.PromptInputLine({
	-- 		description = wezterm.format({
	-- 			{ Attribute = { Intensity = "Bold" } },
	-- 			{ Foreground = { AnsiColor = "Fuchsia" } },
	-- 			{ Text = "Enter name for new tab" },
	-- 		}),
	-- 		action = wezterm.action_callback(function(window, pane, line)
	-- 			-- line will be `nil` if they hit escape without entering anything
	-- 			-- An empty string if they just hit enter
	-- 			-- Or the actual line of text they wrote
	-- 			if line then
	-- 				window:perform_action(act.SpawnTab("CurrentPaneDomain"), pane)
	-- 				window:active_tab():set_title(line)
	-- 			end
	-- 		end),
	-- 	}),
	-- },
	-- -- zoom pane
	-- {
	-- 	key = "z",
	-- 	mods = "LEADER",
	-- 	action = act.TogglePaneZoomState,
	-- },
	-- {
	-- 	key = "r",
	-- 	mods = "LEADER",
	-- 	action = act.PromptInputLine({
	-- 		description = "Enter new name for tab",
	-- 		action = wezterm.action_callback(function(window, pane, line)
	-- 			-- line will be `nil` if they hit escape without entering anything
	-- 			-- An empty string if they just hit enter
	-- 			-- Or the actual line of text they wrote
	-- 			if line then
	-- 				window:active_tab():set_title(line)
	-- 			end
	-- 		end),
	-- 	}),
	-- },
	-- -- SPLITS
	-- -- horizontal split
	-- {
	-- 	key = "-",
	-- 	mods = "LEADER",
	-- 	action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	-- },
	-- -- close split
	-- {
	-- 	key = "w",
	-- 	mods = "LEADER",
	-- 	action = act.CloseCurrentPane({ confirm = true }),
	-- },
	-- navigate splits
	-- {
	-- 	key = "h",
	-- 	mods = "LEADER",
	-- 	action = act.ActivatePaneDirection("Left"),
	-- },
	-- {
	-- 	key = "l",
	-- 	mods = "LEADER",
	-- 	action = act.ActivatePaneDirection("Right"),
	-- },
}

for i = 1, 8 do
	-- CTRL+K + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

-- Workspaces
-- wezterm.on("gui-startup", function(cmd)
-- 	local args = {}
-- 	if cmd then
-- 		args = cmd.args
-- 	end
--
-- 	-- GENERAL WORKSPACES
-- 	local project_dir = wezterm.home_dir .. "/one_drive/github"
--
-- 	-- DSS WORKSPACE START
-- 	-- TAB 1: SHELL
-- 	local tab, pane, window = mux.spawn_window({
-- 		workspace = "dss",
-- 		cwd = project_dir .. "/dss",
-- 	})
-- 	tab:set_title("shell")
--
-- 	-- TAB 2: RADIAN
-- 	local tab = window:spawn_tab({
-- 		cwd = project_dir .. "/dss",
-- 		args = { "radian", "." },
-- 	})
-- 	tab:set_title("radian")
--
-- 	-- TAB 3: R
-- 	local tab = window:spawn_tab({
-- 		cwd = project_dir .. "/dss",
-- 		args = { "R.exe", "." },
-- 	})
-- 	tab:set_title("R")
--
-- 	-- TAB 4: VIM (default)
-- 	local tab = window:spawn_tab({
-- 		cwd = project_dir .. "/dss",
-- 		args = { "nvim", "." },
-- 	})
-- 	tab:set_title("vim")
-- 	-- DSS WORKSPACE END
--
-- 	-- CONFIG WORKSPACE START
-- 	-- TAB 1: SHELL
-- 	local tab, pane, window = mux.spawn_window({
-- 		workspace = "config",
-- 		cwd = project_dir .. "/configwin",
-- 	})
-- 	tab:set_title("shell")
--
-- 	-- TAB 2: VIM (default)
-- 	local tab = window:spawn_tab({
-- 		cwd = project_dir .. "/configwin",
-- 		args = { "nvim", "." },
-- 	})
-- 	tab:set_title("vim")
-- 	-- CONFIG WORKSPACE END
--
-- 	-- ABDATAAPI WORKSPACE START
-- 	-- TAB 1: SHELL
-- 	local tab, pane, window = mux.spawn_window({
-- 		workspace = "abdataapi",
-- 		cwd = project_dir .. "/abdataapi",
-- 	})
-- 	tab:set_title("shell")
--
-- 	-- TAB 2: RADIAN (server)
-- 	local tab = window:spawn_tab({
-- 		cwd = project_dir .. "/abdataapi/src",
-- 		-- args = { "radian", "." },
-- 	})
-- 	tab:set_title("server")
--
-- 	-- TAB 3: RADIAN (testing)
-- 	local tab = window:spawn_tab({
-- 		cwd = project_dir .. "/abdataapi/client",
-- 		-- args = { "radian", "." },
-- 	})
-- 	tab:set_title("testing")
--
-- 	-- TAB 4: VIM (default)
-- 	local tab = window:spawn_tab({
-- 		cwd = project_dir .. "/abdataapi",
-- 	})
-- 	tab:set_title("vim")
-- 	-- ABDATAAPI WORKSPACE END
--
-- 	-- IFX-DSS WORKSPACE START
-- 	-- TAB 1: SHELL
-- 	local tab, pane, window = mux.spawn_window({
-- 		workspace = "ifx-dss",
-- 		cwd = project_dir .. "/ifx-dss",
-- 	})
-- 	tab:set_title("shell")
--
-- 	-- TAB 2: RADIAN (server)
-- 	local tab = window:spawn_tab({
-- 		cwd = project_dir .. "/ifx-dss",
-- 		-- args = { "radian", "." },
-- 	})
-- 	tab:set_title("server")
--
-- 	-- TAB 3: VIM (default)
-- 	local tab = window:spawn_tab({
-- 		cwd = project_dir .. "/ifx-dss",
-- 	})
-- 	tab:set_title("vim")
-- 	-- IFX-DSS WORKSPACE END
--
-- 	-- OBSIDIAN WORKSPACE START
-- 	-- TAB 1: SHELL
-- 	local tab, pane, window = mux.spawn_window({
-- 		workspace = "obsidian",
-- 		cwd = project_dir .. "/obsidian",
-- 	})
-- 	tab:set_title("shell")
--
-- 	-- TAB 2: SHELL
-- 	local tab = window:spawn_tab({
-- 		cwd = project_dir .. "/obsidian",
-- 		args = { "nvim", "main.md" },
-- 	})
-- 	tab:set_title("vim")
-- -- 	-- CONFIG WORKSPACE END
-- end)

return config
