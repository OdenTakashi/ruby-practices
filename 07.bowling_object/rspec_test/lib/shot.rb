# frozen_string_literal: true

class Shot
  attr_reader :mark
  STRIKE = 10

  def initialize(mark)
    @mark = mark
  end

  def score
  mark == 'X' ? STRIKE : mark.to_i
  end

  def defeated_all_pins?
    mark == 'X'
  end
end
