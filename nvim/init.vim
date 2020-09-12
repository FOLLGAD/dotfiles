let mapleader = ','
set wrap linebreak

autocmd BufReadPost \*
    \\ if line("'\\"") >= 1 && line("'\\"") <= line("$") && &ft !\~# 'commit'
    \\ |   exe "normal! g\`\\""
    \\ | endif

command Date :r !date "+\%F \%T (\%a)"
nnoremap <F5> :Date<CR>
inoremap <F5> <C-O>:Date<CR>

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

Plug 'cespare/vim-toml'
Plug 'eagletmt/ghcmod-vim'
Plug 'Shougo/vimproc.vim'
Plug 'ActivityWatch/aw-watcher-vim'

" Sensible defaults (??)
Plug 'tpope/vim-sensible'

" Git commands
Plug 'tpope/vim-fugitive'

" Surround
" cs"' - Change Surrounding "..." into '...'
" cs'<a> - Change Surrounding '...' into <a>...</a>
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Commenting
Plug 'tomtom/tcomment_vim'

" Async linter
" Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Assumes coc-explorer is installed
nnoremap <C-e> :CocCommand explorer<CR>

" Themes
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'
" Nicer-looking bottom bar
Plug 'itchyny/lightline.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

noremap <silent> <Leader>cc :TComment<CR>

" let g:deoplete#enable_at_startup = 1

set mouse=a
set number

" Set the root directory for :tabfind
set path=.,**

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

" Esc alias
inoremap jk <Esc>

" Line moving like in VS code
" Alt-<DIRECTION> - Moves line in direction
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+1<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Toggle syntax highlighting
let s:enabled = 1
function! ToggleSyntax()
	if s:enabled
		syntax off
		let s:enabled = 0
	else
		syntax on
		let s:enabled = 1
	endif
endfunction
nnoremap <silent> <leader><space> :call ToggleSyntax()<CR>

" Tabs
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab autoindent smartindent

set encoding=utf-8

syntax on

colorscheme seoul256-light
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

