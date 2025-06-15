if executable("python")
  autocmd BufRead,BufNewFile *.py map <F5> :% w !python<CR>
else
  autocmd BufRead,BufNewFile *.py map <F5> :echo "You need to install Python first!"<CR>
endif
