set expandtab
set smarttab
set bs=2
set ts=2
set sw=2
filetype plugin indent on
syntax on
set ruler
execute pathogen#infect()
set tags+=./ruby.tags;
set completeopt=menu,preview,longest
set hlsearch
set nomodeline

colo elflord

set rtp+=/usr/local/opt/fzf

highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /\(\t\|\s\+\%#\@<!$\)/
autocmd InsertLeave * redraw!

autocmd FileType Makefile set noexpandtab

autocmd FileType python set ts=4
autocmd FileType python set sw=4

vnoremap # :s/^\([^#]\)/#\1/g <bar> :noh
vnoremap ! :s/^#//g <bar> :noh

nnoremap <leader>d :!git diff HEAD %
nnoremap <leader>h :noh
nnoremap <leader>a :!git add %
nnoremap <leader>b :Gblame
nnoremap <leader>f :FZF

autocmd FileType ruby nnoremap <leader>r :!bundle exec rubocop %
autocmd FileType ruby nnoremap <leader>l :execute "!bundle exec rspec " . expand("%") . ":" . line(".")
autocmd FileType ruby nnoremap <leader>t :!bundle exec rspec %
autocmd FileType python let g:indentLine_enabled = 1
autocmd FileType python nnoremap <leader>t :!py.test %
autocmd FileType javascript nnoremap <leader>r :!yarn run eslint %

set pastetoggle=<leader>p

let g:indentLine_enabled = 0
