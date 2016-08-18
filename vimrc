" Vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'easymotion/vim-easymotion'
call vundle#end()
filetype plugin indent on

" basic settings
set number
set nobackup
set autoindent
syntax on
set background=dark

" instance search
set incsearch

" about tabs
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" paste without cutting
xnoremap p pgvy

" remove delay
set timeoutlen=1000 ttimeoutlen=0

" write latex files
autocmd BufNewFile,BufRead *.tex setlocal textwidth=100

" restore last cursor position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" highlight search
set hlsearch

" ctags (the semicolon is important!)
set tags=tags;

" markdown syntax
autocmd BufNewFile,BufRead *.md setlocal syntax=markdown

" makefile syntax
autocmd BufNewFile,BufRead Makefile.inc setlocal syntax=make

" display filename on the bottom
set statusline=%F\ %m%=line:\ %l\ of\ %L,\ col:\ %c\ (%P)
set laststatus=2

" smart case search needs to enable both smartcase and ignorecase
set smartcase
set ignorecase

" make tabs visible
set list
set listchars=tab:>\ 
highlight SpecialKey ctermfg=0 guifg=gray

" set max tab limit
set tabpagemax=100

" auto indent
set cindent

" faster easymotion
map <SPACE> <Plug>(easymotion-bd-w)

" set cursor margin
set scrolloff=10

" bash-like filename completion
set wildmode=longest,list
