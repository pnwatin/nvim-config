return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
      {
        "<leader>e",
        function()
          local oil = require("oil")
          oil.toggle_float()
        end,
        desc = "Open oil",
        silent = true,
      },
      {
        "<leader>E",
        function()
          local oil = require("oil")
          local cwd = vim.fn.getcwd()
          oil.toggle_float(cwd)
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
    "echasnovski/mini.files",
    lazy = false,
    enabled = false,
    keys = {
      {
        "<leader>fm",
        false,
      },
      {
        "<leader>fM",
        false,
      },
      {
        "<leader>e",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>E",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
    opts = {
      mappings = {
        go_in = "<Right>",
        go_in_plus = "<CR>",
        go_out = "<Left>",
        go_out_plus = "<Left>",
        close = "q",
        synchronize = "s",
      },
      windows = {
        width_focus = 30,
        width_preview = 50,
      },
      options = {
        use_as_default_explorer = true,
      },
    },
  },
}
