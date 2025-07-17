# vim-socrates
![Test](./../../actions/workflows/test.yml/badge.svg)  
A Vim/Neovim plugin for typing ancient Greek characters  
![screenshot](https://github.com/NI57721/vim-socrates/blob/assets/screenshot.gif?raw=true)

## INSTALLATION
You can use your preferred plugin manager.
```vim
" dein.vim
call dein#add('NI57721/vim-socrates')

" vim-plug
Plug 'NI57721/vim-socrates'

" neobundle
NeoBundle 'NI57721/vim-socrates'

" jetpack
Jetpack 'NI57721/vim-socrates'

" packer
packer.startup(function() use 'NI57721/vim-socrates' end)
```

## USAGE
Recommended settings.

Add one of the three lines below in your vimrc/init.vim, and then you can  
toggle keymaps between the current one and socrates-something you choose. My  
favourite is socrates-greed. To learn more about each keymap, see KEYMAPS and  
KEY MAPPINGS.  
```vim
nnoremap <leader>q <Plug>(socrates-greed)
nnoremap <leader>q <Plug>(socrates-latin)
nnoremap <leader>q <Plug>(socrates)
```

## KEYMAPS
Common features.

### Diacritics
You can input diacritics after typing keys corresponding to Greek alphabet.  
You can combine the diacritics in the order you like as long as the grammar  
allows. For example, each of `a~[_`, `a~_[`, `a_[~`, and so on, shows  
\<char-0x1F87> (ᾇ).

    [   - Rough breathing mark,    like ἁ.
    ]   - Smooth breathing mark,   like ἀ.
    `   - Grave accesnt mark,      like ὰ.
    '   - Acute accesnt mark,      like ά.
    ~   - Circumflex accesnt mark, like ᾶ.
    _   - Iota subscript/adscript, like ᾳ, ᾼ.
    -   - Macron,                  like ᾱ.
    ^   - Breve,                   like ᾰ.
    "   - Diaeresis,               like ϋ.

### Punctuations and some characters
You can also input the Ancient Greek punctuations and some characters not  
used in the modern age very well.

    ?   - Greek question mark,        ;.
          Note it is not a semicolon.
    ;   - Greek ano telia,            ·.
    :   - Greek ano telia,            ·.

    F\  - Capital digamma,            Ϝ.
    f\  - Small digamma,              ϝ.
    M\  - Capital san,                Ϻ.
    m\  - Small san,                  ϻ.
    Q\  - Capital koppa,              Ϙ.
    q\  - Small koppa,                ϙ.
    H\  - Capital heta,               Ͱ.
    h\  - Small heta,                 ͱ.
    S\  - Capital Archaic sampi,      Ͳ.
    s\  - Small Archaic sampi,        ͳ.
    Z\  - Sampi,                      Ϡ.
    z\  - Small sampi,                ϡ.
    SH\ - Capital sho,                Ϸ.
    Sh\ - Capital sho,                Ϸ.
    sh\ - Small sho,                  ϸ.
    W\  - Capital Pamphylian digamma, Ͷ.
    w\  - Small Pamphylian digamma,   ͷ.
    ST\ - Stigma,                     Ϛ.
    St\ - Stigma,                     Ϛ.
    st\ - Small stigma,               ϛ.
    j\  - Yot,                        ϳ.


### Separating slash
So as to avoid obscurity while you are converting the Ancient Greek characters,  
vim-socrates offers the slash key `/`. It allows you to confirm the conversion.  
It helps you, let's say, when you want input τη but the conversion result  
becomes θ. In this case, you can input `t/h` instead and then get τη.

### socrates keymap
Based on the Greek keyboard layout. Same for the capital characters.

    a    - α.
    b    - β.
    g    - γ.
    d    - δ.
    e    - ε.
    z    - ζ.
    h    - η.
    u    - θ.
    i    - ι.
    k    - κ.
    l    - λ.
    m    - μ.
    n    - ν.
    j    - ξ.
    o    - ο.
    p    - π.
    r    - ρ.
    s    - σ.
    w    - ς.
    t    - τ.
    y    - υ.
    f    - φ.
    x    - χ.
    c    - ψ.
    v    - ω.

### socrates-latin
Based on the system of the romanization of Greek. When you type capital  
characters that consist of two characters `XX`, either `XX` or `Xx` is allowed.

    a    - α.
    b    - β.
    g    - γ.
    d    - δ.
    e    - ε.
    z    - ζ.
    h    - η.
    th   - θ.
    i    - ι.
    k    - κ.
    l    - λ.
    m    - μ.
    n    - ν.
    x    - ξ.
    ks   - ξ.
    o    - ο.
    p    - π.
    r    - ρ.
    rh   - ῥ.
    s    - σ.
    c    - ς.
    t    - τ.
    y    - υ.
    u    - υ.
    ph   - φ.
    ch   - χ.
    ps   - ψ.
    w    - ω.

### socrates-greed
Mixture of the two above.

    a    - α.
    b    - β.
    g    - γ.
    d    - δ.
    e    - ε.
    z    - ζ.
    h    - η.
    th   - θ.
    i    - ι.
    k    - κ.
    l    - λ.
    m    - μ.
    n    - ν.
    j    - ξ.
    x    - ξ.
    ks   - ξ.
    o    - ο.
    p    - π.
    r    - ρ.
    rh   - ῥ.
    s    - σ.
    c    - ς.
    t    - τ.
    y    - υ.
    u    - υ.
    f    - φ.
    ph   - φ.
    ch   - χ.
    ps   - ψ.
    v    - ω.
    w    - ω.

## VARIABLES
- g:socrates_smart_mode  
  Enable smart mode.  
  It is set to v:true by default.  
  To learn more about smart mode, see SMART MODE.

- g:socrates_punctuations  
  Specifies Greek punctuations, which are used in SMART MODE.  
  It is set as below by default.  
  ",.'\\";:? \\\<char-0x037E>\\\<char-0x0387>\\\<char-0x00FF>"

## KEY MAPPINGS
There are key mappings to toggle the value of &keymap.

```<Plug>(socrates-normal)```  
Toggle between the current &keymap and socrates-normal.

```<Plug>(socrates-latin)```  
Toggle between the current &keymap and socrates-latin.

```<Plug>(socrates-greed)```  
Toggle between the current &keymap and socrates-greed.

To learn more about each keymap, see KEYMAPS.

## SMART MODE
Once smart mode is turned on, some characters are automatically replaced with  
another character according with the Ancient Greek grammar while you are  
typing in insert mode.

### Sigma detection
When you type a punctuation after a small sigma or when you leave from insert  
mode after typing a small sigma, replace the sigma with a final sigma. About  
punctuations, see g:socrates_punctuations.

### Rho detection
When you type a rho at the beginning of a word, replace the rho with that  
with a rough breathing mark.

## CHANGELOG
- 1.0.1 (17 Jul 2025)  
  Fix bugs
- 1.0.0 (16 Dec 2022)  
  First release

