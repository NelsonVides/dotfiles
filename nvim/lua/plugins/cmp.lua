return {
    -- Snippets
    { 'rafamadriz/friendly-snippets' },
    { 'honza/vim-snippets' },
    { 'L3MON4D3/LuaSnip',
        build = "make install_jsregexp",
        dependencies = {
            'rafamadriz/friendly-snippets',
            'honza/vim-snippets'
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load({
                paths = { vim.fn.stdpath("config") .. "/snippets" },
            })
        end,
        keys = {
            {
                "<leader><leader>;",
                function() require("luasnip").jump(1) end,
                desc = "Jump forward a snippet placement",
                mode = "i",
                noremap = true,
                silent = true
            }, {
                "<leader><leader>,",
                function() require("luasnip").jump(-1) end,
                desc = "Jump backward a snippet placement",
                mode = "i",
                noremap = true,
                silent = true
            }
        },
    },
    { 'saadparwaiz1/cmp_luasnip' },

    -- cmp
    { 'chrisgrieser/cmp_yanky' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'lukas-reineke/cmp-under-comparator' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-calc' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'chrisgrieser/cmp_yanky',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'lukas-reineke/cmp-under-comparator',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-cmdline',
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                sorting = {
                    comparators = {
                        function(...) return require('cmp_buffer'):compare_locality(...) end,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.exact,
                        cmp.config.compare.offset,
                        cmp.config.compare.score,
                        require("clangd_extensions.cmp_scores"),
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                window = {},
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources(
                    {
                        { name = 'nvim_lsp' },
                        { name = 'nvim_lsp_signature_help' },
                        { name = 'buffer' },
                        { name = 'luasnip' },
                        { name = 'neorg' },
                        { name = 'calc' },
                        { name = 'cmp_yanky' }
                    },
                    {
                        { name = 'path', option = {
                            trailing_slash = true,
                            label_trailing_slash = true
                        } },
                    })
            })
            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                },
                {
                    { name = 'buffer' },
                })
            })
            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path', option = {
                        trailing_slash = true,
                        label_trailing_slash = true
                    } },
                }, {
                    { name = 'cmdline' }
                })
            })
        end
    }
}
