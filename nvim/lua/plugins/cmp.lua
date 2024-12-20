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
    },
    { 'saadparwaiz1/cmp_luasnip' },

    -- cmp
    { 'onsails/lspkind.nvim' },
    { 'chrisgrieser/cmp_yanky' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'lukas-reineke/cmp-under-comparator' },
    { 'petertriho/cmp-git' },
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
            'petertriho/cmp-git',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-cmdline',
            'onsails/lspkind.nvim',
            'zbirenbaum/copilot-cmp',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local lspkind = require('lspkind')
            cmp.setup({
                window = {},
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
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        menu = ({
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[Latex]",
                        }),
                        symbol_map = { Copilot = "" }
                    }),
                },
                sources = cmp.config.sources(
                    {
                        { name = 'nvim_lsp' },
                        { name = 'nvim_lsp_signature_help' },
                        { name = 'luasnip' },
                        { name = "copilot" },
                        { name = 'buffer',
                            option = {
                                get_bufnrs = function()
                                    local bufs = {}
                                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                                        bufs[vim.api.nvim_win_get_buf(win)] = true
                                    end
                                    return vim.tbl_keys(bufs)
                                end
                            }
                        },
                        { name = 'cmp_yanky' }
                    },
                    {
                        { name = 'calc' },
                        { name = 'path', option = {
                            trailing_slash = true,
                            label_trailing_slash = true
                        } },
                    }),
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ["<C-n>"] = cmp.mapping({
                        c = function()
                            if cmp.visible() then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                            else
                                vim.api.nvim_feedkeys(t("<Down>"), "n", true)
                            end
                        end,
                        i = function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                            else
                                fallback()
                            end
                        end,
                    }),
                    ["<C-p>"] = cmp.mapping({
                        c = function()
                            if cmp.visible() then
                                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                            else
                                vim.api.nvim_feedkeys(t("<Up>"), "n", true)
                            end
                        end,
                        i = function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                            else
                                fallback()
                            end
                        end,
                    }),
                    ["<CR>"] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = false }),
                        -- c = cmp.mapping.confirm({ select = false }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
                    }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            else
                                cmp.select_next_item()
                            end
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        elseif require("copilot.suggestion").is_visible() then
                            require("copilot.suggestion").accept()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if #cmp.get_entries() == 1 then
                                cmp.confirm({ select = true })
                            else
                                cmp.select_prev_item()
                            end
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
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
