vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-x>', ':BufferClose<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-x>', ':bd<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>g', ':BufferPick<CR>', {noremap=true,silent=true})
-- vim.api.nvim_set_keymap('n', '<Leader>g', ':BufferLinePick<CR>', {noremap=true,silent=true})

-- require'bufferline'.setup{
-- 	options = {
-- 		mappings = true,
-- 		diagnostics = "nvim_lsp",
-- 		theme = "tokyonight"
-- 	}
-- }

-- for some reason mapping <TAB> also changes C-i's behaviour. Remap it.
-- vim.api.nvim_set_keymap('n', '<C-i>', '<C-i>', { noremap=true})
