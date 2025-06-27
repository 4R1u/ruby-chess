# frozen_string_literal: true

require_relative '../lib/game'

describe Game, '#check?' do
  subject(:game) { described_class.new }

  context 'when there is no checkmate' do
    it 'returns false' do
      expect(game.checkmate?).to be(false)
    end
  end

  context 'when there is a checkmate' do
    before do
      game_moves = %w[e4 e5 Nf3 d6 d4 Bg4 dxe5 Bxf3 Qxf3 dxe5 Bc4 Nf6 Qb3 Qe7 Nc3 c6 Bg5 b5 Nxb5 cxb5 Bxb5+ Nbd7 O-O-O Rd8 Rxd7 Rxd7 Rd1 Qe6 Bxd7+ Nxd7 Qb8+ Nxb8 Rd8]
      game_moves.each { |i| game.move i }
    end

    it 'returns true' do
      expect(game.checkmate?).to be(true)
    end
  end
end
