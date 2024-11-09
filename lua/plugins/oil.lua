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
}
