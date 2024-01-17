require('harpoon').setup({
  global_settings = {
    save_on_toggle = false,
    save_on_change = true,
    enter_on_sendcmd = false,
    excluded_filetypes = { 'harpoon' },
    mark_branch = true,
    tabline = true,
  }
})

vim.keymap.set("n", "<leader>m", ":lua require('harpoon.mark').add_file()<CR>", {noremap=true})
vim.keymap.set("n", "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", {noremap=true})
