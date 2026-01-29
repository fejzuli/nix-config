return {
    "folke/lazydev.nvim",
    dependencies = {
        { "DrKJeff16/wezterm-types", version = false, lazy = true },
    },
    ft = "lua",
    ---@module "lazydev"
    ---@type lazydev.Config
    opts = {
        library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            { path = "wezterm-types", mods = { "wezterm" } },
        },
    },
    specs = {
        "saghen/blink.cmp",
        ---@module "blink.cmp"
        ---@type blink.cmp.Config
        opts = {
            sources = {
                per_filetype = {
                    lua = { inherit_defaults = true, "lazydev" },
                },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
        },
    },
}
