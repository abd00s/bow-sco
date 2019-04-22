require "./test/test_helper"
require "./main"

class MainTest < Minitest::Test
  describe "when initializing a match" do
    let(:match) { Main.new }

    it "initializes 10 frames" do
      assert_equal 10,
                   match.frames.size
    end
  end
end
