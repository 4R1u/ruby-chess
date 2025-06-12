# frozen_string_literal: true

require_relative '../lib/game'

describe Game, '#move' do
  subject(:game) { described_class.new }

  context 'when white castles kingside' do
    before do
      # 1. g4 g5 2. Nh3 h5 3. Bg2 h4 4. O-O
      game.move 'g4'
      game.move 'g5'
      game.move 'Nh3'
      game.move 'h5'
      game.move 'Bg2'
      game.move 'h4'
      game.move 'O-O'
    end

    it 'king source is empty' do
      expect(game.board.board[7][4].piece).to be_nil
    end

    it 'king destination has king' do
      expect(game.board.board[7][6].piece).to be_a King
    end

    it 'rook source is empty' do
      expect(game.board.board[7][7].piece).to be_nil
    end

    it 'rook destination has rook' do
      expect(game.board.board[7][5].piece).to be_a Rook
    end
  end

  context 'when black castles queenside' do
    before do
      # 1. e4 b5 2. e5 Nc6 3. e6 Ba6 4. exd7+ Qxd7 5. a4 O-O-O
      game.move 'e4'
      game.move 'b5'

      game.move 'e5'
      game.move 'Nc6'

      game.move 'e6'
      game.move 'Ba6'

      game.move 'exd7+'
      game.move 'Qxd7'

      game.move 'a4'
      game.move 'O-O-O'
    end

    it 'king source is empty' do
      expect(game.board.board[0][4].piece).to be_nil
    end

    it 'king destination has king' do
      expect(game.board.board[0][2].piece).to be_a King
    end

    it 'rook source is empty' do
      expect(game.board.board[0][0].piece).to be_nil
    end

    it 'rook destination has rook' do
      expect(game.board.board[0][3].piece).to be_a Rook
    end
  end

  context 'when pieces are in the way' do
    before do
      game.move 'O-O'
    end

    it 'king is at source' do
      expect(game.board.board[7][4].piece).to be_a King
    end

    it 'rook is at source' do
      expect(game.board.board[7][7].piece).to be_a Rook
    end

    it 'knight is at its usual location' do
      expect(game.board.board[7][6].piece).to be_a Knight
    end

    it 'bishop is at its usual location' do
      expect(game.board.board[7][5].piece).to be_a Bishop
    end

    it 'no moves recorded' do
      expect(game.moves).to be_empty
    end

    it "is still white's turn" do
      expect(game.current_player).to eq('white')
    end
  end

  context 'when the king has moved' do
    before do
      # 1. g4 g5 2. Nf3 Nf6 3. Bh3 Bh6 4. e4 e5 5. Ke2 Ng8 6. Ke1 f5 7. O-O
      game.move 'g4'
      game.move 'g5'
      game.move 'Nf3'
      game.move 'Nf6'
      game.move 'Bh3'
      game.move 'Bh6'
      game.move 'e4'
      game.move 'e5'
      game.move 'Ke2'
      game.move 'Ng8'
      game.move 'Ke1'
      game.move 'f5'
      game.move 'O-O'
    end

    it 'king is at source' do
      expect(game.board.board[7][4].piece).to be_a King
    end

    it 'rook is at source' do
      expect(game.board.board[7][7].piece).to be_a Rook
    end

    it 'knight location is empty' do
      expect(game.board.board[7][6].piece).to be_nil
    end

    it 'bishop location is empty' do
      expect(game.board.board[7][5].piece).to be_nil
    end

    it 'no moves recorded' do
      expect(game.moves[-1]).not_to eq('O-O')
    end

    it "is still white's turn" do
      expect(game.current_player).to eq('white')
    end
  end
end
