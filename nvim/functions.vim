augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * if @% != "NvimTree" | set relativenumber | endif
  autocmd BufLeave,FocusLost,InsertEnter   * if @% != "NvimTree" | set norelativenumber | endif
augroup END

" https://old.reddit.com/r/neovim/comments/632wh4/neovim_does_not_save_last_cursor_position/
autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

augroup nim_ft
	au!
	autocmd BufNewFile,BufRead *.nim set filetype=nim
augroup END
