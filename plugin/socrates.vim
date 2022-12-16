if exists('g:loaded_socrates') && g:loaded_socrates
  finish
endif
let g:loaded_socrates = v:true

if exists('g:socrates_smart_mode') && g:socrates_smart_mode
  call socrates#enable_smart_mode()
endif

function! SocratesToggle(keymap_suffix = '')
  let l:current_keymap = 'Socrates' . a:keymap_suffix
  if !exists('l:prev_keymap')
    let l:prev_keymap = &keymap
    execute 'set keymap=' . l:current_keymap
  elseif l:current_keymap ==? &keymap
    execute 'set keymap=' . l:prev_kepmap
    let l:prev_keymap = l:current_keymap
  else
    let l:prev_keymap = &keymap
    execute 'set keymap=' . l:current_keymap
  endif
endfunction

nnoremap <Plug>(socrates-normal) :<C-u>call SocratesToggle()
nnoremap <Plug>(socrates-latin)  :<C-u>call SocratesToggle('Latin')
nnoremap <Plug>(socrates-greed)  :<C-u>call SocratesToggle('Greed')

