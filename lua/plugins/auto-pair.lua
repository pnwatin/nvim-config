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
          suround = true,
          cond = function(fn)
            return not fn.in_lisp() or fn.in_string()
          end,
          alpha = true,
          nft = { "tex", "rust" },
          multiline = false,
        },
      },
    },
  },
}
