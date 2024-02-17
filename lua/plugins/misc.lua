-- worktree settings
require('git-worktree').setup()

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('ibl').setup {
  indent = { char = '┊' },
  exclude = { filetypes = { 'dashboard' } },
}
