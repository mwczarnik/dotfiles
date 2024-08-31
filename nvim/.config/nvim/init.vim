
" General config
set clipboard=unnamedplus
syntax on
set ignorecase
set noswapfile
set nu rnu
set tabstop=4 softtabstop=4000
set shiftwidth=4
set expandtab
set encoding=UTF-8

"set cmdheight=1
"set laststatus=0
"set noshowmode
"set noruler
"set noshowcmd

" Python current buffer exec while <F9>
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>


" Plugin list 
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'airblade/vim-gitgutter'

Plug 'kaicataldo/material.vim', { 'branch': 'main' }

"Plug 'marko-cerovac/material.nvim'
"Plug 'neovim/nvim-lspconfig'
"Plug 'ray-x/navigator.lua'
"Plug 'ryanoasis/vim-devicons'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'Valloric/YouCompleteMe'
call plug#end()

"
"===========================================================
"PLUG CONFIGURATIONS

" Vim material theme
colorscheme material
"let g:material_style = 'ocean'
"let g:material_terminal_italics = 1


"if (has('termguicolors'))
"  set termguicolors
"endif

"NERDTree config
nnoremap <C-n> :NERDTreeToggle<CR> 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinSize=20

let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

"gitgutter config
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '-'
let g:gitgutter_sign_modified_removed = '-'


"airline conf
let g:airline_theme='deus'
let g:airline_powerline_fonts = 1 


if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.colnr = "\u33c7"

""   unicode symbols
"  let g:airline_left_sep = '»'
"  let g:airline_left_sep = '▶'
"  let g:airline_right_sep = '«'
"  let g:airline_right_sep = '◀'
"  let g:airline_symbols.colnr = '㏇'
"  let g:airline_symbols.colnr = '℅'
"  let g:airline_symbols.crypt = '🔒'
"  let g:airline_symbols.linenr = '☰'
"  let g:airline_symbols.linenr = '␊'
"  let g:airline_symbols.linenr = '␤'
"  let g:airline_symbols.linenr = '¶'
"  let g:airline_symbols.maxlinenr = ''
"  let g:airline_symbols.maxlinenr = '㏑'
"  let g:airline_symbols.branch = '⎇'
"  let g:airline_symbols.paste = 'ρ'
"  let g:airline_symbols.paste = 'Þ'
"  let g:airline_symbols.paste = '∥'
"  let g:airline_symbols.spell = 'Ꞩ'
"  let g:airline_symbols.notexists = 'Ɇ'
"  let g:airline_symbols.whitespace = 'Ξ'
"
"  " powerline symbols
"  let g:airline_left_sep = ''
"  let g:airline_left_alt_sep = ''
"  let g:airline_right_sep = ''
"  let g:airline_right_alt_sep = ''
"  let g:airline_symbols.branch = ''
"  let g:airline_symbols.colnr = ''
"  let g:airline_symbols.readonly = ''
"  let g:airline_symbols.linenr = '☰'
"  let g:airline_symbols.maxlinenr = ''
"  let g:airline_symbols.dirty='⚡'
"


""Fileformat config
"autocmd BufNewFile,BufRead *.py 
"    \ set tabstop=4
"    \|set softtabstop=4
"    \|set shiftwidth=4
"    \|set textwidth=79
"    \|set expandtab
"    \|set autoindent
"    \|set fileformat=unix
"
"autocmd BufNewFile,BufRead *.js, *.html, *.css
"    \ set tabstop=2
"    \| set softtabstop=2
"    \| set shiftwidth=2
"
""autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab


