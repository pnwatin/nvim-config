-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- copy current file path to clipboard
vim.keymap.set(
  "n",
  "<leader>fC",
  ':let @+ = expand("%:p:.")<CR>',
  { noremap = true, silent = true, desc = "Copy path (cwd)" }
)

-- write and quit all
vim.keymap.set("n", "<leader>qw", "<Cmd>wqa<CR>", { noremap = true, silent = true, desc = "Write and Quit All" })

-- buffers
vim.keymap.set("n", "<C-,>", ":bprev<enter>", { silent = true, desc = "Prev buffer" })
vim.keymap.set("n", "<C-.>", ":bnext<enter>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<C-x>", function()
  Snacks.bufdelete()
end, { silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader><C-x>", function()
  Snacks.bufdelete.other()
end, { silent = true, desc = "Delete all other buffers" })
vim.keymap.set("n", "<leader>X", function()
  Snacks.bufdelete.all()
end, { silent = true, desc = "Delete all buffers" })

-- toggle lsp diagnostics virtual text
local function toggle_virtual_text()
  local enabled = vim.diagnostic.config().virtual_text == false

  local enabled_config = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  }
  vim.diagnostic.config({ virtual_text = enabled and enabled_config or false })

  local desc = enabled and "Disable diagnostics text" or "Enable diagnostics text"
  vim.keymap.set("n", "<leader>uv", toggle_virtual_text, { desc = desc })

  print(enabled and "Diagnostics text enabled" or "Diagnostics text disabled")
end
vim.keymap.set("n", "<leader>uv", toggle_virtual_text, { desc = "Enable diagnostics text" })
