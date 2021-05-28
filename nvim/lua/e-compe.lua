vim.cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]
-- " Use <Tab> and <S-Tab> to navigate through popup menu
vim.cmd [[inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"]]
vim.cmd [[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]
vim.cmd [[imap <silent> <C-Space> <Plug>(completion_trigger)]]

-- " Set completeopt to have a better completion experience
vim.cmd [[set completeopt=menuone,noinsert,noselect]]

-- " Avoid showing message extra message when using completion
vim.cmd [[set shortmess+=c]]
