" Config file for NeoVim

call plug#begin('~/.config/nvim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'

call plug#end()

color dracula

set showcmd
set number
set relativenumber
set virtualedit+=onemore
set guifont=Monospace:h15
set tabstop=2
set shiftwidth=2

let mapleader = "\<Space>"


let g:lightline = {
	\ 'colorscheme': 'one',
	\ }
