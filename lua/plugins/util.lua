return {
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    ---@type snacks.Config
    opts = {
      git = { enabled = true },
      input = { enabled = false },
      indent = {
        indent = {
          char = "╎",
          hl = "EndOfBuffer",
        },
        animate = { enabled = false },
        scope = { char = "╎", hl = "ModeMsg" },
      },
      lazygit = {
        enabled = true,
        config = {
          os = {
            editPreset = "nvim-remote",
            edit = '[ -z "$NVIM" ] && (nvim -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{filename}})',
            editAtLine = '[ -z "$NVIM" ] && (nvim +{{line}} -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{filename}} && nvim --server "$NVIM" --remote-send ":{{line}}<CR>")',
            openDirInEditor = '[ -z "$NVIM" ] && (nvim -- {{dir}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{dir}})',
          },
        },
      },
      rename = {
        enabled = true,
      },
      statuscolumn = { enabled = true },
      toggle = { enabled = true },
    },
  },
}
