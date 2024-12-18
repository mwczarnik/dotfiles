
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

set cmdheight=0
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
Plug 'glepnir/oceanic-material'
Plug 'airblade/vim-gitgutter'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

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
colorscheme oceanic_material

if (has('termguicolors'))
  set termguicolors
endif

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


"Lualine config
lua << EOF
require('lualine').setup {
  options = {
    theme = 'OceanicNext',
  }
}
EOF
