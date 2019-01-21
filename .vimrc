if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

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
  call dein#add('tpope/vim-fugitive', { 'on_cmd': [ 'Git', 'Gstatus', 'Gread', 'Gwrite', 'Glog', 'Gcommit', 'Gblame', 'Ggrep', 'Gdiff', ] })
  " Simply a super git wrapper: https://github.com/tpope/vim-fugitive/blob/master/doc/fugitive.txt

  call dein#add('w0rp/ale')

  call dein#add('christoomey/vim-system-copy')
  " cpiw => copy word into system clipboard
  " cpi' => copy inside single quotes to system clipboard
  " The sequence cv is mapped to paste the content of system clipboard to the next line.

  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('flazz/vim-colorschemes')
  call dein#add('ntpeters/vim-better-whitespace', {'on_cmd': 'EnableWhitespace'})
  call dein#add('itchyny/lightline.vim')
  call dein#add('maximbaz/lightline-ale')
  let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ ['lineinfo'],
    \              ['percent'],
    \              ['fileformat', 'fileencoding', 'filetype'],
    \              ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }
  let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
  let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
  " let g:lightline#ale#indicator_checking = "\uf110"
  " let g:lightline#ale#indicator_warnings = "\uf071"
  " let g:lightline#ale#indicator_errors = "\uf05e"
  " let g:lightline#ale#indicator_ok = "\uf00c"

  if has('nvim')
    call dein#add('neovimhaskell/haskell-vim',
                \ {'on_ft':'haskell'} )
    let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
    let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
    let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
    let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
    let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
    let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
    let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
    call dein#add('parsonsmatt/intero-neovim', {'on_ft':'haskell'} )
    augroup interoMaps
        au!
        " Automatically reload on save
        au BufWritePost *.hs InteroReload
        " Lookup the type of expression under the cursor
        au FileType haskell nmap <silent> <leader>t <Plug>InteroGenericType
        au FileType haskell nmap <silent> <leader>T <Plug>InteroType
        " Insert type declaration
        au FileType haskell nnoremap <silent> <leader>ni :InteroTypeInsert<CR>
        " Show info about expression or type under the cursor
        au FileType haskell nnoremap <silent> <leader>i :InteroInfo<CR>
        " Open/Close the Intero terminal window
        au FileType haskell nnoremap <silent> <leader>nn :InteroOpen<CR>
        au FileType haskell nnoremap <silent> <leader>nh :InteroHide<CR>
        " Reload the current file into REPL
        au FileType haskell nnoremap <silent> <leader>nf :InteroLoadCurrentFile<CR>
        " Jump to the definition of an identifier
        au FileType haskell nnoremap <silent> <leader>ng :InteroGoToDef<CR>
        " Evaluate an expression in REPL
        au FileType haskell nnoremap <silent> <leader>ne :InteroEval<CR>
        " Start/Stop Intero
        au FileType haskell nnoremap <silent> <leader>ns :InteroStart<CR>
        au FileType haskell nnoremap <silent> <leader>nk :InteroKill<CR>
        " Reboot Intero, for when dependencies are added
        au FileType haskell nnoremap <silent> <leader>nr :InteroKill<CR> :InteroOpen<CR>
        " Managing targets
        " Prompts you to enter targets (no silent):
        au FileType haskell nnoremap <leader>nt :InteroSetTargets<CR>
    augroup END
  endif

  " lazy load on filetype
  call dein#add('LnL7/vim-nix', {'on_ft': ['nix']})

  " lazy load on command executed
  call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})

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
colorscheme 256-jungle

inoremap <c-d> <esc>ddi
inoremap <c-u> <esc>viWUi
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>
