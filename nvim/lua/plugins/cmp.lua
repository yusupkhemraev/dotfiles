return {
    {
        "saghen/blink.cmp",
        version = "1.*",            -- стабильная V1 с прекомпилированным fuzzy-бинарём
        event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets" },  -- набор сниппетов
        opts = {
            -- preset "default": <C-y> принять, <C-n>/<C-p> листать, <C-space> вызвать,
            -- <C-e> закрыть. Альтернативы: "super-tab" (Tab), "enter" (Enter принимает)
            keymap = {
                preset = "super-tab",
                ["<CR>"] = { "accept", "fallback" },
            },

            appearance = { nerd_font_variant = "mono" },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },

            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
            },

            signature = { enabled = true },  -- подсказка сигнатуры функции

            -- если Rust-бинарь не подтянется — откатится на Lua-реализацию с предупреждением
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
