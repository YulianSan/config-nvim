local M = {}

function M.setup()
  require("trevj").setup({
    containers = {
      vue = {
        array = {
          final_separator = ",",
          final_end_line = true,
          skip = {},
        }, 
        object = {
          final_separator = ",",
          final_end_line = true,
          skip = {},
        }, 
        arguments = {
          final_separator = ",",
          final_end_line = true,
          skip = {},
        }, 
        namedimports = {
          final_separator = ",",
          final_end_line = true,
          skip = {},
        }, 
        object_pattern = {
          final_separator = ",",
          final_end_line = true,
          skip = {},
        }, 
        formal_parameters = {
          final_separator = ",",
          final_end_line = true,
          skip = {},
        }, 
        start_tag = {
          final_separator = false,
          final_end_line = true,
          skip = {tag_name = true}
        },
      }
    }
  })

  vim.keymap.set('n', '<space>j', function()
    require('trevj').format_at_cursor()
  end)
end

return M
