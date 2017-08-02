# Write a program that will convert a trinary number, represented as a string
# (e.g. '102012'), to its decimal equivalent using first principles (without
# using an existing method or library that can work with numeral systems).
# Invalid trinary entries should convert to decimal number 0.
class Trinary
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def to_decimal
    return 0 unless valid?

    number
      .chars
      .reverse
      .map.with_index { |digit, idx| digit.to_i * 3**idx }
      .reduce(:+)
  end

  def valid?
    /\A[0-2]+\z/ =~ number
  end
end

p Trinary.new('112').to_decimal
