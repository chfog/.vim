



" CHF's vimrc
" Plugins ---------- {{{
if empty(glob("~/.vim/autoload/plug.vim")) " Load vim-plug if it doesn't yet exist
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'lifepillar/vim-solarized8'
Plug 'scrooloose/nerdtree'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()
" Be sure to :PlugInstall
" }}}

" Essential QOL ----- {{{

set number
set nocompatible
set showcmd
filetype plugin indent on
syntax enable
color desert
set hlsearch
set incsearch 
set cursorline
set ignorecase
set smartcase
set noswapfile
setglobal so=999
set belloff=all
set hidden
set autoread
set autowrite
let mapleader=" "
set foldmethod=marker


let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeQuitOnOpen=3

if has('gui_running')
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guioptions-=L
    set guicursor+=a:blinkon0
    set guifont=Hack:h12
    let g:solarized_statusline="flat"
    colorscheme solarized8
endif

" }}}

" Global remaps ---- {{{

inoremap <esc> <esc>:w<cr>
inoremap <s-cr> <Esc>o
inoremap jj <ESC>
nnoremap <silent> <ESC> :noh<cr><ESC>
nnoremap <down> :resize -2<cr>
nnoremap <left> :vertical resize -2<cr>
nnoremap <right> :vertical resize +2<cr>
nnoremap <up> :resize +2<cr>
nnoremap H <C-u>
nnoremap L <C-d>
nnoremap gp p`[v`]
nnoremap j gj
nnoremap k gk

" }}}

" Global remaps using leader ----{{{

nnoremap <leader><leader> <C-^>
nnoremap <leader>n :NERDTreeFocus<cr>
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fg :GFiles<cr>
nnoremap <leader>fl :Lines<cr>
nnoremap <leader>sp :!<up>
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
function SetStatusLine()
    set statusline=
    setl statusline+=\ [%n]
    if expand("%:p") =~ getcwd()
        setl statusline+=%#StatusLineTermNC#
        setl statusline+=\ %{getcwd()}/
        setl statusline+=%*
        setl statusline+=%f
    else
        setl statusline+=%#Underlined#
        setl statusline+=\ %{GetFullPath()}
        setl statusline+=%*
    endif
    setl statusline+=%=
    setl statusline+=\ %y
    setl statusline+=\ [%{&mod?'+':'-'}]
    setl statusline+=\ (%{strftime('%H:%M')})
    setl statusline+=\ 0x%B
    setl statusline+=%#DiffChange#
    setl statusline+=\ %p%%\ [%l/%L] 
endfunction

autocmd BufEnter * call SetStatusLine()

" }}}

" Functions ==== {{{

function! SwapBG()
    if &background ==# "dark"
        set background=light
    elseif &background ==# "light"
        set background=dark
    endif
endfunction

function! SwapSO()
    if &so > 100
        setlocal so=2
    elseif &so < 100
        setlocal so=999
    endif
endfunction

function GetFullPath()
    return expand("%:p")
endfunction


" }}}

" Commands ----- {{{

command! SwapSO :silent call SwapSO()
command! SwapBG :silent call SwapBG()

" }}}
