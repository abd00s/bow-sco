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

  describe "#score!" do
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

        it "toggles the frame#scored to true" do
          assert_equal true,
                       match.frames.first.scored
        end
      end
    end

    describe "when 2 frames are played" do
      describe "and both are open" do
        let(:input) { [[2, 3], [5,4]] }
        let(:match) { Main.new(input) }

        def setup
          match.score!
        end

        it "assigns the cumulative score of second frame to the match score" do
          assert_equal input.flatten.reduce(&:+),
                       match.total_score
        end
      end
    end
  end

  describe "full game test scenarios" do
    describe "all gutter balls" do
      let(:input) { Array.new(10) { [0, 0] } }
      let(:match) { Main.new(input) }
      let(:expected_result) { 0 }

      it "assigns the correct total cumulative score" do
        match.score!

        assert_equal expected_result,
                     match.total_score
      end
    end

    describe "all threes" do
      let(:input) { Array.new(10) { [3, 3] } }
      let(:match) { Main.new(input) }
      let(:expected_result) { 60 }

      it "assigns the correct total cumulative score" do
        match.score!

        assert_equal expected_result,
                     match.total_score
      end
    end

    describe "perfect game" do
      let(:input) { Array.new(9) { [10] } << [10, 10, 10] }
      let(:match) { Main.new(input) }
      let(:expected_result) { 300 }

      it "assigns the correct total cumulative score" do
        skip "strikes not implemented"
        match.score!

        assert_equal expected_result,
                     match.total_score
      end
    end

    describe "All Spares with first ball a 4" do
      let(:input) { Array.new(9) { [4, 6] } << [4, 6, 4] }
      let(:match) { Main.new(input) }
      let(:expected_result) { 140 }

      it "assigns the correct total cumulative score" do
        skip "spares not implemented"
        match.score!

        assert_equal expected_result,
                     match.total_score
      end
    end

    describe "Nine Strikes followed by a gutter ball" do
      let(:input) { Array.new(9) { [10] } << [0, 0] }
      let(:match) { Main.new(input) }
      let(:expected_result) { 240 }

      it "assigns the correct total cumulative score" do
        skip "strikes not implemented"
        match.score!

        assert_equal expected_result,
                     match.total_score
      end
    end

    describe "random with strikes, spares and gutterballs" do
      let(:input) { [[4,3],[10],[4,5],[1,3],[0,4],[2,5],[8,0],[9,1],[6,2],[2,3]] }
      let(:match) { Main.new(input) }
      let(:expected_result) { 87 }

      it "assigns the correct total cumulative score" do
        skip "strikes and spares not implemented"
        match.score!

        assert_equal expected_result,
                     match.total_score
      end
    end
  end
end
