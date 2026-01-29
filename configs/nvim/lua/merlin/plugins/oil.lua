return {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    keys = {
        { "-", "<Cmd>Oil<CR>", desc = "Open parent directory" },
    },
    ---@module "oil"
    ---@type oil.SetupOpts
    opts = {
        default_file_explorer = true,
        columns = {
            "icon",
            "permissions",
        },
    },
}
