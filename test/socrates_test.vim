let s:suite  = themis#suite('Test for Socrates plugin')
let s:assert = themis#helper('assert')
let s:scope  = themis#helper('scope')
let s:funcs  = s:scope.funcs('autoload/socrates.vim')

function s:suite.toggle_keymap()
  set keymap=
  call SocratesToggle()
  call s:assert.equals(&keymap, 'Socrates')
  call SocratesToggle()
  call s:assert.equals(&keymap, '')
  call SocratesToggle()
  call s:assert.equals(&keymap, 'Socrates')
  call SocratesToggle('Latin')
  call s:assert.equals(&keymap, 'SocratesLatin')
  call SocratesToggle()
  call s:assert.equals(&keymap, 'Socrates')
  call SocratesToggle('Latin')
  call s:assert.equals(&keymap, 'SocratesLatin')
  call SocratesToggle('Latin')
  call s:assert.equals(&keymap, 'Socrates')
  call SocratesToggle('Latin')
  call s:assert.equals(&keymap, 'SocratesLatin')
  call SocratesToggle('Greed')
  call s:assert.equals(&keymap, 'SocratesGreed')
  call SocratesToggle('Greed')
  call s:assert.equals(&keymap, 'SocratesLatin')
  set keymap=
  call SocratesToggle('Latin')
  call s:assert.equals(&keymap, 'SocratesLatin')
  call SocratesToggle('Latin')
  call s:assert.equals(&keymap, '')
  call SocratesToggle('Greed')
  call s:assert.equals(&keymap, 'SocratesGreed')
  call SocratesToggle('Greed')
  call s:assert.equals(&keymap, '')
endfunction

function s:suite.detect_if_rhos_have_any_signatures()
  let l:simple_rhos = ["\<char-0x03A1>", "\<char-0x03C1>"]
  let l:rhos_with_signatures = [
  \   "\<char-0x1FE4>", "\<char-0x1FEC>", "\<char-0x1FEC>", "\<char-0x1FEC>",
  \   "\<char-0x1FE5>", "\<char-0x1FE5>",
  \ ]

  for rho in l:simple_rhos
    call s:assert.true(s:funcs.is_simple_rho(rho))
  endfor
  for rho in l:rhos_with_signatures
    call s:assert.false(s:funcs.is_simple_rho(rho))
  endfor
endfunction

function s:suite.get_exact_nth_char_from_string()
  let l:sample = 'fooＦＯＯ, barＢＡＲ.'
  let l:sample_chars = [
  \   'f', 'o', 'o', 'Ｆ', 'Ｏ', 'Ｏ', ',', ' ', 'b', 'a', 'r', 'Ｂ',
  \   'Ａ', 'Ｒ', '.'
  \ ]

  for i in range(0, strchars(l:sample) - 1)
    call s:assert.equals(
    \   l:l:sample_chars[i], s:funcs.get_exact_nth_char_from(l:sample, i)
    \ )
  endfor
endfunction

