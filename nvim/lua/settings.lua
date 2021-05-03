vim.wo.wrap = false

vim.o.mouse = "a"
vim.o.splitbelow = true -- Horizontal splits will automatically be below
vim.o.termguicolors = true -- set term gui colors most terminals support this
vim.o.splitright = true -- Vertical splits will automatically be to the right

vim.o.t_Co = "256" -- Support 256 colors
vim.o.cmdheight = 2
vim.o.fileencoding = "utf-8"

vim.o.guifont = "Hack\\ Nerd\\ Font\\ Mono"
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

vim.o.showtabline = 2 -- Always show tabs
vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore
vim.o.backup = false -- This is recommended by coc
vim.o.writebackup = false -- This is recommended by coc

vim.cmd('set ts=4') -- Insert 2 spaces for a tab
vim.cmd('set sw=4') -- Change the number of space characters inserted for indentation
vim.bo.expandtab = true -- Converts tabs to spaces
vim.bo.smartindent = true -- Makes indenting smart

vim.o.conceallevel = 0 -- So that I can see `` in markdown files

