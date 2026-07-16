return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo", "FormatDisable", "FormatEnable" },
        keys = {
            {
                "<leader>cf",
                function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
                mode = { "n", "v" },
                desc = "Format buffer/selection",
            },
        },
        opts = {
            formatters_by_ft = {
                go         = { "goimports", "gofumpt" },          -- сначала импорты, потом строгий формат
                python     = { "ruff_organize_imports", "ruff_format" },
                lua        = { "stylua" },
                sh         = { "shfmt" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
                vue        = { "prettierd" },
                css        = { "prettierd" },
                html       = { "prettierd" },
                json       = { "prettierd" },
                yaml       = { "prettierd" },
                markdown   = { "prettierd" },
            },
            format_on_save = function(bufnr)
                -- уважаем тоггл (см. команды ниже)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 1000, lsp_format = "fallback" }
            end,
        },
        config = function(_, opts)
            require("conform").setup(opts)

            -- :FormatDisable — выключить автоформат (с ! только для текущего буфера)
            vim.api.nvim_create_user_command("FormatDisable", function(args)
                if args.bang then
                    vim.b.disable_autoformat = true
                else
                    vim.g.disable_autoformat = true
                end
            end, { bang = true, desc = "Disable autoformat-on-save" })

            -- :FormatEnable — вернуть обратно
            vim.api.nvim_create_user_command("FormatEnable", function()
                vim.b.disable_autoformat = false
                vim.g.disable_autoformat = false
            end, { desc = "Re-enable autoformat-on-save" })
        end,
    },
}
