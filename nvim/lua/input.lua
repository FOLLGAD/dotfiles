vim.o.mouse = "a"

vim.api.nvim_command('set termguicolors number relativenumber')
vim.o.cursorline = true
vim.o.number = true
vim.cmd("set number")

local map = vim.api.nvim_set_keymap

-- Set leader to <Space>
map('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

-- better indenting
map('v', '<', '<gv', {noremap = true, silent = true})
map('v', '>', '>gv', {noremap = true, silent = true})

-- Move selected line / block of text in visual mode
map('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
map('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

-- Leader keybinds
map('n', '<Leader>f', ':Telescope fd<CR>', {noremap=true})
map('n', '<Leader>r', ':Telescope live_grep<CR>', {noremap=true})
map('n', '<Leader>h', ':noh<CR>', {noremap=true,silent=true})

map('n', '<Leader>c', ':CommentToggle<CR>', {noremap=true,silent=true})
map('v', '<Leader>c', ':CommentToggle<CR>', {noremap=true,silent=true})

map('n', '<Leader>e', ':NvimTreeToggle<CR>', {noremap=true, silent=true})

map('n', '<Leader>0', '^', {noremap=true})
map('v', '<Leader>0', '^', {noremap=true})

vim.cmd[[command NvimConf e $HOME/.config/nvim/init.lua]]
vim.cmd[[command CdHere cd %:p:h]]

