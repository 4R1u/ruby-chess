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

  context 'when white makes a move that puts black in check' do
    before do
      game.move 'Nc3'
      game.move 'a5'
      game.move 'Nd5'
      game.move 'a4'
    end

    context 'with +' do
      before do
        game.move 'Nf6+'
      end

      it 'destination has knight' do
        expect(game.board.board[2][5].piece).to be_a Knight
      end

      it 'source is empty' do
        expect(game.board.board[3][3].piece).to be_nil
      end

      it 'black is in check' do
        expect(game).to be_check
      end
    end

    context 'without +' do
      before do
        game.move 'Nf6'
      end

      it 'destination has knight' do
        expect(game.board.board[2][5].piece).to be_a Knight
      end

      it 'source is empty' do
        expect(game.board.board[3][3].piece).to be_nil
      end

      it 'black is in check' do
        expect(game).to be_check
      end
    end
  end

  context 'when white makes a move with a knight that does NOT put black in check' do
    context 'with +' do
      before do
        game.move 'Nc3+'
      end

      it 'destination is empty' do
        expect(game.board.board[5][2].piece).to be_nil
      end

      it 'source has knight' do
        expect(game.board.board[7][1].piece).to be_a Knight
      end
    end

    context 'without +' do
      before do
        game.move 'Nc3'
      end

      it 'destination has knight' do
        expect(game.board.board[5][2].piece).to be_a Knight
      end

      it 'source is empty' do
        expect(game.board.board[7][1].piece).to be_nil
      end
    end
  end

  context 'when making a move with a pawn that does NOT put black in check' do
    context 'with +' do
      before do
        game.move 'e4+'
      end

      it 'destination is empty' do
        expect(game.board.board[4][4].piece).to be_nil
      end

      it 'source has pawn' do
        expect(game.board.board[6][4].piece).to be_a Pawn
      end
    end

    context 'without +' do
      before do
        game.move 'e4'
      end

      it 'destination has pawn' do
        expect(game.board.board[4][4].piece).to be_a Pawn
      end

      it 'source is empty' do
        expect(game.board.board[6][4].piece).to be_nil
      end
    end
  end
end
