# Implement octal to decimal conversion. Given an octal input string, your
# program should produce a decimal output.

# Note:
# Implement the conversion yourself. Do not use something else to perform the
# conversion for you. Treat invalid input as octal 0.
class Octal
  def initialize(number_string)
    @number_string = number_string
  end

  def to_decimal
    return 0 unless valid?

    number_string.chars
                 .reverse
                 .map.with_index { |str, idx| str.to_i * 8**idx }
                 .reduce(:+)
  end

  private

  attr_reader :number_string

  def valid?
    chars = number_string.chars
    !chars.empty? && chars.all? { |char| /[0-7]/ =~ char }
  end
end
