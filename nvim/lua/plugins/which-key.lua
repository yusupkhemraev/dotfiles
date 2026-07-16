return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "modern",
            spec = {  -- имена групп; сами хоткеи which-key возьмёт из desc
                { "<leader>f", group = "find" },
                { "<leader>h", group = "git hunk" },
                -- { "<leader>a", group = "AI/Claude" },
            },
        },
    },
}

