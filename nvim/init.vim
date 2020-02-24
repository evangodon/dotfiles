"
" Useful commands:
" :so % - reload config
"
"
" Links:
" https://github.com/aswathkk/dotfiles/blob/master/nvim/init.vim
" https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode
"
" ### Plugins
call plug#begin()

" Color Schemes
Plug 'dikiaap/minimalist'
Plug 'joshdick/onedark.vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'bluz71/vim-nightfly-guicolors'

" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Startify
Plug 'mhinz/vim-startify'

" Wiki
Plug 'vimwiki/vimwiki'

" Nerd Commenter
Plug 'preservim/nerdcommenter'

" Devicons
Plug 'ryanoasis/vim-devicons'

" Move lines
Plug 'matze/vim-move'

" Auto Pairs
Plug 'jiangmiao/auto-pairs'

call plug#end()

set t_Co=256
set encoding=UTF-8
set termguicolors
syntax on
colorscheme onedark

" ### Plugin Config

" For Nert Commenter
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>
let g:NERDCustomDelimiters={
	\ 'javascript': { 'left': '//', 'right': '', 'leftAlt': '{/*', 'rightAlt': '*/}' },
\}

" For Vim wiki
set nocompatible
filetype plugin on

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

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
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

nmap <space>e :CocCommand explorer<CR>

set background=dark
highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg "Hide that ~ thing for empty lines

let mapleader = "\<Space>" " set <leader>

" Terminal  Mode
tnoremap <Esc> <C-\><C-n>

" Go Vim
nmap <leader>gr :GoRun<CR>



