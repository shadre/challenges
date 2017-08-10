class InvalidCodonError < StandardError; end

class Translation
  CODONS = {
    'AUG'               => 'Methionine',
    %w(UUU UUC)         => 'Phenylalanine',
    %w(UUA UUG)         => 'Leucine',
    %w(UCU UCC UCA UCG) => 'Serine',
    %w(UAU UAC)         => 'Tyrosine',
    %w(UGU UGC)         => 'Cysteine',
    'UGG'               => 'Tryptophan',
    %w(UAA UAG UGA)     => 'STOP'
  }.freeze

  def self.of_codon(codon)
    CODONS[codon] || CODONS.find { |code, _| code.include?(codon) }[1]
  rescue NoMethodError
    raise InvalidCodonError
  end

  def self.of_rna(strand)
    0.step(strand.length - 3, 3).with_object([]) do |index, rna|
      curr = of_codon(strand[index, 3])
      return rna if curr == 'STOP'
      rna << curr
    end
  end
end
