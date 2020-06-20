" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif


call plug#begin()

  " Color Schemes
  Plug 'dikiaap/minimalist'
  Plug 'joshdick/onedark.vim'
  Plug 'bluz71/vim-nightfly-guicolors'
  Plug 'bluz71/vim-nightfly-guicolors'
  Plug 'artanikin/vim-synthwave84'
  Plug 'ghifarit53/tokyonight.vim'
  
  " JavaScript
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

  " Golang
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  " Coc
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Lightline
  Plug 'itchyny/lightline.vim'

  " Startify
  Plug 'mhinz/vim-startify'

  " Wiki
  Plug 'vimwiki/vimwiki'

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

  " Which key"
  Plug 'liuchengxu/vim-which-key'

  " Nerd Commenter
  Plug 'preservim/nerdcommenter'

  "Buftabline
  Plug 'ap/vim-buftabline'

  " Colorizer
  Plug 'norcalli/nvim-colorizer.lua'

call plug#end()


