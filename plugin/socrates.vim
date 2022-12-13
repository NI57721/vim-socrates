if exists('g:loaded_socrates') && g:loaded_socrates
  finish
endif
let g:loaded_socrates = v:true

augroup Socrates
  autocmd!
  autocmd Hoge
augroup END

