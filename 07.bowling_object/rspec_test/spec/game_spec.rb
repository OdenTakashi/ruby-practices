# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Game do
  it 'return_score' do
    args = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'
    game = Game.new(args)
    expect(game.score).to eq 164
  end

  it 'return_score' do
    args = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'
    game = Game.new(args)
    expect(game.score).to eq 107
  end

  it 'return_score' do
    args = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'
    game = Game.new(args)
    expect(game.score).to eq 134
  end

  it 'return_score' do
    args = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8'
    game = Game.new(args)
    expect(game.score).to eq 144
  end

  it 'return_score' do
    args = 'X,X,X,X,X,X,X,X,X,X,X,X'
    game = Game.new(args)
    expect(game.score).to eq 300
  end
end
