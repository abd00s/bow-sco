require "./frame"

class Round
  def self.play(args = {})
    new(args).play
  end

  def initialize(args = {})
    @current_frame  = args[:current_frame]
    @previous_frame = args[:previous_frame]
    @throws         = args[:throws]
  end

  def play
    play_current_frame
    apply_bonus
  end

  private

  def play_current_frame
    @current_frame.roll!(
      throws:           @throws,
      cumulative_score: @previous_frame&.cumulative_score || 0
    )
  end

  def apply_bonus
    return if @previous_frame.nil? || @previous_frame.scored

    @previous_frame&.apply_bonus(@current_frame.rolls.first.pins_down)
    @current_frame.apply_bonus(@current_frame.rolls.first.pins_down)
  end
end
