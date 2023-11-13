vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap("gd", require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ss', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = 'Format current buffer with LSP' })
end

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
local servers = {
  'tsserver',
  'html',
  'cssls',
  'intelephense',
  'omnisharp',
  'volar',
  'tailwindcss',
}

-- Ensure the servers above are installed
require('mason-lspconfig').setup {
  ensure_installed = servers,
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').luau_lsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
}
--
-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

local cmp_window = require "cmp.config.window"
cmp.setup {
  formatting = {
    fields = { "kind", "abbr", "menu" },
    max_width = 0,
    format = function(entry, vim_item)
      local kindLabel = vim_item.kind
      vim_item.kind = ( require('icons').kind[kindLabel] or "?") .. " "
      vim_item.menu = " (" .. kindLabel .. ")"

      if vim.tbl_contains({ "nvim_lsp" }, entry.source.name) then
		local words = {}
		for word in string.gmatch(vim_item.word, "[^-]+") do
			table.insert(words, word)
		end

		local color_name, color_number
		if
			words[2] == "x"
			or words[2] == "y"
			or words[2] == "t"
			or words[2] == "b"
			or words[2] == "l"
			or words[2] == "r"
		then
			color_name = words[3]
			color_number = words[4]
		else
			color_name = words[2]
			color_number = words[3]
		end

		if color_name == "white" or color_name == "black" then
			local color
			if color_name == "white" then
				color = "ffffff"
			else
				color = "000000"
			end

			local hl_group = "lsp_documentColor_mf_" .. color
			vim.api.nvim_set_hl(0, hl_group, { fg = "#" .. color, bg = "#" .. color })
			vim_item.kind_hl_group = hl_group

			vim_item.kind = string.rep("X", 2)

			return vim_item
		elseif #words < 3 or #words > 4 then
			return vim_item
		end

		if not color_name or not color_number then
			return vim_item
		end

		local color_index = tonumber(color_number)
		local tailwindcss_colors = require("tailwindcss-colorizer-cmp.colors").TailwindcssColors

		if not tailwindcss_colors[color_name] then
			return vim_item
		end

		if not tailwindcss_colors[color_name][color_index] then
			return vim_item
		end

		local color = tailwindcss_colors[color_name][color_index]

		local hl_group = "lsp_documentColor_mf_" .. color
		vim.api.nvim_set_hl(0, hl_group, { fg = "#" .. color, bg = "#" .. color })

		vim_item.kind_hl_group = hl_group

		vim_item.kind = string.rep("X", 2)
      end 
	  return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp_window.bordered(),
    documentation = cmp_window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start({
      name = 'bash-language-server',
      cmd = { 'bash-language-server', 'start' },
    })
  end,
})

local autocmd_group = vim.api.nvim_create_augroup("Custom auto-commands", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.php", "*.js", "*.html", "*.ts", "*.cs", "*.tsx" },
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
  group = autocmd_group,
})

vim.keymap.set("n", "gl", function()
    local float = vim.diagnostic.config().float

    if float then
      local config = type(float) == "table" and float or {}
      config.scope = "line"

      vim.diagnostic.open_float(config)
    end
  end,
  {noremap=false}
)
