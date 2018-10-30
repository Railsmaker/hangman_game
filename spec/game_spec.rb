require 'rspec'
require_relative '../lib/game'

describe 'Game' do
  let(:game){ Game.new('ёлка') }

  it 'when the word is solved' do
    expect(game.status).to eq :in_progress
    game.next_step('ё')
    game.next_step('л')
    game.next_step('к')
    game.next_step('а')

    expect(game.errors).to eq 0
    expect(game.solved?).to eq true
    expect(game.max_errors?).to eq false
    expect(game.status).to eq :won
  end

  it 'when the word is solved with errors' do
    expect(game.status).to eq :in_progress
    game.next_step('ё')
    game.next_step('л')
    game.next_step('к')
    game.next_step('ы')
    game.next_step('о')
    game.next_step('а')

    expect(game.errors).to eq 2
    expect(game.solved?).to eq true
    expect(game.max_errors?).to eq false
    expect(game.status).to eq :won
  end

  it 'when the word is solved with errors' do
    expect(game.status).to eq :in_progress
    game.next_step('м')
    game.next_step('о')
    game.next_step('н')
    game.next_step('и')
    game.next_step('т')
    game.next_step('о')
    game.next_step('р')
    game.next_step('ы')

    expect(game.errors).to eq 7
    expect(game.solved?).to eq false
    expect(game.max_errors?).to eq true
    expect(game.status).to eq :lost
  end
end