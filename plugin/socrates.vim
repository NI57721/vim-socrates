if exists('g:loaded_socrates') && g:loaded_socrates
  finish
endif
let g:loaded_socrates = v:true

let g:socrates_punctuations =
\   ",.'\";:? \<char-0x037E>\<char-0x0387>\<char-0x00FF>"

if !exists('g:socrates_smart_mode') || g:socrates_smart_mode
  let g:socrates_smart_mode = v:true
  call socrates#enable_smart_mode()
endif

nnoremap <Plug>(socrates)       <Cmd>call socrates#toggle()<CR>
nnoremap <Plug>(socrates-latin) <Cmd>call socrates#toggle('latin')<CR>
nnoremap <Plug>(socrates-greed) <Cmd>call socrates#toggle('greed')<CR>

