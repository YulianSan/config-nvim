local M = {}

local function db_completion()
  require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
end

vim.cmd([[
  autocmd User DBUIOpened call s:open_db()

  function! s:open_db()
    "Find db.
    call search('dev')
    "Open db
    norm o
    "Find tables
    call search('Tables')
    "Open tables
    norm o
  endfunction
]])

function M.setup()
  vim.g.dadbod_view = 'visible'

  vim.cmd([[
    autocmd FileType dbui nmap <buffer> l <Plug>(DBUI_SelectLine)
  ]])

  vim.g.db_ui_save_location = vim.fn.stdpath "config" .. require("plenary.path").path.sep .. "db_ui"

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "sql",
    },
    command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "sql",
      "mysql",
      "plsql",
    },
    callback = function()
      vim.schedule(db_completion)
    end,
  })
end

return M
