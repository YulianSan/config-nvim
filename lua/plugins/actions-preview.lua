require('actions-preview').setup {

}

vim.keymap.set('n', '<leader>la', require('actions-preview').code_actions)
