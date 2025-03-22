# frozen_string_literal: true

require_relative '../lib/game'

describe Game, '#move' do
  subject(:game) { described_class.new }

  context 'when moving validly' do
    context 'when moving up' do
      before do
        game.move 'a4'
        game.move 'a5'
        game.move 'Ra3'
      end

      it 'source is empty' do
        expect(game.board.board[7][0].piece).to be_nil
      end

      it 'destination has rook' do
        expect(game.board.board[5][0].piece).to be_a(Rook)
      end
    end

    context 'when moving down' do
      before do
        game.move 'a4'
        game.move 'a5'
        game.move 'Ra3'
        game.move 'b5'
        game.move 'Ra1'
      end

      it 'source is empty' do
        expect(game.board.board[5][0].piece).to be_nil
      end

      it 'destination has rook' do
        expect(game.board.board[7][0].piece).to be_a(Rook)
      end
    end

    context 'when moving left' do
      before do
        game.move 'a4'
        game.move 'a5'
        game.move 'Ra3'
        game.move 'b5'
        game.move 'Rf3'
      end

      it 'source is empty' do
        expect(game.board.board[5][0].piece).to be_nil
      end

      it 'destination has rook' do
        expect(game.board.board[5][5].piece).to be_a(Rook)
      end
    end

    context 'when moving right' do
      before do
        game.move 'a4'
        game.move 'a5'
        game.move 'Ra3'
        game.move 'b5'
        game.move 'Rf3'
        game.move 'b4'
        game.move 'Ra3'
      end

      it 'source is empty' do
        expect(game.board.board[5][5].piece).to be_nil
      end

      it 'destination has rook' do
        expect(game.board.board[5][0].piece).to be_a(Rook)
      end
    end

    context 'when capturing' do
      before do
        game.move 'a4'
        game.move 'b5'
        game.move 'b4'
        game.move 'bxa4'
      end

      context 'with x' do
        before do
          game.move 'Rxa4'
        end

        it 'source is empty' do
          expect(game.board.board[7][0].piece).to be_nil
        end

        it 'destination has rook' do
          expect(game.board.board[4][0].piece).to be_a(Rook)
        end
      end

      context 'without x' do
        before do
          game.move 'Ra4'
        end

        it 'source is empty' do
          expect(game.board.board[7][0].piece).to be_nil
        end

        it 'destination has rook' do
          expect(game.board.board[4][0].piece).to be_a(Rook)
        end
      end
    end

    context 'when making a disambiguated move' do
      before do
        game.move 'a4'
        game.move 'b5'
        game.move 'Ra3'
        game.move 'a5'
        game.move 'h4'
        game.move 'b4'
        game.move 'Rah3'
      end

      it 'rook on same rank is gone' do
        expect(game.board.board[5][0].piece).to be_nil
      end

      it 'rook on same file is still there' do
        expect(game.board.board[7][7].piece).to be_a(Rook)
      end

      it 'destination has rook' do
        expect(game.board.board[5][7].piece).to be_a(Rook)
      end
    end
  end

  context 'when trying to move invalidly' do
    context 'when trying to jump over pieces' do
      before do
        game.move 'a4'
        game.move 'b5'
        game.move 'Ra5'
      end

      it 'source has rook' do
        expect(game.board.board[7][0].piece).to be_a(Rook)
      end

      it 'destination is empty' do
        expect(game.board.board[3][0].piece).to be_nil
      end
    end

    context 'when trying to move diagonally' do
      before do
        game.move 'a4'
        game.move 'b5'
        game.move 'Ra3'
        game.move 'b4'
        game.move 'Rc5'
      end

      it 'source has rook' do
        expect(game.board.board[5][0].piece).to be_a(Rook)
      end

      it 'destination has no rook' do
        expect(game.board.board[3][2].piece).not_to be_a(Rook)
      end
    end

    context 'when trying to capture a friendly piece' do
      before do
        game.move 'a4'
        game.move 'b5'
        game.move 'Rxa4'
      end

      it 'source has rook' do
        expect(game.board.board[7][0].piece).to be_a(Rook)
      end

      it 'destination has a pawn' do
        expect(game.board.board[4][0].piece).to be_a(Pawn)
      end
    end

    context 'when using the x notation without capturing' do
      before do
        game.move 'a4'
        game.move 'b5'
        game.move 'Rxa3'
      end

      it 'source has rook' do
        expect(game.board.board[7][0].piece).to be_a(Rook)
      end

      it 'destination is empty' do
        expect(game.board.board[5][0].piece).to be_nil
      end
    end

    context 'when trying to capture with th x notation wrongly' do
      before do
        game.move 'a4'
        game.move 'b5'
        game.move 'b4'
        game.move 'bxa4'
      end

      context 'with x before R' do
        before do
          game.move 'xRa4'
        end

        it 'source has rook' do
          expect(game.board.board[7][0].piece).to be_a(Rook)
        end

        it 'destination has no rook' do
          expect(game.board.board[4][0].piece).not_to be_a(Rook)
        end
      end

      context 'with x before rank' do
        before do
          game.move 'Rax4'
        end

        it 'source has rook' do
          expect(game.board.board[7][0].piece).to be_a(Rook)
        end

        it 'destination has no rook' do
          expect(game.board.board[4][0].piece).not_to be_a(Rook)
        end
      end
    end

    context 'when making an ambiguous move' do
      before do
        game.move 'a4'
        game.move 'b5'
        game.move 'Ra3'
        game.move 'a5'
        game.move 'h4'
        game.move 'b4'
        game.move 'Rh3'
      end

      it 'rook on same rank is still there' do
        expect(game.board.board[5][0].piece).to be_a(Rook)
      end

      it 'rook on same file is still there' do
        expect(game.board.board[7][7].piece).to be_a(Rook)
      end

      it 'destination is empty' do
        expect(game.board.board[5][7].piece).to be_nil
      end
    end

    context 'with wrong starting file' do
      before do
        game.move 'a4'
        game.move 'b5'
        game.move 'Ra3'
        game.move 'a5'
        game.move 'h4'
        game.move 'b4'
        game.move 'Rbh3'
      end

      it 'rook on same rank is still there' do
        expect(game.board.board[5][0].piece).to be_a(Rook)
      end

      it 'rook on same file is still there' do
        expect(game.board.board[7][7].piece).to be_a(Rook)
      end

      it 'destination is empty' do
        expect(game.board.board[5][7].piece).to be_nil
      end
    end
  end
end
