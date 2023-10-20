-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local toggleSystemDarkMode = function()
  local cmd =
    "!osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to not dark mode'"
  vim.cmd("silent " .. cmd)
  ToggleNvimTheme()
end

vim.keymap.set(
  "n",
  "<leader>ts",
  toggleSystemDarkMode,
  { noremap = true, silent = true, desc = "clear current search" }
)

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { noremap = true, silent = true, desc = "clear current search" })

-- buffers
vim.keymap.set("n", "<C-,>", ":bprev<enter>", { silent = true, desc = "Prev buffer" })
vim.keymap.set("n", "<C-.>", ":bnext<enter>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<C-x>", ":bdelete<enter>", { silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader><C-x>", ":%bd!<enter>", { silent = true, desc = "Delete all buffers" })

-- resets
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")
vim.keymap.del("n", "[b")
vim.keymap.del("n", "]b")
vim.keymap.del("n", "<leader>bb")
vim.keymap.del("n", "<leader>`")
