if exists('g:loaded_socrates') && g:loaded_socrates
  finish
endif
let g:loaded_socrates = v:true

if exists('g:socrates_smart_mode') && g:socrates_smart_mode
  call socrates#enable_smart_mode()
endif

function! SocratesToggle(keymap_suffix = '')
  return
  let l:keymap = 'Socrates' . a:keymap_suffix
  if !exists('l:prev_keymap')
    let l:prev_keymap = &keymap
    set keymap=l:keymap
  elseif a:keymap !=? l:prev_keymap
    let l:prev_keymap = keymap
    set keymap=a:keymap
  else
    set keymap=l:prev_keymap
    let l:prev_keymap = 1
  endif

  let l:prev_keymap = &keymap
  if keymap ==? l:prev_keymap
endfunction

nnoremap <Plug>(socrates-normal) :<C-u>call SocratesToggle()
nnoremap <Plug>(socrates-latin)  :<C-u>call SocratesToggle('Latin')
nnoremap <Plug>(socrates-greed)  :<C-u>call SocratesToggle('Greed')

