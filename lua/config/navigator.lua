_NgConfigValues = {
  debug = false, -- log output
  width = 0.75, -- value of cols
  height = 0.38, -- listview height
  preview_height = 0.38,
  preview_lines = 40, -- total lines in preview screen
  preview_lines_before = 5, -- lines before the highlight line
  default_mapping = true,
  keymaps = {}, -- e.g keymaps={{key = "GR", func = vim.lsp.buf.references}, } this replace gr default mapping
  external = nil, -- true: enable for goneovim multigrid otherwise false

  border = 'single', -- border style, can be one of 'none', 'single', 'double', "shadow"
  lines_show_prompt = 10, -- when the result list items number more than lines_show_prompt,
  prompt_mode = 'insert', -- 'normal' | 'insert'
  -- fuzzy finder prompt will be shown
  combined_attach = 'both', -- both: use both customized attach and navigator default attach, mine: only use my attach defined in vimrc
  on_attach = function(client, bufnr)
    -- your on_attach will be called at end of navigator on_attach
  end,
  -- ts_fold = false, -- deprecated
  ts_fold = {
    enable = false,
    comment = true, -- ts fold text object
    max_lines_scan_comments = 2000, -- maximum lines to scan for comments
    disable_filetypes = {'help', 'text', 'markdown'}, -- disable ts fold for specific filetypes
  },
  treesitter_analysis = true, -- treesitter variable context
  treesitter_navigation = true, -- bool|table
  treesitter_analysis_max_num = 100, -- how many items to run treesitter analysis
  treesitter_analysis_max_fnum = 20, -- how many files to run treesitter analysis
  treesitter_analysis_condense = true, -- short format of function
  treesitter_analysis_depth = 3, -- max depth
  transparency = 50, -- 0 ~ 100 blur the main window, 100: fully transparent, 0: opaque,  set to nil to disable it
  lsp_signature_help = true, -- if you would like to hook ray-x/lsp_signature plugin in navigator
  -- setup here. if it is nil, navigator will not init signature help
  signature_help_cfg = { debug = false }, -- if you would like to init ray-x/lsp_signature plugin in navigator, pass in signature help
  ctags = {
    cmd = 'ctags',
    tagfile = '.tags',
    options = '-R --exclude=.git --exclude=node_modules --exclude=test --exclude=vendor --excmd=number',
  },
  lsp = {
    enable = true, -- if disabled make sure add require('navigator.lspclient.mapping').setup() in you on_attach
    code_action = {
      delay = 3000, -- how long the virtual text will be shown
      enable = true,
      sign = true,
      sign_priority = 40,
      virtual_text = true,
      virtual_text_icon = true,
    },
    rename = {
      enable = true,
      style = 'floating-preview', -- 'floating' | 'floating-preview' | 'inplace-preview'
      show_result = true,
      confirm = '<S-CR>',
      cancel = '<S-ESC>',
    },
    document_highlight = true, -- highlight reference a symbol
    code_lens_action = {
      enable = true,
      sign = true,
      sign_priority = 40,
      virtual_text = true,
      virtual_text_icon = true,
    },
    diagnostic = {
      enable = true,
      underline = true,
      virtual_text = { spacing = 3, source = true }, -- show virtual for diagnostic message
      update_in_insert = false, -- update diagnostic message in insert mode
      severity_sort = { reverse = true },
      float = {
        focusable = false,
        sytle = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
      },
    },
    definition = { enable = true },
    call_hierarchy = { enable = true },
    implementation = { enable = true },
    workspace = { enable = true },
    hover = {
      enable = true,
      keymaps = {
        ['<C-k>'] = {
          go = function()
            local w = vim.fn.expand('<cWORD>')
            w = w:gsub('*', '')
            vim.cmd('GoDoc ' .. w)
          end,
          python = function()
            local w = vim.fn.expand('<cWORD>')
            local setup = {
              'pydoc',
              w,
            }
            return vim.fn.jobstart(setup, {
              on_stdout = function(_, data, _)
                if not data or (#data == 1 and vim.fn.empty(data[1]) == 1) then
                  return
                end
                local close_events = { 'CursorMoved', 'CursorMovedI', 'BufHidden', 'InsertCharPre' }
                local config = {
                  close_events = close_events,
                  focusable = true,
                  border = 'single',
                  width = 80,
                  zindex = 100,
                }
                vim.lsp.util.open_floating_preview(data, 'python', config)
              end,
            })
          end,
          default = function()
            local w = vim.fn.expand('<cword>')
            print('default ' .. w)
            vim.lsp.buf.workspace_symbol(w)
          end,
        },
      },
    }, -- bind hover action to keymap; there are other options e.g. noice, lspsaga provides lsp hover
    format_on_save = true, -- {true|false} set to false to disasble lsp code format on save (if you are using prettier/efm/formater etc)
    -- table: {enable = {'lua', 'go'}, disable = {'javascript', 'typescript'}} to enable/disable specific language
    -- enable: a whitelist of language that will be formatted on save
    -- disable: a blacklist of language that will not be formatted on save
    -- function: function(bufnr) return true end to enable/disable lsp format on save
    format_options = { async = false }, -- async: disable by default, I saw something unexpected
    disable_nulls_codeaction_sign = true, -- do not show nulls codeactions (as it will alway has a valid action)
    disable_format_cap = {}, -- a list of lsp disable file format (e.g. if you using efm or vim-codeformat etc), empty by default
    disable_lsp = {}, -- a list of lsp server disabled for your project, e.g. denols and tsserver you may
    -- only want to enable one lsp server
    display_diagnostic_qf = false, -- bool: always show quickfix if there are diagnostic errors
    -- string: trouble use trouble to show diagnostic
    diagnostic_load_files = false, -- lsp diagnostic errors list may contains uri that not opened yet set to true
    -- to load those files
    diagnostic_virtual_text = true, -- show virtual for diagnostic message
    diagnostic_update_in_insert = false, -- update diagnostic message in insert mode
    diagnostic_scrollbar_sign = { '▃', '▆', '█' }, -- set to nil to disable, set to {'╍', 'ﮆ'} to enable diagnostic status in scroll bar area
    tsserver = {
      -- filetypes = {'typescript'} -- disable javascript etc,
      -- set to {} to disable the lspclient for all filetype
    },
    neodev = false,
    lua_ls = {
      -- sumneko_root_path = sumneko_root_path,
      -- sumneko_binary = sumneko_binary,
      -- cmd = {'lua-language-server'}
    },
    servers = {}, -- you can add additional lsp server so navigator will load the default for you
  },
  mason = true, -- set to true if you would like use the lsp installed by williamboman/mason
  mason_disabled_for = {}, -- disable mason for specified lspclients
  icons = {
    -- requires Nerd Font or nvim-web-devicons pre-installed
    icons = true, -- set to false to use system default ( if you using a terminal does not have nerd/icon)

    -- Values (floating window)
    value_definition = '🐶🍡', -- identifier defined
    value_changed = '📝', -- identifier modified
    context_separator = '  ', -- separator between text and value

    -- Formatting for Side Panel
    side_panel = {
      section_separator = '󰇜',
      line_num_left = '',
      line_num_right = '',
      inner_node = '├○',
      outer_node = '╰○',
      bracket_left = '⟪',
      bracket_right = '⟫',
    },
    fold = {
      prefix = '⚡',
      separator = '',
    },

    -- Treesitter
    -- Note: many more node.type or kind may be available
    match_kinds = {
      var = ' ', -- variable -- "👹", -- Vampaire
      const = '󱀍 ',
      method = 'ƒ ', -- method --  "🍔", -- mac
      -- function is a keyword so wrap in ['key'] syntax
      ['function'] = '󰡱 ', -- function -- "🤣", -- Fun
      parameter = '  ', -- param/arg -- Pi
      parameters = '  ', -- param/arg -- Pi
      required_parameter = '  ', -- param/arg -- Pi
      associated = '🤝', -- linked/related
      namespace = '🚀', -- namespace
      type = '󰉿', -- type definition
      field = '🏈', -- field definition
      module = '📦', -- module
      flag = '🎏', -- flag
    },
    treesitter_defult = '🌲', -- default symbol when unknown node.type or kind
    doc_symbols = '', -- document
  },
}

local kind_symbols = {
  Text = '',
  Method = 'ƒ',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '󰠱',
  Interface = '',
  Module = '󰕳',
  Property = '',
  Unit = '',
  Value = '󰰪',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = ' ',
  Event = '',
  Operator = '',
  TypeParameter = ' ',
  Default = '',
}

local CompletionItemKind = {
  '',
  '𝔉 ',
  'ⓕ ',
  ' ',
  '',
  ' ',
  ' ',
  '',
  '',
  ' ',
  ' ',
  '',
  '𝕰 ',
  '',
  '󰘍',
  ' ',
  ' ',
  ' ',
  ' ',
  ' ',
  ' ',
  ' ',
  '󰯹',
  ' ',
  ' ',
  ' ',
}

-- A symbol kind.
-- local SymbolKind = {
--   File = 1,
--   Module = 2,
--   Namespace = 3,
--   Package = 4,
--   Class = 5,
--   Method = 6,
--   Property = 7,
--   Field = 8,
--   Constructor = 9,
--   Enum = 10,
--   Interface = 11,
--   Function = 12,
--   Variable = 13,
--   Constant = 14,
--   String = 15,
--   Number = 16,
--   Boolean = 17,
--   Array = 18,
--   Object = 19,
--   Key = 20,
--   Null = 21,
--   EnumMember = 22,
--   Struct = 23,
--   Event = 24,
--   Operator = 25,
--   TypeParameter = 26
-- }

local SymbolItemKind = {
  ' ',
  ' ',
  ' ',
  ' ',
  ' ',
  'ƒ ',
  ' ',
  '',
  ' ',
  ' ',
  ' ',
  '󰡱 ',
  ' ',
  ' ',
  ' ',
  '',
  ' ',
  ' ',
  '󰇥 ',
  ' ',
  '󰟢',
  '󰎬',
  ' ',
  '󰯹',
  '',
  ' ',
  ' ',
}

function symbol_kind(kind)
  return SymbolItemKind[kind] or ''
end

function prepare_for_render(items, opts)
  opts = opts or {}
  if items == nil or #items < 1 then
    return
  end
  local item = clone(items[1])
  local display_items = { item }
  local last_summary_idx = 1
  local total_ref_in_file = 1
  local total = opts.total
  local icon = ' '
  local lspapi = opts.api or '∑'

  local ok, devicons = pcall(require, 'nvim-web-devicons')
  if ok then
    local fn = filename(items[1].filename)
    local ext = extension(fn)
    icon = devicons.get_icon(fn, ext) or icon
  end
  -- local call_by_presented = false
  opts.width = opts.width or math.floor(vim.api.nvim_get_option('columns') * 0.8)
  local win_width = opts.width -- buf

  for i = 1, #items do
    local space
    local trim
    local lspapi_display = lspapi
    items[i].symbol_name = items[i].symbol_name or '' -- some LSP API does not have range for this

    local fn = display_items[last_summary_idx].filename
    local dfn = items[i].display_filename
    if last_summary_idx == 1 then
      lspapi_display = items[i].symbol_name .. ' ' .. lspapi_display
    end

    display_items[last_summary_idx].filename_only = true
    -- TODO refact display_filename generate part
    if items[i].filename == fn or opts.hide_filename then
      space, trim = get_pads(opts.width, icon .. ' ' .. dfn, lspapi_display .. ' 14 of 33 ')
      if trim and opts.width > 50 and #dfn > opts.width - 20 then
        local fn1 = string.sub(dfn, 1, opts.width - 50)
        local fn2 = string.sub(dfn, #dfn - 10, #dfn)
        display_items[last_summary_idx].display_filename = fn1 .. '󰇘' .. fn2
        space = '  '
        -- log("trim", fn1, fn2)
      end
      local api_disp = string.format(
        '%s  %s%s%s %i',
        icon,
        display_items[last_summary_idx].display_filename,
        space,
        lspapi_display,
        total_ref_in_file
      )

      if total then
        api_disp = api_disp .. ' of: ' .. tostring(total)
      end

      display_items[last_summary_idx].text = api_disp
      total_ref_in_file = total_ref_in_file + 1
    else
      lspapi_display = lspapi
      item = clone(items[i])

      space, trim =
        get_pads(opts.width, icon .. '  ' .. item.display_filename, lspapi_display .. ' 12 of 34')
      if trim and opts.width > 52 and #item.display_filename > opts.width - 20 then
        item.display_filename = string.sub(item.display_filename, 1, opts.width - 52)
          .. '󰇘'
          .. string.sub(item.display_filename, #item.display_filename - 10, #item.display_filename)
        space = '  '
      end
      item.text = string.format('%s  %s%s%s 1', icon, item.display_filename, space, lspapi_display)

      table.insert(display_items, item)
      total_ref_in_file = 1
      last_summary_idx = #display_items
    end
    -- content of code lines
    item = clone(items[i])
    if opts.side_panel then
      item.text = item.text:gsub('%s+', ' ')
    else
      item.text = require('navigator.util').trim_and_pad(item.text)
    end
    item.text = string.format('%4i: %s', item.lnum, item.text)
    local ts_report = ''
    if item.lhs then
      ts_report = _NgConfigValues.icons.value_changed
    end

    -- log(item.text, item.symbol_name, item.uri)
    -- log(item.text)
    if item.definition then
      log('definition', item.call_by, item.symbol_name, item.text)
      if opts.side_panel then
        ts_report = _NgConfigValues.icons.value_definition
      else
        ts_report = ts_report .. _NgConfigValues.icons.value_definition .. ' '
      end
    end
    local header_len = #ts_report + 4 -- magic number 2

    item.text = item.text:gsub('%s*[%[%(%{]*%s*$', '')
    if item.call_by ~= nil and item.call_by ~= '' then
      ts_report = ts_report .. _NgConfigValues.icons.match_kinds['function'] .. item.call_by
    end
    if #ts_report > 1 then
      space, trim = get_pads(win_width, item.text, ts_report)

      local l = math.max(20, opts.width - math.min(20, #ts_report))
      if trim and #item.text < l then
        trim = false
      end
      if trim then
        item.text = string.sub(item.text, 1, l)
        item.text = util.sub_match(item.text)
        -- let check if there are unmatched "/'
      end
      if #space + #item.text + #ts_report >= win_width then
        if #item.text + #ts_report >= win_width then
          space = '  '
          local len = math.max(win_width - #item.text - 4, 16)

          ts_report = ts_report:sub(1, len)
        else
          local remain = win_width - #item.text - #ts_report
          space = string.rep(' ', remain)
        end
      end
      item.text = item.text .. space .. ts_report
    end
    local tail = display_items[#display_items].text
    if tail ~= item.text then -- deduplicate
      table.insert(display_items, item)
    end
  end

  display_items[last_summary_idx].filename_only = true
  -- display_items[last_summary_idx].text=string.format("%s [%i]", display_items[last_summary_idx].filename,
  -- total_ref_in_file)
  return display_items
end

function new_list_view(opts)
  local config = _NgConfigValues

  if active_list_view ~= nil then
    local winnr = active_list_view.win
    local bufnr = active_list_view.buf

    if bufnr and vim.api.nvim_buf_is_valid(bufnr) and winnr and vim.api.nvim_win_is_valid(winnr) then
      log('list view already present')
      return active_list_view
    end
  end
  local items = opts.items

  opts.height_ratio = opts.height_ratio or config.height
  opts.width_ratio = opts.width_ratio or config.width
  opts.preview_height_ratio = opts.preview_height or config.preview_height
  opts.preview_lines = config.preview_lines
  if opts.rawdata then
    opts.data = items
  else
    opts.data = prepare_for_render(items, opts)
  end
  opts.border = config.border or 'shadow'
  if vim.fn.hlID('TelescopePromptBorder') > 0 then
    opts.border_hl = 'TelescopePromptBorder'
    opts.list_hl = 'TelescopeNormal'
    opts.bg_hl = 'TelescopePreviewNormal'
    opts.sel_hl = 'TelescopeSelection'
  else
    opts.border_hl = 'FloatBorder'
    opts.bg_hl = 'NormalFloat'
    opts.list_hl = 'NormalFloat'
    opts.sel_hl = 'PmenuSel'
  end
  if not items or vim.tbl_isempty(items) then
    log('empty data return')
    return
  end

  opts.transparency = config.transparency
  if #items >= config.lines_show_prompt then
    opts.prompt = true
    opts.prompt_mode = _NgConfigValues.prompt_mode 
  end

  opts.external = config.external
  opts.preview_lines_before = 4
  opts.title = opts.title or 'Navigator Searcher'
  if _NgConfigValues.debug then
    local logopts = { items = {}, data = {} }
    logopts = vim.tbl_deep_extend('keep', logopts, opts)
    log(logopts)
  end
  active_list_view = require('guihua.gui').new_list_view(opts)
  return active_list_view
end

function document_symbol_handler(err, result, ctx)
  if err then
    if error ~= 'timeout' then
      vim.notify(
        'failed to get document symbol' .. vim.inspect(ctx) .. err,
        vim.log.levels.WARN
      )
    end
    return
  end
  local bufnr = ctx.bufnr or 0
  local query = ' '
  if ctx.params and ctx.params.query then
    query = query .. ctx.params.query .. ' '
  end

  if not result or vim.tbl_isempty(result) then
    return
  end
  local locations = {}
  local fname = vim.fn.expand('%:p:f')
  local uri = vim.uri_from_fname(fname)
  for i = 1, #result do
    local item = {}
    item.kind = result[i].kind
    local kind = symbol_kind(item.kind)
    item.name = result[i].name
    item.range = result[i].range or result[i].location.range
    item.uri = uri
    item.selectionRange = result[i].selectionRange
    item.detail = result[i].detail or ''
    if item.detail == '()' then
      item.detail = 'func'
    end

    item.lnum = item.range.start.line + 1
    item.text = '[' .. kind .. ']' .. item.name .. ' ' .. item.detail

    item.filename = fname
    item.indent_level = 1

    item.type = kind
    item.node_text = item.name

    table.insert(locations, item)
    if result[i].children ~= nil then
      for _, c in pairs(result[i].children) do
        local child = {}
        child.kind = c.kind
        child.name = c.name
        child.range = c.range or c.location.range
        local ckind = symbol_kind(child.kind)

        child.node_text = child.name
        child.type = ckind
        child.selectionRange = c.selectionRange
        child.filename = fname
        child.uri = uri
        child.lnum = child.range.start.line + 1
        child.detail = c.detail or ''
        child.indent_level = item.indent_level + 1
        child.text = '   ' .. ckind .. '' .. child.name .. ' ' .. child.detail
        table.insert(locations, child)
      end
    end
  end
  if ctx.no_show then
    return locations
  end

  local ft = vim.api.nvim_buf_get_option(bufnr, 'ft')
  new_list_view({
    items = locations,
    prompt = true,
    rawdata = true,
    height = 0.62,
    preview_height = 0.1,
    title = 'Document Symbols',
    ft = ft,
    api = _NgConfigValues.icons.doc_symbol,
  })
end

function document_symbols(opts)
  opts = opts or {}
  local lspopts = {
    loc = 'top_center',
    prompt = true,
    api = ' ',
  }

  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  vim.list_extend(lspopts, opts)
  local params = vim.lsp.util.make_position_params()
  params.context = { includeDeclaration = true }
  params.query = opts.prompt or ''
  vim.lsp.for_each_buffer_client(bufnr, function(client, _, _bufnr)
    client.request('textDocument/documentSymbol', params, document_symbol_handler, _bufnr)
  end)
end

vim.keymap.set('n', 'g0', document_symbols, { desc = 'Symbols' })
