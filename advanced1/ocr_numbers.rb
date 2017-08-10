class OCR
  attr_reader :numbers

  def initialize(text)
    @numbers = numberize(text)
  end

  def convert
    numbers.map(&:convert).join
  end

  private

  def multiple_nums?(text)
    text.lines.any? { |line| line.length > 4 }
  end

  def numberize(text)
    if multiple_nums?(text)
      text.lines
          .map { |line| line.chomp.scan(/...?/) }
          .transpose
          .map { |num| num.join("\n") }
          .map { |text| OCR_Number.new(text) }
    else
      [OCR_Number.new(text)]
    end

  end
end

class OCR_Number
  BLANK                  = /^ {0,}$/
  BOTTOM_WITH_RIGHT_PIPE = / _\|/
  LEFT_PIPE_WITH_BOTTOM  = /\|_ ?$/
  RIGHT_PIPE             = /  \|$/
  SIDE_PIPES             = /\| \|/
  SIDE_PIPES_WITH_BOTTOM = /\|_\|/
  TOP_DASH               = /  ?_/

  PATTERNS = {
    '0' => [TOP_DASH, SIDE_PIPES, SIDE_PIPES_WITH_BOTTOM],
    '1' => [BLANK, RIGHT_PIPE, RIGHT_PIPE],
    '2' => [TOP_DASH, BOTTOM_WITH_RIGHT_PIPE, LEFT_PIPE_WITH_BOTTOM],
    '3' => [TOP_DASH, BOTTOM_WITH_RIGHT_PIPE, BOTTOM_WITH_RIGHT_PIPE],
    '4' => [BLANK, SIDE_PIPES_WITH_BOTTOM, RIGHT_PIPE],
    '5' => [TOP_DASH, LEFT_PIPE_WITH_BOTTOM, BOTTOM_WITH_RIGHT_PIPE],
    '6' => [TOP_DASH, LEFT_PIPE_WITH_BOTTOM, SIDE_PIPES_WITH_BOTTOM],
    '7' => [TOP_DASH, RIGHT_PIPE, RIGHT_PIPE],
    '8' => [TOP_DASH, SIDE_PIPES_WITH_BOTTOM, SIDE_PIPES_WITH_BOTTOM],
    '9' => [TOP_DASH, SIDE_PIPES_WITH_BOTTOM, BOTTOM_WITH_RIGHT_PIPE]
  }

  attr_reader :text

  def initialize(text)
    @text = text
  end

  def convert
    PATTERNS.find { |_, pattern| compare_with(pattern) }&.first || '?'
  end

  private

  def compare_with(pattern)
    text.lines.each_with_index do |line, idx|
      return false unless line.chomp =~ pattern[idx]
    end

    true
  end


  def correct_size?
    text.count("\n") == 3
  end
end
