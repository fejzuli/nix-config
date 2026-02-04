return {
    "nvim-lualine/lualine.nvim",
    version = false,
    priority = 900,
    opts = {
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = {
                function() return vim.fn.getcwd() end,
            },
            lualine_x = {},
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        winbar = {
            lualine_a = { "filetype" },
            lualine_c = {
                { "filename", path = 1 },
            },
        },
        inactive_winbar = {
            lualine_c = {
                { "filename", path = 1 },
            },
        },
        options = {
            section_separators = "",
            -- component_separators = "│",
            component_separators = "|",
            globalstatus = true,
        },
    },
    init = function() vim.o.showmode = false end,
}
