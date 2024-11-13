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
        go_in_plus = "<CR>",
      },
      options = {
        use_as_default_explorer = true,
      },
    },
  },
}
