# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Frame do
  it 'return_frame_score' do
    frame = Frame.new(1, 9)
    expect(frame.score).to eq 10
  end
end
