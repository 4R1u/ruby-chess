# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }

  context 'when knight moves' do
    context 'when moving 2 squares up and left' do
      before do
        game.move 'Nc3'
      end

      it 'source is empty' do
        expect(game.board.board[7][1].piece).to be_nil
      end

      it 'destination has knight' do
        expect(game.board.board[5][2].piece).to be_a(Knight)
      end
    end
  end
end
