set nocompatible
"set term=screen-256color
set t_Co=16
let g:solarized_termcolors=16
let g:solarized_termtrans=1

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

filetype plugin indent on
syntax on

nnoremap <Space> <Nop>
let mapleader = " "
nnoremap <Leader>i3 :set filetype=i3config<CR>

" hidden allows switching buffers without saving
set hidden
set number
set ruler
set nowrap
" set cindent
set autoindent
set shiftwidth=4
set softtabstop=4
set expandtab

set textwidth=120
set colorcolumn=+1

syntax enable
set background=dark
colorscheme solarized

"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
"let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" optional reset cursor on start:
"augroup myCmds
"au!
"autocmd VimEnter * silent !echo -ne "\e[2 q"
"augroup END

nnoremap <C-p> :<C-u>FZF<CR>

call plug#begin('~/.vim/plugged')
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
"Plug 'pangloss/vim-javascript'
"Plug 'tbranyen/vim-typescript'
"Plug 'leafgarland/typescript-vim'
"Plug 'powerline/powerline'
Plug 'altercation/vim-colors-solarized'
Plug 'mboughaba/i3config.vim'
call plug#end()

"set rtp+=$HOME/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim
set laststatus=2
highlight ColorColumn ctermbg=160 guibg=#D80000
