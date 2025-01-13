" ****************************************************************************
"                      `. ___
"                     __,' __`.                _..----....____
"         __...--.'``;.   ,.   ;``--..__     .'    ,-._    _.-'
"   _..-''-------'   `'   `'   `'     O ``-''._   (,;') _,'
" ,'________________                          \`-._`-','
"  `._              ```````````------...___   '-.._'-:
"     ```--.._      ,.                     ````--...__\-.
"             `.--. `-`                       ____    |  |`
"               `. `.                       ,'`````.  ;  ;`
"                 `._`.        __________   `.      \'__/`
"                    `-:._____/______/___/____`.     \  `
"                                |       `._    `.    \
"                                `._________`-.   `.   `.___
"                                                   `------'`
" ****************************************************************************

" Appearance
set colorcolumn=80
set background=dark
colorscheme PaperColor " Gracefully fails if not found
set signcolumn=yes " The sign column is always displayed, even if there are no signs.
set statusline=%<%F\ %y\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set shortmess-=S " Show search result counter
set shortmess+=c

" Behavior
set encoding=utf-8
set hidden " allows you to switch between buffers without saving changes
set backup
set backupdir=$HOME/.bck
set directory=$HOME/.bck " Location for swap files
set undofile " Maintain undo history between sessions
set undodir=$HOME/.vim/undodir
set history=100 " lines of command line history to keep
set list " Show whitespace characters (supercharged with vim-sensible)
set expandtab
" set updatetime=300

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif
