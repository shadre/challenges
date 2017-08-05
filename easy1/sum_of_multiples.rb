class SumOfMultiples
  attr_reader :set

  def initialize(*set)
    set = [3, 5] if set.empty?
    @set = set
  end

  def self.to(limit)
    SumOfMultiples.new.to(limit)
  end

  def to(limit)
    multiples(limit).reduce(:+) || 0
  end

  private

  def multiples(limit)
    multiples_arr = []
    set.each do |num|
      multiples_arr += (1...limit).select { |n| (n % num).zero? }
    end
    multiples_arr.uniq
  end
end
