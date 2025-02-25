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

  describe '#remove_piece' do
    before do
      board.place_piece([0, 4], King.new)
    end

    it 'removes piece' do
      board.remove_piece([0, 4])
      expect(board.board[0][4].piece).to be_nil
    end

    it 'returns removed piece' do
      expect(board.remove_piece([0, 4])).to be_a(King)
    end
  end

  describe '#move_piece' do
    king = King.new
    before do
      board.place_piece([0, 0], king)
      board.move_piece([0, 0], [0, 4])
    end

    it 'piece is at destination' do
      expect(board.board[0][4].piece).to eq(king)
    end

    it 'source square is empty' do
      expect(board.board[0][0].piece).to be_nil
    end
  end
end
