
let s:punctuations = ',.''";:?'

function! socrates#detect_word_beginning() abort
  augroup Socrates
    autocmd!
    autocmd InsertCharPre * call socrates#change_last_sigma()
    autocmd InsertLeave   * call socrates#change_last_sigma()
  augroup END
endfunction

function! socrates#change_last_sigma() abort
  if v:char !=# '' && matchstr(s:punctuations, v:char) !=# '' || &keymap !=? 'socrates'
    return
  endif
  let l:current_char = socrates#get_current_position_char(1)
  let l:current_char2 = socrates#get_current_position_char(2)
  let l:current_char3 = socrates#get_current_position_char(3)
  echom 'char:  ' l:current_char
  echom 'char2: ' l:current_char2
  echom 'char3: ' l:current_char3
  " Failed to get multi byte characters...
  if l:current_char ==# "\<char-0x03C3>"
    execute "normal! r\<char-0x03C2>"
  endif
  if l:current_char2 ==# "\<char-0x03C3>"
    execute "normal! r\<char-0x03C2>"
  endif
  if l:current_char3 ==# "\<char-0x03C3>"
    execute "normal! r\<char-0x03C2>"
  endif
endfunction

function! socrates#get_current_position_char(int) abort
  return matchstr(getline('.'), '\%'.col('.').'c.')
  " return nr2char(strgetchar(getline('.')[col('.') - a:int:], 0))
endfunction

