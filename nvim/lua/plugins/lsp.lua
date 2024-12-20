-------------------------------------------------------------------------------
-- LSP config sections
-------------------------------------------------------------------------------

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    --   require('completion').on_attach(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    --Enable completion triggered by <c-x><c-o>
    --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    local opts = { noremap=true, silent=true }
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     'documentation',
--     'detail',
--     'additionalTextEdits',
--   }
-- }

return {
    { 'neovim/nvim-lspconfig',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },

        config = function()
            local nvim_lsp = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics, {
                    -- delay update diagnostics
                    update_in_insert = true,
                }
            )

            local path_to_elp = vim.fn.expand("~/repos/public/erlang-language-platform/target/github/elp")
            nvim_lsp.elp.setup({
                cmd = {path_to_elp, 'server'},
                on_attach = on_attach,
                capabilities = capabilities,
                flags = {
                    exit_timeout = 0,
                }
            })

            local path_to_elixir_lexical = vim.fn.expand("~/repos/public/lexical/_build/prod/package/lexical/bin/start_lexical.sh")
            nvim_lsp.lexical.setup({
                cmd = {path_to_elixir_lexical},
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "elixir", "eelixir", "heex" },
                settings = {},
            })

            local path_to_clangd = vim.fn.expand("/usr/bin/clangd")
            nvim_lsp.clangd.setup({
                cmd = {path_to_clangd},
                on_attach = on_attach,
                capabilities = capabilities
            })

            local path_to_ltex = vim.fn.expand("~/.cache/ltex-ls/bin/ltex-ls")
            nvim_lsp.ltex.setup({
                cmd = {path_to_ltex},
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { 'gitcommit', 'markdown', 'org', 'norg', 'tex', 'html', 'xhtml' },
                flags = { debounce_text_changes = 300 },
                settings = {
                    ltex = {
                        language = "en-GB",
                        disabledRules = {
                            ["en-GB"] = {
                                "MORFOLOGIK_RULE_EN_GB",
                                "OXFORD_SPELLING_Z_NOT_S",
                                "WHITESPACE_RULE"
                            },
                        },
                    }
                },
            })
        end
    },

    { 'p00f/clangd_extensions.nvim', lazy = true, config = true },

    { 'zbirenbaum/copilot.lua', lazy = true,
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require('copilot').setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end
    },

    { 'zbirenbaum/copilot-cmp', lazy = true,
        config = function ()
            require("copilot_cmp").setup()
        end
    },

}
