# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }
  describe '#move' do
    describe 'testing pawn moves' do
      context 'white pawn moves forward one square' do
        before do
          game.move('e3')
        end

        it 'pawn is at destination' do
          expect(game.board.board[5][4].piece).to be_a(Pawn)
        end

        it 'source is empty' do
          expect(game.board.board[6][4].piece).to be_nil
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
        end
      end

      context 'white pawn tries to move forward three squares' do
        before do
          game.move('e5')
        end

        it 'pawn is at source' do
          expect(game.board.board[6][4].piece).to be_a(Pawn)
        end
      end
    end
  end
end
