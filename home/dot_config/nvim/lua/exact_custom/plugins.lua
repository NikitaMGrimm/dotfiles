local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },
  -- {
  --  'tools-life/taskwiki',
  --   event = "BufEnter *.md",
  --   dependencies = {
  --     {
  --      'vimwiki/vimwiki',
  --      init = function () --replace 'config' with 'init'
  --         vim.g.vimwiki_list = {{path = '~/Documents/Wiki', ext = '.md'}}
  --      end,
  --     },
  --     {
  --       'powerman/vim-plugin-AnsiEsc',
  --     },
  --     {
  --       'majutsushi/tagbar',
  --     },
  --     {
  --       'farseer90718/vim-taskwarrior',
  --     },
  --   },
  --   -- lazy = false,
  -- },

}

return plugins
