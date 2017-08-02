class SecretHandshake
  SECRET = { "1"   => "wink",            "10"   => "double blink",
             "100" => "close your eyes", "1000" => "jump" }

  def initialize(number)
    @binary = convert(number)
  end

  def commands
    analyzed_num = binary.to_i
    commands     = []

    SECRET.each_with_index do |(num, secret), idx|
      if analyzed_num.to_s[-(idx + 1)..-1] == num.to_s
        commands << secret
        analyzed_num -= num.to_i
      end
    end

    commands.reverse! if analyzed_num.to_s[-5..-1] == "10000"

    commands
  end

  private

  attr_reader :binary

  def convert(number)
    string =
      number.class == Fixnum ? number.to_s(2) : number

    /^[0-1]+$/ =~ string ? string : "0"
  end
end

handshake = SecretHandshake.new 31
p handshake

