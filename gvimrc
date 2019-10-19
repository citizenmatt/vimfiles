" Based on gvimrc_example.vim from 2016 Apr 05

set ch=2		" Make command line two lines high

set mousehide		" Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Switch on syntax highlighting if it wasn't on yet.
if !exists("syntax_on")
    syntax on
endif

if has('gui_win32')
    " Patched font from https://github.com/runsisi/consolas-font-for-powerline
    " Unfortunately missing the whitespace glyph, see _vimrc
    set guifont=Powerline\ Consolas:h10
elseif has('gui_macvim')
    " set guifont=Liberation\ Mono\ for\ Powerline:h13
    set guifont=Fira\ Code:h13
    set macligatures
endif

set lines=44 columns=132
set guioptions-=T	" hide the toolbar

autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" turn on visualbell, but prevent it flashing the screen
set vb t_vb=

map <C-Tab> :tabnext<CR>
map <C-S-Tab> :tabprev<CR>
map <C-n> :tabnew<CR>
