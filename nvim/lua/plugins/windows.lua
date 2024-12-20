return {

    { 'nvim-lualine/lualine.nvim',
        config = function ()
            require('lualine').setup {
                theme = 'auto',
                options = {
                    icons_enabled = true,
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                },
                sections = {
                    lualine_a = {{'mode', fmt = function(str) return str:sub(1,1) end}},
                    lualine_b = {{'branch', fmt = function(str) return str:sub(1,1) end}, 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat'},
                    lualine_y = {'filetype'},
                    lualine_z = {function() return vim.fn.wordcount().words end, 'progress', 'location'},
                },
            }
        end
    },

    { 'nvimdev/dashboard-nvim', lazy = true,
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'hyper',
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        {
                            desc = 'Lazy update',
                            group = '@property',
                            action = 'Lazy update',
                            key = 'u'
                        },
                        {
                            icon = ' ',
                            icon_hl = '@variable',
                            desc = 'Files',
                            group = 'Label',
                            action = 'Telescope find_files',
                            key = 'f',
                        },
                        {
                            desc = 'Restore Session',
                            group = 'Number',
                            action = 'SessionLoad',
                            key = 's',
                        },
                    },
                    mru = {
                        limit = 20,
                        icon = 'Most Recent Files',
                        label = '',
                        cwd_only = false
                    },
                }
            }
        end
    },

    { 'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup {
                default = true
            }
        end
    },

    { 'nvim-tree/nvim-tree.lua', lazy = true,
        cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            local function my_on_attach(bufnr)
                local api = require('nvim-tree.api')
                local function opts(desc)
                    return {desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true}
                end
                -- default mappings
                api.config.mappings.default_on_attach(bufnr)
                -- custom mappings
                vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
                vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
                vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
                vim.keymap.set('n', 'i', api.node.show_info_popup, opts('Info'))
                vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
            end
            require("nvim-tree").setup {
                on_attach = my_on_attach,
                view = {
                    float = {enable = true},
                    width = {
                        min = 30,
                        max = 60
                    }
                },
                renderer = {
                    indent_markers = {
                        enable = true
                    }
                },
                filters = {
                    git_ignored = false,
                    custom = {'*.beam'}
                }
            }
        end,
    },

    { 'nyngwang/NeoZoom.lua',
        config = function ()
            require('neo-zoom').setup {
                popup = {
                  enabled = true,
                  exclude_filetypes = {},
                  exclude_buftypes = {},
                },
                exclude_buftypes = { 'terminal' },
                -- exclude_filetypes = { 'lspinfo', 'mason', 'lazy', 'fzf', 'qf' },
                winopts = {
                    offset = {
                        -- NOTE: omit `top`/`left` to center the floating window vertically/horizontally.
                        -- top = 0,
                        -- left = 0.17,
                        width = 120,
                        height = 0.85,
                    },
                    -- NOTE: check :help nvim_open_win() for possible border values.
                    border = 'thicc', -- this is a preset, try it :)
                },
                presets = {
                    {
                        filetypes = {"markdown"},
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

    { 'nanozuki/tabby.nvim', lazy = false, event = 'VimEnter',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('tabby.tabline').use_preset('tab_only', {
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
        ft = {"markdown"},
        config = function()
            require("wrapping").setup({
                auto_set_mode_filetype_allowlist = {
                    "asciidoc", "gitcommit", "latex", "mail",
                    "markdown", "rst", "tex", "text",
                },
            })
        end
    },

    { 'johnfrankmorgan/whitespace.nvim', lazy = true,
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
        end,
        keys = {
            { "<leader>s", "<cmd>lua require('whitespace-nvim').trim()<cr>" },
        },
    },
}
