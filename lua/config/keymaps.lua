-- buffers
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
vim.keymap.set("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- copy current file path to clipboard
vim.keymap.set("n", "<leader>cf", function()
  local filepath = vim.fn.expand("%:p")

  if filepath == "" then
    vim.notify("No file associated with this buffer.", vim.log.levels.WARN)
    return
  end

  vim.fn.setreg("+", filepath)
  vim.fn.setreg("*", filepath)

  vim.notify("Copied file path: " .. filepath, vim.log.levels.INFO)
end, { noremap = true, silent = true, desc = "Copy path (cwd)" })

-- move Lines
vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

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

-- clear search on escape
vim.keymap.set({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- comments
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- lazy
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- lazygit
if vim.fn.executable("lazygit") == 1 then
  vim.keymap.set("n", "<leader>gg", function()
    Snacks.lazygit({ cwd = Snacks.git.get_root() })
  end, { desc = "Lazygit (root)" })
  vim.keymap.set("n", "<leader>gG", function()
    Snacks.lazygit()
  end, { desc = "Lazygit (cwd)" })
end

-- toggles
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tL")
Snacks.toggle.diagnostics():map("<leader>td")
Snacks.toggle.line_number():map("<leader>tl")
Snacks.toggle.treesitter():map("<leader>tT")
Snacks.toggle.indent():map("<leader>tg")

-- resets

-- lsp
vim.keymap.del("n", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grt")
vim.keymap.del("n", "grr")
