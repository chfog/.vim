
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
Plug 'craigemery/vim-autotag'

call plug#end()
" Be sure to :PlugInstall

let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeQuitOnOpen=3

" }}}

" Essential QOL ----- {{{

set number
set nocompatible
set showcmd
filetype plugin indent on
syntax enable
color desert
set hlsearch
nohlsearch
set incsearch
if has('gui_running')
    set cursorline
endif
set ignorecase
set smartcase
set noswapfile
setglobal so=3
set belloff=all
set hidden
set autoread
set autowrite
let mapleader=" "
setglobal foldmethod=marker
set foldminlines=3
nnoremap S <nop>
set foldlevelstart=20

if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && v:version >= 700
    let &g:listchars = "tab:\u25c0 \u25b6,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
    let &g:fillchars = "vert:\u250b,fold:\u00b7"
    let s:modstr = "\u25c6"
    let s:umodstr = "\u25c7"
else
    setglobal listchars=tab:>\ ,trail:-,extends:>,precedes:<
    let s:modstr = "[+]"
    let s:umodstr = "[-]"
endif

if has('gui_running')
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guioptions-=L
    set guicursor+=a:blinkon0
    set guifont=Menlo-Regular:h12
    let g:solarized_statusline="flat"
    colorscheme solarized8
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


" }}}

" Global remaps ---- {{{

" Command mode remaps ---- {{{
cabbrev vb vert sb
cabbrev sh !
cnoremap : <up>
cnoremap ; <down>
" }}}

" Insert mode remaps ---- {{{
inoremap <s-cr> <Esc>o
inoremap jj <ESC>
" }}}

" Normal mode remaps ---- {{{
nnoremap <down> :resize -2<cr>
nnoremap <left> :vertical resize -2<cr>
nnoremap <right> :vertical resize +2<cr>
nnoremap <silent> <ESC> :nohlsearch<cr><ESC>
nnoremap <up> :resize +2<cr>
nnoremap X "_dd
nnoremap Y y$
nnoremap gp `[v`]
nnoremap gP P`[v`]
nnoremap j gj
nnoremap k gk
nnoremap x "_x
" }}}

" Visual mode remaps ---- {{{

vnoremap r "_dP
vnoremap x "_d

" }}}

" Terminal mode mappings ---- {{{
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
elseif v:version > 800
    tnoremap <Esc> <C-w>N
endif
" }}}

" }}}

" Global remaps using leader ----{{{

nnoremap <leader><leader> <C-^>
nnoremap <leader>t :!
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>v :call SplitIfOneWin($MYVIMRC)<CR>
nnoremap <leader>w <C-w>
nnoremap <silent> <leader>wm :call WinMaximize()<CR>

" }}}

" Tab Management ----- {{{

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" }}}

" Statusline ==== {{{

set laststatus=2

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
        setlocal so=3
    elseif &so < 100
        setlocal so=999
    endif
endfunction

function! GetModMarker()
    if &modifiable
        return &mod?s:modstr:s:umodstr
    else
        return ""
endfunction

function! WinMaximize()
    resize
    vertical resize
endfunction

function! SetStatusLine()
    set statusline=
    setlocal statusline+=\ [%n]%<
    " check if current file is child of cwd
    if expand("%:p") =~ getcwd() || &filetype ==# ""
        setlocal statusline+=%#StatusLineTermNC#
        setlocal statusline+=\ %{getcwd()}/
        setlocal statusline+=%*
        setlocal statusline+=%f
        " otherwise just give the full path, underlined
    else
        setlocal statusline+=%#Underlined#
        setlocal statusline+=\ %{expand('%:p')}
        setlocal statusline+=%*
    endif
    setlocal statusline+=%=
    setlocal statusline+=\ %y
    setlocal statusline+=\ %{GetModMarker()}
    setlocal statusline+=\ (%{strftime('%H:%M')})
    setlocal statusline+=\ 0x%02B
    setlocal statusline+=%#DiffChange#
    setlocal statusline+=\ %3p%%\ [%l:%v/%L]
endfunction


function! SplitIfOneWin(buffer)
    if winnr("$") == 1
        execute "vertical split " . a:buffer
    else
        execute "edit " . a:buffer
    endif
endfunction

" }}}

" Commands ----- {{{

command! SwapSO :silent call SwapSO()
command! SwapBG :silent call SwapBG()
command! CD execute "cd " . expand("%:p:h")

" }}}

" Autocommands ---- {{{
if has('autocmd')
    augroup myvimrc
        autocmd!
        " Source vimrc on save
        autocmd bufwritepost vimrc source $MYVIMRC
        " Reset statusline when switching buffers or working directory
        autocmd BufEnter * call SetStatusLine()
        if exists('##DirChanged')
            autocmd DirChanged * call SetStatusLine()
        endif
        "set filetype-specific modifications
        autocmd Filetype python setlocal foldmethod=indent
        autocmd FileType make setlocal list tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
        autocmd FileType plaintex set ft=tex
        autocmd FileType tex nnoremap \lm <silent> :botright terminal latexmk %<cr><C-w>k | nnoremap \lc :!latexmk -c %<cr>
        "set cursorline local to window
        autocmd BufWInEnter,WinEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline
    augroup END
endif
" }}}
