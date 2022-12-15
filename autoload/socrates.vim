
let s:punctuations = ",.'\";:? \<char-0x037E>\<char-0x0387>\<char-0x00FF>"

function! socrates#latinise_keymaps() abort
  augroup Socrates
    autocmd!
    autocmd OptionSet keymap
      \ if &keymap ==? 'socrates' |
      \   call socrates#latinise_keymaps() |
      \ endif
  augroup END
endfunction

function! socrates#enable_smart_checker() abort
  augroup Socrates
    autocmd!
    autocmd TextChangedI *
      \ if &keymap =~? '^socrates' |
      \   call socrates#change_last_sigma() |
      \ endif
    autocmd InsertCharPre *
      \ if &keymap =~? '^socrates' |
      \   call socrates#change_first_pho() |
      \ endif
    autocmd InsertLeave  *
      \ if &keymap =~? '^socrates' |
      \   call socrates#change_last_sigma_when_leaving_insert() |
      \ endif
  augroup END
endfunction

" Change a sigma with a final-sigma if cursor is just on the sigma that is the
" last character of the current line when you leave from insert mode.
function! socrates#change_last_sigma_when_leaving_insert() abort
  if v:char !=# '' || !s:is_cursor_at_line_end_in_normal_mode()
    return
  endif
  " U+03C3: Small sigma, U+03C2: Final Sigma.
  if s:get_char_from_line_end() ==# "\<char-0x03C3>"
    execute "normal! r\<char-0x03C2>"
  endif
endfunction

" Change a sigma with a final-sigma if you type one of punctuations in insert
" mode.
function! socrates#change_last_sigma() abort
  let l:current_char        = s:get_nth_char_from(getline('.'), charcol('.') - 2)
  if matchstr(s:punctuations, l:current_char) ==# ''
    return
  endif

  let l:char_before_cursor = s:get_nth_char_from(getline('.'), charcol('.') - 3)
  let l:is_at_line_end     = s:is_cursor_at_line_end_in_insert_mode()
  " U+03C3: Small sigma, U+03C2: Final Sigma.
  if l:char_before_cursor ==# "\<char-0x03C3>"
    execute "normal! hhr\<char-0x03C2>ll"
    if l:is_at_line_end
      call feedkeys("\<right>", 'nit')
    endif
  endif
endfunction

" Add a rough breathing mark on a rho, if the rho has no breathing mark and is
" at the beginning of a word.
function! socrates#change_first_pho() abort
  let l:current_char        = s:get_nth_char_from(getline('.'), charcol('.') - 2)
  if !s:is_simple_rho(v:char) || matchstr(s:punctuations, l:current_char) ==# ''
    return
  endif

  " Capital Rho: U+03A1, Capital Rho with rough breathing: U+1FEC
  "   Small Rho: U+03C1,   small Rho with rough breathing: U+1FE5
  if v:char ==# "\<char-0x03A1>"
    let v:char = "\<char-0x1FEC>"
  elseif v:char ==# "\<char-0x03C1>"
    let v:char = "\<char-0x1FE5>"
  endif
endfunction

function! s:is_simple_rho(char) abort
  return a:char ==# "\<char-0x03A1>" || a:char ==# "\<char-0x03C1>"
endfunction

function! s:get_nth_char_from(str, n) abort
  return nr2char(strgetchar(a:str, a:n))
endfunction

function! s:get_char_from_line_end(offset = 1) abort
  let l:current_line = getline('.')
  return nr2char(strgetchar(current_line, strchars(current_line) - a:offset))
endfunction

function! s:is_cursor_at_line_end_in_normal_mode() abort
  return charcol('.') == strchars(getline('.'))
endfunction

function! s:is_cursor_at_line_end_in_insert_mode() abort
  return charcol('.') == strchars(getline('.')) + 1
endfunction

