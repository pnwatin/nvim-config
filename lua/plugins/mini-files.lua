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
        close = "q",
        go_in = "<CR>",
        go_in_plus = "<CR>",
        go_out = "<bs>",
        go_out_plus = "<bs>",
        mark_goto = "'",
        mark_set = "m",
        reset = "<BS>",
        reveal_cwd = "@",
        show_help = "g?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
      },
      options = {
        use_as_default_explorer = true,
      },
    },
  },
}
