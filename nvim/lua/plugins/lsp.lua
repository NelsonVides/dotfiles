local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

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

    { 'CopilotC-Nvim/CopilotChat.nvim',
        -- version = "v3.3.0", -- Use a specific version to prevent breaking changes
        dependencies = {
            { 'zbirenbaum/copilot.lua' }, -- or zbirenbaum/copilot.lua
            { 'nvim-telescope/telescope.nvim' }, -- Use telescope for help actions
            { 'nvim-lua/plenary.nvim' },
        },
        opts = {
            question_header = "## User ",
            answer_header = "## Copilot ",
            error_header = "## Error ",
            prompts = prompts,
            auto_follow_cursor = false, -- Don't follow the cursor after getting response
            mappings = {
                -- Use tab for completion
                complete = {
                    detail = "Use @<Tab> or /<Tab> for options.",
                    insert = "<Tab>",
                },
                -- Close the chat
                close = {
                    normal = "q",
                    insert = "<C-c>",
                },
                -- Reset the chat buffer
                reset = {
                    normal = "<C-x>",
                    insert = "<C-x>",
                },
                -- Submit the prompt to Copilot
                submit_prompt = {
                    normal = "<CR>",
                    insert = "<C-CR>",
                },
                -- Accept the diff
                accept_diff = {
                    normal = "<C-y>",
                    insert = "<C-y>",
                },
                -- Show help
                show_help = {
                    normal = "g?",
                },
            },
        },
        config = function(_, opts)
            local chat = require("CopilotChat")
            chat.setup(opts)

            local select = require("CopilotChat.select")
            vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
                chat.ask(args.args, { selection = select.visual })
            end, { nargs = "*", range = true })

            -- Inline chat with Copilot
            vim.api.nvim_create_user_command("CopilotChatInline", function(args)
                chat.ask(args.args, {
                    selection = select.visual,
                    window = {
                        layout = "float",
                        relative = "cursor",
                        width = 1,
                        height = 0.4,
                        row = 1,
                    },
                })
            end, { nargs = "*", range = true })

            -- Restore CopilotChatBuffer
            vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
                chat.ask(args.args, { selection = select.buffer })
            end, { nargs = "*", range = true })

            -- Custom buffer for CopilotChat
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-*",
                callback = function()
                    vim.opt_local.relativenumber = true
                    vim.opt_local.number = true

                    -- Get current filetype and set it to markdown if the current filetype is copilot-chat
                    local ft = vim.bo.filetype
                    if ft == "copilot-chat" then
                        vim.bo.filetype = "markdown"
                    end
                end,
            })
        end,
        event = "VeryLazy",
        keys = {
            -- Show prompts actions with telescope
            {
                "<leader>ap",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                end,
                desc = "CopilotChat - Prompt actions",
            },
            {
                "<leader>ap",
                ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
                mode = "x",
                desc = "CopilotChat - Prompt actions",
            },
            -- Code related commands
            { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
            { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
            { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
            { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
            { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
            -- Chat with Copilot in visual mode
            {
                "<leader>av",
                ":CopilotChatVisual",
                mode = "x",
                desc = "CopilotChat - Open in vertical split",
            },
            {
                "<leader>ax",
                ":CopilotChatInline<cr>",
                mode = "x",
                desc = "CopilotChat - Inline chat",
            },
            -- Custom input for CopilotChat
            {
                "<leader>ai",
                function()
                    local input = vim.fn.input("Ask Copilot: ")
                    if input ~= "" then
                        vim.cmd("CopilotChat " .. input)
                    end
                end,
                desc = "CopilotChat - Ask input",
            },
            -- Generate commit message based on the git diff
            {
                "<leader>am",
                "<cmd>CopilotChatCommit<cr>",
                desc = "CopilotChat - Generate commit message for all changes",
            },
            -- Quick chat with Copilot
            {
                "<leader>aq",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        vim.cmd("CopilotChatBuffer " .. input)
                    end
                end,
                desc = "CopilotChat - Quick chat",
            },
            -- Debug
            { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
            -- Fix the issue with diagnostic
            { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
            -- Clear buffer and chat history
            { "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
            -- Toggle Copilot Chat Vsplit
            { "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
            -- Copilot Chat Models
            { "<leader>a?", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Select Models" },
            -- Copilot Chat Agents
            { "<leader>aa", "<cmd>CopilotChatAgents<cr>", desc = "CopilotChat - Select Agents" },
        },
    },

}
