local M = {
  supported = {
    "astro",
    "css",
    "graphql",
    -- "html",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    -- "markdown",
    "svelte",
    "typescript",
    "typescriptreact",
    "vue",
    -- "yaml",
  },
}

--- Get formatter configuration for conform.nvim
function M.get_config()
  return { require_cwd = true }
end

--- Register biome for supported filetypes
---@param formatters_by_ft table
function M.register(formatters_by_ft)
  for _, ft in ipairs(M.supported) do
    formatters_by_ft[ft] = formatters_by_ft[ft] or {}
    table.insert(formatters_by_ft[ft], "biome-check")
  end
end

return M
