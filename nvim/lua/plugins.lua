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
                    lualine_b = {'branch', 'diff', 'diagnostics'},
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

    { 'nvim-lua/plenary.nvim' },

    { 'tpope/vim-fugitive', lazy = true,
        cmd = { 'Git' },
        keys = {
            { "<leader>b", "<cmd>:Git blame<cr>" },
        },
    },
    { 'sindrets/diffview.nvim', lazy = true },

    { 'jiaoshijie/undotree', lazy = true,
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

    { 'olimorris/persisted.nvim', lazy = false,
        cmd = { 'SessionLoad', 'SessionSave', 'SessionDelete' },
        config = function()
            require('persisted').setup({
                use_git_branch = true, -- create session files based on the branch of a git enabled repository
                default_branch = "main", -- the branch to load if a session file is not found for the current branch
                autosave = true, -- automatically save session files when exiting Neovim
                should_autosave = function() return vim.bo.filetype ~= "dashboard" end, -- do not autosave if the dashboard is the current filetype
                follow_cwd = true, -- change session file name to match current working directory if it changes
            })
        end
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
    { 'iamcco/markdown-preview.nvim',
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        config = function()
            vim.g.mkdp_open_to_the_world = true
        end,
        keys = {
            { "<leader>P", "<cmd>:MarkdownPreview<cr>" },
        },
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
                    float = {enable = true}
                },
                filters = {
                    git_ignored = false,
                    custom = {'*.beam'}
                }
            }
        end,
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

    { 'kylechui/nvim-surround', lazy = true,
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = true
    },

    { 'yorickpeterse/nvim-window', lazy = true,
        keys = {
            { "<leader>w", "<cmd>lua require('nvim-window').pick()<cr>" },
        },
        config = true,
    },

    { 'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require('nvim-autopairs').setup({
                check_ts = true
            })
        end
    },

    { 'gbprod/yanky.nvim', lazy = true,
        opts = {},
    },

    { 'p00f/clangd_extensions.nvim', lazy = true,
        config = true,
        opts = {
            inlay_hints = {
                inline = false,
            },
            ast = {
                role_icons = {
                    type = "",
                    declaration = "",
                    expression = "",
                    specifier = "",
                    statement = "",
                    ["template argument"] = "",
                },
                kind_icons = {
                    Compound = "",
                    Recovery = "",
                    TranslationUnit = "",
                    PackExpansion = "",
                    TemplateTypeParm = "",
                    TemplateTemplateParm = "",
                    TemplateParamObject = "",
                },
            },
        },
    },

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

    { 'alexghergh/nvim-tmux-navigation',
        config = function()
            require('nvim-tmux-navigation').setup {
                disable_when_zoomed = true, -- defaults to false
                keybindings = {
                    left = "<C-h>",
                    down = "<C-j>",
                    up = "<C-k>",
                    right = "<C-l>",
                    next = "<C-Space>",
                }
            }
        end
    },

    { 'backdround/global-note.nvim', lazy = true,
        cmd = { 'GlobalNote' },
        config = function()
            local global_note = require("global-note")
            local get_project_dir = function()
                local project_directory, err = vim.loop.cwd()
                if project_directory == nil then
                    vim.notify(err, vim.log.levels.WARN)
                    return nil
                end
                return project_directory
            end
            local get_project_name = function()
                local project_directory = get_project_dir()
                if project_directory == nil then return nil end
                local project_name = vim.fs.basename(project_directory)
                if project_name == nil then
                    vim.notify("Unable to get the project name", vim.log.levels.WARN)
                    return nil
                end
                return project_name
            end
            global_note.setup({
                additional_presets = {
                    projects = {
                        title = "Projects Note",
                        command_name = "ProjectsNote",
                        directory = get_project_dir,
                        filename = function() return get_project_name() .. ".md" end,
                    }
                }
            })
            vim.keymap.set("n", "<leader>m", global_note.toggle_note)
            vim.keymap.set("n", "<leader>p", function() global_note.toggle_note('projects') end)
        end,
        keys = {
            { "<leader>m", "<cmd>:GlobalNote<cr>" },
            { "<leader>p", "<cmd>:ProjectsNote<cr>" },
        },
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


    { 'andymass/vim-matchup' },
}
