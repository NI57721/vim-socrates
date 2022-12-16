#!/usr/bin/env ruby
# frozen_string_literal: true

require 'csv'

KEYMAP_HEADER = <<~EOS
  let b:keymap_name = "Socrates"

  loadkeymap
EOS

CSV_FNAME = 'keymaps.csv'
VIM_FNAME = 'socrates.vim'
SEPARATOR = '|'

def keymap_format(main_alphabet, signatures, unicode, comment, separator: false)
  sprintf(
    "%s%s\t%s\t\%s",
    main_alphabet,
    signatures.join + (separator ? '|' : ''),
    unicode,
    comment
  )
end

def permutate_signatures(input, unicode, comment)
  main_alphabet, *signatures = input.scan(/[a-zA-Z]+|./)
  signatures.permutation.flat_map do |sgns|
    [
      keymap_format(main_alphabet, sgns, unicode, comment),
      keymap_format(main_alphabet, sgns, unicode, comment, separator: true)
    ]
  end
end

File.open(VIM_FNAME, 'w+') do |f|
  f.puts(KEYMAP_HEADER)
  CSV.open(
    CSV_FNAME,
    col_sep: "\t",
    quote_char: nil,
    skip_blanks: true,
    skip_lines: /^"/
  ).each do |row|
    f.puts(permutate_signatures(*row).join("\n"))
  end
end

