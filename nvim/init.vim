""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EOL funs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
    call vim_erlang_tags#AsyncVimErlangTags(arg)
endfunction

function! GetOtpTagsPath()
    return ChompSystemEndOfLine(system("asdf where erlang")) . "/otptags"
endfunction

function! BuildMongooseTags()
    let arg = "--include include src test big_tests _build "
          \ . "--ignore _build/mim1 _build/mim2 _build/mim3 _build/fed1 _build/reg1 _build/prod "
          \ .           "big_tests/deps/ "
          \ .           "_build/default/lib/mongooseim "
          \ .           "_build/test/lib/mongooseim "
          \ .           "--match-mode full_func_name_args"
    call vim_erlang_tags#AsyncVimErlangTags(arg)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dein section
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE . '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set Dein base path (required)
let s:dein_base = '/home/videsnelson/.cache/dein'

" Set Dein source path (required)
let s:dein_src = '/home/videsnelson/.cache/dein/repos/github.com/Shougo/dein.vim'

" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" Call Dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

" Your plugins go here:
    call dein#add('neovim/nvim-lspconfig')
    call dein#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})

    " call dein#add('glepnir/lspsaga.nvim')
    " call dein#add('nvim-lua/completion-nvim')
    " call dein#add('nvim-lua/popup.nvim')
    " call dein#add('nvim-lua/plenary.nvim')
    " call dein#add('nvim-telescope/telescope.nvim')
    " call dein#add('nvim-telescope/telescope-fzy-native.nvim')
    " call dein#add('nvim-telescope/telescope-frecency.nvim')
    " call dein#add('tami5/sqlite.lua')

    call dein#add('windwp/nvim-autopairs')
    call dein#add('gpanders/editorconfig.nvim')
    call dein#add('gcmt/taboo.vim')
    call dein#add('ntpeters/vim-better-whitespace')

    " TPOPE
    call dein#add('tpope/vim-sensible')
    call dein#add('tpope/vim-obsession')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-fugitive')

    call dein#add('christoomey/vim-system-copy')
    let g:system_copy#copy_command='xclip -selection clipboard'
    let g:system_copy#paste_command='xclip -selection clipboard -o'
    " cpiw => copy word into system clipboard
    " cpi' => copy inside single quotes to system clipboard
    " The sequence cv is mapped to paste the content of system clipboard to the next line.

    " DESIGN
    call dein#add('kyazdani42/nvim-web-devicons')
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
    call dein#add('vim-erlang/vim-erlang-tags', {
                \ 'on_ft' : 'erlang',
                \ 'on_func': ['BuildMongooseTags', 'AsyncVimErlangTags'],
                \ 'hook_post_source': 'let &tags .= "," . GetOtpTagsPath()'
                \ })
    let g:erlang_tags_otp = 1

    """ LAZY LOAD ON COMMAND EXECUTED
    call dein#add('jeetsukumaran/vim-buffergator', {'on_cmd': 'BuffergatorToggle'})
    call dein#add('mbbill/undotree', {'on_cmd': 'UndotreeToggle'})
    call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})
    call dein#add('vimlab/split-term.vim', {'on_cmd': ['Term', 'VTerm', '10Term']})
    call dein#add('majutsushi/tagbar', {'on_cmd': ['Tagbar']})
    call dein#add('manu-mannattil/vim-longlines', {'on_ft':'markdown'})

" Finish Dein initialization (required)
call dein#end()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Uncomment if you want to install not-installed plugins on startup.
"if dein#check_install()
" call dein#install()
"endif

let g:python3_host_prog = '/usr/bin/python3'
let mapleader = "\\"
colorscheme 256-jungle
highlight SpellBad ctermbg=none ctermfg=none cterm=underline
highlight Comment ctermfg=red

set sessionoptions+=tabpages,globals
autocmd VimEnter * call dein#call_hook('post_source')

autocmd FileType markdown setlocal spell
autocmd FileType markdown setlocal complete+=kspell
autocmd FileType gitcommit setlocal spell
autocmd FileType gitcommit setlocal complete+=kspell

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType markdown setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType elixir setlocal commentstring=#\ %s

autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd BufNewFile,BufRead *.config set filetype=erlang
autocmd BufNewFile,BufRead *.spec set filetype=erlang

" nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>rm :!rm %
nnoremap <leader>f :TagbarToggle<CR>
nnoremap <leader>c :TagbarOpenAutoClose<CR>
nnoremap <leader>cp :let @" = expand("%:p")<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <C-W>o <ESC>

lua require('treesitter')
lua require('remaps')
lua require('config')
lua require('lsp')
