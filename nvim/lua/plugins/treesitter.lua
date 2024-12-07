return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.install").prefer_git = true
        require('nvim-treesitter.configs').setup {
            ensured_installed = {
                "erlang", "elixir", "heex",
                "c", "cpp", "rust",
                "lua", "luadoc", "vimdoc", "norg", "graphql",
                "sql", "bash", "make", "cmake", "diff", "dockerfile",
                "git_config", "git_rebase", "gitcommit", "gitignore", "ssh_config",
                "html", "xml", "json", "latex", "markdown", "markdown_inline", "regex",
                "toml", "yaml",
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
            highlight = { enable = true },
            indent = {
                enable = true, -- this is an experimental feature
                disable = {}
            },
            matchup = {
                enable = false,
                disable = {}
            },
        }
    end,
}
