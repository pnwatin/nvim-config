return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local bordered = require("cmp.config.window").bordered
      opts.window = {
        completion = bordered("rounded"),
        documentation = bordered("rounded"),
      }
      opts.formatting = {
        format = function(_, item)
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end

          item.abbr = string.sub(item.abbr, 1, 30)
          return item
        end,
      }
    end,
  },
}
