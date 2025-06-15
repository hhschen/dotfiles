" Integrate fzf via Homebrew
set rtp+=/usr/local/opt/fzf

" Initialize configuration dictionary
let g:fzf_vim = {}

let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Customize command
command! -bang ProjectFiles call fzf#vim#files('~/Documents/Development', {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat {}']}, <bang>0)
command! -bang PluginFiles call fzf#vim#files('~/.vim', {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat {}']}, <bang>0)

" Keymap
nnoremap <leader>fb :Buffer<CR>
nnoremap <leader>fc :Commits<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fG :GFiles?<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fp :ProjectFiles<CR>
nnoremap <leader>fP :PluginFiles<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>f/ :Rg<CR>
