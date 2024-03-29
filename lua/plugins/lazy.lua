-- Install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Fixes Notify opacity issues
vim.o.termguicolors = true

require('lazy').setup({
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},  -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.summary"] = {},
          ["core.dirman"] = {      -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
  },
  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-ui',
  'kristijanhusak/vim-dadbod-completion',
  -- Database
  {
    "tpope/vim-dadbod",
    opt = true,
    requires = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      require("config.dadbod").setup()
    end,
  },
  'nvim-tree/nvim-tree.lua',
  'ThePrimeagen/git-worktree.nvim',
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require("project_nvim").setup {}
    end
  },
  'tpope/vim-surround',
  {
    'numToStr/FTerm.nvim',
    config = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      require 'FTerm'.setup({
        blend = 0,
        dimensions = {
          height = 0.90,
          width = 0.90,
          x = 0.5,
          y = 0.5,
        },
        hl = 'Normal',
      })
    end
  },

  {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        width = 120, -- Width of the floating window
        height = 15, -- Height of the floating window
        border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
        default_mappings = true,
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
        },
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = true,                                        -- Focus the floating window when opening it.
        dismiss_on_move = false,                                     -- Dismiss the floating window when moving the cursor.
        force_close = true,                                          -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe",                                          -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = true,                       -- Whether to nest floating windows
        preview_window_title = { enable = true, position = "left" }, -- Whether
      }
    end
  },

  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
      })
    end
  },

  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        lsp = {
          hover = {
            enabled = false,
          }
        }
        -- add any options here
        -- routes = {
        --   {
        --     view = "notify",
        --     filter = { event = "msg_showmode" },
        --   },
        -- },
      })
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },

  -- 'ray-x/go.nvim',
  'ray-x/guihua.lua',
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
    end
  },
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },


  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',
    }
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
    },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    }
  },

  { "rcarriga/nvim-dap-ui",                dependencies = { "mfussenegger/nvim-dap" } },
  'theHamsta/nvim-dap-virtual-text',
  'leoluz/nvim-dap-go',
  {
    'mxsdev/nvim-dap-vscode-js',
  },
  {
    "microsoft/vscode-js-debug",
    opt = true,
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'lewis6991/gitsigns.nvim',

  'navarasu/onedark.nvim',     -- Theme inspired by Atom
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  { "lukas-reineke/indent-blankline.nvim", main = "ibl",                            opts = {} },
  'numToStr/Comment.nvim',     -- "gc" to comment visual regions/lines
  'tpope/vim-sleuth',          -- Detect tabstop and shiftwidth automatically
  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim',            branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  'nvim-telescope/telescope-symbols.nvim',
  'ThePrimeagen/harpoon',

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make',   cond = vim.fn.executable 'make' == 1 },
  {
    "folke/twilight.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'doom',
        config = {
          center = {
            {
              icon = ' ',
              icon_hl = 'Title',
              desc = 'Find File           ',
              desc_hl = 'String',
              key = 'f',
              keymap = 'SPC s f',
              key_hl = 'Number',
              key_format = ' %s',
              action = 'lua require("telescope.builtin").find_files()'
            },
            {
              icon = ' ',
              desc = 'Find Grep',
              key = 'g',
              keymap = 'SPC f g',
              key_format = ' %s',
              action = 'lua require("telescope.builtin").live_grep()'
            },
            {
              icon = ' ',
              desc = 'Find Recent Files',
              key = '?',
              keymap = 'SPC ?',
              key_format = ' %s',
              action = 'lua require("telescope.builtin").oldfiles()'
            },
          },
          header = {
            [[                                                                     ]],
            [[                                                                     ]],
            [[                                                                     ]],
            [[                                                                     ]],
            [[          ____                                                       ]],
            [[         /___/\_                                                     ]],
            [[        _\   \/_/\__                                                 ]],
            [[      __\       \/_/\                             __                 ]],
            [[      \   __    __ \ \             ___    __  __ /\_\     ___ ___    ]],
            [[     __\  \_\   \_\ \ \   __     /' _ `\ /\ \/\ \\/\ \  /' __` __`\  ]],
            [[    /_/\\   __   __  \ \_/_/\    /\ \/\ \\ \ \_/ |\ \ \ /\ \/\ \/\ \ ]],
            [[    \_\/_\__\/\__\/\__\/_\_\/    \ \_\ \_\\ \___/  \ \_\\ \_\ \_\ \_\]],
            [[       \_\/_/\       /_\_\/       \/_/\/_/ \/__/    \/_/ \/_/\/_/\/_/]],
            [[          \_\/       \_\/                                            ]],
            [[                                                                     ]],
            [[                                                                     ]],
            [[                                                                     ]],
            [[                                                                     ]],
            [[                                                                     ]]
          }
        },
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },
  'mg979/vim-visual-multi',
  'ggandor/lightspeed.nvim',
  {
    'AckslD/nvim-trevJ.lua',
    config = function()
      require('plugins.trevj').setup()
    end,
  },
  "windwp/nvim-ts-autotag",
  "christoomey/vim-tmux-navigator",
  "ap/vim-css-color",
  -- {
  --   'ray-x/navigator.lua',
  --   requires = {
  --     { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
  --     { 'neovim/nvim-lspconfig' },
  --   },
  --   config = function()
  --     require("navigator").setup({
  --       lsp = {
  --         disable_lsp='all',
  --       },
  --     })
  --   end,
  -- },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    lazy = false,
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end,
  },
  'xiyaowong/transparent.nvim',
  'yamatsum/nvim-cursorline',
  'p00f/nvim-ts-rainbow',
  { 'aznhe21/actions-preview.nvim', lazy = true },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require("treesitter-context").setup({
        enable = false,
      })
    end,
  },
  {
    'Exafunction/codeium.vim',
    config = function()
      vim.keymap.set(
        'i',
        '<C-k>',
        function() return vim.fn['codeium#Accept']() end,
        { expr = true, silent = true, noremap = true }
      )

      vim.keymap.set(
        'i',
        '<C-j>',
        function() return vim.fn['codeium#CycleCompletions'](1) end,
        { expr = true, silent = true, noremap = true }
      )

      vim.keymap.set(
        'i',
        '<C-f>',
        function() return vim.fn['codeium#CycleCompletions'](-1) end,
        { expr = true, silent = true, noremap = true }
      )

      vim.keymap.set(
        'i',
        '<C-x>',
        function() return vim.fn['codeium#Clear']() end,
        { expr = true, silent = true, noremap = true }
      )

      vim.keymap.set('i', '<C-l>', function()
        local fullCompletion = vim.api.nvim_eval(
        "b:_codeium_completions.items[b:_codeium_completions.index].completionParts[0].text")
        local cursor = vim.api.nvim_win_get_cursor(0)
        local line = vim.api.nvim_get_current_line()
        local completion = string.match(fullCompletion, '[ ,;.]*[^ ,;.]+')
        vim.defer_fn(function()
          if (string.match(completion, '^\t')) then
            vim.api.nvim_buf_set_lines(0, cursor[1], cursor[1], true, { completion })
            vim.api.nvim_win_set_cursor(0, { cursor[1] + 1, #completion })
          else
            local nline = line:sub(0, cursor[2]) .. completion .. line:sub(cursor[2] + 1)
            vim.api.nvim_set_current_line(nline)
            vim.api.nvim_win_set_cursor(0, { cursor[1], cursor[2] + #completion })
          end
        end, 0)
      end, { expr = true })
    end
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
      "rouge8/neotest-rust",
    },
  },
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<space>u", vim.cmd.UndotreeToggle)
    end
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
      })
    end,
  },
  "godlygeek/tabular",
  {
    "aaronhallaert/advanced-git-search.nvim",
    config = function()
      require("telescope").setup {
        extensions = {
          advanced_git_search = {}
        }
      }

      require("telescope").load_extension("advanced_git_search")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-fugitive",
      "tpope/vim-rhubarb",
    },
  },
  {
    'saecki/crates.nvim',
    tag = 'stable',
    config = function()
      require('crates').setup({
        popup = { border = 'rounded' },
      })
    end,
  }
})
