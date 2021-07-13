local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
end

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

-- Automatically recompile packages on write
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

return require("packer").startup(
  function(use)
    use {"wbthomason/packer.nvim", opt = true}
    use {"sindrets/diffview.nvim"}
    use {"tpope/vim-sensible"}
    use {"tpope/vim-surround"}
    use {"mattn/emmet-vim"}

    -- Use the branch that supports indent for all lines, not just blank lines
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("indent-line")
      end
    }

    use {
      "karb94/neoscroll.nvim",
      config = function()
        require("neoscroll").setup()
      end
    }

    use {
      "neovim/nvim-lspconfig",
      requires = {
        {"glepnir/lspsaga.nvim"},
        {"kabouzeid/nvim-lspinstall"},
        {"nvim-lua/lsp_extensions.nvim"},
        {
          "ray-x/lsp_signature.nvim",
          config = function()
            require "lsp_signature".on_attach()
          end
        }
      },
      config = function()
        require("lsp")
        require("lsp.js")
        require("lsp.css")
        require("lsp.efm-general")
      end
    }
    use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
    use {"folke/tokyonight.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {
      "camspiers/snap",
      rocks = {"fzy"},
      config = function()
        require("e-snap")
      end
    }

    use {
      "hrsh7th/nvim-compe",
      requires = {
        {"hrsh7th/vim-vsnip"},
        {"hrsh7th/vim-vsnip-integ"}
      },
      config = function()
        require("compe-completion")
      end
    }
    use {
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup()
      end
    }
    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require "nvim-treesitter.configs".setup {
          ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
          autotag = {
            enable = true
          },
          highlight = {
            enable = true -- false will disable the whole extension
          }
        }
      end
    }
    use {"windwp/nvim-ts-autotag"}

    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end
    }
    use {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("e-gitsigns")
      end
    }
    use {"TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim"}
    use {"f-person/git-blame.nvim"}
    use {"folke/which-key.nvim"}
    use {
      "terrortylor/nvim-comment",
      config = function()
        require("nvim_comment").setup()
      end
    }
    use {"kevinhwang91/nvim-bqf"}

    use {
      "hoob3rt/lualine.nvim",
      config = function()
        require("e-lualine")
      end
    }

    use {
      "kyazdani42/nvim-tree.lua",
      cmd = "NvimTreeToggle",
      opt = true,
      config = function()
        require("e-nvimtree").config()
      end
    }
    use {
      "romgrk/barbar.nvim",
      requires = {"kyazdani42/nvim-web-devicons"},
      config = function()
        require("e-tabs")
      end
    }
  end
)
