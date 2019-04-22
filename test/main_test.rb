require "./test/test_helper"
require "./main"

class MainTest < Minitest::Test
  describe "when initializing a match" do
    let(:match) { Main.new }

    it "initializes 10 frames" do
      assert_equal 10,
                   match.frames.size
    end

    it "assigns numbers to the frames in a sequential 1 to 10 order" do
      assert_equal (1..10).to_a,
                   match.frames.map(&:number)
    end

    it "starts with a score of zero (0)" do
      assert_equal 0, match.total_score
    end
  end
end
