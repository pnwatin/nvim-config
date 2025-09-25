return {
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    ---@type snacks.Config
    opts = {
      git = { enabled = true },
      input = { enabled = false },
      image = { enabled = true },
      indent = {
        indent = {
          char = "╎",
          hl = "EndOfBuffer",
        },
        animate = { enabled = false },
        scope = { char = "╎", hl = "ModeMsg" },
      },
      lazygit = { enabled = true },
      rename = {
        enabled = true,
      },
      statuscolumn = { enabled = true },
      toggle = { enabled = true },
    },
  },
}
