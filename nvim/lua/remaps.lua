-------------------------------------------------------------------------------
-- remap section
-------------------------------------------------------------------------------
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('i', '<C-d>', '<esc>ddi')
map('i', '<C-u>', '<esc>viWUi')

map('n', 'Q', ':q<CR>')
map('n', '<Esc><Esc>', ':update<CR>')
map('n', '<C-n>', ':NERDTreeToggle<CR>')
map('n', '<C-m>', ':NERDTreeFocus<CR>')
map('n', '<leader>n', ':1tag!<CR>')

map('n', '<leader>1', '1gt')
map('n', '<leader>2', '2gt')
map('n', '<leader>3', '3gt')
map('n', '<leader>4', '4gt')
map('n', '<leader>5', '5gt')
map('n', '<leader>6', '6gt')
map('n', '<leader>7', '7gt')
map('n', '<leader>8', '8gt')
map('n', '<leader>9', '9gt')
map('n', '<leader>0', ':tablast<CR>')
map('n', '<leader>t', ':Term<CR>')

map('i', '<silent><C-k>', '<Cmd>Lspsaga signature_help<CR>')
map('n', '<silent>K', ':Lspsaga hover_doc<CR>')
map('n', '<silent>gh', '<Cmd>Lspsaga lsp_finder<CR>')

map('n', 'ff', '<cmd>Telescope find_files<CR>')
map('n', 'fr', '<cmd>Telescope live_grep<CR>')
map('n', 'fb', '<cmd>Telescope buffers<CR>')
map('n', 'fh', '<cmd>Telescope help_tags<CR>')
