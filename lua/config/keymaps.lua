-- windows
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- buffers
vim.keymap.set("n", "<leader>d", ":bd<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>D", ":bd!<CR>", { noremap = true, silent = true })

-- diagnostics
local diagnostic_goto = function(next, severity)
  return function()
    local diag = next and vim.diagnostic.get_next({ severity = severity })
      or vim.diagnostic.get_prev({ severity = severity })
    if not diag then
      vim.api.nvim_echo({ { "No more valid diagnostics to move to", "WarningMsg" } }, true, {})
      return
    end
    vim.diagnostic.jump({ diagnostic = diag, count = (diag == nil and 1) or nil })
  end
end
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, vim.diagnostic.severity.ERROR), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, vim.diagnostic.severity.ERROR), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, vim.diagnostic.severity.WARN), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, vim.diagnostic.severity.WARN), { desc = "Prev Warning" })

-- lazy
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

vim.keymap.set("n", "<leader>cf", function()
  local filepath = vim.fn.expand("%:p")

  if filepath == "" then
    vim.notify("No file associated with this buffer.", vim.log.levels.WARN)
    return
  end

  local relpath = vim.fn.fnamemodify(filepath, ":.")

  vim.fn.setreg("+", relpath)
  vim.fn.setreg("*", relpath)

  vim.notify("Copied file path: " .. relpath, vim.log.levels.INFO)
end, { noremap = true, silent = true, desc = "Copy path (cwd)" })

-- clear search on escape
vim.keymap.set({ "i", "n", "s" }, "<Esc>", "<Esc>:noh<CR>", { noremap = true, silent = true })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- comments
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
