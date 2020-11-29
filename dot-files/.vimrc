" Vundle configuration -----------
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugin for python autocomplete
Plugin 'Valloric/YouCompleteMe'

" Syntax Checking for python
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'

"Enable Folding
Plugin 'tmhedberg/SimpylFold'


" All of your Plugins must be added before the following line
call vundle#end()            " required
"-------------------------------------

let g:ycm_auto_trigger = 1
let g:ycm_autoclose_preview_window_after_completion=1

"Have docstring in folded code
let g:SimpylFold_docstring_preview=1


let mapleader=" "
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red
autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"Syntastic recommended settings------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1


nnoremap <F8> :SyntasticCheck<CR>

let g:syntastic_is_open = 0  
function! SyntasticToggle()
    if g:syntastic_is_open == 1
        lclose
        let g:syntastic_is_open = 0
    else
        Errors
        let g:syntastic_is_open = 1
    endif
endfunction

nnoremap <F9> :call SyntasticToggle()<CR>

" Enable folding based on indentation
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

" For full syntax highlighting
let python_highlight_all=1
syntax on                 " enable syntax highlighting
filetype plugin indent on " enable automatic indentation 

" PEP8 Proper indentation
" Use 4 spaces always when having tab.
autocmd BufRead,BufNewFile *py,*pyw,*.c,*.h,*.groovy set tabstop=4
autocmd BufRead,BufNewFile *.py,*.py,*.groovy set softtabstop=4
autocmd BufRead,BufNewFile *.py,*.py,*.groovy set fileformat=unix
autocmd BufRead,BufNewFile *.py,*pyw,*.groovy set shiftwidth=4
autocmd BufRead,BufNewFile *.py,*.pyw,*.groovy set expandtab
" Wrap text after a certain number of characters
autocmd BufRead,BufNewFile *.py,*.pyw,*.groovy set textwidth=80


" Do not use swapfiles because i don't like them
set noswapfile

" if using a dark background adjust the colors for better contrast
set background=dark
set number           " enable line numbers
set ruler            " show the line number on the bar
set more             " use more prompt
set autoread         " watch for file changes
set noautowrite      " don't automagically write on :next
set lazyredraw       " don't redraw when don't have to
set showmode
set showcmd
set bs=2 
set wrap!
set smartindent
set expandtab        " turn tabs into whitespace
set shiftwidth=4     " indent width for autoindent
set encoding=utf-8   " enable utf-8 encoding
set incsearch        " enable incremental search

"set list
"set lcs+=space:.
