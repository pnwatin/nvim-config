local M = {
  supported = {
    "sql",
    "mysql",
    "plsql",
  },
}

function M.get_config()
  return {
    cwd = require("conform.util").root_file({ ".sqlfluff", ".git" }),
    args = { "format", "-" },
  }
end

--- Register sqlfluff for supported filetypes
---@param formatters_by_ft table
function M.register(formatters_by_ft)
  for _, ft in ipairs(M.supported) do
    formatters_by_ft[ft] = formatters_by_ft[ft] or {}
    table.insert(formatters_by_ft[ft], "sqlfluff")
  end
end

return M
