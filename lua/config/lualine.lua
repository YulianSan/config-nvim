local M = {}

local lenny_mapping = {
  n       = '  (⌐■_■)  ',
  i       = '  (ಠ_ಠ)   ',
  c       = '  ⤜(ʘ_ʘ)⤏ ',
  V       = ' ( ͡° ͜ʖ ͡°) ',
  ['']    = ' ( ͡° ͜ʖ ͡°) ',
  v       = ' ( ͡° ͜ʖ ͡°) ',
  R       = ' ⤜(ʘ_ʘ)⤏  ',
  s       = '  (ಠ_ಠ)   ',
  S       = '  (ಠ_ಠ)   ',
}

local mode_alias = {
  n       = ' NORMAL ',
  i       = ' INSERT ',
  c       = ' COMMAND',
  V       = ' VISUAL ',
  ['']    = ' VISUAL ',
  v       = ' VISUAL ',
  R       = ' REPLACE',
  s       = ' SELECT ',
  S       = ' SELECT ',
}

M.mode_with_lenny = function()
  local mode = vim.fn.mode()
  return lenny_mapping[mode] .. (vim.b['visual_multi'] and mode_alias[mode] .. ' - MULTI' or mode_alias[mode])
end

M.lsp_server_info = function()
  local msg = "No active LSP"
  local clients = vim.lsp.get_active_clients()

  if #clients == 0 then
    return msg
  end

  msg = clients[1].name
  for i = 2, #clients do
    msg = msg .. ", " .. clients[i].name
  end
  return msg
end

return M
