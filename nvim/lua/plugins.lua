local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

-- Automatically recompile packages on write
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

-- TODO:
-- Maybe this one: https://github.com/nvim-lua/lsp-status.nvim for displaying in lua-line

return require('packer').startup(function(use)
  use "wbthomason/packer.nvim"
  use "sindrets/diffview.nvim"
  use "tpope/vim-sensible"
  use "tpope/vim-surround"
  use "mattn/emmet-vim"
  use_rocks 'fzy'

	use "neovim/nvim-lspconfig"
	use "glepnir/lspsaga.nvim"
	use "kabouzeid/nvim-lspinstall"
	use "nvim-lua/lsp_extensions.nvim"

	use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
	use "folke/tokyonight.nvim"

	use "nvim-lua/popup.nvim"
	use "nvim-lua/plenary.nvim"
	use {"camspiers/snap", rocks = {"fzy"}}

	use "nvim-lua/completion-nvim"
	-- Treesitter
	use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
	use {"windwp/nvim-ts-autotag"}

	use "kyazdani42/nvim-tree.lua"

	use {"norcalli/nvim-colorizer.lua",
		config = function()
			require('colorizer').setup()
		end
	}
	use "lewis6991/gitsigns.nvim"
	use "f-person/git-blame.nvim"
	use "folke/which-key.nvim"
	use {"windwp/nvim-autopairs"}
	use {"terrortylor/nvim-comment",
		config = function()
			require('nvim_comment').setup()
		end
	}
	use "kevinhwang91/nvim-bqf"

	use "hoob3rt/lualine.nvim"

	-- Icons
	use "kyazdani42/nvim-web-devicons"

	use "romgrk/barbar.nvim"
	use "adelarsq/vim-hackernews"
end)

