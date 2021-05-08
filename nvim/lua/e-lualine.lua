require('lualine').setup{
	options = {
		theme = 'palenight',
		section_separators = {'', ''},
		component_separators = {'', ''},
		disabled_filetypes = {},
		icons_enabled = true,
	},
	sections = {
		lualine_a = { {'mode', upper = true} },
		lualine_b = { {'filename', file_status = true} },
		lualine_c = {{'diagnostics', sources = {'nvim_lsp'}}},
		lualine_x = { '"emil"' },
		lualine_y = { 'filetype' },
		lualine_z = { {'location',padding_right=0}, {'"/"',padding=0}, "vim.fn.line('$')" },
	},
	inactive_sections = {
		lualine_a = {  },
		lualine_b = {  },
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {  },
		lualine_z = {   }
	},
	extensions = { 'fzf' }
}
