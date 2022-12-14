if exists('g:loaded_socrates') && g:loaded_socrates
  finish
endif
let g:loaded_socrates = v:true

call socrates#detect_word_beginning()

