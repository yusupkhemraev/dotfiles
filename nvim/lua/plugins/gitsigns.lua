return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "│" }, change = { text = "│" },
                delete = { text = "_" }, topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            on_attach = function(buf)
                local gs = require("gitsigns")
                local function map(l, r, desc)
                    vim.keymap.set("n", l, r, { buffer = buf, desc = desc })
                end
                -- nav_hunk — актуальный API (next_hunk/prev_hunk устарели)
                map("]h", function() gs.nav_hunk("next") end, "Next hunk")
                map("[h", function() gs.nav_hunk("prev") end, "Prev hunk")
                map("<leader>hs", gs.stage_hunk, "Stage hunk")
                map("<leader>hr", gs.reset_hunk, "Reset hunk")
                map("<leader>hp", gs.preview_hunk, "Preview hunk")
                map("<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
            end,
        },
    },
}
