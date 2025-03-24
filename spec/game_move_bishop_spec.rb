# frozen_string_literal: true

require_relative '../lib/game'

describe Game, '#move' do
  subject(:game) { described_class.new }

  context 'when moving up and to the right' do
    before do
      game.move 'd4'
      game.move 'a5'
      game.move 'Be3'
    end

    it 'source is empty' do
      expect(game.board.board[7][2].piece).to be_nil
    end

    it 'destination has bishop' do
      expect(game.board.board[5][4].piece).to be_a(Bishop)
    end
  end

  context 'when moving up and to the left' do
    before do
      game.move 'b4'
      game.move 'd5'
      game.move 'Ba3'
    end

    it 'source is empty' do
      expect(game.board.board[7][2].piece).to be_nil
    end

    it 'destination has bishop' do
      expect(game.board.board[5][0].piece).to be_a(Bishop)
    end
  end

  context 'when moving down and to the left' do
    before do
      game.move 'b4'
      game.move 'b5'
      game.move 'a4'
      game.move 'Ba6'
    end

    it 'source is empty' do
      expect(game.board.board[0][2].piece).to be_nil
    end

    it 'destination has bishop' do
      expect(game.board.board[2][0].piece).to be_a(Bishop)
    end
  end

  context 'when moving down and to the right' do
    before do
      game.move 'b4'
      game.move 'd5'
      game.move 'a4'
      game.move 'Be6'
    end

    it 'source is empty' do
      expect(game.board.board[0][2].piece).to be_nil
    end

    it 'destination has bishop' do
      expect(game.board.board[2][4].piece).to be_a(Bishop)
    end
  end

  context 'when trying to move over another piece' do
    before do
      game.move 'Be3'
    end

    it 'source has bishop' do
      expect(game.board.board[7][2].piece).to be_a(Bishop)
    end

    it 'destination is empty' do
      expect(game.board.board[5][4].piece).to be_nil
    end
  end

  context 'with rank of departure marked' do
    before do
      game.move 'd4'
      game.move 'a5'
      game.move 'B1e3'
    end

    it 'source is empty' do
      expect(game.board.board[7][2].piece).to be_nil
    end

    it 'destination has bishop' do
      expect(game.board.board[5][4].piece).to be_a(Bishop)
    end
  end

  context 'with wrong rank of departure marked' do
    before do
      game.move 'd4'
      game.move 'a5'
      game.move 'B2e3'
    end

    it 'source has bishop' do
      expect(game.board.board[7][2].piece).to be_a(Bishop)
    end

    it 'destination is empty' do
      expect(game.board.board[5][4].piece).to be_nil
    end
  end

  context 'when trying to move off the board' do
    before do
      game.move 'B`0'
      game.move 'Bi9'
      game.move 'B`1'
    end

    it "is still white's turn" do
      expect(game.current_player).to eq('white')
    end
  end
end
