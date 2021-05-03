augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * if @% != "NvimTree" | set relativenumber | endif
  autocmd BufLeave,FocusLost,InsertEnter   * if @% != "NvimTree" | set norelativenumber | endif
augroup END
