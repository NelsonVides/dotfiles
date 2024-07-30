return{
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
                livePreview = true -- Apply theme while browsing. Default to true.
            }
        end
    },
    { 'folke/tokyonight.nvim', name = "tokyonight", lazy = true },
    { 'tiagovla/tokyodark.nvim', name = "tokyodark", lazy = true },
    { 'bluz71/vim-nightfly-colors', name = "nightfly", lazy = true },
    { 'catppuccin/nvim', name = "catppuccin", lazy = true },
    { 'rebelot/kanagawa.nvim', name = "kanagawa", lazy = true },
    { 'ellisonleao/gruvbox.nvim', name = "gruvbox", lazy = true },
    { 'Mofiqul/vscode.nvim', name = "vscode", lazy = true },
    { 'Mofiqul/dracula.nvim', name = "dracula", lazy = true },
}
