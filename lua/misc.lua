local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


vim.api.nvim_set_keymap("n", "<Leader><tab>", "<Cmd>lua require('telescope.builtin').commands()<CR>", {noremap=false})

vim.api.nvim_set_keymap("n", "<leader>tt", ":lua require('FTerm').toggle()<CR>", {noremap=true})
vim.api.nvim_set_keymap("t", "<leader>tt", '<C-\\><C-n>:lua require("FTerm").toggle()<CR>', {noremap=true})

vim.api.nvim_set_keymap("n", "<leader>gc", ":Git commit -m \"", {noremap=false})
vim.api.nvim_set_keymap("n", "<leader>gp", ":Git push -u origin HEAD<CR>", {noremap=false})
