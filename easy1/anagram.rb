# Write a program that, given a word and a list of possible anagrams,
# selects the correct sublist that contains the anagrams of the word.

class Anagram
  attr_reader :word

  def initialize(word)
    @word = word.downcase
  end

  def anagram?(candidate)
    checked_word = candidate.downcase

    checked_word != word && letters(checked_word) == letters(word)
  end

  def match(words)
    words.select { |checked_word| anagram?(checked_word) }
  end

  private

  def letters(string = word)
    string.chars.sort
  end
end
