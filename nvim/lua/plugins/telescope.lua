return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>",   desc = "Recent files" },
            { "<leader>fd", "<cmd>Telescope diagnostics<cr>",desc = "Diagnostics" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help tags" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    file_ignore_patterns = { "node_modules", "%.git/" },
                },
            })
            pcall(telescope.load_extension, "fzf")
        end,
    },
}
