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
  vim.g.db_ui_table_helpers = {
    mysql = {
      ["Foreign Keys"] = "SELECT *\n  FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS\nWHERE TABLE_SCHEMA = (SELECT DATABASE())\n  AND TABLE_NAME = '{table}'\n  AND CONSTRAINT_TYPE = 'FOREIGN KEY';",
      ["Primary Keys"] = "SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE\n  FROM INFORMATION_SCHEMA.COLUMNS\n  WHERE TABLE_SCHEMA = (SELECT DATABASE())\n  AND COLUMN_KEY = 'PRI'\n  AND TABLE_NAME = '{table}' ORDER BY TABLE_NAME;", 
      Count = "SELECT count(*) FROM {table}"
    }
  }

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
