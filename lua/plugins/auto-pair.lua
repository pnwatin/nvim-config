return {
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    opts = {
      config_internal_pairs = {
        { "{", "}", suround = true, multiline = true },
        { "[", "]", suround = true, multiline = true },
        { "(", ")", suround = true, multiline = true },
        {
          "'",
          "'",
          multiline = false,
          surround = true,
          cond = function(fn)
            if fn.get_ft() ~= "rust" then
              return true
            end
            return not fn.in_node({ "bounded_type", "reference_type", "type_arguments", "type_parameters" })
          end,
        },
      },
    },
  },
}
