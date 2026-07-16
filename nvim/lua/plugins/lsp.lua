return {
    {
        "mason-org/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        config = function()
            -- ── Диагностика ───────────────────────────────────────────────
            vim.diagnostic.config({
                virtual_text = true,
                severity_sort = true,
                float = { border = "rounded" },
            })

            -- ── Хоткеи навешиваются, когда сервер цепляется к буферу ───────
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local o = function(d) return { buffer = args.buf, desc = d } end
                    local map = vim.keymap.set
                    map("n", "gd", vim.lsp.buf.definition, o("Go to definition"))
                    map("n", "gr", vim.lsp.buf.references, o("References"))
                    map("n", "gi", vim.lsp.buf.implementation, o("Implementation"))
                    map("n", "K", vim.lsp.buf.hover, o("Hover"))
                    map("n", "<leader>rn", vim.lsp.buf.rename, o("Rename"))
                    map("n", "<leader>ca", vim.lsp.buf.code_action, o("Code action"))
                    -- goto_next/prev устарели в 0.11+, в 0.12 используем jump
                    map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, o("Prev diagnostic"))
                    map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, o("Next diagnostic"))
                end,
            })

            -- путь до @vue/typescript-plugin (ставится вместе с vue-language-server)
            local vue_plugin_path = vim.fn.stdpath("data")
                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

            -- ── Конфиги серверов (новый vim.lsp.config) ───────────────────
            vim.lsp.config("gopls", {
                settings = {
                    gopls = {
                        analyses = { unusedparams = true },
                        staticcheck = true,
                        gofumpt = true,
                        hints = {  -- inlay hints
                            assignVariableTypes = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                    },
                },
            })

            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = {
                        analysis = {
                            typeCheckingMode = "standard",   -- можно "recommended"/"strict"
                            diagnosticMode = "openFilesOnly",
                        },
                        disableOrganizeImports = true,       -- импорты разрулит ruff
                    },
                },
            })

            -- ruff: только линт/формат, hover отдаём basedpyright (иначе дубли)
            vim.lsp.config("ruff", {
                on_attach = function(client)
                    client.server_capabilities.hoverProvider = false
                end,
            })

            -- vtsls + плагин Vue (hybrid mode)
            vim.lsp.config("vtsls", {
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                settings = {
                    vtsls = {
                        tsserver = {
                            globalPlugins = {
                                {
                                    name = "@vue/typescript-plugin",
                                    location = vue_plugin_path,
                                    languages = { "vue" },
                                    configNamespace = "typescript",
                                },
                            },
                        },
                    },
                },
            })

            vim.lsp.config("vue_ls", {})  -- шаблоны и стили в .vue

            vim.lsp.config("lua_ls", {     -- чтобы не ругался на глобал vim в конфиге
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            })

            -- ── Установка + авто-включение серверов ───────────────────────
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "gopls",
                    "basedpyright", "ruff",
                    "vtsls", "vue_ls",
                    "lua_ls",
                },
                -- automatic_enable = true по умолчанию: серверы из списка
                -- сами поднимутся через vim.lsp.enable() с конфигами выше
            })
        end,
    },
}
