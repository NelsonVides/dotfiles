local treesitter = require('nvim-treesitter.configs')
require("nvim-treesitter.install").prefer_git = true
treesitter.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = false,
        disable = {},
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "grr",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    matchup = {
        enable = true,
        disable = {},
    },
}
