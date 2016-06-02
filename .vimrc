set expandtab
set smarttab
set bs=2
set ts=2
set sw=2
filetype plugin indent on
syntax on
set ruler
colo elflord
execute pathogen#infect()
set tags+=ruby.tags,python.tags
set completeopt=menu,preview
set hlsearch

autocmd FileType python set ts=4
autocmd FileType python set sw=4

vnoremap # :s/^\([^#]\)/#\1/g <bar> :noh
vnoremap ! :s/^#//g <bar> :noh

nnoremap <leader>d :!git diff HEAD %
nnoremap <leader>h :noh
nnoremap <leader>a :!git add %
nnoremap <leader>b :!git blame %

autocmd FileType ruby nnoremap <leader>r :!rubocop %
autocmd FileType ruby nnoremap <leader>l :execute "!rspec " . expand("%") . ":" . line(".")
autocmd FileType ruby nnoremap <leader>t :!rspec %
autocmd FileType python nnoremap <leader>t :!py.test %

set pastetoggle=<leader>p
