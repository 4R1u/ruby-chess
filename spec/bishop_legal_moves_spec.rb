# frozen_string_literal: true

require_relative '../lib/game'

describe Bishop, '.legal_moves' do
  context 'when moves in all directions are available' do
    it 'has all moves listed' do
      # 1. d4 d5 2. Bf4 e6
      g = Game.new
      g.move 'd4'
      g.move 'd5'
      g.move 'Bf4'
      g.move 'e6'
      expect(described_class.legal_moves([4, 5], g)).to eq(%w[Bf4g5 Bf4h6 Bf4g3 Bf4e3 Bf4d2 Bf4c1 Bf4e5 Bf4d6 Bf4xc7])
    end
  end
end
