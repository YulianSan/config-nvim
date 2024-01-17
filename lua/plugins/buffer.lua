vim.opt.termguicolors = true
require("bufferline").setup{
  options = {
    numbers = function(opts)
      local marks = require('harpoon').get_mark_config().marks
      local bufname = vim.fn.bufname(opts.id)
      
      for i, mark in ipairs(marks) do
        if bufname == mark.filename then
          return i
        end
      end
      
      return -1
    end,
	custom_filter = function(buf_number)
      local marks = require('harpoon').get_mark_config().marks
      for _, mark in ipairs(marks) do
        if vim.fn.bufname(buf_number) == mark.filename then
          return true
        end
      end
      return false
	end,
	sort_by = function(buffer_a, buffer_b)
      local a = 1
      local b = 1
      
      local marks = require('harpoon').get_mark_config().marks
      for _, mark in ipairs(marks) do
        if vim.fn.bufname(buffer_a.id) == mark.filename then
          a = 0
          break
        elseif vim.fn.bufname(buffer_b.id) == mark.filename then
          b = 0
          break
      end
      end
      return a < b
	end,
    slope = true,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true,
      }
    },
    separator = true,
  }
}

vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", {noremap=true})
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", {noremap=true})
vim.keymap.set("n", "<leader>bl", ":BufferLineCloseRight<CR>", {noremap=true})
vim.keymap.set("n", "<leader>bh", ":BufferLineCloseLeft<CR>", {noremap=true})
vim.keymap.set("n", "<leader>bp", ":BufferLinePick<CR>", {noremap=true})

function buf_kill(kill_command, bufnr, force)
  kill_command = kill_command or "bd"

  local bo = vim.bo
  local api = vim.api
  local fmt = string.format
  local fn = vim.fn

  if bufnr == 0 or bufnr == nil then
    bufnr = api.nvim_get_current_buf()
  end

  local bufname = api.nvim_buf_get_name(bufnr)

  if not force then
    local choice
    if bo[bufnr].modified then
      choice = fn.confirm(fmt([[Save changes to "%s"?]], bufname), "&Yes\n&No\n&Cancel")
      if choice == 1 then
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd("w")
        end)
      elseif choice == 2 then
        force = true
      else return
      end
    elseif api.nvim_buf_get_option(bufnr, "buftype") == "terminal" then
      choice = fn.confirm(fmt([[Close "%s"?]], bufname), "&Yes\n&No\n&Cancel")
      if choice == 1 then
        force = true
      else
        return
      end
    end
  end

  -- Get list of windows IDs with the buffer to close
  local windows = vim.tbl_filter(function(win)
    return api.nvim_win_get_buf(win) == bufnr
  end, api.nvim_list_wins())

  if force then
    kill_command = kill_command .. "!"
  end

  -- Get list of active buffers
  local buffers = vim.tbl_filter(function(buf)
    return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
  end, api.nvim_list_bufs())

  -- If there is only one buffer (which has to be the current one), vim will
  -- create a new buffer on :bd.
  -- For more than one buffer, pick the previous buffer (wrapping around if necessary)
  if #buffers > 1 and #windows > 0 then
    for i, v in ipairs(buffers) do
      if v == bufnr then
        local prev_buf_idx = i == 1 and #buffers or (i - 1)
        local prev_buffer = buffers[prev_buf_idx]
        for _, win in ipairs(windows) do
          api.nvim_win_set_buf(win, prev_buffer)
        end
      end
    end
  end

  -- Check if buffer still exists, to ensure the target buffer wasn't killed
  -- due to options like bufhidden=wipe.
  if api.nvim_buf_is_valid(bufnr) and bo[bufnr].buflisted then
    vim.cmd(string.format("%s %d", kill_command, bufnr))
  end
end

vim.api.nvim_create_user_command(
  "BufferKill", 
  function()
    buf_kill "bd"
  end, 
  {}
)

vim.keymap.set("n", "<space>c", ":BufferKill<CR>", {noremap=true})
