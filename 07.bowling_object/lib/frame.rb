# frozen_string_literal: true

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_shot, second_shot = Shot.new(nil), third_shot = nil)
    @first_shot = first_shot
    @second_shot = second_shot
    @third_shot = third_shot.nil? ? Shot.new(nil) : third_shot
  end

  def score
    @first_shot.score + @second_shot.score
  end

  def final_score
    @first_shot.score + @second_shot.score + @third_shot.score
  end

  def strike?
    @first_shot.score == Game::STRIKE
  end

  def spare?
    score == Game::STRIKE
  end
end
