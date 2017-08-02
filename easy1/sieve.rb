# Write a program that uses the Sieve of Eratosthenes to find all the primes
# from 2 up to a given number.
class Sieve
  attr_reader :limit, :numbers

  def initialize(limit)
    @limit   = limit
    @numbers = (2..limit).map { |num| [num, true] }.to_h
    sift!
  end

  def first_unmarked
    numbers.find(&:last).first
  end

  def multiples(number)
    (2..limit).each_with_object([]) do |times, result|
      multple = number * times
      break result if multple > limit
      result << multple
    end
  end

  def primes
    numbers.select { |_, flag| flag }.keys
  end

  def sift!
    numbers.each do |number, flag|
      next unless flag

      multiples(number).each { |multiple| numbers[multiple] = false }
    end
  end
end
