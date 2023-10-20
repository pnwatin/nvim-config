---@diagnostic disable: missing-global-doc
-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

function IsDarkMode()
  local command = "defaults read -g AppleInterfaceStyle 2>/dev/null"
  local output = vim.fn.system(command)

  if string.find(output, "Dark") then
    return true
  else
    return false
  end
end

function ToggleNvimTheme()
  vim.cmd("Catppuccin " .. (IsDarkMode() == true and "mocha" or "latte"))
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = ToggleNvimTheme,
})
