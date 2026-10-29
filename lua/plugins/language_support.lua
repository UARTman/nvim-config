return {
  {
    "neovim/nvim-lspconfig",
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "Bilal2453/luvit-meta",
    lazy = true
  }, -- optional `vim.uv` typings
  {
    'ShinKage/idris2-nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'MunifTanjim/nui.nvim' },
    ft = "idris2",
    config = function()
      require('idris2').setup({
        server = {
          settings = {
            briefCompletions = true,
          },

        },
      })
    end,
    keys = {
      { '<leader>i',  group = "Idris", },
      { '<leader>im', function() require('idris2.metavars').request_all() end,           desc = "List metavars" },
      { '<leader>ik', function() require('idris2.hover').open_split() end,               desc = "Open hover in panel" },
      { '<leader>ib', function() require('idris2.browse').browse() end,                  desc = "Browse namespace" },
      { '<leader>iE', function() require('idris2.repl').evaluate() end,                  desc = "Evaluate in REPL",   mode = { "n" } },
      { '<leader>iE', function() require('idris2.repl').evaluate({ visual = true }) end, desc = "Evaluate in REPL",   mode = { "v" } },
    }
  },
  {
    'kaarmu/typst.vim',
    ft = 'typst',
    lazy = false,
  },
  {
    "chomosuke/typst-preview.nvim",
    -- lazy = false,
    ft = "typst",
    version = "1.*",
    opts = {
      dependencies_bin = {
        ['tinymist'] = "tinymist",
        ['websocat'] = "websocat",
      },
      debug = true,
    },
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false,   -- This plugin is already lazy
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
  'mrcjkb/haskell-tools.nvim',
  version = '^6', -- Recommended
  lazy = false, -- This plugin is already lazy
  },
  {
    'Julian/lean.nvim',
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

    dependencies = {
      -- optional dependencies:

      -- 'nvim-telescope/telescope.nvim', -- for Lean-specific pickers
      -- 'andymass/vim-matchup',          -- for enhanced % motion behavior
      -- 'andrewradev/switch.vim',        -- for switch support
      -- 'tomtom/tcomment_vim',           -- for commenting
    },

    ---@type lean.Config
    opts = { -- see the manual for full configuration options
      mappings = true,
    }
  }
}
