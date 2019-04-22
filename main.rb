require "./frame"

class Main
  attr_reader :frames
  def initialize
    @total_score = 0
    @frames = initialize_frames
  end

  private

  def initialize_frames
    Array.new(10) { |i| Frame.new(number: i + 1) }
  end
end
