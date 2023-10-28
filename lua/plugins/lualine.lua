require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = "horizon",
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { 'packer', 'NVimTree', 'NvimTree' }
  },
  sections = {
    lualine_x = {
      'encoding', 'fileformat', 'filetype',
    },
  }
}

