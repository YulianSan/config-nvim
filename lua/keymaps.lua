vim.api.nvim_set_keymap("i", "jj", "<Esc>", {noremap=false})
-- twilight
-- buffers
vim.api.nvim_set_keymap("n", "tk", ":bnext<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "tj", ":bprev<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "th", ":bfirst<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "tl", ":blast<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "td", ":bdelete<enter>", {noremap=false})
-- files
vim.api.nvim_set_keymap("n", "<space>q", ":q<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<space>w", ":w<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "E", "$", {noremap=false})
vim.api.nvim_set_keymap("n", "B", "^", {noremap=false})
vim.api.nvim_set_keymap("n", "<space>h", ":noh<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", {noremap=true})
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", {noremap=true})
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", {noremap=true})
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", {noremap=true})
vim.keymap.set('n', "<C-p>", "<C-i>", {noremap=true})
vim.keymap.set('n', "<Tab>", ">>", { noremap = true, silent = true })
vim.keymap.set('n', "<S-Tab>", "<<", { noremap = true, silent = true })
vim.keymap.set('v', "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set('v', "<S-Tab>", "<gv", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-S-Left>', ':vertical resize -5<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-Right>', ':vertical resize +5<CR>', { noremap = true })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
