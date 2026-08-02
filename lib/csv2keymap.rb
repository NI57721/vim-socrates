#!/usr/bin/env ruby
# frozen_string_literal: true

require 'csv'

KEYMAP_HEADER = <<~EOS
  let b:keymap_name = 'Socrates%s'

  loadkeymap
EOS

CSV_FNAME = 'lib/keymaps.csv'
KEYMAPS = {
  normal: 'keymap/socrates_utf-8.vim',
  latin: 'keymap/socrates-latin_utf-8.vim',
  greed: 'keymap/socrates-greed_utf-8.vim',
}
SEPARATOR = '/'

def keymap_format(main_alphabet, signatures, unicode, comment, separator: false)
  sprintf(
    "%s%s\t%s\t\%s",
    main_alphabet,
    signatures.join.gsub(/\\/, '\\\\\\\\') + (separator ? SEPARATOR : ''),
    unicode,
    comment
  )
end

def permutate_signatures(input, unicodes, comment)
  main_alphabet, *signatures = input.scan(/[a-zA-Z]+|./)
  signatures.permutation.flat_map do |sgns|
    [
      keymap_format(main_alphabet, sgns, unicodes, comment),
      keymap_format(main_alphabet, sgns, unicodes, comment, separator: true)
    ]
  end
end

def keymap_for?(keymap, input, comment)
  case keymap
  when :normal
    keymap_for_normal?(input, comment)
  when :latin
    keymap_for_latin?(input, comment)
  when :greed
    keymap_for_greed?(input, comment)
  else
    raise 'Invalid keymap is given.'
  end
end

def matches_character_definition?(input, comment, target_input, character)
  input.match?(/\A#{Regexp.escape(target_input)}(?:\Z|[^a-z])/i) &&
    comment.include?(character)
end

def keymap_for_normal?(input, comment)
  if input.match?(/\Ath/i) ||
      matches_character_definition?(input, comment, 'x', 'Xi') ||
      matches_character_definition?(input, comment, 'ks', 'Xi') ||
      matches_character_definition?(input, comment, 'rh', 'Rho') ||
      matches_character_definition?(input, comment, 'c', 'Final sigma') ||
      matches_character_definition?(input, comment, 'c', 'Sigma') ||
      matches_character_definition?(input, comment, 'u', 'Upsilon') ||
      matches_character_definition?(input, comment, 'ph', 'Phi') ||
      matches_character_definition?(input, comment, 'ch', 'Chi') ||
      matches_character_definition?(input, comment, 'ps', 'Psi') ||
      matches_character_definition?(input, comment, 'w', 'Omega')
    return false
  end
  true
end

def keymap_for_latin?(input, comment)
  if matches_character_definition?(input, comment, 'u', 'Theta') ||
      matches_character_definition?(input, comment, 'j', 'Xi') ||
      matches_character_definition?(input, comment, 'w', 'Final sigma') ||
      matches_character_definition?(input, comment, 'w', 'Sigma') ||
      matches_character_definition?(input, comment, 'f', 'Phi') ||
      matches_character_definition?(input, comment, 'x', 'Chi') ||
      matches_character_definition?(input, comment, 'c', 'Psi') ||
      matches_character_definition?(input, comment, 'v', 'Omega')
    return false
  end
  true
end

def keymap_for_greed?(input, comment)
  if matches_character_definition?(input, comment, 'u', 'Theta') ||
      matches_character_definition?(input, comment, 'w', 'Final sigma') ||
      matches_character_definition?(input, comment, 'w', 'Sigma') ||
      matches_character_definition?(input, comment, 'x', 'Chi') ||
      matches_character_definition?(input, comment, 'c', 'Psi')
    return false
  end
  true
end

KEYMAPS.each do |keymap, keymap_file|
  keymap_suffix_in_vim = keymap == :normal ? '' : keymap.capitalize
  File.open(keymap_file, 'w+') do |f|
    f.puts(KEYMAP_HEADER % keymap_suffix_in_vim)
    CSV.open(
      CSV_FNAME,
      col_sep: "\t",
      quote_char: nil,
      skip_blanks: true,
      skip_lines: /^"/
    ).each do |input, unicodes, comment|
      next if !keymap_for?(keymap, input, comment)

      f.puts(permutate_signatures(input, unicodes, comment).join("\n"))
    end
  end
end
