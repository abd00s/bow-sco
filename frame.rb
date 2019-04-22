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
end
