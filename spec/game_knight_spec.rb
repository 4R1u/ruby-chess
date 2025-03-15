# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }

  context 'when moving 2 squares up and left, jumping over a piece' do
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

  context 'when capturing' do
    context 'with x' do
      before do
        game.move 'h4'
        game.move 'a5'
        game.move 'h5'
        game.move 'a4'
        game.move 'h6'
        game.move 'a3'
        game.move 'Nxa3'
      end

      it 'source is empty' do
        expect(game.board.board[7][1].piece).to be_nil
      end

      it 'destination has knight' do
        expect(game.board.board[5][0].piece).to be_a(Knight)
      end
    end

    context 'without x' do
      before do
        game.move 'h4'
        game.move 'a5'
        game.move 'h5'
        game.move 'a4'
        game.move 'h6'
        game.move 'a3'
        game.move 'Na3'
      end

      it 'source is empty' do
        expect(game.board.board[7][1].piece).to be_nil
      end

      it 'destination has knight' do
        expect(game.board.board[5][0].piece).to be_a(Knight)
      end
    end
  end

  context 'when trying to capture an empty square' do
    before do
      game.move 'Nxc3'
    end

    it 'source has knight' do
      expect(game.board.board[7][1].piece).to be_a(Knight)
    end

    it 'destination is empty' do
      expect(game.board.board[5][2].piece).to be_nil
    end
  end
end
