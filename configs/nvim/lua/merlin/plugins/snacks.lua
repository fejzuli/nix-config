return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        { "<Leader>pp", function() Snacks.picker() end },
        { "<Leader><Space>", function() Snacks.picker.smart() end, },
        { "<Leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
        { "<Leader>gr", function() Snacks.picker.grep() end, desc = "Find files" },
        { "<Tab>", function() Snacks.picker.explorer() end, desc = "File tree" },
        -- Help
        { "<Leader>hh", function() Snacks.picker.help() end, desc = "Find help" },
        { "<Leader>hk", function() Snacks.picker.keymaps() end, desc = "Find keymap" },
        { "<Leader>hc", function() Snacks.picker.commands() end, desc = "Find command" },
    },
    ---@module "snacks"
    ---@type snacks.config
    opts = {
        bigfile = { enabled = true },
        image = { enabled = true },
        -- hides list chars for tab, using indent-blankline for now
        indent = { enabled = true },
        input = { enabled = true },
        picker = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
    },
}
