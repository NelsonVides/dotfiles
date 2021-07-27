if &compatible
    set nocompatible
endif
" Add the dein installation directory into runtimepath

function! ChompSystemEndOfLine(string)
    return substitute(a:string, '\n\+$', '', '')
endfunction

function! LightlineObsession()
    return '%{ObsessionStatus(''$'', '''')}'
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTP Tags section
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! AsyncBuildOtpTags()
    let otppath = ChompSystemEndOfLine(system("asdf where erlang"))
    let arg = "-i " . otppath . " -o " . otppath . "/otptags"
    call AsyncVimErlangTags(arg)
endfunction

function! GetOtpTagsPath()
    return ChompSystemEndOfLine(system("asdf where erlang")) . "/otptags"
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MongooseIM section
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! BuildMongooseTags()
    let arg = "--include include src test big_tests _build "
          \ . "--ignore _build/mim1 _build/mim2 _build/mim3 _build/fed1 _build/reg1 _build/prod "
          " \ .           "big_tests/_build/ct_report "
          \ .           "big_tests/deps/ "
          \ .           "_build/default/lib/mongooseim "
          \ .           "_build/test/lib/mongooseim "
          \ .           "--match-mode full_func_name_args"
    call AsyncVimErlangTags(arg)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dein section
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath+=~/.config/dein/repos/github.com/Shougo/dein.vim
let mapleader = "\\"
if dein#load_state('~/.config/dein')
    call dein#begin('~/.config/dein')
    call dein#add('~/.config/dein/repos/github.com/Shougo/dein.vim')

    call dein#add('neovim/nvim-lspconfig')
    call dein#add('hrsh7th/nvim-compe')
    call dein#add('L3MON4D3/LuaSnip')
    call dein#add('windwp/nvim-autopairs')

    call dein#add('tpope/vim-sensible')
    call dein#add('tpope/vim-obsession')
    call dein#add('tpope/vim-repeat', {'on_map' : '.'} )
    call dein#add('tpope/vim-surround', {'on_map': {'n' : ['cs', 'ds', 'ys'], 'x' : 'S'}, 'depends' : 'vim-repeat'})
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-fugitive')
    call dein#add('gcmt/taboo.vim')

    call dein#add('christoomey/vim-system-copy')
    let g:system_copy#copy_command='xclip -selection clipboard'
    let g:system_copy#paste_command='xclip -selection clipboard -o'
    " cpiw => copy word into system clipboard
    " cpi' => copy inside single quotes to system clipboard
    " The sequence cv is mapped to paste the content of system clipboard to the next line.

    call dein#add('manu-mannattil/vim-longlines', {'on_ft':'markdown'})

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
    " call dein#add('vim-erlang/erlang-motions.vim', {'on_ft' : 'erlang'})
    " call dein#add('vim-erlang/vim-erlang-omnicomplete', {'on_ft' : 'erlang'})
    " call dein#add('vim-erlang/vim-erlang-skeletons', {'on_ft' : 'erlang'})
    " call dein#add('vim-erlang/vim-erlang-compiler', {'on_ft' : 'erlang'})
    call dein#add('NelsonVides/vim-erlang-tags', {
                \ 'on_ft' : 'erlang',
                \ 'on_func': ['BuildMongooseTags', 'AsyncVimErlangTags'],
                \ 'hook_post_source': 'let &tags .= "," . GetOtpTagsPath()'
                \ })

    " ELIXIR
    " call dein#add('elixir-editors/vim-elixir', {'on_ft' : 'elixir'})
    " call dein#add('mhinz/vim-mix-format', {'on_ft' : 'elixir'})

    call dein#add('lervag/vimtex', {'on_ft': 'tex'})
    call dein#add('xuhdev/vim-latex-live-preview', {'on_ft': 'tex'})
    call dein#add('cespare/vim-toml', {'on_ft': 'toml'})

    call dein#add('jeetsukumaran/vim-buffergator')

    """ LAZY LOAD ON COMMAND EXECUTED
    call dein#add('mbbill/undotree', {'on_cmd': 'UndotreeToggle'}) " UndotreeToggle to show the undo tree
    call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})
    call dein#add('vimlab/split-term.vim', {'on_cmd': ['Term', 'VTerm', '10Term']})
    call dein#add('majutsushi/tagbar', {'on_cmd': ['Tagbar']})
    call dein#add('ntpeters/vim-better-whitespace', {'on_cmd': ['StripWhitespace', 'EnableWhitespace', 'DisableWhitespace']})

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set autoread      " Reload files changed outside vim
"set cursorline    " highlight the current line
set textwidth=100
set number
set relativenumber

set tabstop=4 " The width of a TAB is set to 4.
" Still it is a \t, it is just that vim will interpret it
" to be having a width of 4.
set shiftwidth=4 " Indents will have a width of 4
set softtabstop=4 " Sets the number of columns to a TAB
set expandtab " Expand TABs to spaces
set nowrap
set splitbelow
set splitright
set laststatus=2
set noshowmode
set noequalalways
set colorcolumn=101
colorscheme 256-jungle
highlight SpellBad ctermbg=none ctermfg=none cterm=underline
highlight Comment ctermfg=red

inoremap <c-d> <esc>ddi
inoremap <c-u> <esc>viWUi
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>
nnoremap <leader>rm :!rm %
noremap <Esc><Esc> :update<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell
nnoremap <C-m> :NERDTreeFocus<CR>
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd BufNewFile,BufRead *.config set filetype=erlang
autocmd BufNewFile,BufRead *.spec set filetype=erlang
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType markdown setlocal ts=2 sts=2 sw=2 expandtab
nnoremap <leader>n :1tag!<CR>
nnoremap <leader>f :TagbarToggle<CR>
nnoremap <leader>c :TagbarOpenAutoClose<CR>
set sessionoptions+=tabpages,globals
nnoremap <leader>cp :let @" = expand("%:p")<CR>
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd VimEnter * call dein#call_hook('post_source')

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
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

require('nvim-autopairs').setup()

vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };
  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

EOF

