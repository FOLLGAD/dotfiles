function! PasteImageToMarkdown()
    call mkdir("./images")
    !xclip -sel c -t image/png -o > "./images/image0.png"
endfunction
