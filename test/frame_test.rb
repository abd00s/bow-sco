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
      assert_equal false, frame.scored
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
      assert frame.roll!(throws: sample_throw)
    end

    describe "when a cumulative score is passed in arguments" do
      let(:cumulative_score) { 7 }
      let(:sample_throw) { [3, 3] }
      let(:frame) { Frame.new(number: frame_number) }

      def setup
        frame.roll!(throws: sample_throw, cumulative_score: cumulative_score)
      end

      it "sums the previous frame's cum with this frame's score so far" do
        assert_equal cumulative_score + sample_throw.reduce(:+),
                     frame.cumulative_score
      end
    end

    describe "when it is an open frame" do
      let(:frame) { Frame.new(number: frame_number) }
      let(:sample_throw) { [3, 3] }

      def setup
        frame.roll!(throws: sample_throw)
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

      it "maintains @strike as false" do
        assert_equal false,
                     frame.strike
      end

      it "toggles @scored to true" do
        assert_equal true,
                     frame.scored
      end

      it "toggles @played as true" do
        assert_equal true,
                     frame.played
      end
    end

    describe "when it is a spare frame" do
      let(:frame) { Frame.new(number: frame_number) }
      let(:sample_throw) { [5, 5] }

      def setup
        frame.roll!(throws: sample_throw)
      end

      it "toggles @spare to true" do
        assert_equal true,
                     frame.spare
      end

      it "maintains @strike as false" do
        assert_equal false,
                     frame.strike
      end

      it "maintains @scored as false" do
        assert_equal false,
                     frame.scored
      end
    end

    describe "when it is a strike frame" do
      let(:frame) { Frame.new(number: frame_number) }
      let(:strike_throw) { [10] }

      def setup
        frame.roll!(throws: strike_throw)
      end

      it "creates one Roll" do
        assert_equal 1, frame.rolls.size
      end

      it "sets @score to the max amount" do
        assert_equal Frame::MAX_NUMBER_OF_PINS,
                     frame.score
      end

      it "maintains @spare as false" do
        assert_equal false,
                     frame.spare
      end

      it "toggles @strike to true" do
        assert_equal true,
                     frame.strike
      end
    end
  end

  describe "#apply_bonus" do
    let(:bonus) { 5 }
    let(:frame) { Frame.new(number: 1) }

    it "increments the frame score by the bonus amount" do
      frame.apply_bonus(bonus)

      assert_equal bonus,
                   frame.score
    end
  end
end
