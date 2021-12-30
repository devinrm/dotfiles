--  ____ ____ ____ ____ ____ ____ ____ ____
-- ||s |||e |||t |||t |||i |||n |||g |||s ||
-- ||__|||__|||__|||__|||__|||__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

vim.bo.smartindent = true
vim.g.nord_cursorline_transparent = true
vim.g.nord_borders = true
vim.cmd('colorscheme ' .. 'nord')
vim.cmd('filetype plugin on')
vim.cmd('set spellfile=$HOME//.vim-spell-en.utf-8.add') -- Name of the word list file where words are added for the |zg| and |zw| commands.
vim.g.is_posix = 1 -- When the type of shell script is /bin/sh, assume a POSIX-compatible shell for syntax highlighting purposes.
vim.g.mapleader = ' ' -- Set Leader key to <Space> bar
vim.g.python3_host_prog = (vim.env.HOME .. '/.asdf/shims/python')
vim.g.coq_settings = { auto_start = true }
vim.o.autowriteall = true
vim.o.backspace = '2' -- Backspace deletes like most programs in insert mode
vim.o.backup = false -- Don't make a backup before overwriting a file
vim.o.backupcopy = 'yes'
vim.o.clipboard = 'unnamedplus' -- copy paste to system clipboard
vim.o.expandtab = true -- Use the appropriate number of spaces to insert a <Tab>.
vim.o.foldenable = false -- Leave open all folds
vim.o.formatprg = 'fmt'
vim.o.gdefault = true -- Replace all matches on a line instead of just the first
vim.o.grepformat = '%f:%l:%c:%m,%f:%l:%m'
vim.o.grepprg = 'rg --vimgrep --no-heading'
vim.o.ignorecase = true -- case insensitive pattern matching
vim.o.inccommand = 'split' -- this is necessary for using this %s with a quickfix window in nvim
vim.o.joinspaces = false -- Insert one space after a '.', '?' and '!' with a join command.
vim.o.lazyredraw = true
vim.o.matchtime = 0 -- Speed up escape after (){} chars
vim.o.mouse = 'a' -- Enable mouse for pair programming
vim.o.pumheight = 10 -- limit size of popup menu
vim.o.pumblend = 20
vim.o.redrawtime = 1000 -- Stop highlighting if it takes more than a second
vim.o.scrolloff = 3 -- show 3 lines above and below cursor
vim.o.shiftround = true -- Round indent to multiple of 'shiftwidth'.
vim.o.shiftwidth = 2 -- Returns the effective value of 'shiftwidth'
vim.o.showmode = false -- If in Insert, Replace or Visual mode don't put a message on the last line.
vim.o.showtabline = 2
vim.o.smartcase = true -- overrides ignorecase if pattern contains upcase
vim.o.spelllang = 'en_us' -- Set region to US English
vim.o.splitbelow = true -- When on, splitting a window will put the new window below the current one.
vim.o.splitright = true -- When on, splitting a window will put the new window right of the current one.
vim.o.suffixesadd = '.js,.jsx,.ts,.tsx'
vim.o.swapfile = false -- Do not create a swapfile for a new buffer.
vim.o.synmaxcol = 200
vim.o.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for.
vim.o.termguicolors = true
-- vim.o.textwidth = 100 -- Maximum width of text that is being inserted. A longer line will be broken after white space to get this width.
vim.o.ttimeout = true -- determine the behavior when part of a key code sequence has been received by the terminal UI.
vim.o.undofile = true -- Automatically saves undo history to an undo file when writing a buffer to a file, and restores undo history from the same file on buffer read.
vim.o.undolevels = 500
vim.o.undoreload = 500
vim.o.updatetime = 100
vim.o.wildignore = 'tmp/**' -- Ignore stuff that can't be opened
vim.o.wildmode = 'list:longest,list:full'
vim.o.writebackup = false -- Don't make a backup before overwriting a file.
vim.opt.colorcolumn = '+1' -- highlight column after 'textwidth
vim.opt.completeopt:remove({'i', 't', 'preview'})
vim.opt.diffopt:append({'vertical'}) -- Start diff mode with vertical splits
vim.opt.guicursor:append({'a:blinkon0'}) -- Disable blinking cursor on nvim
vim.opt.list = true
vim.opt.path:append({'.,,', '.,app/javascript', 'node_modules'})
vim.opt.shortmess = 'filnxtToOFc' -- vim default with 'c' appended (don't give |ins-completion-menu| messages)
vim.wo.cursorline = true
vim.wo.number = true -- Turn on line numbers
vim.wo.numberwidth = 1 -- Minimal number of columns to use for the line number.
vim.wo.signcolumn = 'yes' -- Leave signcolumn enabled otherwise it's a little jarring
vim.wo.wrap = false -- Don't wrap lines longer than the width of the window
