return {

    { 'nyngwang/NeoTerm.lua',
        config = function ()
            require('neo-term').setup {
                exclude_filetypes = { 'oil' },
                -- exclude_buftypes = {}, -- 'terminal' will always be added by NeoTerm.lua
                -- enabled by default!
                -- presets = {
                --   'vim-test',
                -- }
            }
            vim.keymap.set('n', '<leader>t', function () vim.cmd('NeoTermToggle') end)
            vim.keymap.set('t', '<leader>t', function () vim.cmd('NeoTermToggle') end)
            vim.keymap.set('t', '<esc>', function () vim.cmd('NeoTermEnterNormal') end)
        end
    },

    { 'chomosuke/term-edit.nvim',
        lazy = false, -- or ft = 'toggleterm' if you use toggleterm.nvim
        version = '1.*',
        config = function()
            require 'term-edit'.setup {
                prompt_end = '%$ ',
            }
        end
    },

    { 'samjwill/nvim-unception',
        init = function()
            -- Optional settings go here!
            -- e.g.) vim.g.unception_open_buffer_in_new_tab = true
        end
    },

}
