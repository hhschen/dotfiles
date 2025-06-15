" This file is for general key mappings.
" If you want to configure a specific plugin, you should go to the plugin/

let mapleader = "\<space>"

nnoremap <silent> <Space>sv :source $MYVIMRC<CR>

" Disable arrow keys
nnoremap <up> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <down> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <right> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <left> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>

" Do thing without registers
nnoremap c "_c
nnoremap C "_C
nnoremap cc "_cc
nnoremap x "_x
nnoremap <leader>p "0p
nnoremap <leader>P "0P
nnoremap <leader>c "_c
nnoremap <leader>C "_C
nnoremap <leader>d "_d
nnoremap <leader>D "_D
vnoremap <leader>p "0p
vnoremap <leader>c "_c
vnoremap <leader>C "_C
vnoremap <leader>d "_d
vnoremap <leader>D "_D

" Quicker window movement
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" Resize split windows using arrow keys by pressing:
noremap <c-w><up> <c-w>+
noremap <c-w><down> <c-w>-
noremap <c-w><left> <c-w><
noremap <c-w><right> <c-w>>

" Buffer
nnoremap <S-Tab> :bprev<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <leader>q :bd<CR>

" Disable highlight
map <silent> <leader><CR> :noh<CR>
