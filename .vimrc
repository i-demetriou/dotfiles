" ****************************************************************************
" A sane extendable .vimrc template
"
" This file contains some reasonable settings that can be simply dropped in
" any Linux home env and work without any dependencies.
"
" ****************************************************************************

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" default appearance {{{
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set hlsearch
set number
set laststatus=2
set foldmethod=marker
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
set background=dark
colorscheme industry " Best theme available in most system
" }}}
" default behavior {{{
set incsearch
set ignorecase
set smartcase
set shortmess-=S

set autoindent
set nowrap
set tabstop=4
set shiftwidth=4
set is
set noscrollbind
set viminfo+=!

set autoread " read modified files from disk if unchanged in vim
set backspace=indent,eol,start " allow backspacing over everything in insert mode

set completeopt=menuone,menu,longest,preview

" A popular option to indicate switching to and from Insert mode is toggling the
" cursorline option, which is responsible for whether the current screen line is
" highlighted (see :help cursorline):
:autocmd InsertEnter,InsertLeave * set cul!
" }}}
" spelling {{{
hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellLocal
hi SpellLocal cterm=underline
hi clear SpellCap
hi SpellCap cterm=underline
hi clear SpellRare
hi SpellRare cterm=underline

set spell spelllang=en_us
highlight Pmenu ctermbg=darkcyan gui=bold
" }}}

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Looking to specify how to specify file type specific actions using the
" `ftplugin` using autocommands, like:
"
" > autocmd BufNewFile,BufRead *.cxx set filetype=cpp, or
" > autocmd BufNewFile,BufRead *.cxx setfiletype cpp
"
" Have a [read](http://vimdoc.sourceforge.net/htmldoc/filetype.html#ftdetect) on
" why you will find it in either:
" - ~/.vim/ftdetect/filetypes.vim
" - ~/.vim/filetype.vim
"
" Then specify what each FileType (language) will do in either
" - ~/.vim/ftdetect/language/vim
" - ~/.vim/after/ftdetect/language.vim

augroup vimrcEx
au!
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif
augroup END

"" Silently continue with additional customization
silent! so ~/.vim/init.vim

" --- Load any per project rc by specifying a .vimlocal in the root of the project
silent! so .vimlocal
