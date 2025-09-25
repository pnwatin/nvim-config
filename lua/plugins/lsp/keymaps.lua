---@diagnostic disable: inject-field

local M = {}

---@type LazyKeysLspSpec[]|nil
M._keys = nil

---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string|string[], cond?:fun():boolean}
---@alias LazyKeysLsp LazyKeys|{has?:string|string[], cond?:fun():boolean}

---@return LazyKeysLspSpec[]
function M.get()
  if M._keys then
    return M._keys
  end
  M._keys = {
    { "gd", require("fzf-lua").lsp_definitions, desc = "Goto Definition", has = "definition" },
    { "gr", require("fzf-lua").lsp_references, desc = "References", nowait = true },
    {
      "gI",
      require("fzf-lua").lsp_implementations,
      desc = "Goto Implementation",
      nowait = true,
    },
    { "gy", require("fzf-lua").lsp_typedefs, desc = "Goto Type Definition", nowait = true },
    {
      "gD",
      require("fzf-lua").lsp_declarations,
      desc = "Goto Type Declaration",
      nowait = true,
    },
    {
      "K",
      function()
        return vim.lsp.buf.hover()
      end,
      desc = "Hover",
    },
    {
      "<leader>cK",
      function()
        return vim.lsp.buf.signature_help()
      end,
      desc = "Signature Help",
      has = "signatureHelp",
    },
    {
      "<leader>ca",
      require("fzf-lua").lsp_code_actions,
      desc = "Code Action",
      mode = { "n", "v" },
      has = "codeAction",
    },
    { "<leader>cc", vim.lsp.codelens.run, desc = "Codelens", mode = { "n", "v" }, has = "codeLens" },
    { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh Codelens", has = "codeLens" },
    {
      "<leader>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
      has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
    },
    { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
  }

  return M._keys
end

---@param method string|string[]
function M.has(buffer, method)
  if type(method) == "table" then
    for _, m in ipairs(method) do
      if M.has(buffer, m) then
        return true
      end
    end
    return false
  end
  method = method:find("/") and method or "textDocument/" .. method
  local clients = vim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client:supports_method(method) then
      return true
    end
  end
  return false
end

---@return LazyKeysLsp[]
function M.resolve(buffer)
  local Keys = require("lazy.core.handler.keys")
  if not Keys.resolve then
    return {}
  end
  local spec = vim.tbl_extend("force", {}, M.get())
  local opts = Util.opts("nvim-lspconfig")
  local clients = vim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    local has = not keys.has or M.has(buffer, keys.has)
    local cond = not (keys.cond == false or ((type(keys.cond) == "function") and not keys.cond()))

    if has and cond then
      local opts = Keys.opts(keys)
      opts.cond = nil
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      ---@diagnostic disable-next-line: param-type-mismatch
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
