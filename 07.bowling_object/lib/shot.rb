# frozen_string_literal: true

class Shot

  def initialize(mark)
    @mark = mark
  end

  def score
    @mark == 'X' ? Game::STRIKE : @mark.to_i
  end

  def defeated_all_pins?
    @mark == 'X'
  end
end
