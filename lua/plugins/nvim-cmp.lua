return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local bordered = require("cmp.config.window").bordered
      opts.window = {
        completion = bordered("rounded"),
        documentation = bordered("rounded"),
      }
    end,
  },
}
