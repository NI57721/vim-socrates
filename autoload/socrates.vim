
let s:punctuations = ',.''";:?'

function! socrates#detect_word_beginning() abort
  augroup Socrates
    autocmd!
    autocmd InsertCharPre * call socrates#change_last_sigma()
    autocmd InsertLeave   * call socrates#change_last_sigma()
  augroup END
endfunction

function! socrates#change_last_sigma() abort
  if v:char !=# '' && matchstr(s:punctuations, v:char) !=# ''
    return
  endif
  let l:current_char = socrates#get_current_position_char()
  if l:current_char ==# "\<char-0x03C3>"
    execute "normal! r\<char-0x03C2>"
  endif
endfunction

function! socrates#get_current_position_char() abort
  return nr2char(strgetchar(getline('.')[col('.') - 1:], 0))
endfunction

