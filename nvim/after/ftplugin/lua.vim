setlocal suffixesadd=.lua
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
setlocal include=require
setlocal define=function
