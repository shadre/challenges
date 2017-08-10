class OCR
  attr_reader :numbers

  def initialize(text)
    @numbers = numberize(text)
  end

  def convert
    if numbers.all? { |el| el.kind_of? Array }
      numbers.map { |array| convert_to_string(array) }
             .join(',')
    else
      convert_to_string(numbers)
    end
  end

  private

  def convert_to_string(array_of_ocr_numbers)
    array_of_ocr_numbers.map(&:convert).join
  end

  def multiple_nums?(text)
    text.lines.any? { |line| line.chomp.length > 3 }
  end

  def numberize(text)
    if multiple_nums?(text)
      if text =~ /\n\n/
        text.split("\n\n")
            .map { |line_text| turn_into_numbers(line_text) }
      else
        turn_into_numbers(text)
      end
    else
      [OCR_Number.new(text)]
    end
  end

  def turn_into_numbers(line_text)
    line_text.lines
             .map { |line| line.chomp.scan(/...?/) }
             .transpose
             .map { |num| num.join("\n") }
             .map { |text| OCR_Number.new(text) }
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
end
