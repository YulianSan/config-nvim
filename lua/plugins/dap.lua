
require('dapui').setup()
require('dap-go').setup()
require('nvim-dap-virtual-text').setup()
vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })

vim.keymap.set('n', '<F5>', require 'dap'.continue)
vim.keymap.set('n', '<F10>', require 'dap'.step_over)
vim.keymap.set('n', '<F11>', require 'dap'.step_into)
vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)
vim.keymap.set('n', '<leader>B', function()
  require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)

vim.keymap.set("n", "<leader>du", require 'dapui'.toggle)
vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", {noremap=true})
vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", {noremap=true})
vim.keymap.set("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", {noremap=true})

require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = vim.fn.stdpath('data') .. "/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

local js_based_languages = { "typescript", "javascript", "typescriptreact" }
local dap = require("dap")

for _, language in ipairs(js_based_languages) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require 'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Start Chrome with \"localhost\"",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
    }
  }
end

local function skipDisplayingVariable(variable, buf)
  local filetype = vim.bo[buf].filetype
  if variable.name == '$this' and filetype == 'php' then
    return true
  end
  return false
end

require('nvim-dap-virtual-text').setup({
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
  only_first_definition = false,
  all_references = true,
  filter_references_pattern = '<module',
  virt_text_pos = 'eol',
  all_frames = false,
  virt_lines = false,
  virt_text_win_col = nil,
  display_callback = function(variable, bufId, _stackframe, _node)
    if true == skipDisplayingVariable(variable, bufId) then
      return ''
    end
    return variable.name .. ': ' .. variable.value
  end,
})

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/vscode-php-debug/out/phpDebug.js'},
}

dap.configurations.php = {
  {
    name = "Listen for XDebug on Docker",
    type = "php",
    request = "launch",
    port = 9003,
    pathMappings = {
      ["/var/www/html/"] = "${workspaceFolder}/.."
    },
    log = true,
  },
  {
    name = "run current script",
    type = "php",
    request = "launch",
    port = 9003,
    cwd="${fileDirname}",
    program = "${file}",
  },
}
