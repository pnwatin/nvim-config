return {}
-- return {
--   {
--     -- integrate with lualine
--     "nvim-lualine/lualine.nvim",
--     opts = function(_, opts)
--       local colors = {
--         yellow = "#e7d37a",
--         white = "#a1aab8",
--         magenta = "#c792ea",
--       }
--       local icons = require("lazyvim.config").icons
--       opts.sections.lualine_c = {
--         {
--           "diagnostics",
--           symbols = {
--             error = icons.diagnostics.Error,
--             warn = icons.diagnostics.Warn,
--             info = icons.diagnostics.Info,
--             hint = icons.diagnostics.Hint,
--           },
--         },
--         {
--           "lsp_progress",
--           colors = {
--             percentage = colors.yellow,
--             title = colors.white,
--             lsp_client_name = colors.magenta,
--             use = true,
--           },
--           separators = {
--             progress = " ",
--           },
--           timer = { progress_enddelay = 100, lsp_client_name_enddelay = 100 },
--           display_components = { "lsp_client_name", { "title", "percentage" } },
--         },
--       }
--     end,
--   },
--   {
--     "arkav/lualine-lsp-progress",
--   },
-- }
