# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shot do
  it 'conversion_X_to_10' do
    shot = Shot.new('X')
    expect(shot.score).to eq 10
  end
end
