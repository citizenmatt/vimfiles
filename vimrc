unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

function! PackagerInit() abort

    if has('win32')
        let s:packager_dir = expand('~/vimfiles/pack/packager/opt/vim-packager')
    else
        let s:packager_dir = expand('~/.vim/pack/packager/opt/vim-packager')
    endif

    if !isdirectory(s:packager_dir)
        execute '!git clone https://github.com/kristijanhusak/vim-packager ' . s:packager_dir
    endif

    packadd vim-packager

    call packager#init()

    call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })

    call packager#add('tpope/vim-sensible')
    call packager#add('altercation/vim-colors-solarized')
    call packager#add('sonph/onehalf', {'rtp': 'vim/'})
    call packager#add('vim-airline/vim-airline')
    call packager#add('vim-airline/vim-airline-themes')

    " Editing and text objects
    " See also vim-text-obj-variable-segment (camel case textobj, no motion)
    " and vim-wordmotion (camel case motions)
    call packager#add('bkad/CamelCaseMotion')
    call packager#add('vim-scripts/SearchComplete')
    call packager#add('vim-scripts/argtextobj.vim')
    call packager#add('vim-scripts/closetag.vim')
    call packager#add('easymotion/vim-easymotion')
    call packager#add('tpope/vim-repeat')
    call packager#add('tpope/vim-surround')
    call packager#add('kana/vim-textobj-user') " Required for lastpat
    call packager#add('kana/vim-textobj-lastpat')
    call packager#add('tommcdo/vim-exchange')
    call packager#add('vim-scripts/ReplaceWithRegister')

    " Alternative to easymotion
    "call packager#add('justinmk/vim-sneak')

    " Features
    call packager#add('editorconfig/editorconfig-vim')
    call packager#add('tpope/vim-commentary')
    call packager#add('sjl/gundo.vim')
    call packager#add('tpope/vim-git')
    call packager#add('tpope/vim-fugitive')
    call packager#add('airblade/vim-gitgutter')
    call packager#add('xolox/vim-misc')
    call packager#add('xolox/vim-notes')
    call packager#add('mhinz/vim-startify')
    call packager#add('machakann/vim-highlightedyank')
    " Note that vim-multiple-cursors is deprecated in favour of
    " vim-visual-multi, but they work differently
    call packager#add('terryma/vim-multiple-cursors')
    " call packager#add('mg979/vim-visual-multi')
    " call packager#add('gerw/vim-HiLinkTrace')

    " I was planning on some updates. Can't remember what for now...
    call packager#add('citizenmatt/vim-signature')

    " File types
    call packager#add('vim-syntastic/syntastic')
    call packager#add('udalov/kotlin-vim')
    call packager#add('vim-scripts/ShaderHighLight')
    call packager#add('leafgarland/typescript-vim')
    call packager#add('hail2u/vim-css3-syntax')
    call packager#add('skammer/vim-css-color')
    call packager#add('groenewege/vim-less')
    call packager#add('fsharp/vim-fsharp')
    call packager#add('PProvost/vim-ps1')
    call packager#add('plasticboy/vim-markdown')

endfunction

command! PackagerInstall call PackagerInit() | call packager#install()
command! -bang PackagerUpdate call PackagerInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean call PackagerInit() | call packager#clean()
command! PackagerStatus call PackagerInit() | call packager#status()



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
let g:vim_markdown_fenced_languages = [ 'csharp=cs' ]


" put the swap file in %TEMP%. The extra backslashes cause a unique filename
if has("unix")
  set directory=/tmp
else
  set directory=$TEMP\\\
endif

"set nobackup		" do not keep a backup file, use versions instead
set showmode		" show the input mode in the footer
set wildmode=list:longest
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number relativenumber	" show line numbers centred around the current line
set encoding=utf-8
set cursorline
set shortmess-=S    " Show count of search matches
" set signcolumn=number

" disable errorbell, turn on visualbell, but prevent it flashing the screen
set noeb vb t_vb=

set ignorecase
set smartcase       " ignore nore case unless you use upper case
set showmatch       " show matching bracket when entered

set clipboard=unnamed,unnamedplus   " wire the system clipboard to the unnamed register

" all alt to handle the menu shortcuts, and also vim command mappings
" map alt+space to allow opening the system menu
set winaltkeys=menu
map <A-Space> :simalt ~<CR>

" Use <leader><space> to disable search highlighting (leader is \ by default)
" nnoremap <leader><space> :nohlsearch<CR>

" Use F2 to paste without formatting
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Create new undo change sets while typing punctuation
" https://mobile.twitter.com/vimgifs/status/913390282242232320
" See `:h i_CTRL-G_u`
inoremap . .<C-G>u
inoremap ? ?<C-G>u
inoremap ! !<C-G>u
inoremap , ,<C-G>u
inoremap ` `<C-G>u

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set hlsearch

  " let g:solarized_termcolors=256
  " colorscheme solarized
  " set background=dark
  " hi MatchParen gui=underline cterm=underline
  " let g:airline_theme='dark'

  " Onehalf light theme
  colorscheme onehalfdark
  set background=dark
  " onehalfdark doesn't distinguish between search + current search sonph/onehalf#21
  hi! link IncSearch PMenuSel
  hi clear SpellBad
  hi SpellBad cterm=underline gui=undercurl
  hi NonText guifg=darkgrey " wordwrap, whitespace, etc.
  " Make the line number gutter a bit more distinctive
  hi LineNr guibg=#24222a
  let g:airline_theme='onehalfdark'
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


  autocmd BufRead,BufNewFile	*.build		setfiletype xml
  autocmd BufRead,BufNewFile	*.targets	setfiletype xml
  autocmd BufRead,BufNewFile	*.props		setfiletype xml
  autocmd BufRead,BufNewFile	*.nunit		setfiletype xml
  autocmd BufRead,BufNewFile	*.config	setfiletype xml
  autocmd BufRead,BufNewFile	*.xaml		setfiletype xml
  autocmd BufRead,BufNewFile	*.DotSettings		setfiletype xml
  autocmd BufRead,BufNewFile	*.DotSettings.user	setfiletype xml
  autocmd BufRead,BufNewFile	*.*proj		setfiletype xml
  autocmd BufRead,BufNewFile    *.unity     setfiletype yaml
  autocmd BufRead,BufNewFile    *.meta      setfiletype yaml

  " Auto save when losing focus, silently ignoring failures (untitled files)
  autocmd FocusLost * silent! :wa

  augroup END

endif " has("autocmd")

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

" On mac, this check returns false because they're actually links...
if isdirectory('~/Dropbox/vim-notes')
    let g:notes_directories = [ '~/Dropbox/vim-notes' ]
else
    let g:notes_directories = [ '~/Dropbox (Personal)/vim-notes' ]
endif
let g:notes_suffix = '.txt'

let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1

" Might clash with vim-sneak
map <Leader><Leader>; <Plug>(easymotion-next)
map <Leader><Leader>, <Plug>(easymotion-prev)

" Default (red) colours are too tricky to read.
hi link EasyMotionTarget Search
hi link EasyMotionTarget2First Search
hi link EasyMotionTarget2Second Search
hi link EasyMotionShade Comment

let g:startify_custom_header = []
if has('win32')
    let g:startify_bookmarks = [ '~\vimfiles\vimrc', '~\vimfiles\gvimrc' ]
else
    let g:startify_bookmarks = [ '~/.vim/vimrc', '~/.vim/gvimrc' ]
endif

map <silent> <Up> gk
imap <silent> <Up> <C-o>gk
map <silent> <Down> gj
imap <silent> <Down> <C-o>gj
map <silent> <home> g<home>
imap <silent> <home> <C-o>g<home>
map <silent> <End> g<End>
imap <silent> <End> <C-o>g<End>

let g:camelcasemotion_key='<leader>'

" CamelCaseMotion's motions are great, but the inner motions have some
" problems as text objects. E.g. vi\w includes trailing underscores and vi\e
" does not. This should be an inner and around text object. However, the
" inner motions allow a count, which is useful, and can't easily be done with
" a straight text object.
" These maps provide a rough approximation of vim-text-obj-variable-segment.
" Camel case text object. Possibly unintuitive behaviour with av at the end of
" an identifier, but good enough.
xmap iv i\e
xmap av i\w
omap iv i\e
omap av i\w

" Use :list to see chars at current list, :set list to see in screen
" EOL is just shown with the eol char. CRLF is treated as EOL when in
" dos mode, reload in unix mode to see ^M¶ - :e ++ff=unix
set showbreak=↪\ 
set listchars=eol:⏎,tab:→\ ,trail:␠,space:·,precedes:«,extends:»,nbsp:⎵

" vim-sensible will actually load matchit for us
packadd! editexisting
packadd! matchit

let g:highlightedyank_highlight_duration=250

" Avoid default <A-N> and g<A-N> shortcuts, as <A-N> on Mac is a dead key
let g:multi_cursor_select_all_key='<leader>g<C-N>'
let g:multi_cursor_select_all_word_key='<leader><C-N>'

" let g:SignatureMarkTextHLDynamic=1
" let g:SignatureMarkerTextHLDynamic=1
" let g:SignatureIncludeMarks='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.''`^<>[]{}()"'
" let g:SignatureIncludeMarkers='          '

" https://gist.github.com/breandan/ed814aba2cee6d27a0efff655e231b09
" To only apply these macros in e.g. Python files, prepend 'autocmd FileType py', e.g.:
" autocmd FileType py inoremap \mu μ
"
" inoremap \alpha α
" inoremap \beta β
" inoremap \gamma γ
" inoremap \delta δ
" inoremap \epsilon ε
" inoremap \zeta ζ
" inoremap \eta η
" inoremap \theta θ
" inoremap \iota ι
" inoremap \kappa κ
" inoremap \lambda λ
" inoremap \mu μ
" inoremap \nu ν
" inoremap \xi ξ
" inoremap \pi π
" inoremap \rho ρ
" inoremap \sigma σ
" inoremap \tau τ
" inoremap \upsilon υ
" inoremap \phi φ
" inoremap \chi χ
" inoremap \psi ψ
" inoremap \omega ω
" 
" inoremap \Gamma Γ
" inoremap \Delta Δ
" inoremap \Lambda Λ
" inoremap \Xi Ξ
" inoremap \Pi Π
" inoremap \Sigma Σ
" inoremap \Upsilon ϒ
" inoremap \Phi Φ
" inoremap \Psi Ψ
" inoremap \Omega Ω
" 
" inoremap \nabla ∇
" inoremap \partial ∂


