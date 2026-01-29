return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
    end,
    lazy = false,
    main = "nvim-treesitter.configs",
    opts = {
    ensure_installed = {
        -- these five parsers should always be installed
        "c", "lua", "vim", "vimdoc", "query",
        -- others
        "bash", "fish",
        "markdown", "json", "toml", "yaml",
        "rust",
        "nix",
    },
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    },
}
