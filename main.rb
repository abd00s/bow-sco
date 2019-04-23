require "./frame"
require "./round"

class Main
  attr_reader :frames, :total_score

  def initialize(input = [])
    @total_score = 0
    @frames = initialize_frames
    @input = input
  end

  def score!
    @input.each do |throws|
      Round.play(
        current_frame:  current_frame,
        previous_frame: previous_frame,
        throws:         throws
      )
    end
    @total_score = last_played_frame.cumulative_score
  end

  private

  def initialize_frames
    Array.new(10) { |i| Frame.new(number: i + 1) }
  end

  def current_frame
    @frames.find { |frame| frame.played == false }
  end

  def previous_frame
    @frames.find { |frame| frame.number == current_frame.number - 1 }
  end

  def last_played_frame
    @frames.reverse.find { |frame| frame.played }
  end
end
