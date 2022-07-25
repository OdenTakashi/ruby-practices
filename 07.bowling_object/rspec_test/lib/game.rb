# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

class Game
  Amount_of_standard_frames = 9
  STRIKE = 10

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
    Amount_of_standard_frames.times do
      ary_of_shots_picked = shots.shift(2)
      if ary_of_shots_picked.first.defeated_all_pins?
        frames << Frame.new(ary_of_shots_picked[0])
        shots.unshift(ary_of_shots_picked.last)
      else
        frames << Frame.new(ary_of_shots_picked[0], ary_of_shots_picked[1])
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
