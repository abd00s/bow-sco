require "./frame"

class Main
  attr_reader :frames, :total_score

  def initialize(input = [])
    @total_score = 0
    @frames = initialize_frames
    @input = input
  end

  def score!
    @input.each do |played_frame|
      current_frame.roll!(
        throws:           played_frame,
        cumulative_score: previous_frame&.cumulative_score || 0
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
