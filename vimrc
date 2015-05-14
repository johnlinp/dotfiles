" basic settings
set number
set nobackup
set autoindent
syntax on
set background=dark

" instance search
set incsearch

" about tabs
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

" use mouse
if has('mouse')
  set mouse=a
endif

" highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" highlight search
set hlsearch

" ctags (the semicolon is important!)
set tags=tags;

" Gblame
if filereadable($HOME."/fugitive.vim")
	source ~/fugitive.vim
endif

" markdown syntax
autocmd BufNewFile,BufRead *.md setlocal syntax=markdown

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
