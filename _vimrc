" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
filetype plugin indent on

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" put the swap file in %TEMP%. The extra backslashes cause a unique filename
set directory=$TEMP\\\

set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set showmode		" show the input mode in the footer
set scrolloff=2
set autoindent
set wildmenu		" Display a menu of wildcard choices on tab completion
set wildmode=list:longest
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set relativenumber	" show line numbers centred around the current line

" disable errorbell, turn on visualbell, but prevent it flashing the screen
set noeb vb t_vb=

set incsearch		" do incremental searching
set ignorecase
set smartcase       " ignore nore case unless you use upper case
set showmatch       " show matching bracket when entered

set clipboard=unnamed

" Use <leader><space> to disable search highlighting (leader is \ by default)
nnoremap <leader><space> :nohlsearch<CR>

" Use F2 to paste without formatting
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  autocmd FileType notes setlocal linebreak

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  autocmd BufRead,BufNewFile	*.build		setfiletype xml
  autocmd BufRead,BufNewFile	*.targets	setfiletype xml
  autocmd BufRead,BufNewFile	*.nunit		setfiletype xml
  autocmd BufRead,BufNewFile	*.config	setfiletype xml
  autocmd BufRead,BufNewFile	*.xaml		setfiletype xml
  autocmd BufRead,BufNewFile	*.DotSettings		setfiletype xml

  " Auto save when losing focus, silently ignoring failures (untitled files)
  autocmd FocusLost * silent! :wa

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

let g:ruby_path = ':C:\ruby192\bin'
