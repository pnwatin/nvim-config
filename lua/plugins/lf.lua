return {
  {
    "lmburns/lf.nvim",
    cmd = "Lf",
    dependencies = { "nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim" },
    opts = {
      winblend = 0,
      highlights = { NormalFloat = { guibg = "NONE" } },
      border = "rounded",
      escape_quit = false,
    },
    keys = {
      { "<leader>e", "<cmd>Lf<cr>", desc = "LF file manager" },
      { "<leader>E", "<cmd>lua require('lf').start({ dir = 'gwd' })<cr>", desc = "LF file manager (GWD)" },
    },
  },
}
