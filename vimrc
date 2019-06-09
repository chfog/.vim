



" CHF's vimrc
" Plugins ---------- {{{
if has("gui_running")                          "only add packages on a gui terminal.
    if empty(glob("~/.vim/autoload/plug.vim")) " Load vim-plug if it doesn't yet exist
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    call plug#begin('~/.vim/bundle')

    Plug 'lifepillar/vim-solarized8'
    Plug 'scrooloose/nerdtree'

    call plug#end()
    " Be sure to :PlugInstall
endif
" }}}

" Essential QOL ----- {{{
set number
set nocompatible
set showcmd
filetype plugin indent on
syntax enable
color solarized8_flat
set hlsearch
set incsearch 
set ignorecase
set smartcase
set so=30
set belloff=all
set hidden
set autoread
set autowrite
nnoremap ; :
let mapleader=" "
nnoremap <ESC> :noh<cr><ESC>
set foldmethod=marker
inoremap jj <ESC>

nnoremap k gk
nnoremap j gj

if has('gui_running')
    set guicursor+=a:blinkon0
endif
" }}}

" Global remaps using leader ----{{{
nnoremap <leader>; :
nnoremap <leader>: :!
nnoremap <leader><leader> <C-^>
nnoremap <leader>bb :b<Space>
nnoremap <leader>bd :bdelete<Space>
nnoremap <leader>bn :bn<cr>
nnoremap <leader>bp :bp<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>pc :make
nnoremap <leader>sr :%s//gc<left><left><Left>
nnoremap <leader>w <C-w>
" }}}

" Tab Management ----- {{{
if has("autocmd")
    " Use actual tab chars in makefiles
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

" For everything else, tab width of 4 chars
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" }}}

" Statusline ==== {{{
set laststatus=2
set statusline=
set statusline+=%#StatusLineTermNC#
set statusline+=\ [%n]
set statusline+=\ %{getcwd()}/
set statusline+=%*
set statusline+=%f
set statusline+=%=
set statusline+=\ %y
set statusline+=\ [%{&mod?'+':'-'}]
set statusline+=\ (%{strftime('%H:%M')})
set statusline+=\ 0x%B
set statusline+=%#DiffChange#
set statusline+=\ %p%%\ [%l/%L] 
" }}}

" Functions ==== {{{
" }}}
