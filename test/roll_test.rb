require "./roll"
require "./test/test_helper"

class RollTest <  Minitest::Test
  describe ".create" do
    describe "when all pins are dropped" do
      let(:max_num_pins) { 10 }
      let(:roll) { Roll.create(pins_down: max_num_pins) }

      it "assigns #all_pins_down? to true" do
        assert roll.all_pins_down?
      end
    end
  end
end
