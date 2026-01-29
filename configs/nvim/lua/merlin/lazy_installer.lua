local M = {}

function M.setup()
    vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

    require("lazy").setup({
        spec = {
            { import = "merlin/plugins" },
        },
        defaults = { version = "*" },
        install = { missing = false },
        performance = {
            rtp = {
                disabled_plugins = {
                    "gzip",
                    "netrwPlugin",
                    "tarPlugin",
                    "tohtml",
                    "tutor",
                    "zipPlugin",
                },
            },
        },
        rocks = { enabled = false },
    })
end

function M.is_installed()
    return not not vim.uv.fs_stat(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
end

function M.install()
    return vim.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
    }, { text = true })
end

return M
