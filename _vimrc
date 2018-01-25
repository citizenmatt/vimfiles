" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" This needs to be set to stop vi failing with a git commit
filetype on
filetype off

" Need to set this before importing via pathogen
if has('win32') && has('gui')
    let g:airline_powerline_fonts = 1
    " The Powerline Consolas font seems to be missing the whitespace glyph...
    if (!exists('g:airline_symbols'))
        let g:airline_symbols = {}
    endif
    let g:airline_symbols.whitespace = 'Ξ'
endif
if has('gui_macvim')
    let g:airline_powerline_fonts = 1
endif

let g:vim_markdown_formatter = 1
let g:vim_markdown_folding_level = 3
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype plugin indent on

" put the swap file in %TEMP%. The extra backslashes cause a unique filename
if has("unix")
  set directory=/tmp
else
  set directory=$TEMP\\\
endif

set nobackup		" do not keep a backup file, use versions instead
set showmode		" show the input mode in the footer
set showcmd         " show current command as you're typing it
set scrolloff=2
set wildmode=list:longest
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number relativenumber	" show line numbers centred around the current line
set encoding=utf-8

" disable errorbell, turn on visualbell, but prevent it flashing the screen
set noeb vb t_vb=

set ignorecase
set smartcase       " ignore nore case unless you use upper case
set showmatch       " show matching bracket when entered

set clipboard=unnamed   " wire the system clipboard to the unnamed register

" all alt to handle the menu shortcuts, and also vim command mappings
" map alt+space to allow opening the system menu
set winaltkeys=menu
map <A-Space> :simalt ~<CR>

" Use <leader><space> to disable search highlighting (leader is \ by default)
" nnoremap <leader><space> :nohlsearch<CR>

" Use F2 to paste without formatting
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" https://mobile.twitter.com/vimgifs/status/913390282242232320
" See `:h i_CTRL-G_u`
inoremap . .<C-G>u
inoremap ? ?<C-G>u
inoremap ! !<C-G>u
inoremap , ,<C-G>u
inoremap ` `<C-G>u

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch

  let g:solarized_termcolors=256
  colorscheme solarized
  set background=dark
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
  autocmd FileType markdown setlocal linebreak


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
  autocmd BufRead,BufNewFile	*.props		setfiletype xml
  autocmd BufRead,BufNewFile	*.nunit		setfiletype xml
  autocmd BufRead,BufNewFile	*.config	setfiletype xml
  autocmd BufRead,BufNewFile	*.xaml		setfiletype xml
  autocmd BufRead,BufNewFile	*.DotSettings		setfiletype xml
  autocmd BufRead,BufNewFile	*.*proj		setfiletype xml
  autocmd BufRead,BufNewFile    *.unity     setfiletype yaml
  autocmd BufRead,BufNewFile    *.meta      setfiletype yaml

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

setlocal spell spelllang=en_gb
set spellsuggest=5
autocmd BufRead,BufNewFile * setlocal spell
autocmd FileType startify setlocal nospell
autocmd FileType help setlocal nospell
" From https://github.com/teranex/dotvim/blob/576680a9f8086f185856c8ab1b9b01ea016f05e9/vimrc#L440
" the following line makes vim ignore camelCase and CamelCase words so they are not highlighted as spelling mistakes
autocmd Syntax * syn match CamelCase "\(\<\|_\)\%(\u\l*\)\{2,}\(\>\|_\)\|\<\%(\l\l*\)\%(\u\l*\)\{1,}\>" transparent containedin=.*Comment.*,.*String.*,VimwikiLink contains=@NoSpell contained

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatusLineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:ruby_path = ':C:\ruby192\bin'

let g:notes_directories = [ '~/DropBox/vim-notes' ]
let g:notes_suffix = '.txt'

let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

hi link EasyMotionTarget ErrorMsg

let g:startify_custom_header = []
let g:startify_bookmarks = [ '~\vimfiles\_vimrc', '~\vimfiles\_gvimrc' ]

let g:vim_markdown_fenced_languages = [ 'csharp=cs' ]

map <silent> <Up> gk
imap <silent> <Up> <C-o>gk
map <silent> <Down> gj
imap <silent> <Down> <C-o>gj
map <silent> <home> g<home>
imap <silent> <home> <C-o>g<home>
map <silent> <End> g<End>
imap <silent> <End> <C-o>g<End>

call camelcasemotion#CreateMotionMappings('<leader>')

" Use :list to see chars at current list, :set list to see in screen
" EOL is just shown with the eol char. CRLF is treated as EOL when in
" dos mode, reload in unix mode to see ^M¶ - :e ++ff=unix
set listchars=eol:¶,tab:▸·,trail:·,space:·,precedes:«,extends:»,nbsp:¬
