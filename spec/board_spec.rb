# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/king'

describe Board do
  subject(:board) { described_class.new }
  describe '#place_piece' do
    king = King.new(black: true)
    before do
      board.place_piece([0, 4], king)
    end

    it 'places piece' do
      expect(board.board[0][4].piece).to eq(king)
    end
  end
end
