# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }

  describe '#move for pawn' do
    context 'when white pawn moves forward one square' do
      before do
        game.move('e3')
      end

      it 'pawn is at destination' do
        expect(game.board.board[5][4].piece).to be_a(Pawn)
      end

      it 'source is empty' do
        expect(game.board.board[6][4].piece).to be_nil
      end

      it 'current player has become black' do
        expect(game.current_player).to eq('black')
      end
    end

    context 'white pawn moves forward two squares' do
      context 'white pawn has not moven' do
        before do
          game.move('e4')
        end

        it 'pawn is at destination' do
          expect(game.board.board[4][4].piece).to be_a(Pawn)
        end

        it 'source is empty' do
          expect(game.board.board[6][4].piece).to be_nil
        end

        it 'current player has become black' do
          expect(game.current_player).to eq('black')
        end
      end

      context 'white pawn has moven' do
        before do
          game.move('e3')
          game.move('e6')
          game.move('e5')
        end

        it 'pawn is at source' do
          expect(game.board.board[5][4].piece).to be_a(Pawn)
        end

        it 'current player is still white' do
          expect(game.current_player).to eq('white')
        end
      end

      context 'when there is a pawn in front' do
        before do
          game.move 'e4'
          game.move 'd5'
          game.move 'e5'
          game.move 'd4'
          game.move 'e6'
          game.move 'd3'
          game.move 'd4'
        end

        it 'pawn at source is white' do
          expect(game.board.board[6][3].piece.black).to be(false)
        end

        it 'destination is empty' do
          expect(game.board.board[4][3].piece).to be_nil
        end

        it 'pawn in front is black' do
          expect(game.board.board[5][3].piece.black).to be(true)
        end
      end
    end

    context 'black pawn moves forward one square' do
      before do
        game.move('e3')
        game.move('e6')
      end

      it 'pawn is at destination' do
        expect(game.board.board[2][4].piece).to be_a(Pawn)
      end

      it 'source is empty' do
        expect(game.board.board[1][4].piece).to be_nil
      end

      it 'current player is white again' do
        expect(game.current_player).to eq('white')
      end
    end

    context 'black pawn moves forward two squares' do
      context 'black pawn has not moven' do
        before do
          game.move('e3')
          game.move('e5')
        end

        it 'pawn is at destination' do
          expect(game.board.board[3][4].piece).to be_a(Pawn)
        end

        it 'source is empty' do
          expect(game.board.board[1][4].piece).to be_nil
        end

        it 'current player has become white' do
          expect(game.current_player).to eq('white')
        end
      end

      context 'black pawn has moven' do
        before do
          game.move('e3')
          game.move('e6')
          game.move('d3')
          game.move('e4')
        end

        it 'pawn is at source' do
          expect(game.board.board[2][4].piece).to be_a(Pawn)
        end

        it 'current player is still black' do
          expect(game.current_player).to eq('black')
        end
      end

      context 'when there is a pawn in front' do
        before do
          game.move 'e4'
          game.move 'd5'
          game.move 'e5'
          game.move 'd4'
          game.move 'e6'
          game.move 'd3'
          game.move 'd4'
          game.move 'e5'
        end

        it 'pawn at source is black' do
          expect(game.board.board[1][4].piece.black).to be(true)
        end

        it 'destination is empty' do
          expect(game.board.board[3][4].piece).to be_nil
        end

        it 'pawn in front is white' do
          expect(game.board.board[2][4].piece.black).to be(false)
        end
      end
    end

    context 'white pawn tries to move forward three squares' do
      before do
        game.move('e5')
      end

      it 'pawn is at source' do
        expect(game.board.board[6][4].piece).to be_a(Pawn)
      end

      it 'current player remains white' do
        expect(game.current_player).to eq('white')
      end
    end

    context 'white pawn tries to move forward four squares' do
      before do
        game.move('e6')
      end

      it 'pawn is at source' do
        expect(game.board.board[6][4].piece).to be_a(Pawn)
      end

      it 'current player remains white' do
        expect(game.current_player).to eq('white')
      end
    end

    context 'testing capture' do
      context 'white pawn captures black pawn normally' do
        before do
          game.move('d4')
          game.move('e5')
        end

        context 'using the x abbreviation' do
          before do
            game.move('dxe5')
          end

          it 'pawn at destination is white' do
            expect(game.board.board[3][4].piece.black).to be(false)
          end

          it 'source is empty' do
            expect(game.board.board[4][3].piece).to be_nil
          end
        end

        context 'without the x abbreviation' do
          before do
            game.move('de5')
          end

          it 'pawn at destination is white' do
            expect(game.board.board[3][4].piece.black).to be(false)
          end

          it 'source is empty' do
            expect(game.board.board[4][3].piece).to be_nil
          end
        end

        context 'using the x abbreviation wrongly' do
          before do
            game.move('xde5')
          end

          it 'pawn at destination is black' do
            expect(game.board.board[3][4].piece.black).to be(true)
          end

          it 'pawn at source is white' do
            expect(game.board.board[4][3].piece.black).to be(false)
          end
        end
      end

      context 'black pawn captures white pawn' do
        before do
          game.move('d3')
          game.move('e5')
          game.move('d4')
        end

        context 'using the x abbreviation' do
          before do
            game.move('exd4')
          end

          it 'pawn at destination is black' do
            expect(game.board.board[4][3].piece.black).to be(true)
          end

          it 'source is empty' do
            expect(game.board.board[3][4].piece).to be_nil
          end
        end

        context 'without the x abbreviation' do
          before do
            game.move('ed4')
          end

          it 'pawn at destination is black' do
            expect(game.board.board[4][3].piece.black).to be(true)
          end

          it 'source is empty' do
            expect(game.board.board[3][4].piece).to be_nil
          end
        end

        context 'using the x abbreviation wrongly' do
          before do
            game.move('xed4')
          end

          it 'pawn at destination is white' do
            expect(game.board.board[4][3].piece.black).to be(false)
          end

          it 'pawn at source is black' do
            expect(game.board.board[3][4].piece.black).to be(true)
          end
        end
      end

      context 'white pawn tries to capture white pawn' do
        before do
          game.move('e3')
          game.move('e6')
          game.move('dxe3')
        end

        it 'pawn at source is white' do
          expect(game.board.board[6][3].piece.black).to be(false)
        end

        it 'pawn at destination is white' do
          expect(game.board.board[5][4].piece.black).to be(false)
        end

        it 'current player is still white' do
          expect(game.current_player).to eq('white')
        end
      end

      context 'black pawn tries to capture black pawn' do
        before do
          game.move('e3')
          game.move('e6')
          game.move('e4')
          game.move('fxe6')
        end

        it 'pawn at source is black' do
          expect(game.board.board[1][5].piece.black).to be(true)
        end

        it 'pawn at destination is black' do
          expect(game.board.board[2][4].piece.black).to be(true)
        end

        it 'current player is still black' do
          expect(game.current_player).to eq('black')
        end
      end

      context 'white pawn tries to capture black pawn in front of it' do
        before do
          game.move('e4')
          game.move('e5')
        end

        context 'using capture notation' do
          before do
            game.move('exe5')
          end

          it 'pawn at source is white' do
            expect(game.board.board[4][4].piece.black).to be(false)
          end

          it 'pawn at destination is black' do
            expect(game.board.board[3][4].piece.black).to be(true)
          end
        end

        context 'without capture notation' do
          before do
            game.move('e5')
          end

          it 'pawn at source is white' do
            expect(game.board.board[4][4].piece.black).to be(false)
          end

          it 'pawn at destination is black' do
            expect(game.board.board[3][4].piece.black).to be(true)
          end
        end
      end

      context 'black pawn tries to capture white pawn in front of it' do
        before do
          game.move('e4')
          game.move('e5')
          game.move('d3')
        end

        context 'using capture notation' do
          before do
            game.move('exe4')
          end

          it 'pawn at source is black' do
            expect(game.board.board[3][4].piece.black).to be(true)
          end

          it 'pawn at destination is white' do
            expect(game.board.board[4][4].piece.black).to be(false)
          end
        end

        context 'without capture notation' do
          before do
            game.move('e4')
          end

          it 'pawn at source is black' do
            expect(game.board.board[3][4].piece.black).to be(true)
          end

          it 'pawn at destination is white' do
            expect(game.board.board[4][4].piece.black).to be(false)
          end
        end
      end

      context 'white pawn tries to move into empty square with x abbreviation' do
        context 'moving straight ahead' do
          before do
            game.move('exe3')
          end

          it 'piece at source is pawn' do
            expect(game.board.board[6][4].piece).to be_a(Pawn)
          end

          it 'destination is empty' do
            expect(game.board.board[5][4].piece).to be_nil
          end
        end

        context 'moving left' do
          before do
            game.move('fxe3')
          end

          it 'piece at source is pawn' do
            expect(game.board.board[6][5].piece).to be_a(Pawn)
          end

          it 'destination is empty' do
            expect(game.board.board[5][4].piece).to be_nil
          end
        end
      end

      context 'en passant captures' do
        before do
          game.move('e4')
          game.move('a5')
          game.move('e5')
          game.move('a4')
        end

        context 'white pawn captures black pawn' do
          before do
            game.move('h3')
            game.move('f5')
          end

          context 'with e.p. notation' do
            before do
              game.move('exf6 e.p.')
            end

            it 'pawn at destination is white' do
              expect(game.board.board[2][5].piece.black).to be(false)
            end

            it 'source is empty' do
              expect(game.board.board[3][4].piece).to be_nil
            end

            it 'black pawn captured' do
              expect(game.board.board[3][5].piece).to be_nil
            end
          end

          context 'without e.p. notation' do
            before do
              game.move('exf6')
            end

            it 'pawn at destination is white' do
              expect(game.board.board[2][5].piece.black).to be(false)
            end

            it 'source is empty' do
              expect(game.board.board[3][4].piece).to be_nil
            end

            it 'black pawn captured' do
              expect(game.board.board[3][5].piece).to be_nil
            end
          end
        end

        context 'black pawn captures white pawn' do
          before do
            game.move('b4')
          end

          context 'with e.p. notation' do
            before do
              game.move('axb3 e.p.')
            end

            it 'pawn at destination is black' do
              expect(game.board.board[5][1].piece.black).to be(true)
            end

            it 'source is empty' do
              expect(game.board.board[4][0].piece).to be_nil
            end

            it 'white pawn captured' do
              expect(game.board.board[4][1].piece).to be_nil
            end
          end

          context 'without e.p. notation' do
            before do
              game.move('axb3')
            end

            it 'pawn at destination is black' do
              expect(game.board.board[5][1].piece.black).to be(true)
            end

            it 'source is empty' do
              expect(game.board.board[4][0].piece).to be_nil
            end

            it 'white pawn captured' do
              expect(game.board.board[4][1].piece).to be_nil
            end
          end
        end
      end
    end
  end
end
