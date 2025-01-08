# frozen_string_literal: true

require_relative '../lib/square'
require_relative '../lib/king'
require_relative '../lib/pawn'

describe Square do
  subject(:square) { described_class.new(King.new) }
  describe '#piece=' do
    context 'when the new piece candidate is invalid' do
      before do
        square.piece = 'invalid argument'
      end

      it 'remains unchanged' do
        expect(square.piece).to be_a(King)
      end
    end

    context 'when the new piece is another piece' do
      before do
        square.piece = Pawn.new
      end

      it 'becomes a new piece' do
        expect(square.piece).to be_a(Pawn)
      end
    end

    context 'when the new piece is nil' do
      before do
        square.piece = nil
      end

      it 'square is empty' do
        expect(square.piece).to be_nil
      end
    end
  end
end
