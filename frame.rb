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

    throws.each do |throw|
      @rolls << Roll.create(pins_down: throw)
    end

    @score = @rolls.inject(0) { |sum, r| sum + r.pins_down }
    # @spare = @score == MAX_NUMBER_OF_PINS
    @played = true
  end
end
