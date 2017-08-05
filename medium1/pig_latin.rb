class PigLatin
  VOWEL_SOUNDS = %w(a e i o u).freeze

  class << self
    def translate(string)
      string.split.map { |word| to_pig_latin(word) }.join(' ')
    end

    def to_pig_latin(word)
      return word + 'ay' if starts_with_vowel?(word)

      breakpoint = first_vowel_index(word)

      word[breakpoint..-1] + word[0...breakpoint] + 'ay'
    end

    def starts_with_vowel?(word)
      first = word[0]
      return true if %w(y x).include?(first) && !starts_with_vowel?(word[1..-1])

      VOWEL_SOUNDS.include? first
    end

    def first_vowel_index(word)
      letters = word.chars
      first_vowel = letters.find.with_index do |letter, idx|
        next if letter == 'u' && letters[idx - 1] == 'q'
        VOWEL_SOUNDS.include? letter
      end
      word.chars.index(first_vowel)
    end
  end
end
