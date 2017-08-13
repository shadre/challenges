class CircularBuffer
  def initialize(limit)
    @limit  = limit
    @buffer = Array.new
  end

  def clear
    self.buffer = Array.new
  end

  def read
    buffer.shift || raise(BufferEmptyException, 'Buffer is empty')
  end

  def write(data)
    store(data) { raise BufferFullException, "Buffer is full" }
  end

  def write!(data)
    store(data) { read }
  end

  private

  attr_accessor :buffer
  attr_reader :limit

  def store(data)
    return unless data

    yield if buffer.size == limit

    buffer << data
  end

  class BufferEmptyException < Exception; end
  class BufferFullException < Exception; end
end
