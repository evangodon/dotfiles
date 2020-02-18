" ### Plugins
call plug#begin()

" Color Schemes
Plug 'dikiaap/minimalist'

" JavaScript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Tools


call plug#end()

set t_Co=256
syntax on
colorscheme minimalist

" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" Setup Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
