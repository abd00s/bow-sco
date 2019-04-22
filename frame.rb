require "./roll"

class Frame
  attr_reader :number, :played, :score, :strike, :spare, :rolls

  MAX_NUMBER_OF_PINS = 10

  def initialize(number:)
    @number = number
    @played = false
    @score = 0
    @strike = false
    @spare = false
    @rolls = []
  end

  def roll!(throws)
    # return strike if throws.size == 1

    create_rolls(throws)
    set_initial_score
    toggle_spare
    mark_played
  end

  def create_rolls(throws)
    throws.each do |throw|
      @rolls << Roll.create(pins_down: throw)
    end
  end

  def set_initial_score
    @score = @rolls.inject(0) { |sum, r| sum + r.pins_down }
  end

  def toggle_spare
    @spare = @score == MAX_NUMBER_OF_PINS
  end

  def mark_played
    @played = true
  end
end
