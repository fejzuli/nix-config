return {
    "stevearc/conform.nvim",
    keys = {
        {
            "grf",
            function() require("conform").format() end,
            mode = { "n", "v" },
            desc = "Format code",
        },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            rust = { "rustfmt" },
        },
    },
}
