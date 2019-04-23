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
    return if @previous_frame.nil?

    apply_spare_bonus
    apply_strike_bonus
  end

  def apply_spare_bonus
    return unless @previous_frame.spare

    @previous_frame.apply_bonus(@current_frame.rolls.first.pins_down)
    @current_frame.apply_bonus(@current_frame.rolls.first.pins_down)
  end

  def apply_strike_bonus
    return unless @previous_frame.strike

    @previous_frame.apply_bonus(@current_frame.score)
    @current_frame.apply_bonus(@current_frame.score)
  end
end
