" ****************************************************************************
"                                                     _nnnn_                 *
"                                                    dGGGGMMb                *
"                                                   @p~qp~~qMb               *
"                                                   M|@||@) M|               *
"                                                   @,----.JM|               *
"                                                  JS^\__/  qKL              *
"                                                 dZP        qKRb            *
"                                                dZP          qKKb           *
"                                               fZP            SMMb          *
"                                               HZM            MMMM          *
"                                               FqM            MMMM          *
"                                             __| ".        |\dS"qML         *
"                                             |    `.       | `' \Zq         *
"                                            _)      \.___.,|     .'         *
"                                            \____   )MMMMMP|   .'           *
"                                                 `-'       `--'             *
" ****************************************************************************

" --- Add copyright disclaimer with year
let @c='iCopyright (C) =matchstr(system("date +%Y"), "[^\n\r]*") "=$COPYRIGHTpa. All Rights Reserved.gcc<<o'
" --- Create a header file template
let @h='yy@co#ifndef UUID_@uy$o#define poooo#endif /* !defined (pa) */kk'
" --- Toggle tags easier
map <Leader>T :TlistToggle<CR>

let g:netrw_list_hide='\(^\|\s\s\)\zs.\+.\.o\($\|\s\+\|\*\)' " Hide .o files in file explorer

" --- :Make in vim
function! MakeCompletion(A, L, P) abort
    let l:targets = systemlist("make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}' | sort -u")
    return filter(l:targets, 'v:val =~ "^' . a:A . '"')
endfunction

command! -nargs=* -complete=customlist,MakeCompletion Make Make <args>

map <Leader>m :Make<space>

" --- Build and run simple one-file c application
nnoremap <silent> <F6> :!gcc -ggdb -o %< %<CR>
nnoremap <F7> :!./%<<CR>

" --- Load termdebug pluging
packadd termdebug
"" NOTE: if you want to use gdb-multiarch instead of gdb, then uncomment:
" let g:termdebugger='gdb-multiarch'
"" For more info see
"" https://github.com/vim/vim/blob/master/runtime/pack/dist/opt/termdebug/plugin/termdebug.vim
