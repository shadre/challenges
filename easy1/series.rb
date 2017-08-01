class Series
  def initialize(string)
    @digits = string.chars.map(&:to_i)
  end

  def slices(n)
    raise ArgumentError unless (0..digits.size).include? n

    digits.each_cons(n).to_a
  end

  private

  attr_reader :digits
end


series = Series.new('01234')
p series.slices(4)
