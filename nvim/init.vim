let mapleader = ','
set wrap linebreak

set nocompatible
filetype plugin on
syntax on

autocmd BufReadPost \*
    \\ if line("'\\"") >= 1 && line("'\\"") <= line("$") && &ft !\~# 'commit'
    \\ |   exe "normal! g\`\\""
    \\ | endif

command! Date :r !date "+\%F \%T (\%a)" | tr -d '\\n'
nnoremap <F5> i<C-R>=strftime("%Y-%m-%d %H:%M (%a)")<CR><Esc>
inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M (%a)")<CR>

" " Copy to clipboard
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

call plug#begin('~/.local/share/nvim/plugged')

" Nice start-screen
Plug 'plasticboy/vim-markdown'
autocmd FileType markdown set conceallevel=2
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_conceal = 2
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_edit_url_in = 'tab'
let g:vim_markdown_follow_anchor = 1

Plug 'vimwiki/vimwiki'

Plug 'mhinz/vim-startify'
Plug 'cespare/vim-toml'
Plug 'Shougo/vimproc.vim'
Plug 'tmsvg/pear-tree'

" Plug 'ActivityWatch/aw-watcher-vim'
" JSX syntax support
Plug 'maxmellon/vim-jsx-pretty'

" Sensible defaults
Plug 'tpope/vim-sensible'

" Git commands
Plug 'tpope/vim-fugitive'

" Surround
" cs([ - Change Surrounding (...) into [...]
" cs{<a> - Change Surrounding {...} into <a>...</a>
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Commenting
Plug 'tomtom/tcomment_vim'
noremap <silent> <Leader>cc :TComment<CR>

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'weirongxu/coc-explorer', {'do': 'yarn install --frozen-lockfile'}

" Assumes coc-explorer is installed
nnoremap <C-e> :CocCommand explorer<CR>

" Themes
Plug 'morhetz/gruvbox'
" Plug 'altercation/vim-colors-solarized'
" Plug 'junegunn/seoul256.vim'
" Nicer-looking bottom bar
Plug 'itchyny/lightline.vim'

" Fuzzyfind
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

set mouse=a
set number

" Set the root directory for :tabfind
" set path=.,**

" Folding
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

set foldmethod=syntax " one of "syntax", "indent"
set foldnestmax=10
set nofoldenable
set foldlevel=2

call plug#end()

let g:lightline = {
	\ 'colorscheme': 'PaperColor'
\ }
set noshowmode

" Better pane navigation
" (terminal)
tnoremap <C-Left> <C-\><C-N><C-w>h
tnoremap <C-Down> <C-\><C-N><C-w>j
tnoremap <C-Up> <C-\><C-N><C-w>k
tnoremap <C-Right> <C-\><C-N><C-w>l

inoremap <C-Left> <C-\><C-N><C-w>h
inoremap <C-Down> <C-\><C-N><C-w>j
inoremap <C-Up> <C-\><C-N><C-w>k
inoremap <C-Right> <C-\><C-N><C-w>l

" THese don't work for some reason...
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
" ^^^

nnoremap <C-Left> <C-w>h
nnoremap <C-Down> <C-w>j
nnoremap <C-Up> <C-w>k
nnoremap <C-Right> <C-w>l

" Easier tab navigation
nnoremap <S-Left> :tabprevious<CR>
nnoremap <S-Right> :tabnext<CR>

" Line moving like in VS code
" Alt-<DIRECTION> - Moves line in direction
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+1<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Tabs
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab autoindent smartindent

set encoding=utf-8

colorscheme gruvbox
set termguicolors " True color support
set background=light

" Gruvbox settings
let g:gruvbox_contrast_dark = 'soft' " hard, medium, soft
let g:gruvbox_contrast_light = 'medium' " hard, medium, soft
let g:gruvbox_termcolors = 256
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1

