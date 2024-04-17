return {
    { 'vhyrro/luarocks.nvim', lazy = true,
        priority = 1000,
        opts = {
            luarocks_build_args = { "--with-lua-include=/opt/homebrew/opt/luajit/include/" }, -- extra options to pass to luarocks's configuration script
        }
    },
    { 'nvim-neorg/neorg', lazy = true,
        cmd = { 'Neorg' },
        ft = { 'norg' },
        dependencies = { 'luarocks.nvim' },
        config = function()
            require('neorg').setup {
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    ["core.concealer"] = {
                        config = {
                            icons = {
                                todo = {
                                    done = { icon = "✓⃝" },
                                    pending = { icon = "⏱︎" },
                                },
                                heading = {
                                    icons = {"◉", "◎", "○", "▶", "▷", "⤷"}
                                }
                            },
                        },
                    },
                    ["core.completion"] = {
                        config = {
                            engine = "nvim-cmp"
                        }
                    },
                    ["core.export"] = {},
                    ["core.keybinds"] = {
                        config = {
                            hook = function(keybinds)
                                keybinds.map("norg", "n", "<leader>c", "<cmd>Neorg toggle-concealer<CR>")
                            end
                        }
                    },
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                notes = "~/notes",
                            },
                            default_workspace = "notes"
                        },
                    },
                },
            }
        end,
    }
}
