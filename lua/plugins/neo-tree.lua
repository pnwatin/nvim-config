return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree", remap = true },
    },
    opts = function(_, opts)
      opts.keys = {
        {
          { "<leader>e", "<leader>fe", desc = "Explorer NeoTree", remap = true },
        },
      }
    end,
  },
}
