class Luhn
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def self.add_last_digit(number, digit)
    (number.to_s + digit.to_s).to_i
  end

  def self.create(number)
    zero_checksum = add_last_digit(number, 0)
    luhn          = Luhn.new(zero_checksum)

    return zero_checksum if luhn.valid?

    current_rest     = luhn.checksum % 10
    valid_last_digit = 10 - current_rest

    add_last_digit(number, valid_last_digit)
  end

  def addends
    digits.reverse
          .map.with_index do |digit, index|
            next digit if index.even?
            number = digit * 2
            number -= 9 if number >= 10
            number
          end
          .reverse
  end

  def checksum
    addends.reduce(:+)
  end

  def valid?
    (checksum % 10).zero?
  end

  private

  def digits
    number.to_s.chars.map(&:to_i)
  end
end
