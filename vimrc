



" CHF's vimrc

" Essential QOL ----- {{{
set nu
syntax enable
set hlsearch
set incsearch 
set so=30
set belloff=all
set hidden
set autoread
set autowrite
nnoremap , :
nnoremap <ESC> :noh<cr><ESC>
set foldmethod=marker
inoremap jj <ESC>
inoremap kk <ESC>

nnoremap k gk
nnoremap j gj

if has('gui_running')
    set guicursor+=a:blinkon0
endif
" }}}

" Remaps using space ----{{{
nnoremap <Space><Space> :!
nnoremap <Space>bb :b<Space>
nnoremap <Space>bd :bdelete<Space>
nnoremap <Space>bn :bn<cr>
nnoremap <Space>bp :bp<cr>
nnoremap <Space>t :Vexplore<cr>
nnoremap <Space>pc :make
nnoremap <Space>sf :%s//gc<left><left><Left>
nnoremap <Space>sp :!<up>
nnoremap <Space>w <C-w>
" }}}

" Tab Management ----- {{{
if has("autocmd")
    " Use filetype detection and automatic indenting
    filetype plugin indent on

    " Use actual tab chars in makefiles
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

" For everything else, tab width of 4 chars
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" }}}

" For netrw ==== {{{
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=20
" }}}

" Statusline ==== {{{
set laststatus=2
set statusline=
set statusline+=%{getcwd()}
set statusline+=\ %F
set statusline+=%=
set statusline+=
" }}}

" Functions ==== {{{
" }}}
