vim.o.mouse = "a"

vim.o.hidden = true
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.wo.number = true
vim.o.number = true
vim.o.inccommand = "nosplit"

-- fold based on indentation
vim.wo.foldmethod = "indent"
-- don't auto-fold my shit, please
vim.wo.foldenable = false
-- how many folds can exist within eachother. could be higher since no autofolding
vim.wo.foldnestmax = 5

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

map('n', '<Leader>e', ':NvimTreeToggle<CR>', {noremap=true, silent=true})

map('n', '<Leader>h', ':noh<CR>', {noremap=true,silent=true})

map('n', '<Leader>c', ':CommentToggle<CR>', {noremap=true,silent=true})
map('v', '<Leader>c', ':CommentToggle<CR>', {noremap=true,silent=true})

-- because ^ is difficult to write on swedish keyboard
map('n', '<Leader>0', '^', {noremap=true})
map('v', '<Leader>0', '^', {noremap=true})

vim.cmd[[command NvimConf e $HOME/.config/nvim/init.lua]]
vim.cmd[[command CdHere cd %:p:h]]

