# frozen_string_literal: true

require_relative '../lib/piece'

describe Piece do
  subject(:piece) { described_class.new }
  describe '#valid_move?' do
    context 'when source and destination are valid' do
      it 'returns true' do
        expect(piece.valid_move?([0, 0], [7, 7])).to eq(true)
      end
    end

    context 'when source is valid, destination is not' do
      it 'returns false' do
        expect(piece.valid_move?([-1, 8], [7, 7])).to eq(false)
      end
    end

    context 'when neither the source nor destination are valid' do
      it 'returns false' do
        expect(piece.valid_move?([-1, 8], [8, -1])).to eq(false)
      end
    end
  end
end
