syntax enable
filetype plugin indent on

function! ChompSystemEndOfLine(string)
    return substitute(a:string, '\n\+$', '', '')
endfunction

function! LightlineObsession()
    return '%{ObsessionStatus(''$'', '''')}'
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Erlang tags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! AsyncBuildOtpTags()
    let otppath = ChompSystemEndOfLine(system("asdf where erlang"))
    let arg = "-i " . otppath . " -o " . otppath . "/otptags"
    call AsyncVimErlangTags(arg)
endfunction

function! GetOtpTagsPath()
    return ChompSystemEndOfLine(system("asdf where erlang")) . "/otptags"
endfunction

function! BuildMongooseTags()
    let arg = "--include include src test big_tests _build "
          \ . "--ignore _build/mim1 _build/mim2 _build/mim3 _build/fed1 _build/reg1 _build/prod "
          \ .           "big_tests/_build/ct_report "
          \ .           "big_tests/deps/ "
          \ .           "_build/default/lib/mongooseim "
          \ .           "_build/test/lib/mongooseim "
          \ .           "--match-mode full_func_name_args"
    call AsyncVimErlangTags(arg)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dein section
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add the dein installation directory into runtimepath
set runtimepath+=~/.config/dein/repos/github.com/Shougo/dein.vim
let g:python3_host_prog = '/usr/bin/python3'
let mapleader = "\\"
if dein#load_state('~/.config/dein')
    call dein#begin('~/.config/dein')
    call dein#add('~/.config/dein/repos/github.com/Shougo/dein.vim')

    call dein#add('neovim/nvim-lspconfig')
    call dein#add('glepnir/lspsaga.nvim')
    call dein#add('nvim-lua/completion-nvim')
    call dein#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})
    call dein#add('nvim-lua/popup.nvim')
    call dein#add('nvim-lua/plenary.nvim')
    call dein#add('nvim-telescope/telescope.nvim')
    call dein#add('kyazdani42/nvim-web-devicons')

    call dein#add('windwp/nvim-autopairs')

    call dein#add('tpope/vim-sensible')
    call dein#add('tpope/vim-obsession')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-fugitive')
    call dein#add('gcmt/taboo.vim')
    call dein#add('ntpeters/vim-better-whitespace')

    call dein#add('christoomey/vim-system-copy')
    let g:system_copy#copy_command='xclip -selection clipboard'
    let g:system_copy#paste_command='xclip -selection clipboard -o'
    " cpiw => copy word into system clipboard
    " cpi' => copy inside single quotes to system clipboard
    " The sequence cv is mapped to paste the content of system clipboard to the next line.

    " DESIGN
    call dein#add('christoomey/vim-tmux-navigator')
    call dein#add('flazz/vim-colorschemes')
    call dein#add('itchyny/lightline.vim')
    let g:lightline = {
                \ 'colorscheme': 'wombat',
                \ 'active': {
                \   'left':  [ ['mode', 'paste' ],
                \              ['gitbranch', 'readonly', 'filename', 'modified' ] ],
                \   'right': [ ['percent', 'lineinfo'],
                \              ['fileformat', 'fileencoding', 'filetype', 'filesize'],
                \              ['obsession'] ]
                \ },
                \ 'component_function': {
                \   'gitbranch': 'fugitive#head'
                \ },
                \ 'component_expand': {
                \   'obsession': 'LightlineObsession'
                \ },
                \ }

    """ LANGUAGE PLUGGINS
    " ERLANG
    call dein#add('NelsonVides/vim-erlang-tags', {
                \ 'on_ft' : 'erlang',
                \ 'on_func': ['BuildMongooseTags', 'AsyncVimErlangTags'],
                \ 'hook_post_source': 'let &tags .= "," . GetOtpTagsPath()'
                \ })

    """ LAZY LOAD ON COMMAND EXECUTED
    call dein#add('jeetsukumaran/vim-buffergator', {'on_cmd': 'BuffergatorToggle'})
    call dein#add('mbbill/undotree', {'on_cmd': 'UndotreeToggle'})
    call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})
    call dein#add('vimlab/split-term.vim', {'on_cmd': ['Term', 'VTerm', '10Term']})
    call dein#add('majutsushi/tagbar', {'on_cmd': ['Tagbar']})
    call dein#add('manu-mannattil/vim-longlines', {'on_ft':'markdown'})

    call dein#end()
    call dein#save_state()
endif

colorscheme 256-jungle
highlight SpellBad ctermbg=none ctermfg=none cterm=underline
highlight Comment ctermfg=red

set sessionoptions+=tabpages,globals
autocmd VimEnter * call dein#call_hook('post_source')
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd BufNewFile,BufRead *.config set filetype=erlang
autocmd BufNewFile,BufRead *.spec set filetype=erlang
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType markdown setlocal ts=2 sts=2 sw=2 expandtab
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>
nnoremap <leader>rm :!rm %
nnoremap <leader>f :TagbarToggle<CR>
nnoremap <leader>c :TagbarOpenAutoClose<CR>
nnoremap <leader>cp :let @" = expand("%:p")<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
local nvim_lsp = require('lspconfig')

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
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  require('completion').on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  --Enable completion triggered by <c-x><c-o>
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "erlangls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local saga = require('lspsaga')
require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
}

require'nvim-web-devicons'.setup {
  override = {},
  default = true
}

require('nvim-autopairs').setup()

local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options
local o = vim.o -- a table to access global variables
local wo = vim.wo
local bo = vim.bo

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
bo.swapfile = false
wo.wrap = false
wo.number = true -- Show line numbers
wo.relativenumber = true -- Relative line numbers
wo.colorcolumn = "101"

EOF
