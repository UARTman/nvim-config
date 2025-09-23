return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme gruvbox]]
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "igorlfs/nvim-dap-view", opts = {} },
    },
    keys = {
      {
        "<F5>",
        function()
          if (require("dap").session() == nil) then
            vim.cmd [[DapNew]]
          else
            require("dap").continue()
          end
        end,
        desc = ""
      }
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
    keys = {
      { '<leader>dt', function() require('dapui').toggle() end, desc = "Toggle debug windows" },
    },
  },
  "mfussenegger/nvim-lint",
  "mhartington/formatter.nvim",
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("telescope").setup {
        defaults = {
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top"
          }
        },
        pickers = {
          buffers = {
            theme = "dropdown",
            layout_config = {
              preview_cutoff = 1, -- Preview should always show (unless previewer = false)
              width = 0.5,
              height = function(_, _, max_lines)
                return math.min(max_lines, 20)
              end,
            },
            wrap_results = true,
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown()
          },
          ["file_browser"] = {
            -- hijack_netrw = true,
          },
        }
      }
    end,
    keys = {
      { '<leader>t',   group = "Telescope" },
      { '<leader>tb',  function() require('telescope.builtin').buffers() end,                   desc = "Buffers" },
      { '<leader>tB',  function() require('telescope.builtin').current_buffer_fuzzy_find() end, desc = "Current buffer fuzzy" },
      { '<leader>tf',  function() require('telescope.builtin').git_files() end,                 desc = "Git Files" },
      { '<leader>tF',  function() require('telescope.builtin').find_files() end,                desc = "Find Files" },
      { '<leader>tg',  function() require('telescope.builtin').live_grep() end,                 desc = "Grep local dir" },
      { '<leader>tls', function() require('telescope.builtin').lsp_document_symbols() end,      desc = "Grep local dir" },
    },
  },
  { "nvim-telescope/telescope-ui-select.nvim" },
  -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = { open_mapping = "<space>T", terminal_mappings = false, insert_mappings = false, }
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    }
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer"
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup {
        -- enabled = false,
        completion = { autocomplete = false },
        -- autocomplete = false,
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
              -- elseif luasnip.expand_or_jumpable() then
              --   luasnip.expand_or_jump()
            else
              -- cmp.complete()
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
              -- elseif luasnip.expand_or_jumpable() then
              --   luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),

        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }),
      }

      -- cmp.setup.buffer({enabled=false})

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        autocomplete = false,
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        autocomplete = false,
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end
  },
  {
    "nvimdev/indentmini.nvim",
    config = function()
      vim.cmd.highlight('IndentLine guifg=#665c54')
      vim.cmd.highlight('IndentLineCurrent guifg=#a89984')
      require("indentmini").setup({})
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      theme = 'gruvbox',
      sections = {
        lualine_a = { 'mode', 'selectioncount', 'searchcount' },
        lualine_b = { 'branch', 'diff',
          {
            'diagnostics',
            sources = { 'nvim_diagnostic', 'nvim_workspace_diagnostic', },
          } },
        lualine_c = { 'lsp_status', 'filename', },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = { 'diagnostics' },
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {
        lualine_a = {
          {
            _G.__get_selector,
            cond = function()
              local manager = require("neo-tree.sources.manager")
              local renderer = require("neo-tree.ui.renderer")

              local state_fs = manager.get_state("filesystem")
              local state_buf = manager.get_state("buffers")
              local state_git = manager.get_state("git_status")

              local window_exists = renderer.window_exists(state_fs) or renderer.window_exists(state_buf) or
                  renderer.window_exists(state_git)
              return window_exists
            end,
            padding = 0,
            separator = ""
          },
          "buffers"
        },
        lualine_b = {},
        lualine_c = {},
        lualine_z = { "tabs" },
      },
      extensions = {
        "toggleterm",
        "lazy",
        "nvim-dap-ui",
        "mason",
        "neo-tree",
        "fugitive",
        "trouble",
      }
    },
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>v", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
      sources = {
        "filesystem",
        "buffers",
        "document_symbols",
        "git_status",
      },
      -- source_selector = {
      --   winbar = true,
      -- },
      event_handlers = {
        {
          event = "after_render",
          handler = function(state)
            if state.current_position == "left" or state.current_position == "right" then
              vim.api.nvim_win_call(state.winid, function()
                local str = require("neo-tree.ui.selector").get()
                if str then
                  _G.__cached_neo_tree_selector = str
                end
              end)
            end
            -- print("test")
          end,
        },
      },

      -- fill any relevant options here
    },
    keys = {
      { '<leader>ft', ":Neotree toggle<return>",     desc = "Toggle neotree" },
      { '<leader>fg', ":Neotree git_status<return>", desc = "Neotree (git)" },
      { '<leader>fb', ":Neotree buffers<return>",    desc = "Neotree (buffers)" },
      { '<leader>ff', ":Neotree filesystem<return>", desc = "Neotree (filesystem)" },
    },
  },
  {
    "lewis6991/satellite.nvim", -- Scrollbar
    opts = {},
  },
  {
    'Wansmer/langmapper.nvim',
    lazy = false,
    priority = 1, -- High priority is needed if you will use `autoremap()`
    config = function()
      require('langmapper').setup({ --[[ your config ]] })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {
      warn_no_results = false,
      open_no_results = true,
    },
    cmd = "Trouble",
    keys = {
      {
        "<leader>x",
        desc = "Trouble",
      },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "tpope/vim-fugitive",
    keys = {
      { "<Leader>g", "<cmd>vertical G<cr>", desc = "Open Fugitive vertically" },
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua",              -- optional
      -- "echasnovski/mini.pick",         -- optional
      -- "folke/snacks.nvim",             -- optional
    },
    opts = {
      graph_style = "ascii",
    },
    keys = {
      { "<leader>ng", ":Neogit<cr>", "Open NeoGit" }
    },
  },
  {
    "tiagovla/scope.nvim",
    config = function()
      vim.opt.sessionoptions = {
        "buffers",
        "tabpages",
        "globals",
      }
      require("scope").setup({})
    end,
  },
  {
    "coffebar/neovim-project",
    opts = {
      projects = { -- define project roots
        -- "~/projects/*",
        -- "~/.config/*",
        -- "~/Programming/*",
        "~/Programming/dtc-utils"
      },
      picker = {
        type = "telescope", -- or "fzf-lua"
      },
      last_session_on_startup = false,
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      -- optional picker
      { "nvim-telescope/telescope.nvim", tag = "0.1.8" },
      -- optional picker
      { "ibhagwan/fzf-lua" },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    'gorbit99/codewindow.nvim',
    config = function()
      local codewindow = require('codewindow')
      codewindow.setup()
      codewindow.apply_default_keybinds()
    end,
  },
  {
    "NotAShelf/direnv.nvim",
    config = function()
      require("direnv").setup({})
    end,
  },
  {
    "tpope/vim-repeat",
  },
  {
    "rlane/pounce.nvim",
    keys = {
      { "<leader>s", "<cmd>Pounce<cr>", desc = "Pounce", mode = { "n", "x" } },
      { "<leader>S", "<cmd>Pounce<cr>", desc = "Pounce" },
    }
  },
  {
    "ojroques/nvim-bufdel",
    opts = {
      next = "alternate",
      quit = false,
    },
    keys = {
      { '<leader>q', ":BufDel<cr>", desc = "Close buffer" },
    },
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({
        lightbulb = {
          enable = false,
        }
      })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    }
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      require("notify").setup({
        merge_duplicates = true,
        timeout = 4000,
        top_down = false,
        render = "wrapped-compact"
      })
      vim.notify = require("notify")
    end
  },
  {
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
    opts = {},
    keys = {
      {
        "<leader>fs",
        function() require("rip-substitute").sub() end,
        mode = { "n", "x" },
        desc = " rip substitute",
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
  -- {
  --   'swaits/lazyjj.nvim',
  --   dependencies = 'nvim-lua/plenary.nvim',
  --   opts = {
  --     mapping = '<leader>jj'
  --   }
  -- },
  -- {
  --   "willothy/flatten.nvim",
  --   opts = {
  --     window = {
  --       open = "alternate",
  --     },
  --   },
  -- or pass configuration with
  -- opts = {  }
  -- Ensure that it runs first to minimize delay when opening file from terminal
  -- lazy = false,
  -- priority = 1001,
  -- }
  {
    "julienvincent/hunk.nvim",
    cmd = { "DiffEditor" },
    config = function()
      require("hunk").setup()
    end,
  },
  -- {
  --   "m4xshen/autoclose.nvim",
  --   opts = {},
  -- },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  --
  --   -- For `nvim-treesitter` users.
  --   priority = 49,
  --
  --   -- For blink.cmp's completion
  --   -- source
  --   -- dependencies = {
  --   --     "saghen/blink.cmp"
  --   -- },
  -- },
}
