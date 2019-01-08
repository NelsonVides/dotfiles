if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')

  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-fugitive')
  call dein#add('christoomey/vim-system-copy')
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('flazz/vim-colorschemes')
  call dein#add('ntpeters/vim-better-whitespace',
        \{'on_cmd': 'EnableWhitespace'})
  call dein#add('itchyny/lightline.vim')
  let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }

  " lazy load on filetype
  call dein#add('LnL7/vim-nix',
        \{'on_ft': ['nix']})

  " lazy load on command executed
  call dein#add('scrooloose/nerdtree',
         \{'on_cmd': 'NERDTreeToggle'})

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
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
colorscheme 256-jungle
