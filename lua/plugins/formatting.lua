return {
  {
    "stevearc/conform.nvim",
    lazy = false,
    cmd = "ConformInfo",
    opts = {
      formatters = {
        ["biome-check"] = { require_cwd = true },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        css = { "biome-check" },
        graphql = { "biome-check" },
        javascript = { "biome-check" },
        javascriptreact = { "biome-check" },
        json = { "biome-check" },
        jsonc = { "biome-check" },
        typescript = { "biome-check" },
        typescriptreact = { "biome-check" },
      },
      format_on_save = {
        timeout_ms = 500,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
    },
  },
}
