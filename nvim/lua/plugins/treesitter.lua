return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",        -- ветка под 0.12 (полный rewrite)
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup()

            local parsers = {
                "go", "gomod", "gosum",
                "python",
                "typescript", "tsx", "javascript", "vue",
                "json", "yaml", "toml",
                "html", "css",
                "lua", "bash", "markdown", "markdown_inline",
            }

            -- Ставим только те парсеры, которых ещё нет (без переустановки на каждом старте)
            local installed = require("nvim-treesitter.config").get_installed()
            local to_install = vim.iter(parsers)
                :filter(function(p) return not vim.tbl_contains(installed, p) end)
                :totable()
            if #to_install > 0 then
                require("nvim-treesitter").install(to_install)
            end

            -- В main setup() парсеры только ставит; подсветку и отступы включаем сами
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)  -- no-op, если для буфера нет парсера
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
