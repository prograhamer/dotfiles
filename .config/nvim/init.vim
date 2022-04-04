let mapleader = "\\"

set encoding=UTF-8

filetype off
syntax on

set ts=2 sts=2 sw=2
set expandtab

set nobackup
set nowritebackup
set nocompatible
set laststatus=2
set cmdheight=2
set nomodeline
set noshowmode
set hlsearch
set cursorline
set number
set laststatus
set ruler
set autoindent
set mouse=""
set clipboard=unnamed
set termguicolors
set background=dark
set signcolumn=yes

set updatetime=200

let g:go_highlight_fields = 1
let g:go_auto_type_info = 1

call plug#begin()
" General
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'NLKNguyen/papercolor-theme'
Plug 'SirVer/ultisnips'
Plug 'mhinz/vim-signify'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'AndrewRadev/splitjoin.vim'

" Kubernetes
Plug 'andrewstuart/vim-kubernetes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.colnr = 'C:'
let g:airline_theme='papercolor'
colorscheme PaperColor

autocmd FileType go set noexpandtab ts=3 sts=3 sw=3
autocmd FileType Makefile set noexpandtab

nmap <C-P> :FZF<CR>
nnoremap <silent> <leader>d :!git diff HEAD %<CR>
nnoremap <silent> <leader>h :noh<CR>
nnoremap <silent> <leader>a :!git add %<CR>

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <c-space> coc#refresh()

