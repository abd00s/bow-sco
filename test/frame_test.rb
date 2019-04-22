require "./test/test_helper"
require "./frame"

class FrameTest <  Minitest::Test
  describe "when intsantiating a frame" do
    let(:frame_number) { 1 }
    let(:frame) { Frame.new(number: frame_number) }

    it "initializes it with the deafult options" do
      assert_equal frame_number, frame.number
      assert_equal false, frame.played
      assert_equal 0, frame.score
      assert_equal false, frame.strike
      assert_equal false, frame.spare
    end

    it "initializes the rolls attribute as an empty array" do
      assert_equal [], frame.rolls
    end
  end

  describe "#roll!()" do
    let(:frame_number) { 1 }
    let(:frame) { Frame.new(number: frame_number) }
    let(:sample_throw) { [3, 3] }

    it "implements a #roll! message" do
      assert frame.roll!(sample_throw)
    end

    describe "when it is an open frame" do
      let(:frame) { Frame.new(number: frame_number) }
      let(:sample_throw) { [3, 3] }

      def setup
        frame.roll!(sample_throw)
      end

      it "creates two Rolls" do
        assert_equal 2, frame.rolls.size
      end

      it "assigns the score for the rolls" do
        assert_equal sample_throw.reduce(&:+),
                     frame.score
      end

      it "maintains @spare as false" do
        assert_equal false,
                     frame.spare
      end
    end
  end
end
