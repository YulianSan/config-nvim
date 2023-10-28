vim.opt.termguicolors = true
require("bufferline").setup{
  options = {
    slope = true,
    offsets = {
        {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
        }
    },
    separator_style = "slope",
    separator = true,
  }
}

vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", {noremap=true})
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", {noremap=true})
