vim.api.nvim_set_keymap("i", "jj", "<Esc>", {noremap=false})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.api.nvim_set_keymap("n", "tw", ":Twilight<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "tk", ":bnext<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "tj", ":bprev<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "th", ":bfirst<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "tl", ":blast<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "td", ":bdelete<enter>", {noremap=false})

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
vim.api.nvim_set_keymap('n', '<C-S-Up>', ':horizontal resize +5<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-Down>', ':horizontal resize -5<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-Right>', ':vertical resize +5<CR>', { noremap = true })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<CR>', { silent = true })
vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<CR>', { silent = true })
vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<CR>', { silent = true })
vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<CR>', { silent = true })
