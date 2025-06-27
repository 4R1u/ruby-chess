# frozen_string_literal: true

require_relative '../lib/game'

describe Queen, '.legal_moves' do
  context 'when moves in all directions are available' do
    it 'has all moves listed' do
      # 1. e4 d5 2. Qg4 dxe4
      g = Game.new
      g.move 'e4'
      g.move 'd5'
      g.move 'Qg4'
      g.move 'dxe4'
      expect(described_class.legal_moves([4, 6], g)).to eq(%w[Qg4h5 Qg4h3 Qg4f3 Qg4e2 Qg4d1 Qg4f5 Qg4e6 Qg4d7 Qg4xc8 Qg4g5 Qg4g6 Qg4xg7 Qg4h4 Qg4g3 Qg4f4 Qg4xe4])
    end
  end
end
