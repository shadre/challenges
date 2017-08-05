class SumOfMultiples
  attr_reader :set

  def initialize(*set)
    set = [3, 5] if set.empty?
    @set = set
  end

  def self.to(limit)
    new.to(limit)
  end

  def to(limit)
    multiples(limit).reduce(0, :+)
  end

  private

  def multiples(limit)
    (1...limit).select { |n| set.any? { |num| (n % num).zero? } }
  end
end
