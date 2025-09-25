local prettier = require("plugins.formatting.prettier")
local biome = require("plugins.formatting.biome")

local format_opts = {
  timeout_ms = 3000,
  async = false,
  quiet = false,
  lsp_format = "fallback",
}

return {
  {
    "stevearc/conform.nvim",
    lazy = false,
    cmd = "ConformInfo",
    opts = function()
      local opts = {
        formatters_by_ft = {
          lua = { "stylua" },
        },
        formatters = {
          prettier = prettier.get_config(),
          biome = biome.get_config(),
          ["biome-check"] = biome.get_config(),
        },
        format_on_save = function(bufnr)
          local b = vim.b[bufnr].autoformat
          local g = vim.g.autoformat
          local global_enabled = g
          local buffer_enabled = b == nil or b

          if not global_enabled or not buffer_enabled then
            return
          end

          return format_opts
        end,
        default_format_opts = format_opts,
      }

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      prettier.register(opts.formatters_by_ft)
      biome.register(opts.formatters_by_ft)

      return opts
    end,
    config = function(_, opts)
      require("conform").setup(opts)

      Snacks.toggle
        .new({
          name = "Auto Format (global)",
          get = function()
            return vim.g.autoformat
          end,
          set = function(state)
            vim.g.autoformat = state
          end,
        })
        :map("<leader>tf")
      Snacks.toggle
        .new({
          name = "Auto Format (buffer)",
          get = function()
            local b = vim.b.autoformat

            return b == nil or b
          end,
          set = function(state)
            vim.b.autoformat = state
          end,
        })
        :map("<leader>tF")
    end,
  },
}
