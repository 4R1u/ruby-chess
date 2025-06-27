# frozen_string_literal: true

require_relative '../lib/game'

describe Rook, '.legal_moves' do
  context 'when in the middle' do
    it 'has all moves listed' do
      # 1. a4 b5 2. axb5 c6 3. Ra4 c5 4. Re4 c4
      g = Game.new
      g.move 'a4'
      g.move 'b5'
      g.move 'axb5'
      g.move 'c6'
      g.move 'Ra4'
      g.move 'c5'
      g.move 'Re4'
      g.move 'c4'
      expect(described_class.legal_moves([4, 4], g)).to eq(%w[Re4e5 Re4e6 Re4xe7 Re4f4 Re4g4 Re4h4 Re4e3 Re4d4 Re4xc4])
    end
  end
end
