require "./roll"

class Frame
  attr_reader :number, :played, :score, :strike, :spare, :rolls, :scored,
              :cumulative_score

  MAX_NUMBER_OF_PINS = 10

  def initialize(number:)
    @number = number
    @played = false
    @score  = 0
    @strike = false
    @spare  = false
    @scored = false
    @rolls  = []
  end

  def roll!(throws:, cumulative_score: 0)
    create_rolls(throws)
    set_initial_score
    update_cumulative_score(cumulative_score)
    toggle_strike
    toggle_spare
    mark_scored
    mark_played
  end

  def apply_bonus(points)
    @score += points
    @cumulative_score += points
  end

  private

  def create_rolls(throws)
    throws.each do |throw|
      @rolls << Roll.create(pins_down: throw)
    end
  end

  def set_initial_score
    @score = @rolls.inject(0) { |sum, r| sum + r.pins_down }
  end

  def toggle_strike
    @strike = score == MAX_NUMBER_OF_PINS && rolls.size == 1
  end

  def toggle_spare
    @spare = score == MAX_NUMBER_OF_PINS && rolls.size == 2
  end

  def mark_scored
    @scored = true unless spare
  end

  def update_cumulative_score(previous_cumulative_score)
    @cumulative_score = previous_cumulative_score + score
  end

  def mark_played
    @played = true
  end
end
