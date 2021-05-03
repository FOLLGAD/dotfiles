DATA_PATH = vim.fn.stdpath('data')

require('plugins')
require('colorscheme')

require('input')
require('settings')

vim.cmd("source ~/.config/nvim/functions.vim")

-- Plugin configurations
require('e-compe')
require('e-gitsigns')
require('e-lualine')
require('e-nvimtree')
require('e-tabs')
require('e-treesitter')

require('lsp')
require('lsp.js')
require('lsp.efm-general')
-- require('lsp.lua')

