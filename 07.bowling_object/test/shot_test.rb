require 'minitest/autorun'

class ShotTest < Minitest::Test
  def test_score
		first_shot = Shot.new(5)
		assert_equal 5, shot.score
  end
end
