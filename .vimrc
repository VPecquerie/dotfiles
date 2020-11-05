set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" The status bar
Plugin 'vim-airline/vim-airline' 
Plugin 'vim-airline/vim-airline-themes'
" A wrapper for git 
Plugin 'tpope/vim-fugitive'
" Emmet support
Plugin 'mattn/emmet-vim'
" Themes support 
Bundle 'gmist/vim-palette'

Plugin 'rakr/vim-one'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"

set shell=/bin/zsh
set background=dark
colorscheme one
syntax on

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

let g:airline_theme='onedark'
