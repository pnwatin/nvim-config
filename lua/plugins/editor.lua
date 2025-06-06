return {
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    enabled = true,
    opts = {
      max_count = 4,
      disable_mouse = false,
      disabled_keys = {
        ["<Up>"] = false,
        ["<Down>"] = false,
        ["<Left>"] = false,
        ["<Right>"] = false,
      },
      restricted_keys = {
        ["<Up>"] = { "n", "x" },
        ["<Down>"] = { "n", "x" },
        ["<Left>"] = { "n", "x" },
        ["<Right>"] = { "n", "x" },
      },
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
      {
        "<leader>e",
        function()
          local oil = require("oil")
          oil.open(nil, { preview = { vertical = true } })
        end,
        desc = "Open oil",
        silent = true,
      },
      {
        "<leader>E",
        function()
          local oil = require("oil")
          oil.open(vim.fn.getcwd(), { preview = { vertical = true } })
        end,
        desc = "Open oil (cwd)",
        silent = true,
      },
    },
    opts = {
      keymaps = {
        ["q"] = "actions.close",
        ["<bs>"] = "actions.parent",
      },
      view_options = {
        show_hidden = true,
      },
      skip_confirm_for_simple_edits = true,
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {},
    keys = {
      { "s", false },
      { "S", false },

      {
        "ss",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "SS",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
}
