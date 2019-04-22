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
  end
end
