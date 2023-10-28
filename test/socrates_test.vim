let s:suite  = themis#suite('Test for Socrates plugin')
let s:assert = themis#helper('assert')
let s:scope  = themis#helper('scope')
let s:funcs  = s:scope.funcs('autoload/socrates.vim')

function s:suite.toggle_keymaps()
  set keymap=
  call socrates#toggle()
  call s:assert.equals(&keymap, 'socrates')
  call socrates#toggle()
  call s:assert.equals(&keymap, '')
  call socrates#toggle()
  call s:assert.equals(&keymap, 'socrates')
  call socrates#toggle('latin')
  call s:assert.equals(&keymap, 'socrates-latin')
  call socrates#toggle()
  call s:assert.equals(&keymap, 'socrates')
  call socrates#toggle('latin')
  call s:assert.equals(&keymap, 'socrates-latin')
  call socrates#toggle('latin')
  call s:assert.equals(&keymap, 'socrates')
  call socrates#toggle('latin')
  call s:assert.equals(&keymap, 'socrates-latin')
  call socrates#toggle('greed')
  call s:assert.equals(&keymap, 'socrates-greed')
  call socrates#toggle('greed')
  call s:assert.equals(&keymap, 'socrates-latin')
  set keymap=
  call socrates#toggle('latin')
  call s:assert.equals(&keymap, 'socrates-latin')
  call socrates#toggle('latin')
  call s:assert.equals(&keymap, '')
  call socrates#toggle('greed')
  call s:assert.equals(&keymap, 'socrates-greed')
  call socrates#toggle('greed')
  call s:assert.equals(&keymap, '')
endfunction

function s:suite.detect_if_rhos_have_any_signatures()
  let simple_rhos = ["\<char-0x03A1>", "\<char-0x03C1>"]
  let rhos_with_signatures = [
    \   "\<char-0x1FE4>", "\<char-0x1FEC>", "\<char-0x1FEC>", "\<char-0x1FEC>",
    \   "\<char-0x1FE5>", "\<char-0x1FE5>",
    \ ]

  for rho in simple_rhos
    call s:assert.true(s:funcs.is_simple_rho(rho))
  endfor
  for rho in rhos_with_signatures
    call s:assert.false(s:funcs.is_simple_rho(rho))
  endfor
endfunction

function s:suite.get_exact_nth_char_from_string()
  let sample = 'fooＦＯＯ, barＢＡＲ.'
  let sample_chars = [
    \   'f', 'o', 'o', 'Ｆ', 'Ｏ', 'Ｏ', ',', ' ', 'b', 'a', 'r', 'Ｂ',
    \   'Ａ', 'Ｒ', '.'
    \ ]

  for i in range(0, strchars(sample) - 1)
    call s:assert.equals(
      \   sample_chars[i], s:funcs.get_exact_nth_char_from(sample, i)
      \ )
  endfor
endfunction

