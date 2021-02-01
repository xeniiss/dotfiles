set nocompatible
filetype plugin on

let mapleader=" "

" Interface
set number
set showcmd
set showmatch
set title
set visualbell
set wildmenu
set wildmode=full
set scrolloff=5
set diffopt=filler,vertical
set completeopt=menuone,preview
set nocursorline
set nrformats=hex
set list
set listchars=tab:\|\ ,

" Options
set hidden
set clipboard=unnamed
set backspace=indent,eol,start
set autoread
set encoding=utf-8
set virtualedit=block
set nojoinspaces
set grepformat=%f:%l:%c:%m,%f:%l:%m

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Indentation
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Performance
set lazyredraw


" ============================================================================
" MAPPINGS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Basic mappings
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" ============================================================================
" Plugins
" ============================================================================
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Plugin colorscheme
Plug 'junegunn/seoul256.vim'

" Plugin edit utils
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Plugin lang#go
Plug 'fatih/vim-go'

" Plugin Toolbar
Plug 'majutsushi/tagbar'

" Plugin Navigator
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'

" Plugin Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plugin git
Plug 'tpope/vim-fugitive'

" Initialize plugin system
call plug#end()

" ----------------------------------------------------------------------------
" Colorscheme
" ----------------------------------------------------------------------------
silent! colo seoul256

" ----------------------------------------------------------------------------
" vim-go
" ----------------------------------------------------------------------------
let g:go_test_timeout='20s'
let g:go_fmt_command='goimports'