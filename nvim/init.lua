-- Bootstrap packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd('packadd packer.nvim')
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Diffview keymaps
vim.keymap.set('n', '<leader>dv', '<cmd>DiffviewOpen<cr>', { desc = 'Open diffview' })
vim.keymap.set('n', '<leader>dh', '<cmd>DiffviewFileHistory<cr>', { desc = 'File history' })
vim.keymap.set('n', '<leader>dc', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' })
