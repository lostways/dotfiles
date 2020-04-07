"--------VIM PLug-----------------"
so ~/.vim/plugins.vim

syntax enable


set backspace=indent,eol,start
set number

"--------------DONT DO IT-------------"
" don't use arrowkeys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" really, just don't
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>

"--------------Swap Files----------------"
"set swapfile
"set dir=~/.vimswp
set noswapfile

"--------------Paths----------------"
set wildmenu
set path+=**

"--------------Visuals----------------"
"colorscheme desert

"--------------Searching----------------"
set hlsearch
set incsearch


"--------------Split Mangement------------"
set splitright
set splitbelow


"--------------TABS------------"
filetype plugin indent on

" show existing tab with 4 spaces width
set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

" Python
autocmd FileType python setlocal shiftwidth=2 softtabstop=2 expandtab

"--------------Plugins-------------------"

"/////////CTRLP////////"
let g:ctrlp_custom_ignore = 'node_modules\DS_Store\|git'

" CtrlP Recent FIles
nmap <c-p> :CtrlPMRUFiles<cr>

"/////////NerdTree/////"
let NERDTreeHijackNetrw = 0

"--------------Spell Check-------------"
augroup markdownSpell
        autocmd!
        autocmd FileType markdown setlocal spell
        autocmd BufRead,BufNewFile *.md setlocal spell
augroup END

"--------------Mappings----------------"

" Escape insert mode with jj
imap jj <esc>

" Make it easy to edit the VIMRC "
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"Add simple highlight removal"
nmap <Leader><space> :nohlsearch<cr>

"Toggle Nerd Tree"
nmap <Leader>e :NERDTreeToggle<cr>

"Save file with sudo"
command! W :execute ':silent w !sudo tee % > /dev/null' | edit!

"-------------Auto-Command-------------"
"Automatically source the Vimrc file on save"
augroup autosourcing
        autocmd!
        autocmd BufWritePost .vimrc source %
augroup END
