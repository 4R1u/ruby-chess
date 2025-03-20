# frozen_string_literal: true

require_relative '../lib/piece'

describe Piece do
  subject(:piece) { described_class }

  describe '::find_qualifier' do
    context 'with a Rook' do
      it 'returns file' do
        expect(piece.find_qualifier('Rab3')).to eq('a')
      end

      it 'returns rank' do
        expect(piece.find_qualifier('R1b3')).to eq('1')
      end

      it 'returns rank and file' do
        expect(piece.find_qualifier('Ra1b3')).to eq([7, 0])
      end
    end

    context 'with a Knight'
    context 'with a Bishop'
  end
end
