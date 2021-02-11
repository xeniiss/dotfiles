set nocompatible
syntax enable
filetype plugin indent on

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

" Plugin lang#rust
Plug 'rust-lang/rust.vim'

" Plugin Toolbar
Plug 'majutsushi/tagbar'

" Plugin Navigator
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'

" Plugin Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plugin git
Plug 'tpope/vim-fugitive'

" Plugin vimwiki
Plug 'vimwiki/vimwiki', {'branch' : 'dev'}

" Plugin startify
Plug 'mhinz/vim-startify'

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

" ----------------------------------------------------------------------------
" vimwiki
" ----------------------------------------------------------------------------
let g:vimwiki_list = [
    \{
    \    'path':'~/note',
    \    'ext':'.md',
    \    'syntax':'markdown',
    \},
    \]
let g:vimwiki_global_ext=0
let g:vimwiki_conceallevel=0
let g:md_modify_disabled = 0

function! LastModified()
    if g:md_modify_disabled
        return
    endif
    if &modified
        echom 'markdown updated time modified'
        let save_cursor = getpos(".")
        let n = min([10, line("$")])
        keepjumps exe '1,' . n . 's#^\(.\{,10}updated\s*: \).*#\1' .
            \ strftime('%Y-%m-%d %H:%M:%S +0900') . '#e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfunction

function! NewTemplate()

    let l:wiki_directory = v:false

    for wiki in g:vimwiki_list
        if expand('%:p:h') == expand(wiki.path)
            let l:wiki_directory = v:true
            break
        endif
    endfor

    if !l:wiki_directory
        return
    endif

    if line("$") > 1
        return
    endif

    let l:template = []
    call add(l:template, '---')
    call add(l:template, 'layout  : post')
    call add(l:template, 'title   : ')
    call add(l:template, 'summary : ')
    call add(l:template, 'topic  : ')
    call add(l:template, 'date    : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
    call add(l:template, 'updated : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
    call add(l:template, 'tags    : ')
    call add(l:template, 'toc     : true')
    call add(l:template, 'public  : true')
    call add(l:template, '---')
    call add(l:template, '')
    call add(l:template, '# ')
    call setline(1, l:template)
    execute 'normal! G'
    execute 'normal! $'

    echom 'new wiki page has created'
endfunction

augroup vimwikiauto
    autocmd BufWritePre *note/*.md call LastModified()
    autocmd BufRead,BufNewFile *note/*.md call NewTemplate()
augroup END
