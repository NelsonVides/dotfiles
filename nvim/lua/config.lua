-- local actions = require('telescope.actions')
-- require('telescope').setup{
--   defaults = {
--     mappings = {
--       n = {
--         ["q"] = actions.close
--       },
--     },
--   },
--   extensions = {
--     frecency = {
--       show_scores = true,
--       show_unindexed = true,
--       workspaces = {
--         ["conf"]    = "/home/videsnelson/.config",
--         ["data"]    = "/home/videsnelson/.local/share",
--         ["repos"]   = "/home/videsnelson/repos",
--         ["wiki"]    = "/home/videsnelson/wiki"
--       }
--     }
--   }
-- }
-- require('telescope').load_extension('fzy_native')
-- require('telescope').load_extension('frecency')

-- local saga = require('lspsaga')
require'nvim-web-devicons'.setup {
  default = true,
  override = {}
}

require('nvim-autopairs').setup({
    check_ts = true
})

local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options
local o = vim.o -- a table to access global variables
local wo = vim.wo
local bo = vim.bo

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
-- opt.foldenable = false -- Disable folding at startup.

o.completeopt = "menuone,noinsert,noselect"
o.showmode = false
o.equalalways = false
o.autoread = true
o.laststatus = 2
o.splitbelow = true -- Put new windows below current
o.splitright = true -- Put new windows right of current
o.textwidth = 100
o.tabstop = 4 -- The width of a TAB is set to 4.
o.shiftwidth = 4 -- Indents will have a width of 4
o.softtabstop = 4 -- Sets the number of columns to a TAB
o.expandtab = true -- Expand TABs to spaces
o.swapfile = false
wo.wrap = false
wo.number = true -- Show line numbers
wo.relativenumber = true -- Relative line numbers
wo.colorcolumn = "101"
