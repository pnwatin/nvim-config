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
          oil.open()
        end,
        desc = "Open oil",
        silent = true,
      },
      {
        "<leader>E",
        function()
          local oil = require("oil")
          local cwd = vim.fn.getcwd()
          oil.open(cwd)
        end,
        desc = "Open oil (cwd)",
        silent = true,
      },
    },
    opts = {
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["|"] = "actions.select_vsplit",
        ["-"] = "actions.select_split",
        ["<C-p>"] = "actions.preview",
        ["q"] = "actions.close",
        ["gr"] = "actions.refresh",
        ["<bs>"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      use_default_keymaps = false,
      view_options = {
        show_hidden = true,
      },
      preview = {
        min_width = 30,
      },
      skip_confirm_for_simple_edits = true,
    },
  },
}
