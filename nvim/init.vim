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
Plug 'artanikin/vim-synthwave84'

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

" Signify for Git
Plug 'mhinz/vim-signify'

" Goyo
Plug 'junegunn/goyo.vim'

" limelight
Plug 'junegunn/limelight.vim'

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

call plug#end()

set t_Co=256
set encoding=UTF-8
set termguicolors
syntax on
colorscheme onedark

" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" Setup Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile


" General settings
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

" When going up or down one line, use displayed lines instead of physical lines
noremap silent! <silent> k gk
noremap silent! <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

nnoremap <space>e :CocCommand explorer<CR>

set background=dark
highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg "Hide that ~ thing for empty lines

nnoremap <silent> <C-N> :bnext<CR>
nnoremap <silent> <C-P> :bprev<CR>

" Airline
set noshowmode "hide mode status since I use airline
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1

" Vim Wiki
set nocompatible
filetype plugin on

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Nerd Commenter
nnoremap <C-_>   <Plug>NERDCommenterToggle
vnoremap <C-_>   <Plug>NERDCommenterToggle<CR>
let g:NERDCustomDelimiters={
	\ 'javascript': { 'left': '//', 'right': '', 'leftAlt': '{/*', 'rightAlt': '*/}' },
\}

" set <leader>
let mapleader = "\<Space>" 

" Terminal  Mode
tnoremap <Esc> <C-\><C-n>

" Vim Go
nnoremap <leader>gr :write <bar> :GoRun<CR>



