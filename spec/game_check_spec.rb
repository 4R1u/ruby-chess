# frozen_string_literal: true

require_relative '../lib/game'

describe Game, '#check?' do
  subject(:game) { described_class.new }

  context 'when there is no check' do
    it 'returns false' do
      expect(game.check?).to be(false)
    end
  end

  context 'when black king is in check' do
    before do
      game.move 'Nc3'
      game.move 'a5'
      game.move 'Nd5'
      game.move 'a4'
    end

    context 'with + notation' do
      before do
        game.move 'Nf6+'
      end

      it 'returns true' do
        expect(game.check?).to be(true)
      end
    end

    context 'without + notation' do
      before do
        game.move 'Nf6'
      end

      it 'returns true' do
        expect(game.check?).to be(true)
      end
    end
  end
end
