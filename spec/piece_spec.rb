# frozen_string_literal: true

require_relative '../lib/piece'

describe Piece do
  subject(:piece) { described_class }

  describe '::find_qualifier' do
    it 'returns file' do
      expect(piece.find_qualifier('Rab3')).to eq('a')
    end

    it 'returns rank' do
      expect(piece.find_qualifier('N1b3')).to eq('1')
    end

    it 'returns rank and file' do
      expect(piece.find_qualifier('Ba1b3')).to eq([7, 0])
    end

    it 'returns nil with no qualifier' do
      expect(piece.find_qualifier('Rc4')).to be_nil
    end

    context 'when capturing' do
      it 'returns file' do
        expect(piece.find_qualifier('Raxb3')).to eq('a')
      end

      it 'returns rank' do
        expect(piece.find_qualifier('N1xb3')).to eq('1')
      end

      it 'returns rank and file' do
        expect(piece.find_qualifier('Ba1xb3')).to eq([7, 0])
      end

      it 'returns nil with no qualifier' do
        expect(piece.find_qualifier('Rxc4')).to be_nil
      end
    end
  end
end
