# frozen_string_literal: true

require_relative '../lib/game'

describe Game, '#move' do
  subject(:game) { described_class.new }

  context 'when moving one square up' do
    before do
      game.move 'e4'
      game.move 'e5'
      game.move 'Ke2'
    end

    it 'source is empty' do
      expect(game.board.board[7][4].piece).to be_nil
    end

    it 'destination is empty' do
      expect(game.board.board[6][4].piece).to be_a(King)
    end
  end

  context 'when capturing' do
    context 'with x' do
      before do
        game.move 'e4'
        game.move 'd5'
        game.move 'e5'
        game.move 'd4'
        game.move 'e6'
        game.move 'd3'
        game.move 'exf7'
        game.move 'Kxf7'
      end

      it 'source is empty' do
        expect(game.board.board[0][4].piece).to be_nil
      end

      it 'destination has king' do
        expect(game.board.board[1][5].piece).to be_a(King)
      end
    end

    context 'without x' do
      before do
        game.move 'e4'
        game.move 'd5'
        game.move 'e5'
        game.move 'd4'
        game.move 'e6'
        game.move 'd3'
        game.move 'exf7'
        game.move 'Kf7'
      end

      it 'source is empty' do
        expect(game.board.board[0][4].piece).to be_nil
      end

      it 'destination has king' do
        expect(game.board.board[1][5].piece).to be_a(King)
      end
    end
  end

  context 'when trying to capture an empty square' do
    before do
      game.move 'e4'
      game.move 'e5'
      game.move 'Kxe2'
    end

    it 'source has king' do
      expect(game.board.board[7][4].piece).to be_a(King)
    end

    it 'destination is empty' do
      expect(game.board.board[6][4].piece).to be_nil
    end
  end

  context 'with file of departure marked' do
    before do
      game.move 'e4'
      game.move 'e5'
      game.move 'K1e2'
    end

    it 'source is empty' do
      expect(game.board.board[7][4].piece).to be_nil
    end

    it 'destination has king' do
      expect(game.board.board[6][4].piece).to be_a(King)
    end
  end

  context 'with wrong file of departure marked' do
    before do
      game.move 'e4'
      game.move 'e5'
      game.move 'K3e2'
    end

    it 'source has king' do
      expect(game.board.board[7][4].piece).to be_a(King)
    end

    it 'destination is empty' do
      expect(game.board.board[6][4].piece).to be_nil
    end
  end
end
