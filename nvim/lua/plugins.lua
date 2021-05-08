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

return require('packer').startup(function(use)
    use "wbthomason/packer.nvim"

	use {"tpope/vim-sensible"}
	-- https://github.com/folke/lsp-trouble.nvim

    use {"neovim/nvim-lspconfig"}
    use {"glepnir/lspsaga.nvim"}
    use {"kabouzeid/nvim-lspinstall"}

    use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
	use {'folke/tokyonight.nvim'}

    -- Telescope
    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {"nvim-telescope/telescope.nvim"}

    -- Autocomplete
    use {"hrsh7th/nvim-compe"}
    use {"hrsh7th/vim-vsnip"}

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate",
		config = function ()
			require('nvim-treesitter.configs').setup {
				autopairs = {enable = true}
			}
		end
	}
    use {"windwp/nvim-ts-autotag"}

    use "kyazdani42/nvim-tree.lua"

    use {"norcalli/nvim-colorizer.lua",
        config = function()
            require('colorizer').setup()
        end
    }
    use {"lewis6991/gitsigns.nvim"}
    use {"folke/which-key.nvim"}
    use {"windwp/nvim-autopairs",
        config = function()
            require('nvim-autopairs').setup({
			    check_ts = true,
				ts_config = {
					lua = {'string'},-- it will not add pair on that treesitter node
					javascript = {'template_string'},
				}
			})
        end
    }
    use {"terrortylor/nvim-comment",
		config = function()
			require('nvim_comment').setup()
		end
	}
    use {"kevinhwang91/nvim-bqf"}

	use {'hoob3rt/lualine.nvim',
	}

    -- Icons
    use {"kyazdani42/nvim-web-devicons"}

    -- Status Line and Bufferline
    -- use {"glepnir/galaxyline.nvim"}
    use {"romgrk/barbar.nvim"}
    -- use {"akinsho/nvim-bufferline.lua"}
end)

