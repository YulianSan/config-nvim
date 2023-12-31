local my_lualine = require('config/lualine')
local mode_with_lenny = my_lualine.mode_with_lenny
local lsp_server_info = my_lualine.lsp_server_info

vim.g.VM_set_statusline = 0
vim.g.VM_silent_exit = 1

require('lualine').setup {
  options = {
    -- theme = theme(),
    theme = 'material',
    icons_enabled = true,
    component_separators = { left = "|", right = "|" },
    disabled_filetypes = { 'packer', 'NVimTree', 'NvimTree' },
    section_separators = { left = '', right = ''},
  },
    sections = {
    lualine_a = {
      {
        mode_with_lenny,
      },
    },
    lualine_b = {
      {
        "filetype",
        colored = true,
        icon_only = true,
        padding = { left = 1, right = 0}
      },
      {
        "filename",
        symbols = {
          modified = " ",
          readonly = "",
          unnamed = " "
        }
      }
    },
    lualine_c = {
      { "branch", icon = "" },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = " ",
          warn = " ",
          info = " ",
          hint = " "
        }
      },
      {
          'diff'
      },
    },
    lualine_x = {
        {
            lsp_server_info,
            icon = " LSP:"
        },
        { 
          'vim.fn["codeium#GetStatusString"]()',
          fmt = function(str) 
            return '{...}' .. str  
          end 
        },
    },
    lualine_y = {
      {
        "progress",
        separator = { left = "", right = ""},
        fmt = function(str)
          return "%#MiniStatuslineDevinfo#" .. str
        end
      }
    },
    lualine_z = {
      {
        "location",
        fmt = function(str)
          return "%#MiniStatuslineDevinfo#▎" .. str
        end,
        padding = { left = 0, right = 1}
      }
    }
  },
}

