syntax on
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set cursorline
set clipboard+=unnamedplus

let mapleader = " "                           " <Space> as leader
nnoremap <leader>w :w<CR>                     " Save file with <Space>w
nnoremap <leader>q :q<CR>                     " Save file with <Space>q

" Move cursor to the right <leader>l
nnoremap <leader>l <C-w>l

" Move cursor to the left <leader>h
nnoremap <leader>h <C-w>h

" Open Telescope find_files
nnoremap <leader>p :Telescope find_files<CR>

call plug#begin()

" List your plugins here
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

call plug#end()

"Ignore folders"
lua << EOF
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "node_modules", "%.git/", "%.cache" } -- Exclui pastas chamadas 'node_modules'
  }
}
EOF
