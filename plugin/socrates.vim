if exists('g:loaded_socrates') && g:loaded_socrates
  finish
endif
let g:loaded_socrates = v:true

if exists('g:socrates_smart_mode') && g:socrates_smart_mode
  call socrates#enable_smart_mode()
endif

function! SocratesToggle(keymap_suffix = '')
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

nnoremap <Plug>(socrates-normal) :<C-u>call SocratesToggle()<CR>
nnoremap <Plug>(socrates-latin)  :<C-u>call SocratesToggle('latin')<CR>
nnoremap <Plug>(socrates-greed)  :<C-u>call SocratesToggle('greed')<CR>

