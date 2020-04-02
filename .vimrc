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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dein section
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath+=~/.config/dein/repos/github.com/Shougo/dein.vim
let mapleader = "\\"
if dein#load_state('~/.config/dein')
    call dein#begin('~/.config/dein')

    call dein#add('~/.config/dein/repos/github.com/Shougo/dein.vim')
    call dein#add('Shougo/deoplete.nvim')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    call dein#add('tpope/vim-sensible')
    call dein#add('Asheq/close-buffers.vim', {'on_cmd': ['CloseOtherBuffers','CloseHiddenBuffers','CloseBufferMenu','CloseNamelessBuffers','CloseThisBuffer']})
    call dein#add('qpkorr/vim-bufkill')
    call dein#add('tpope/vim-obsession')
    " to save the state of a session
    call dein#add('Raimondi/delimitMate')
    " to provide automatic closing of delimiters (quotes, parenthesis, brackets, etc
    call dein#add('tpope/vim-repeat', {'on_map' : '.'} )
    " repeat the command even if it comes from a plugin
    call dein#add('tpope/vim-surround', {'on_map': {'n' : ['cs', 'ds', 'ys'], 'x' : 'S'}, 'depends' : 'vim-repeat'})
    " cs'" to change surrounding from ' to "
    " cs'<q> to change surrounding from ' to <q>
    " cst" to change surrounding from tag to "
    " ds deletes surrounding, ys yanks
    call dein#add('tpope/vim-commentary')
    " gc gets mapped to 'g - comment'
    " so gcc comments, gc to comment the target of a motion, etc
    call dein#add('tpope/vim-fugitive')
    " Simply a super git wrapper: https://github.com/tpope/vim-fugitive/blob/master/doc/fugitive.txt

    call dein#add('christoomey/vim-system-copy')
    let g:system_copy#copy_command='xclip -selection clipboard'
    let g:system_copy#paste_command='xclip -selection clipboard -o'
    " cpiw => copy word into system clipboard
    " cpi' => copy inside single quotes to system clipboard
    " The sequence cv is mapped to paste the content of system clipboard to the next line.

    call dein#add('mbbill/undotree', {'on_cmd': 'UndotreeToggle'})
    " UndotreeToggle to show the undo tree

    call dein#add('christoomey/vim-tmux-navigator')
    call dein#add('flazz/vim-colorschemes')
    call dein#add('ntpeters/vim-better-whitespace', {'on_cmd': 'EnableWhitespace'})
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

    if has('nvim')
        call dein#add('neovimhaskell/haskell-vim', {'on_ft':'haskell'} )
        let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
        let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
        let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
        let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
        let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
        let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
        let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
        call dein#add('parsonsmatt/intero-neovim', {
                    \ 'on_ft':'haskell',
                    \ 'hook_post_source': "
                    \ \" Maps for intero. Restrict to Haskell buffers so the bindings don't collide.\n
                    \
                    \ \" Background process and window management\n
                    \ au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>\n
                    \ au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>\n
                    \
                    \ \" Open intero/GHCi split horizontally\n
                    \ au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>\n
                    \ \" Open intero/GHCi split vertically\n
                    \ au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H\n
                    \ au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>\n
                    \
                    \ \" Reloading (pick one)\n
                    \ \" Automatically reload on save\n
                    \ au BufWritePost *.hs InteroReload\n
                    \ \" Manually save and reload\n
                    \ au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>\n
                    \
                    \ \" Load individual modules\n
                    \ au FileType haskell nnoremap <leader>il :InteroLoadCurrentModule<CR>\n
                    \ au FileType haskell nnoremap <leader>if :InteroLoadCurrentFile<CR>\n
                    \
                    \ \" Type-related information\n
                    \ \" Heads up! These next two differ from the rest.\n
                    \ au FileType haskell nnoremap <silent> <leader>t <Plug>InteroGenericType\n
                    \ au FileType haskell nnoremap <silent> <leader>T <Plug>InteroType\n
                    \ au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>\n
                    \
                    \ \" Navigation\n
                    \ au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>\n
                    \
                    \ \" Managing targets\n
                    \ \" Prompts you to enter targets (no silent):\n
                    \ au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>\n
                    \ "})
    endif

    call dein#add('LnL7/vim-nix')

    " ERLANG
    call dein#add('vim-erlang/erlang-motions.vim', {'on_ft' : 'erlang'})
    call dein#add('vim-erlang/vim-erlang-omnicomplete', {'on_ft' : 'erlang'})
    call dein#add('vim-erlang/vim-erlang-skeletons', {'on_ft' : 'erlang'})
    call dein#add('vim-erlang/vim-erlang-compiler', {'on_ft' : 'erlang'})
    call dein#add('NelsonVides/vim-erlang-tags', {
                \ 'on_ft' : 'erlang',
                \ 'on_func': ['BuildMongooseTags', 'AsyncVimErlangTags'],
                \ 'hook_post_source': 'let &tags .= "," . GetOtpTagsPath()'
                \ })

    " ELIXIR
    call dein#add('elixir-editors/vim-elixir', {'on_ft' : 'elixir'})
    call dein#add('mhinz/vim-mix-format', {'on_ft' : 'elixir'})

    call dein#add('derekelkins/agda-vim', {'on_ft': 'agda'})
    augroup agdaMaps
        au!
        au FileType agda nnoremap <LocalLeader>vcs :vsplit ~/.config/dein/repos/github.com/derekelkins/agda-vim/agda-utf8.vim<CR>
    augroup END
    call dein#add('lervag/vimtex', {'on_ft': 'tex'})
    call dein#add('xuhdev/vim-latex-live-preview', {'on_ft': 'tex'})

    " lazy load on command executed
    call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})

    call dein#add('vimlab/split-term.vim', {'on_cmd': ['Term', 'VTerm', '10Term']})

    call dein#add('jeetsukumaran/vim-buffergator')
    call dein#add('gcmt/taboo.vim')

    call dein#add('majutsushi/tagbar')

    call dein#add('rust-lang/rust.vim', {'on_ft': 'rust'})

    if has('nvim')
        if isdirectory("/usr/local/opt/llvm/lib/")
            call dein#add('arakashic/chromatica.nvim')
            let g:chromatica#libclang_path='/usr/local/opt/llvm/lib/libclang.dylib'
        endif
        if isdirectory("/usr/lib/llvm-8/lib/")
            call dein#add('arakashic/chromatica.nvim')
            let g:chromatica#libclang_path='/usr/lib/llvm-8/lib/libclang.so.1'
        endif
    endif

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
nnoremap <leader>n :1tag!<CR>
nnoremap <leader>f :TagbarToggle<CR>
nnoremap <leader>c :TagbarOpenAutoClose<CR>
set sessionoptions+=tabpages,globals
nnoremap <leader>cp :let @" = expand("%:p")<CR>

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
autocmd VimEnter * call dein#call_hook('post_source')
