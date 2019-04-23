require "./test/test_helper"
require "./main"

class MainTest < Minitest::Test
  describe "when initializing a match" do
    let(:match) { Main.new([]) }

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

  describe "#score" do
    describe "when 1 frame is played" do
      describe "and frame is open" do
        let(:input) { [[2, 3]] }
        let(:match) { Main.new(input) }

        def setup
          match.score!
        end

        it "sums the total of pins and assigns that to score" do
          assert_equal input.first.reduce(&:+),
                       match.frames.first.score
        end
      end
    end
  end
end
