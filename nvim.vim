let mapleader = ','

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/vim-easy-align'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
nnoremap <C-e> :NERDTreeToggle<CR>

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" Vue + Pug support
Plug 'posva/vim-vue'
Plug 'digitaltoad/vim-pug'

Plug 'neovimhaskell/haskell-vim'
Plug 'eagletmt/ghcmod-vim'
Plug 'Shougo/vimproc.vim'

" Sensible defaults (??)
Plug 'tpope/vim-sensible'

" Git commands
Plug 'tpope/vim-fugitive'

" Surround
" cs"' - Change surrounding "..." into '...'
" cs'<a> - Change surrounding '...' into <a>...</a>
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Idk tbh
Plug 'Shougo/denite.vim'

" Commenting
Plug 'tomtom/tcomment_vim'
noremap <silent> <Leader>cc :TComment<CR>

" Set the root directory for :tabfind
set path=~

" SNIPPETS (inspired by https://castel.dev/post/lecture-notes-1/)
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" Folding
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf
set foldmethod=syntax " one of "syntax", "indent"

set foldnestmax=10
set nofoldenable
set foldlevel=2

" Async linter
Plug 'dense-analysis/ale'

" Themes
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'

" Nicer-looking bottom bar
Plug 'itchyny/lightline.vim'

call plug#end()

let g:lightline = {
	\ 'colorscheme': 'gruvbox'
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
nnoremap <silent> ,<space> :call ToggleSyntax()<CR>

" Tabs
set tabstop=4
set shiftwidth=4

set encoding=utf-8

syntax on

colorscheme gruvbox
set termguicolors " True color support
set background=light
let g:gruvbox_contrast_dark = 'soft' " hard, medium, soft
let g:gruvbox_contrast_light = 'hard' " hard, medium, soft
let g:gruvbox_termcolors = 256
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
