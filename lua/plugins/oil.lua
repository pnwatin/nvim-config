return {
  {
    "omelette-watin/oil.nvim",
    opts = {
      -- default_file_explorer = false,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["|"] = "actions.select_vsplit",
        ["-"] = "actions.select_split",
        -- ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["q"] = "actions.close",
        ["gr"] = "actions.refresh",
        ["<bs>"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      use_default_keymaps = false,
      view_options = {
        show_hidden = true,
      },
      preview = {
        min_width = 30,
      },
      skip_confirm_for_simple_edits = true,
      confirmation = {
        confirm = {
          label = "[Y]es",
          keymaps = {
            "y",
            "Y",
          },
        },
        cancel = {
          label = "[N]o",
          keymaps = {
            "n",
            "N",
          },
        },
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
