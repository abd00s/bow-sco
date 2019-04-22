class Roll
  attr_reader :pins_down, :all_pins_down
  alias_method :all_pins_down?, :all_pins_down

  def self.create(pins_down:)
    new(pins_down).tap(&:create)
  end

  def initialize(pins_down)
    @pins_down = pins_down
  end

  def create
    @all_pins_down = pins_down == 10
  end
end
