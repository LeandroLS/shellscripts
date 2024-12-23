syntax on
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set cursorline
set clipboard+=unnamedplus

call plug#begin()

" List your plugins here
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

call plug#end()

"Ignore nome modules"
lua << EOF
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "node_modules", "%.git/", "%.cache" } -- Exclui pastas chamadas 'node_modules'
  }
}
EOF
