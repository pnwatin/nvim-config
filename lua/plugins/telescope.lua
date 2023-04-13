return {
  {
    "nvim-telescope/telescope.nvim",

    opts = function(_, opts)
      local actions = require("telescope.actions")

      opts.defaults.mappings.i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      }
    end,
  },
}
