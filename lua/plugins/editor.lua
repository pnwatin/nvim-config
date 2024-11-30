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
        close = "<esc>",
        go_in_plus = "<CR>",
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
  {
    "folke/which-key.nvim",
    opts = {
      triggers = {
        { "<auto>", mode = "nixsotc" },
        { "s", mode = { "n", "v" } },
      },
    },
  },
  {
    "folke/flash.nvim",
    keys = {
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
      {
        "s",
        false,
      },
      {
        "S",
        false,
      },
    },
  },
}
