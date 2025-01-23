return {
  {
    "echasnovski/mini.files",
    lazy = false,
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
