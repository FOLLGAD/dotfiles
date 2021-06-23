_G.light = true
vim.o.background = _G.light and "light" or "dark"
if _G.light then
  vim.cmd([[colorscheme tokyonight]])
else
  vim.cmd([[colorscheme gruvbox]])
end

vim.wo.cursorline = true

