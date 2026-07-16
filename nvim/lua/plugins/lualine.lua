return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "auto",
                globalstatus = true,       -- одна строка на всё окно
                component_separators = "|",
                section_separators = "",
            },
        },
    },
}
