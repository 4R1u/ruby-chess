# frozen_string_literal: true

require_relative '../lib/game'

describe King, '.legal_moves' do
  context 'when in the middle' do
    it 'has all one-square moves listed' do
      # 1. e4 d5 2. Ke2 dxe4 3. Ke3 a6 4. Kxe4 a5 5. Kf4 Kd7
      g = Game.new
      g.move 'e4'
      g.move 'd5'
      g.move 'Ke2'
      g.move 'dxe4'
      g.move 'Ke3'
      g.move 'a6'
      g.move 'Kxe4'
      g.move 'a5'
      g.move 'Kf4'
      g.move 'Kd7'
      expect(described_class.legal_moves([4, 5], g)).to eq(%w[Kf4f5 Kf4g5 Kf4g4 Kf4g3 Kf4f3 Kf4e3 Kf4e4 Kf4e5])
    end
  end

  context 'when castling both sides is available' do
    it 'has all moves' do
      # 1. d4 d5 2. Bh6 Bh3 3. Qd3 Qd6 4. gxh3 gxh6 5. Bg2 Bg7 6. Nf3 Nf6 7. Nc3 Nc6
      g = Game.new

      g.move 'd4'
      g.move 'd5'

      g.move 'Bh6'
      g.move 'Bh3'

      g.move 'Qd3'
      g.move 'Qd6'

      g.move 'gxh3'
      g.move 'gxh6'

      g.move 'Bg2'
      g.move 'Bg7'

      g.move 'Nf3'
      g.move 'Nf6'

      g.move 'Nc3'
      g.move 'Nc6'

      expect(described_class.legal_moves([7, 4], g)).to eq(%w[Ke1f1 Ke1d1 Ke1d2 O-O O-O-O])
    end
  end
end
