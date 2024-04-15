-- autocmd FileType markdown setlocal tabstop=2 softtabstop=2 softwidth=2 expandtab
-- autocmd FileType yaml setlocal tabstop=2 softtabstop=2 softwidth=2 expandtab
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"markdown", "yaml"},
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.tabstop = 2 -- The width of a TAB is set to 4.
        vim.opt_local.softtabstop = 2 -- Sets the number of columns to a TAB
        vim.opt_local.shiftwidth = 2 -- Indents will have a width of 4
        vim.opt_local.expandtab = true -- Expand TABs to spaces
    end
})

-- autocmd BufNewFile,BufRead *.livemd set filetype=markdown
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.livemd"},
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
    end
})

-- autocmd BufNewFile,BufRead *.config set filetype=erlang
-- autocmd BufNewFile,BufRead *.spec set filetype=erlang
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.config", "*.spec"},
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(buf, "filetype", "erlang")
    end
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.brew"},
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(buf, "filetype", "bash")
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    callback = function()
        vim.opt_local.spell = true
    end
})

-- autocmd FileType elixir setlocal commentstring=#\ %s

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.termguicolors = true

vim.opt.autoread = true
vim.opt.swapfile = false

vim.opt.fileencoding = 'UTF-8'
vim.opt.fileformat = 'unix' -- Set unix line endings
vim.opt.fileformats = 'unix,mac,dos'
vim.opt.path = {'.', vim.fn.expand('~') .. '/.config/nvim', vim.fn.expand('~') .. '/.config/nvim/lua'}
vim.opt.shortmess:append('I')
vim.opt.shada = "'100,f1" -- Save up to 100 marks, enable capital marks

vim.opt.wildmenu = true
vim.opt.wildmode = "longest,full:full"
vim.opt.wildignore:append({'.hg', '.git', '.svn'})                          -- Version control files
vim.opt.wildignore:append({'*.aux', '*.out', '*.toc'})                      -- LaTeX intermediate files
vim.opt.wildignore:append({'*.jpg', '*.bmp', '*.gif', '*.png', '*.jpeg'})   -- Binary images
vim.opt.wildignore:append({'*.o', '*.obj', '*.exe', '*.dll', '*.manifest'}) -- Compiled object files
vim.opt.wildignore:append({'*.spl'})                                        -- Compiled spelling word lists
vim.opt.wildignore:append({'*.sw?'})                                        -- Vim swap files
vim.opt.wildignore:append({'*.DS_Store'})                                   -- macOS noise
vim.opt.wildignore:append({'*.luac'})                                       -- Lua byte code
vim.opt.wildignore:append({'migrations'})                                   -- Django migrations
vim.opt.wildignore:append({'go/pkg'})                                       -- Go static files
vim.opt.wildignore:append({'go/bin'})                                       -- Go bin files
vim.opt.wildignore:append({'go/bin-vagrant'})                               -- Go bin-vagrant files
vim.opt.wildignore:append({'*.pyc'})                                        -- Python byte code
vim.opt.wildignore:append({'*.orig'})                                       -- Merge resolution files
vim.opt.wildignore:append({'node_modules'})                                 -- Node.js modules
vim.opt.wildignore:append({'*.beam'})                                       -- BEAM byte code

-- -- Time out on key codes but not mappings. Basically this makes terminal Vim
-- -- behave in a sane way.
-- vim.opt.timeout = false
-- vim.opt.ttimeout = true
-- vim.opt.ttimeoutlen = 10

-- Better Completion
-- vim.opt.completeopt = 'menu,menuone,noselect'
-- vim.opt.omnifunc = 'syntaxcomplete#Complete'

-- Undo, backups and history
vim.opt.backup = false
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.undofile = true
vim.opt.undolevels = 1000 -- Use many mucho levels of undo
vim.opt.writebackup = false

vim.opt.background = 'light'
vim.opt.cmdheight = 1 -- Give more space for displaying messages.
vim.opt.colorcolumn = "101" -- Make a mark for columns 101
vim.opt.copyindent = true -- Copy the previous indentation on autoindenting
vim.opt.diffopt:append('vertical')
vim.opt.equalalways = false
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.foldenable = true -- Enable folding
vim.opt.foldlevelstart = 99 -- Open most folds by default
vim.opt.foldmethod = "expr" -- Fold based on indent level
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.opt.foldnestmax = 10 -- 10 nested fold max
vim.opt.gdefault = true -- Search everything, not just the current line
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = false
vim.opt.inccommand = 'nosplit'
vim.opt.laststatus = 2
vim.opt.linebreak = true
vim.opt.list = false
vim.opt.modelines = 1
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.scrolloff = 5 -- Keep the cursor visible within 3 lines when scrolling
vim.opt.shiftround = false
vim.opt.shiftwidth = 4 -- When reading, tabs are 4 spaces
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.softtabstop = 4 -- In insert mode, tabs are 4 spaces
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.tagcase = 'followscs' -- Follow smartcase and ignorecase when doing tag search
vim.opt.textwidth = 100 -- Turn off hard word wrapping
vim.opt.updatetime = 300
vim.opt.wrap = false
vim.opt.wrapmargin = 0
vim.opt.wrapscan = true
vim.opt.showtabline = 2
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.cmd [[
" Make background transparent
highlight Normal guibg=none ctermbg=none gui=none
highlight NonText guibg=none ctermbg=none gui=none
highlight SignColumn guibg=none ctermbg=none gui=none
highlight EndOfBuffer guibg=none ctermbg=none gui=none
" SignColumn
highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
]]
