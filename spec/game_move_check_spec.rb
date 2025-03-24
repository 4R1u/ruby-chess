# frozen_string_literal: true

require_relative '../lib/game'

describe Game, '#move' do
  subject(:game) { described_class.new }

  context 'when white tries to make a move that would put them in check' do
    before do
      game.move 'e4'
      game.move 'd5'
      game.move 'exd5'
      game.move 'Qxd5'
      game.move 'Be2'
      game.move 'Qe5'
      game.move 'Bf1'
    end

    it 'source has bishop' do
      expect(game.board.board[6][4].piece).to be_a(Bishop)
    end

    it 'destination is empty' do
      expect(game.board.board[7][5].piece).to be_nil
    end

    it "is still white's turn" do
      expect(game.current_player).to eq('white')
    end
  end
end
