return {
  {
    "williamboman/mason.nvim",
    keys = { { "<leader>cM", vim.cmd.Mason, desc = "Mason" }, { "<leader>cm", false } },
    opts = {
      ui = { border = "rounded" },
    },
  },
}
