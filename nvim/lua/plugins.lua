return {

    { 'nvim-lua/plenary.nvim' },

    { 'tpope/vim-fugitive', lazy = true,
        cmd = { 'Git' },
        keys = {
            { "<leader>b", "<cmd>:Git blame<cr>" },
        },
    },

    { 'jiaoshijie/undotree', lazy = true,
        dependencies = 'nvim-lua/plenary.nvim',
        config = true,
        keys = {
            { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
        },
    },

    { 'olimorris/persisted.nvim', lazy = false,
        cmd = { 'SessionLoad', 'SessionSave', 'SessionDelete' },
        config = function()
            require('persisted').setup({
                use_git_branch = false, -- create session files based on the branch of a git enabled repository
                autoload = false, -- Automatically load the session for the cwd on Neovim startup?
                autosave = true, -- automatically save session files when exiting Neovim
                should_autosave = function() return vim.bo.filetype ~= "dashboard" end, -- do not autosave if the dashboard is the current filetype
                follow_cwd = true, -- change session file name to match current working directory if it changes
                should_save = function()
                    -- Do not save if a dashboard is the current filetype
                    if vim.bo.filetype == "dashboard" then
                        return false
                    end
                    return true
                end,
            })
        end
    },

    { 'richardbizik/nvim-toc', lazy = true,
        ft = {"markdown"},
        config = function()
            require("nvim-toc").setup({})
        end
    },

    { 'iamcco/markdown-preview.nvim', lazy = true,
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = function() vim.fn["mkdp#util#install"]() end,
        config = function()
            vim.g.mkdp_open_to_the_world = true
        end,
        keys = {
            { "<leader>P", "<cmd>:MarkdownPreview<cr>" },
        },
    },

    { 'kylechui/nvim-surround', lazy = true,
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = true
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
            require("telescope").load_extension("persisted")
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
                }
            }
        end
    },

    { 'andymass/vim-matchup' },

    { 'rmagatti/alternate-toggler',
        event = { "BufReadPost" }, -- lazy load after reading a buffer
        config = function()
            require("alternate-toggler").setup {
                alternates = {
                    ["ok"] = "error",
                    ["left"] = "right",
                    ["=="] = "!=",
                }
            }
            vim.keymap.set("n", "<leader><space>", -- <space><space>
                "<cmd>lua require('alternate-toggler').toggleAlternate()<CR>"
            )
        end,
    }

}
