# frozen_string_literal: true

class Game

  def initialize(marks)
    @frames = build_frames(marks)
  end

  def score
    @frames.each_with_index.sum do |frame, idx|
      final_frame?(idx) ? frame.final_score : not_final_frame_score(frame, @frames, idx)
    end
  end

  private

  def build_frames(args)
    marks = args.split(',')
    shots = marks.map { |mark| Shot.new(mark) }

    frames = []
    9.times do
      frame = shots.shift(2)
      if frame.first.strike?
        frames << [10, nil]
        shots.unshift(frame.last)
      else
        frames << frame
      end
    end
    frames << shots.map(&:score)
    frames.map { |frame| Frame.new(frame[0], frame[1], frame[2]) }
  end

  def final_frame?(frame_number)
    frame_number == 9
  end

  def point_of_strike(frame, frames, idx)
    if frames[idx + 1].strike? && !frames[idx + 2].nil?
      frame.score + frames[idx + 1].score + frames[idx + 2].first_shot.score
    else
      frame.score + frames[idx + 1].score
    end
  end

  def point_of_spare(frame, frames, idx)
    frame.score + frames[idx + 1].first_shot.score
  end

  def not_final_frame_score(frame, frames, idx)
    if frame.strike?
      point_of_strike(frame, frames, idx)
    elsif frame.spare?
      point_of_spare(frame, frames, idx)
    else
      frame.score
    end
  end
end
