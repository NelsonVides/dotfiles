return {

    { 'nyngwang/NeoZoom.lua',
        config = function ()
            require('neo-zoom').setup {
                popup = { enabled = true }, -- this is the default.
                -- NOTE: Add popup-effect (replace the window on-zoom with a `[No Name]`).
                -- EXPLAIN: This improves the performance, and you won't see two
                --          identical buffers got updated at the same time.
                -- popup = {
                --   enabled = true,
                --   exclude_filetypes = {},
                --   exclude_buftypes = {},
                -- },
                exclude_buftypes = { 'terminal' },
                -- exclude_filetypes = { 'lspinfo', 'mason', 'lazy', 'fzf', 'qf' },
                winopts = {
                    offset = {
                        -- NOTE: omit `top`/`left` to center the floating window vertically/horizontally.
                        -- top = 0,
                        -- left = 0.17,
                        width = 150,
                        height = 0.85,
                    },
                    -- NOTE: check :help nvim_open_win() for possible border values.
                    border = 'thicc', -- this is a preset, try it :)
                },
                presets = {
                    {
                        -- NOTE: regex pattern can be used here!
                        filetypes = { 'dapui_.*', 'dap-repl' },
                        winopts = {
                            offset = { top = 0.02, left = 0.26, width = 0.74, height = 0.25 },
                        },
                    },
                    {
                        filetypes = {"markdown", "norg"},
                        callbacks = {
                            function () vim.wo.wrap = true end,
                        },
                    },
                },
            }
            vim.keymap.set('n', '<CR>', function () vim.cmd('NeoZoomToggle') end, { silent = true, nowait = true })
        end
    },

    { 'yorickpeterse/nvim-window', lazy = true,
        keys = {
            { "<leader>w", "<cmd>lua require('nvim-window').pick()<cr>" },
        },
        config = true,
    },

    { 'nanozuki/tabby.nvim',
        lazy = false,
        event = 'VimEnter',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('tabby.tabline').use_preset('active_wins_at_tail', {
                lualine_theme = "vscode",        -- lualine theme name
                theme = {
                    fill = 'TabLineFill',       -- tabline background
                    head = 'TabLine',           -- head element highlight
                    current_tab = 'TabLineSel', -- current tab label highlight
                    tab = 'TabLine',            -- other tab label highlight
                    win = 'TabLine',            -- window highlight
                    tail = 'TabLine',           -- tail element highlight
                },
            })
        end,
    },

    { 'andrewferrier/wrapping.nvim', lazy = true,
        cmd = "ToggleWrapMode",
        ft = {"markdown", "norg"},
        config = function()
            require("wrapping").setup({
                auto_set_mode_filetype_allowlist = {
                    "asciidoc", "gitcommit", "latex", "mail",
                    "markdown", "rst", "tex", "text", "norg",
                },
            })
        end
    },

    { 'johnfrankmorgan/whitespace.nvim',
        config = function ()
            local whitespace = require('whitespace-nvim')
            whitespace.setup {
                highlight = 'DiffDelete',
                ignored_filetypes = {
                    'TelescopePrompt',
                    'dashboard',
                    'Trouble',
                    'NeogitPopup',
                    'help' },
                ignore_terminal = true,
            }
            vim.keymap.set('n', '<Leader>s', whitespace.trim)
        end
    },

}
