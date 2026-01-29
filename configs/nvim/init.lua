vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

---------------------------------- [Options] ----------------------------------
vim.o.shiftwidth = 4
vim.o.softtabstop = -1
vim.o.expandtab = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.scrolloff = 5

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.cursorline = true
vim.o.colorcolumn = "80"
vim.o.list = true
vim.opt.listchars = {
    tab = '» ',
    trail = '·',
    nbsp = '␣',
}

vim.o.breakindent = true
vim.o.linebreak = true
vim.o.showbreak = ">>> "

vim.o.signcolumn = "yes"
vim.o.termguicolors = true

---------------------------------- [Keymaps] ----------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " l"
vim.keymap.set("n", "<Space>", "<NOP>")

vim.keymap.set("n", "<Esc>", "<Cmd>noh<CR>", {
    desc = "Turn off search highlights",
})

-------------------------------- [Autocommands] -------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight text on yank",
    group = vim.api.nvim_create_augroup("merlin-highlight-yank", { clear = true }),
    callback = function() vim.hl.on_yank() end,
})


-------------------------------- [Usercommands] -------------------------------
vim.api.nvim_create_user_command("FactoryReset", function()
    local res = vim.fn.confirm(
        [[This will delete everything in share/nvim and state/nvim.
Do you wish to continue?]],
        "&yes\n&no",
        2
    )

    if res == 1 then
        vim.system({
            "rm",
            "-rf",
            vim.fn.stdpath("data"),
            vim.fn.stdpath("state"),
        })
    end
end, { desc = "Delete everything from share/nvim and state/nvim" })


------------------------------------ [LSP] ------------------------------------
vim.lsp.enable({
    "lua_ls",
    "nil_ls",
})


-------------------------------- [Lazy Setup] ---------------------------------
local lazy_installer = require("merlin/lazy_installer")

if lazy_installer.is_installed() then
    lazy_installer.setup()
else
    vim.api.nvim_create_user_command("Setup", function()
        local res = lazy_installer.install():wait()

        if res.code == 0 then
            vim.api.nvim_del_user_command("Setup")
            print("Setup complete")
        else
            print(string.format("Error %d\n%s", res.code, res.stderr))
        end
    end, {})
end
