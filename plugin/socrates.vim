if exists('g:loaded_socrates') && g:loaded_socrates
  finish
endif
let g:loaded_socrates = v:true

if exists('g:socrates_smart_mode') && g:socrates_smart_mode
  call socrates#enable_smart_checker()
endif

