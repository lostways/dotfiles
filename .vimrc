"--------VIM PLug-----------------"
so ~/.vim/plugins.vim

syntax enable


set encoding=utf-8
set backspace=indent,eol,start
set number
set mouse=a
set ttymouse=sgr
set updatetime=300
set laststatus=2

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

"--------------Cursor----------------"
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[2 q"

"--------------Tabline----------------"
"set showtabline

"--------------Visuals----------------"
colorscheme desert

" Visual Mode
highlight Visual cterm=bold ctermbg=Blue ctermfg=White

" Popup Menu (for coc)
hi Pmenu ctermbg=black ctermfg=white

"--------------Paste----------------"
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
set clipboard=unnamed

"--------------Searching----------------"
set hlsearch
set incsearch


"--------------Split Mangement------------"
set splitright
set splitbelow

" Remap split movements to match tmux
map <silent> <C-h> <Plug>WinMoveLeft
map <silent> <C-j> <Plug>WinMoveDown
map <silent> <C-k> <Plug>WinMoveUp
map <silent> <C-l> <Plug>WinMoveRight

"--------------SCROLLING------------"
noremap <C-e> 10<C-e>
noremap <C-y> 10<C-y>

"--------------Mappings----------------"

" Escape insert mode with jj
imap jj <esc>l

" Make it easy to edit the VIMRC "
nmap <Leader>ev :tabedit $MYVIMRC<cr>

" Add simple highlight removal"
nmap <Leader><space> :nohlsearch<cr>

" Save file with sudo"
command! SudoWrite :execute ':silent w !sudo tee % > /dev/null' | edit!

"--------------TABS------------"
filetype plugin indent on

" show existing tab with 2 spaces width
set tabstop=2

" when indenting with '>', use 2 spaces width
set shiftwidth=2

" On pressing tab, insert 4 spaces
set expandtab

" Python
autocmd FileType python setlocal
  \ shiftwidth=2
  \ softtabstop=2
  \ autoindent
  \ tabstop=2

" PHP
autocmd FileType php setlocal shiftwidth=4 softtabstop=4 

" MAKEFILE
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0 syntax=make

"--------------Plugins-------------------"

"/////////CTRLP////////"
let g:ctrlp_custom_ignore = '_output\|vendor\|node_modules\|DS_Store\|git'

" CtrlP Recent FIles
nmap <c-p> :CtrlPMRUFiles<cr>

"/////////NerdTree/////"
let NERDTreeHijackNetrw = 0
let NERDTreeShowHidden = 1

"Toggle Nerd Tree"
nmap <Leader>e :NERDTreeToggle<cr>

"/////////Prettier/////"
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"/////////CoC/////"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location
" list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use <C-j> for trigger snippet expand.
imap <C-j> <Plug>(coc-snippets-expand)

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <silent><expr> <cr> (pumvisible() ? '<esc> :call coc#refresh()<cr>' : "\<cr>")

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


"/////////Fugitive////"
" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>


"--------------Spell Check-------------"
augroup markdownSpell
        autocmd!
        autocmd FileType markdown setlocal spell
        autocmd BufRead,BufNewFile *.md setlocal spell
augroup END


"-------------Auto-Command-------------"
"Automatically source the Vimrc file on save"
augroup autosourcing
        autocmd!
        autocmd BufWritePost .vimrc source %
augroup END
