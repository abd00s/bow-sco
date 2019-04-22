require "./roll"

class Frame
  attr_reader :number, :played, :score, :strike, :spare, :rolls

  def initialize(number: )
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
  end
end
