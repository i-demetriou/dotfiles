" ****************************************************************************
"
"     .                  .-.    .  _   *     _   .
"            *          /   \     ((       _/ \       *    .
"          _    .   .--'\/\_ \     `      /    \  *    ___
"      *  / \_    _/ ^      \/\'__        /\/\  /\  __/   \ *
"        /    \  /    .'   _/  /  \  *' /    \/  \/ .`'\_/\   .
"   .   /\/\  /\/ :' __  ^/  ^/    `--./.'  ^  `-.\ _    _:\ _
"      /    \/  \  _/  \-' __/.' ^ _   \_   .'\   _/ \ .  __/ \
"    /\  .-   `. \/     \ / -.   _/ \ -. `_/   \ /    `._/  ^  \
"   /  `-.__ ^   / .-'.--'    . /    `--./ .-'  `-.  `-. `.  -  `.
" @/        `.  / /      `-.   /  .-'   / .   .'   \    \  \  .-  \%
" @&8jgs@@%% @)&@&(88&@.-_=_-=_-=_-=_-=_.8@% &@&&8(8%@%8)(8@%8 8%@)%
" @88:::&(&8&&8:::::%&`.~-_~~-~~_~-~_~-~~=.'@(&%::::%@8&8)::&#@8::::
" `::::::8%@@%:::::@%&8:`.=~~-.~~-.~~=..~'8::::::::&@8:::::&8:::::'
"  `::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.'
" ****************************************************************************

" let mapleader = " " " Be a hypster - use <space> as leader

"Make Y behave more like vim
nnoremap Y y$

nnoremap J :m '>+1<CR>gv=gv
nnoremap K :m '<-2<CR>gv=gv

" Keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo break points
" inoremap , ,<c-g>u
" inoremap . .<c-g>u
" inoremap ! !<c-g>u
" inoremap ? ?<c-g>u

" Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

" Reload everything
map <leader>r :bufdo! e<CR>

" Remove highlighting
map <leader>h :noh<CR>

" greatest remap ever - when pasting over a selection, don't update latest buffer
vnoremap <leader>p "_dP
