function! socrates#toggle(keymap_suffix = '')
  let l:current_keymap =
  \   'socrates' . (a:keymap_suffix == '' ? '' : '-') . a:keymap_suffix
  if !exists('s:prev_keymap')
    let s:prev_keymap = &keymap
    execute 'set keymap=' . l:current_keymap
  elseif l:current_keymap ==? &keymap
    execute 'set keymap=' . s:prev_keymap
    let s:prev_keymap = l:current_keymap
  else
    let s:prev_keymap = &keymap
    execute 'set keymap=' . l:current_keymap
  endif
endfunction

function! socrates#enable_smart_mode() abort
  augroup Socrates
    autocmd!
    autocmd TextChangedI *
      \ if &keymap =~# '^socrates' |
      \   call s:change_last_sigma() |
      \ endif
    autocmd InsertCharPre *
      \ if &keymap =~# '^socrates' |
      \   call s:change_first_pho() |
      \ endif
    autocmd InsertLeave  *
      \ if &keymap =~# '^socrates' |
      \   call s:change_last_sigma_when_leaving_insert() |
      \ endif
  augroup END
endfunction

" Change a sigma with a final-sigma if cursor is just on the sigma that is the
" last character of the current line when you leave from insert mode.
function! s:change_last_sigma_when_leaving_insert() abort
  if v:char !=# '' || !s:is_cursor_at_line_end_in_normal_mode()
    return
  endif
  let l:current_line = getline('.')
  let l:last_char_in_current_line = s:get_exact_nth_char_from(
  \   l:current_line, strchars(l:current_line) - 1
  \ )
  " U+03C3: Small sigma, U+03C2: Final Sigma.
  if l:last_char_in_current_line ==# "\<char-0x03C3>"
    execute "normal! r\<char-0x03C2>"
  endif
endfunction

" Change a sigma with a final-sigma if you type one of punctuations in insert
" mode.
function! s:change_last_sigma() abort
  let l:current_char = s:get_exact_nth_char_from(getline('.'), charcol('.') - 2)
  if !s:is_punctuation(l:current_char)
    return
  endif

  let l:char_before_cursor =
  \   s:get_exact_nth_char_from(getline('.'), charcol('.') - 3)
  let l:is_cursor_at_line_end = s:is_cursor_at_line_end_in_insert_mode()
  " U+03C3: Small sigma, U+03C2: Final Sigma.
  if l:char_before_cursor ==# "\<char-0x03C3>"
    execute "normal! hhr\<char-0x03C2>ll"
    if l:is_cursor_at_line_end
      call feedkeys("\<right>", 'nit')
    endif
  endif
endfunction

" Add a rough breathing mark on a rho, if the rho has no breathing mark and is
" at the beginning of a word.
function! s:change_first_pho() abort
  let l:current_char = s:get_exact_nth_char_from(getline('.'), charcol('.') - 2)
  if !s:is_simple_rho(v:char) || !s:is_punctuation( l:current_char)
    return
  endif

  " Capital Rho: U+03A1, Capital Rho with rough breathing: U+1FEC
  "   Small Rho: U+03C1,   Small Rho with rough breathing: U+1FE5
  if v:char ==# "\<char-0x03A1>"
    let v:char = "\<char-0x1FEC>"
  elseif v:char ==# "\<char-0x03C1>"
    let v:char = "\<char-0x1FE5>"
  endif
endfunction

function! s:is_simple_rho(char) abort
  return a:char ==# "\<char-0x03A1>" || a:char ==# "\<char-0x03C1>"
endfunction

function! s:is_punctuation(char) abort
  return matchstr(g:socrates_punctuations, a:char) !=# ''
endfunction

" This function counts both ASCII characters and multibyte characters as a
" single character.
function! s:get_exact_nth_char_from(str, n) abort
  return nr2char(strgetchar(a:str, a:n))
endfunction

function! s:is_cursor_at_line_end_in_normal_mode() abort
  return charcol('.') == strchars(getline('.'))
endfunction

function! s:is_cursor_at_line_end_in_insert_mode() abort
  return charcol('.') == strchars(getline('.')) + 1
endfunction

