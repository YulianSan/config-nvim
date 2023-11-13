require("transparent").setup({
  groups = {
    "Normal",
    "NormalNC",
    "Comment",
    "Constant",
    "Special",
    "Identifier",
    "Statement",
    "PreProc",
    "Type",
    "Underlined",
    "Todo",
    "String",
    "Function",
    "Conditional",
    "Repeat",
    "Operator",
    "Structure",
    "LineNr",
    "NonText",
    "SignColumn",
    "CursorLineNr",
    "EndOfBuffer",
  },
  extra_groups = {
    "NormalSB",
    "NvimTreeNormal",
    "NvimTreeNormalNC",
    "NvimTreeNormalSB",
    "Folded",
    "NonText",
    "SpecialKey",
    "VertSplit",
    "EndOfBuffer",
    "SignColumn",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineBufferSelected",
  },
  exclude_groups = {},
})

vim.api.nvim_set_hl(0, 'NotifyBackground', vim.api.nvim_get_hl_by_name('Normal', true))

vim.g.transparent_groups = vim.list_extend(
  vim.g.transparent_groups or {},
  vim.tbl_map(function(v)
    return v.hl_group
  end, vim.tbl_values(require("bufferline.config").highlights))
)

