# frozen_string_literal: true

require_relative '../lib/game'

describe Knight, '.legal_moves' do
  context 'when in the middle' do
    it 'has all moves listed' do
      # 1. Nc3 e5 2. Nd5 e4 3. c3 d6
      g = Game.new
      g.move 'Nc3'
      g.move 'e5'
      g.move 'Nd5'
      g.move 'e4'
      g.move 'c3'
      g.move 'f6'
      expect(described_class.legal_moves([3, 3], g)).to eq(%w[Nd5e7 Nd5xf6 Nd5f4 Nd5e3 Nd5b4 Nd5b6 Nd5xc7])
    end
  end

  context 'on the edge of the board' do
    g = Game.new
    it 'has only valid moves' do
      expect(described_class.legal_moves([7, 1], g)).to eq(%w[Nb1c3 Nb1a3])
    end
  end
end
