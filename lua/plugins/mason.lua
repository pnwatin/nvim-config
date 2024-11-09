return {
  {
    "williamboman/mason.nvim",
    keys = { { "<leader>M", vim.cmd.Mason, desc = "Mason" }, { "<leader>cm", false } },
    opts = {
      ui = { border = "rounded" },
    },
  },
}
