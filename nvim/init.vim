" ### Plugins
call plug#begin()

" Color Schemes
Plug 'dikiaap/minimalist'
Plug 'joshdick/onedark.vim'

" JavaScript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Startify
Plug 'mhinz/vim-startify'


call plug#end()

set t_Co=256
syntax on
colorscheme onedark

" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" Setup Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

set autoindent " always set autoindenting on
set copyindent " copy the previous indentation on autoindenting
set expandtab " expand tabs by default (overloadable per file type)
set shiftround " use multiple of shiftwidth when indenting with '<' and '>'
set shiftwidth=2 " number of spaces to use for autoindenting

set smartindent
set smarttab " insert tabs on the start of a line according to shiftwidth, not tabstop

set softtabstop=2 " when hitting <BS>, pretend like a tab is removed, even if spaces
set tabstop=2 " tabs are n spaces

set number relativenumber "turn hybrid line numbers on

" AirLine Config
set noshowmode "hide insert status since I use airline

nmap <space>e :CocCommand explorer<CR>
