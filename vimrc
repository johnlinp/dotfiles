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

" use mouse
if has('mouse')
  set mouse=a
endif

