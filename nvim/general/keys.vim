
" set <leader>
let mapleader = "\<Space>" 
let g:maplocalleader = ','

" When going up or down one line, use displayed lines instead of physical lines
noremap silent! <silent> k gk
noremap silent! <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

" Navigate buffers
nnoremap <silent> <C-N> :bnext<CR>
nnoremap <silent> <C-P> :bprev<CR>

" Terminal  Mode
tnoremap <Esc> <C-\><C-n>

" Map control-s to write
noremap  <silent> <C-S>  :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
set timeoutlen=500

" Single mappings
let g:which_key_map['.'] = [ ':e ~/.config/nvim'          , 'open init' ]
let g:which_key_map[';'] = [ ':Commands'                  , 'commands' ]
let g:which_key_map['='] = [ '<C-W>='                     , 'balance windows' ]
let g:which_key_map[','] = [ 'Startify'                   , 'start screen' ]
let g:which_key_map['d'] = [ ':bd'                        , 'delete buffer']
let g:which_key_map['e'] = [ ':CocCommand explorer'       , 'explorer' ]
let g:which_key_map['f'] = [ ':Files'                     , 'search files' ]
let g:which_key_map['h'] = [ '<C-W>s'                     , 'split below']
let g:which_key_map['q'] = [ 'q'                          , 'quit' ]
let g:which_key_map['S'] = [ ':SSave'                     , 'save session' ]
let g:which_key_map['v'] = [ '<C-W>v'                     , 'split right']
let g:which_key_map['z'] = [ 'Goyo'                       , 'zen' ]
" Need to add theses
"let g:which_key_map['T'] = [ ':Rg'                        , 'search text' ]
"let g:which_key_map['c'] = [ ':Codi!!'                    , 'virtual repl']
"let g:which_key_map['r'] = [ ':RnvimrToggle'              , 'ranger' ]
"let g:which_key_map['W'] = [ 'w'                          , 'write' ]


" Register which key map
call which_key#register('<Space>', "g:which_key_map")
