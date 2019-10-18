let mapleader = ','

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-github-dashboard'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
nnoremap <C-e> :NERDTreeToggle<CR>

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

Plug 'pangloss/vim-javascript'
Plug 'mustache/vim-mustache-handlebars'
Plug 'posva/vim-vue'

Plug 'artur-shaik/vim-javacomplete2'
Plug 'neovimhaskell/haskell-vim'

Plug 'eagletmt/ghcmod-vim'

Plug 'junegunn/seoul256.vim'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'tmhedberg/SimpylFold'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim'

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

" LaTeX
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:tex_fold_enabled=1
let g:vimtex_compiler_progname = 'nvr'

Plug 'vim-syntastic/syntastic'
set statusline+=%#warningmsg#                                   "syntastic
set statusline+=%{SyntasticStatuslineFlag()}                    "syntastic
set statusline+=%*                                              "syntastic

let g:syntastic_quiet_messages = { "type": "style" }		"syntastic
let g:syntastic_always_populate_loc_list = 1                    "syntastic
let g:syntastic_auto_loc_list = 1                               "syntastic
let g:syntastic_check_on_open = 1                               "syntastic
let g:syntastic_check_on_wq = 0                                 "syntastic
let g:syntastic_javascript_checkers = ['eslint']                "syntastic

Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'

Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['latex'] " Replaced by vimlatex


Plug 'itchyny/lightline.vim'

call plug#end()

let g:lightline = {
	\ 'colorscheme': 'gruvbox',
	\ 'active': {
	\ 'left':[ [ 'mode', 'paste' ],
	\ [ 'gitbranch', 'readonly', 'filename', 'modified' ]
	\ ]
	\ },
	\ 'component_function': {
	\ 'gitbranch': 'fugitive#head',
	\ },
	\ 'separator': {
	\ 'left': '', 'right': ''
    \ },
	\ 'subseparator': {
	\   'left': '', 'right': '' 
	\ }
    \ }
set noshowmode

" Better pane navigation
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Easier tab navigation
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Esc alias
inoremap jk <Esc>

" Line moving like in VS code
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+1<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Toggle syntax
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
set softtabstop=0 noexpandtab
set shiftwidth=4

set encoding=utf-8

syntax on

colorscheme gruvbox
set termguicolors " True color support
set background=dark
let g:gruvbox_contrast_dark = 'soft' " hard, medium, soft
let g:gruvbox_contrast_light = 'soft' " hard, medium, soft
let g:gruvbox_termcolors = 256
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
