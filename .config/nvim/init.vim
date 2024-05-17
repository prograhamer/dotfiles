let mapleader = "\\"

set encoding=UTF-8

filetype off
syntax on

set ts=2 sts=2 sw=2
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
let g:go_fmt_command = 'gopls'
let g:rustfmt_autosave = 1

call plug#begin()
" Look & Feel
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ryanoasis/vim-devicons'

Plug 'preservim/nerdtree'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Comments
Plug 'tpope/vim-commentary'

" Git Integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Telescope setup
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Autocompletion & Code Intelligence
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'hrsh7th/cmp-vsnip'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'golang/vscode-go'
Plug 'AndrewRadev/splitjoin.vim'

" Rust
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'

" Kubernetes
Plug 'andrewstuart/vim-kubernetes'

" Terraform
Plug 'hashivim/vim-terraform'

" XML :(
Plug 'chrisbra/vim-xml-runtime'
call plug#end()

let g:airline_powerline_fonts = 1
let g:airline_theme='papercolor'
colorscheme PaperColor

set completeopt=menu,menuone,noselect

lua <<EOF
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end


local cmp = require('cmp')
cmp.setup {
    snippet = {

        expand = function(args) vim.fn["vsnip#anonymous"](args.body) end
    },
    mapping = cmp.mapping.preset.insert({
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = fale }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer' },
    })
   -- ... Your other configuration ...
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- set up lspconfig
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local telescope = require('telescope.builtin')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua require(\'telescope.builtin\').lsp_definitions()<cr>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '', '<cmd>lua require(\'telescope.builtin\').lsp_definitions()<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua require(\'telescope.builtin\').lsp_implementations()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua require(\'telescope.builtin\').lsp_references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local rt = require("rust-tools")

local rt_on_attach = function(client, bufnr)
	-- Hover actions
	vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
	-- Code action groups
	vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
	on_attach(client, bufnr)
end

rt.setup({
  server = {
    on_attach = rt_on_attach,
  },
})

local lspconfig = require('lspconfig')

lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt = true
    },
  },
})

local servers = { 'pylsp', 'golangci_lint_ls' }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end
EOF

au FileType yaml set expandtab ts=2 sts=2 sw=2
au FileType go set ts=3 sts=3 sw=3
au FileType asm set ts=3 sts=3 sw=3
au FileType xml set expandtab nofixendofline noeol
au FileType xsd set expandtab nofixendofline noeol
au BufNewFile,BufRead Tiltfile set filetype=python

" Common git operations
nnoremap <silent> <leader>a :Git add %<CR>
nnoremap <silent> <leader>d :Gvdiffsplit HEAD<CR>

" Clear highlighting
nnoremap <silent> <leader>h :noh<CR>

nnoremap <C-L> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <C-P> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap S <cmd>lua require('telescope.builtin').buffers()<cr>

let g:NERDTreeQuitOnOpen = 1
nnoremap <C-n> <cmd>NERDTreeToggle<CR>

nnoremap gfs <cmd>GoFillStruct<CR>

" base64 encode selected region
vnoremap <leader>64 y:let @"=system('base64 -w0', @")<cr>gv""P
vnoremap <leader>46 y:let @"=system('base64 -d', @")<cr>gv""P
