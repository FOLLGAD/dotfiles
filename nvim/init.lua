DATA_PATH = vim.fn.stdpath("data")

require("plugins")
require("colorscheme")

require("logging")

require("input")
require("settings")

vim.cmd("source ~/.config/nvim/functions.vim")

-- Plugin configurations
require("e-git")
