return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,  -- грузим раньше остальных, чтобы не было вспышки темы
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                integrations = {
                    treesitter = true,
                    native_lsp = { enabled = true },
                    gitsigns = true,
                    telescope = true,
                    which_key = true,
                    mason = true,
                    blink_cmp = true,  -- движок, который выбрали на шаг 4
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
