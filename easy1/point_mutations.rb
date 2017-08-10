class DNA
  attr_reader :strand

  def initialize(strand)
    @strand = strand
  end

  def dna_length(dna_strand = strand)
    dna_strand.length
  end

  def hamming_distance(distant_strand)
    length_for_comparison = smaller_dna_length(distant_strand)

    (0..length_for_comparison - 1).count do |nucleotide_position|
      strand[nucleotide_position] != distant_strand[nucleotide_position]
    end
  end

  def smaller_dna_length(other_strand)
    [dna_length, dna_length(other_strand)].min
  end
end
