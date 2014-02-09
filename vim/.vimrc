" required for pathogen
filetype off
call pathogen#runtime_append_all_bundles()
filetype on
filetype plugin indent on

syntax on
set smartindent

" show unprintable chars
set list
set listchars=tab:»\ ,eol:¶,trail:·

set nocompatible "screw vi

filetype plugin on
set ofu=syntaxcomplete#Complete

set tabstop=4
set shiftwidth=4
au FileType ruby setlocal shiftwidth=2 tabstop=2

set expandtab

set number " show line numbers
set colorcolumn=80 " 80 width colum

set encoding=utf-8
set scrolloff=5 "minmax lines to keep above/below the curson
set showcmd "off by default in Unix
set hidden "?

set wildmenu "wildmenu, better autocomplete of commands
set wildmode=list:longest

set backspace=indent,eol,start
set laststatus=2
set relativenumber " relative line numberings
set undofile " allow infinate list undo

" search settings
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

set wildignore+=*.pyc,*/env/*     " MacOSX/Linux

set mouse=a " allow mice control

set clipboard=unnamed " avoid the faf for copy/paste
set lazyredraw

" avoid the delay exiting insert mode
au InsertEnter * set timeoutlen=0
au InsertLeave * set timeoutlen=1000

nnoremap <leader><space> :noh<cr> " remove search highlighting

nnoremap <tab> %
vnoremap <tab> %

" make the md file extension markdown
au BufRead,BufNewFile *.md set filetype=markdown

" Change cursor shape in different modes on OS X
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
endif

" enable 256 colours
set background=dark
colorscheme solarized


" change autocomplete so that it works more like a 'standard' ide
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
:set completeopt=longest,menuone
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

  inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
    \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


" nerd tree settings
let NERDTreeIgnore = ['\.pyc$']
nmap <silent> <C-D> :NERDTreeToggle<CR>

"Ctrl P
set runtimepath^=~/.vim/bundle/ctrlp.vim
nnoremap <leader>t :CtrlP<CR>

" powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" autoindent
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1

" syntastic
let g:syntastic_javascript_checkers=['jshint', 'jslint']
let g:syntastic_ruby_checkers=['mri', 'rubocop']
let g:syntastic_python_checkers=['python', 'pyflakes', 'pylint']

" remap arrow keys to move around slips
nnoremap <silent> <Right> <c-w>l
nnoremap <silent> <Left> <c-w>h
nnoremap <silent> <Up> <c-w>k
nnoremap <silent> <Down> <c-w>j


" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>