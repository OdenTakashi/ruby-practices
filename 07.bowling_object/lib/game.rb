# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

class Game
  AMOUNT_OF_STANDARD_FRAMES = 9
  FULL_MARKS = 10

  def initialize(marks)
    @frames = build_frames(marks)
  end

  def score
    @frames.each_with_index.sum do |frame, idx|
      final_frame?(idx) ? frame.final_score : not_final_frame_score(frame, idx)
    end
  end

  private

  def build_frames(args)
    marks = args.split(',')
    shots = marks.map { |mark| Shot.new(mark) }

    frames = []
    AMOUNT_OF_STANDARD_FRAMES.times do
      picked_shots = shots.shift(2)
      if picked_shots.first.defeated_all_pins?
        frames << Frame.new(picked_shots[0])
        shots.unshift(picked_shots.last)
      else
        frames << Frame.new(picked_shots[0], picked_shots[1])
      end
    end
    frames << Frame.new(shots[0], shots[1], shots[2])
  end

  def final_frame?(frame_number)
    frame_number == @frames.count - 1
  end

  def point_of_strike(frame, idx)
    if @frames[idx + 1].strike? && !@frames[idx + 2].nil?
      frame.score + @frames[idx + 1].score + @frames[idx + 2].first_shot.score
    else
      frame.score + @frames[idx + 1].score
    end
  end

  def point_of_spare(frame, idx)
    frame.score + @frames[idx + 1].first_shot.score
  end

  def not_final_frame_score(frame, idx)
    if frame.strike?
      point_of_strike(frame, idx)
    elsif frame.spare?
      point_of_spare(frame, idx)
    else
      frame.score
    end
  end
end

ary = ARGV[0]
game = Game.new(ary)
p game.score
