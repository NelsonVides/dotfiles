return {

    { 'neovim/nvim-lspconfig' },

    { 'nvim-treesitter/nvim-treesitter',
        config = function()
            require("nvim-treesitter.install").prefer_git = true
            require('nvim-treesitter.configs').setup {
                ensured_installed = {
                    "erlang", "elixir", "c", "cpp", "rust",
                    "lua", "sql", "bash", "make", "cmake", "diff", "dockerfile",
                    "git_config", "git_rebase", "gitcommit", "gitignore", "ssh_config",
                    "html", "xml", "json", "latex", "markdown", "toml", "yaml", "regex"
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
                highlight = {
                    enable = true,
                    disable = {"lua", "vimdoc"}
                },
                indent = {
                    enable = true, -- this is an experimental feature
                    disable = {"lua", "vimdoc"}
                },
                matchup = {
                    enable = false
                },
            }
        end,
    },

    { 'zaldih/themery.nvim',
        priority = 1000,
        config = function()
            require('themery').setup {
                themes = {
                    "tokyonight-night",
                    "tokyonight-storm",
                    "tokyonight-moon",
                    "tokyodark",
                    "nightfly",
                    "catppuccin-mocha",
                    "catppuccin-macchiato",
                    "catppuccin-frappe",
                    "kanagawa-wave",
                    "kanagawa-dragon",
                    "dracula",
                    "dracula-soft",
                    { name = "VSCode dark", colorscheme = "vscode",
                        before = [[ vim.opt.background = "dark" ]] },
                    { name = "Gruvbox dark", colorscheme = "gruvbox",
                        before = [[ vim.opt.background = "dark" ]] },
                    { name = "VSCode (light)", colorscheme = "vscode",
                        before = [[ vim.opt.background = "light" ]] },
                    { name = "Gruvbox (light)", colorscheme = "gruvbox",
                        before = [[ vim.opt.background = "light" ]] },
                    { name = "tokyonight-day (light)", colorscheme = "tokyonight-day"},
                    { name = "catppuccin-latte (light)", colorscheme = "catppuccin-latte"},
                    { name = "kanagawa-lotus (light)", colorscheme = "kanagawa-lotus"},
                }, -- Your list of installed colorschemes
                themeConfigFile = "lua/theme.lua", -- Described below
                livePreview = true -- Apply theme while browsing. Default to true.
            }
        end
    },
    { 'folke/tokyonight.nvim', name = "tokyonight" },
    { 'tiagovla/tokyodark.nvim', name = "tokyodark" },
    { 'bluz71/vim-nightfly-colors', name = "nightfly" },
    { 'catppuccin/nvim', name = "catppuccin" },
    { 'rebelot/kanagawa.nvim', name = "kanagawa" },
    { 'ellisonleao/gruvbox.nvim', name = "gruvbox" },
    { 'Mofiqul/vscode.nvim', name = "vscode" },
    { 'Mofiqul/dracula.nvim', name = "dracula" },

    { 'nvim-lualine/lualine.nvim',
        config = function ()
            require('lualine').setup {
                theme = 'vscode',
                options = {
                    icons_enabled = false,
                    theme = gruvbox_light,
                    -- theme = nord_theme,
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    -- lualine_c = {'filename', {require('auto-session.lib').current_session_name}},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                -- tabline = {
                --     lualine_a = {
                --         {
                --             'buffers',
                --             mode = 2,
                --             symbols = {
                --                 modified = ' *',     -- Text to show when the buffer is modified
                --                 alternate_file = '', -- Text to show to identify the alternate file
                --                 directory =  '',     -- Text to show when the buffer is a directory
                --             },
                --         }
                --     },
                --     lualine_b = {},
                --     lualine_c = {},
                --     lualine_x = {},
                --     lualine_y = {},
                --     lualine_z = {}
                -- },
            }
        end
    },

    { 'nvimdev/dashboard-nvim',
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

    { 'nvim-lua/plenary.nvim' },

    { 'tpope/vim-fugitive',
        keys = {
            { "<leader>b", "<cmd>:Git blame<cr>" },
        },
    },
    { 'sindrets/diffview.nvim' },
    { 'NeogitOrg/neogit',
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',         -- required
            'sindrets/diffview.nvim',        -- optional - Diff integration
            -- Only one of these is needed, not both.
            -- 'nvim-telescope/telescope.nvim', -- optional
            -- 'ibhagwan/fzf-lua',              -- optional
        },
        keys = {
            { "<leader>g", "<cmd>:Neogit kind=floating<cr>" },
            { "<leader>d", "<cmd>:Neogit diff<cr>" }
        },
        config = true,
    },

    { 'jiaoshijie/undotree',
        dependencies = 'nvim-lua/plenary.nvim',
        config = true,
        keys = {
            { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
        },
    },

    { 'terrortylor/nvim-comment',
        config = function()
            require('nvim_comment').setup {}
        end
    },

    { 'nvimdev/dbsession.nvim',
        cmd = { 'SessionSave', 'SessionDelete', 'SessionLoad'},
        opts = {
            auto_save_on_exit = true
        }
    },

    -- { 'rmagatti/auto-session',
    --     config = function()
    --         require('auto-session').setup {
    --             log_level = "error",
    --             auto_session_enabled = false,
    --             auto_session_enabled_last_session = true,
    --             auto_save_enabled = true,
    --             auto_restore_enabled = false,
    --             auto_session_suppress_dirs = { "~/", "/"},
    --             auto_session_use_git_branch = true
    --         }
    --     end,
    --     cmd = "SessionRestore",
    -- },

    { 'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup {
              default = true
            }
        end
    },

    { 'nvim-tree/nvim-tree.lua',
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
                    float = {enable = true}
                }
            }
        end,
    },

    { 'johnfrankmorgan/whitespace.nvim',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function ()
            require('whitespace-nvim').setup {
                highlight = 'DiffDelete',
                ignored_filetypes = {
                    'TelescopePrompt',
                    'dashboard',
                    'Trouble',
                    'NeogitPopup',
                    'help' },
                ignore_terminal = true,
            }
            vim.keymap.set('n', '<Leader>s', require('whitespace-nvim').trim)
        end
    },

    { 'kylechui/nvim-surround',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup {}
        end
    },

    { 'yorickpeterse/nvim-window',
        keys = {
            { "<leader>w", "<cmd>lua require('nvim-window').pick()<cr>" },
        },
        config = true,
    },

    { 'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({
                check_ts = true
            })
        end
    },

    { 'akinsho/toggleterm.nvim',
        config = function()
            require('toggleterm').setup {
                open_mapping = [[<leader>t]],
                insert_mappings = false,
                direction = 'float'
            }
        end
    },

    { 'ms-jpq/coq_nvim', config = function() require('coq') end },
    { 'ms-jpq/coq.artifacts' },

    { 'nvim-telescope/telescope-fzy-native.nvim' },
    { 'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup {
                defaults = {
                    preview = {
                        treesitter = false
                    }
                },
                extensions = {
                    fzy_native = {
                        override_generic_sorter = false,
                        override_file_sorter = true,
                    }
                }
            }
            require('telescope').load_extension('fzy_native')
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
        end
    },

    { 'alexghergh/nvim-tmux-navigation', -- TODO
        config = function()
            require('nvim-tmux-navigation').setup {
                keybindings = {
                    left = "<C-h>",
                    down = "<C-j>",
                    up = "<C-k>",
                    right = "<C-l>",
                    -- last_active = "<C-\\>",
                    next = "<C-Space>",
                }
            }
        end
    },

    -- { 'nanozuki/tabby.nvim', -- TODO
    --     dependencies = 'nvim-tree/nvim-web-devicons',
    --     config = function()
    --         require('tabby.tabline').use_preset('tab_with_top_win', {
    --           theme = {
    --             fill = 'TabLineFill',       -- tabline background
    --             head = 'TabLine',           -- head element highlight
    --             current_tab = 'TabLineSel', -- current tab label highlight
    --             tab = 'TabLine',            -- other tab label highlight
    --             win = 'TabLine',            -- window highlight
    --             tail = 'TabLine',           -- tail element highlight
    --           },
    --           nerdfont = true,              -- whether use nerdfont
    --           lualine_theme = "vscode",          -- lualine theme name
    --           tab_name = {
    --             name_fallback = function(tabid)
    --               return tabid
    --             end,
    --           },
    --           buf_name = {
    --             mode = "'unique'|'relative'|'tail'|'shorten'",
    --           },
    --         })
    --     end
    -- },

    { 'andymass/vim-matchup' },
    { 'manu-mannattil/vim-longlines',
        ft = "markdown",
        cmd = "LongLines",
    },

}
