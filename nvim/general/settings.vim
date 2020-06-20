set t_Co=256                                                                                      
set encoding=UTF-8                                                                                
set termguicolors                                                                                 
set nowrap                                                                                        
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
set colorcolumn=90

set smartindent
set smarttab " insert tabs on the start of a line according to shiftwidth, not tabstop

set softtabstop=2 " when hitting <BS>, pretend like a tab is removed, even if spaces
set tabstop=2 " tabs are n spaces

set number "turn hybrid line numbers on


set background=dark
highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg "Hide that ~ thing for empty lines

