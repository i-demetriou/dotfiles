" ****************************************************************************
"                                           $"   *.
"               d$$$$$$$P"                  $    J
"                   ^$.                     4r  "
"                   d"b                    .db
"                  P   $                  e" $
"         ..ec.. ."     *.              zP   $.zec..
"     .^        3*b.     *.           .P" .@"4F      "4
"   ."         d"  ^b.    *c        .$"  d"   $         %
"  /          P      $.    "c      d"   @     3r         3
" 4        .eE........$r===e$$$$eeP    J       *..        b
" $       $$$$$       $   4$$$$$$$     F       d$$$.      4
" $       $$$$$       $   4$$$$$$$     L       *$$$"      4
" 4         "      ""3P ===$$$$$$"     3                  P
"  *                 $       """        b                J
"   ".             .P                    %.             @
"     %.         z*"                      ^%.        .r"
"        "*==*""                             ^"*==*""
" ****************************************************************************

" --- Trim trailing whitespace
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
" --- Generate a UUID using the UNIX command
let @u='"=matchstr(system("uuidgen"), "[^\n\r]*")pF-r_;r_;r_;r_b'
" --- Remove all lines that contain only the given word
let @d=':%s/^$\n\(^.\+$\n\)\+.*\<t\>.*$\n\(^.\+$\n\)\+//'
" change current buffer's working directory to the file's one
map <C-l> :lcd %:p:h<CR>
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
  \ | wincmd p | diffthis
endif
" Create a scratch pad buffer
command! ScratchPad setlocal noswapfile buftype=nofile bufhidden=hide
" Split resizing
nnoremap <silent> <Leader>+ :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
" Reload Config
nnoremap <leader>rr :source $MYVIMRC \
            \| runtime plugin/*.vim \
            \| runtime after/plugin/*.vim<CR>
" Run a command in vim
command! -complete=shellcmd -nargs=+ Run call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline) abort
    exe 'vert terminal '. a:cmdline
endfunction
