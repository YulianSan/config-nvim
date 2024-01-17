-- Set highlight on search
vim.o.hlsearch = true
vim.opt.foldmethod = "syntax"

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Disable mouse mode
vim.o.mouse = ''

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
--vim.cmd [[colorscheme onedark]]
vim.cmd.colorscheme "tokyonight-night"

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Concealer for Neorg
vim.o.conceallevel=2
vim.opt.colorcolumn = "80"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- vim.cmd(
--   [[autocmd ColorScheme * highlight ColorColumn guibg=#15161f ctermbg=235]]
-- )

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.indent_blankline_filetype_exclude = {'dashboard'}

