local wez = require("wezterm")
local cfg = wez.config_builder()

cfg.check_for_updates = false

cfg.default_prog = { "/etc/profiles/per-user/merlin/bin/fish" }

cfg.color_scheme = "Catppuccin Mocha"
-- cfg.color_scheme = "Alabaster"
cfg.use_fancy_tab_bar = false
cfg.tab_bar_at_bottom = true
cfg.initial_cols = 120
cfg.initial_rows = 24
cfg.max_fps = 144

-- font
cfg.font = wez.font("Iosevka", {
    weight = "Book",
})
cfg.font_size = 12.0

-- cursor
cfg.cursor_blink_rate = 700
cfg.cursor_blink_ease_in = "Constant"
cfg.cursor_blink_ease_out = "Constant"
cfg.default_cursor_style = "BlinkingBlock"

-- keys
cfg.disable_default_key_bindings = true
cfg.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

local act = wez.action
cfg.keys = {
    { key = "l",          mods = "CTRL|SHIFT", action = act.ShowDebugOverlay },
    { key = "p",          mods = "LEADER",     action = act.ActivateCommandPalette },
    { key = "c",          mods = "ALT",        action = act.CopyTo("Clipboard") },
    { key = "v",          mods = "ALT",        action = act.PasteFrom("Clipboard") },
    { key = "PageUp",     mods = "",           action = act.ScrollByPage(-1) },
    { key = "PageDown",   mods = "",           action = act.ScrollByPage(1) },
    { key = "Home",       mods = "SHIFT",      action = act.ScrollToTop },
    { key = "End",        mods = "SHIFT",      action = act.ScrollToBottom },
    { key = "-",          mods = "CTRL",       action = act.DecreaseFontSize },
    { key = "=",          mods = "CTRL",       action = act.IncreaseFontSize },
    { key = "0",          mods = "CTRL",       action = act.ResetFontSize },

    -- tabs
    { key = "9",          mods = "ALT",        action = act.ActivateTabRelativeNoWrap(-1) },
    { key = "0",          mods = "ALT",        action = act.ActivateTabRelativeNoWrap(1) },
    { key = "(",          mods = "ALT|SHIFT",  action = act.MoveTabRelative(-1) },
    { key = ")",          mods = "ALT|SHIFT",  action = act.MoveTabRelative(1) },
    { key = "1",          mods = "ALT",        action = act.ActivateTab(0) },
    { key = "2",          mods = "ALT",        action = act.ActivateTab(1) },
    { key = "3",          mods = "ALT",        action = act.ActivateTab(2) },
    { key = "4",          mods = "ALT",        action = act.ActivateTab(3) },
    { key = "5",          mods = "ALT",        action = act.ActivateTab(4) },
    { key = "6",          mods = "ALT",        action = act.ActivateTab(5) },
    { key = "7",          mods = "ALT",        action = act.ActivateTab(6) },
    { key = "8",          mods = "ALT",        action = act.ActivateTab(7) },
    { key = "Tab",        mods = "ALT",        action = act.ActivateLastTab },
    { key = "t",          mods = "LEADER",     action = act.SpawnTab("CurrentPaneDomain") },

    -- panes
    { key = "h",          mods = "LEADER",        action = act.ActivatePaneDirection("Left") },
    { key = "j",          mods = "LEADER",        action = act.ActivatePaneDirection("Down") },
    { key = "k",          mods = "LEADER",        action = act.ActivatePaneDirection("Up") },
    { key = "l",          mods = "LEADER",        action = act.ActivatePaneDirection("Right") },
    { key = "LeftArrow",  mods = "ALT",        action = act.AdjustPaneSize { "Left", 5 } },
    { key = "DownArrow",  mods = "ALT",        action = act.AdjustPaneSize { "Down", 5 } },
    { key = "UpArrow",    mods = "ALT",        action = act.AdjustPaneSize { "Up", 5 } },
    { key = "RightArrow", mods = "ALT",        action = act.AdjustPaneSize { "Right", 5 } },
    { key = "[",          mods = "ALT",        action = act.RotatePanes("CounterClockwise") },
    { key = "]",          mods = "ALT",        action = act.RotatePanes("Clockwise") },
    { key = "v",          mods = "LEADER",     action = act.SplitHorizontal },
    { key = "s",          mods = "LEADER",     action = act.SplitVertical },
    { key = "c",          mods = "LEADER",     action = act.CloseCurrentPane { confirm = true } },
    { key = "z",          mods = "LEADER",     action = act.TogglePaneZoomState },
}

wez.on("format-tab-title", function(tab)
    local num = tab.tab_index + 1
    local active_pane = tab.active_pane
    local prefix

    if active_pane.is_zoomed then
        prefix = "[" .. num .. "]:"
    else
        prefix = " " .. num .. ": "
    end

    return prefix .. active_pane.title .. " "
end)

wez.on("update-status", function(win, pane)
    local _, leds = win:keyboard_modifiers()
    local left_bg = "#11111b"
    local left_fg = "#cdd6f4"

    if win:leader_is_active() then
        left_bg = "#94e2d5"
        left_fg = "#11111b"
    end

    win:set_left_status(wez.format {
        { Background = { Color = left_bg } },
        {Foreground = {Color = left_fg}},
        { Text = " ✞ " },
    })
    win:set_right_status(leds)
end)

return cfg
