call plug#begin('~/.local/share/nvim/plugged')
"Plug 'chriskempson/base16-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'OmniSharp/omnisharp-vim'
Plug 'junegunn/fzf.vim'
Plug 'Soares/base16.nvim'
Plug 'morhetz/gruvbox'
Plug 'peitalin/vim-jsx-typescript'
Plug 'mboughaba/i3config.vim'
Plug 'vimwiki/vimwiki'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'scrooloose/nerdcommenter'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
" ?? not sure about the md preview tplugin below just yet
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
call plug#end()

let mapleader="\<SPACE>"
let g:base16_transparent_background = 1
let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.md'}]
let g:OmniSharp_server_stdio = 1
let g:coc_global_extensions = [
  \ 'coc-explorer',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-emmet',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-json',
  \ ]
set termguicolors
set hidden
set number
set nowrap
set textwidth=120
set colorcolumn=+1
autocmd vimenter * colorscheme gruvbox
" colorscheme default
" vanilla Vim
hi Pmenu ctermbg=red
" Vim with GUI support
hi Pmenu guibg=blue
bl
nnoremap <C-p> :<C-u>FZF<CR>
nmap <Leader>e :CocCommand explorer<CR>
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

let g:coc_explorer_global_presets = {
\   '.vim': {
\      'root-uri': '~/.vim',
\   },
\   'floating': {
\      'position': 'floating',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\   },
\   'floatingLeftside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 50,
\   },
\   'floatingRightside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 50,
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   },
\   'icon': {
\     'enableNerdFont': 'true'
\   }
\ }

" Use preset argument to open it
nmap <space>ed :CocCommand explorer --preset .vim<CR>
nmap <space>ef :CocCommand explorer --preset floating<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" List all presets
nmap <space>el :CocList explPresets
let g:lightline = {
	\ 'colorscheme': 'default',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'FugitiveHead',
	\   'cocstatus': 'coc#status'
	\ },
	\ }
