# frozen_string_literal: true

require_relative '../lib/game'

describe Game, '#move' do
  subject(:game) { described_class.new }

  context 'when moving up' do
    before do
      game.move 'd4'
      game.move 'd5'
      game.move 'Qd3'
      game.move 'a5'
    end

    it 'source is empty' do
      expect(game.board.board[7][3].piece).to be_nil
    end

    it 'destination has queen' do
      expect(game.board.board[5][3].piece).to be_a(Queen)
    end

    context 'when moving back down' do
      before do
        game.move 'Qd1'
      end

      it 'source is empty' do
        expect(game.board.board[5][3].piece).to be_nil
      end

      it 'destination has queen' do
        expect(game.board.board[7][3].piece).to be_a(Queen)
      end
    end

    context 'when moving right' do
      before do
        game.move 'Qe3'
      end

      it 'source is empty' do
        expect(game.board.board[5][3].piece).to be_nil
      end

      it 'destination has queen' do
        expect(game.board.board[5][4].piece).to be_a(Queen)
      end
    end

    context 'when moving left' do
      before do
        game.move 'Qc3'
      end

      it 'source is empty' do
        expect(game.board.board[5][3].piece).to be_nil
      end

      it 'destination has queen' do
        expect(game.board.board[5][2].piece).to be_a(Queen)
      end
    end
  end

  context 'when moving north-east' do
    before do
      game.move 'e4'
      game.move 'd5'
      game.move 'Qg4'
      game.move 'dxe4'
    end

    it 'source is empty' do
      expect(game.board.board[7][3].piece).to be_nil
    end

    it 'destination has queen' do
      expect(game.board.board[4][6].piece).to be_a(Queen)
    end

    context 'when moving south-east' do
      before do
        game.move 'Qh3'
      end

      it 'source is empty' do
        expect(game.board.board[4][6].piece).to be_nil
      end

      it 'destination has queen' do
        expect(game.board.board[5][7].piece).to be_a(Queen)
      end
    end

    context 'when moving back south-west' do
      before do
        game.move 'Qd1'
      end

      it 'source is empty' do
        expect(game.board.board[4][6].piece).to be_nil
      end

      it 'destination has queen' do
        expect(game.board.board[7][3].piece).to be_a(Queen)
      end
    end
  end

  context 'when moving northwest' do
    before do
      game.move 'c4'
      game.move 'c5'
      game.move 'Qa4'
    end

    it 'source is empty' do
      expect(game.board.board[7][3].piece).to be_nil
    end

    it 'destination has queen' do
      expect(game.board.board[4][0].piece).to be_a(Queen)
    end
  end

  context 'when trying to move over a piece' do
    before do
      game.move 'Qd3'
    end

    it 'source has queen' do
      expect(game.board.board[7][3].piece).to be_a(Queen)
    end

    it 'destination is empty' do
      expect(game.board.board[5][0].piece).to be_nil
    end
  end

  context 'when trying to move off the board' do
    before do
      game.move 'Q`0'
      game.move 'Qi9'
      game.move 'Q`1'
    end

    it "is still white's turn" do
      expect(game.current_player).to eq('white')
    end
  end
end
