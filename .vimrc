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


"--------------Plugins-------------------"

"CtrlP
let g:ctrlp_custom_ignore = 'node_modules\DS_Store\|git'

"--------------Spell Check-------------"
augroup markdownSpell
        autocmd!
        autocmd FileType markdown setlocal spell
        autocmd BufRead,BufNewFile *.md setlocal spell
augroup END

"--------------Mappings----------------"

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