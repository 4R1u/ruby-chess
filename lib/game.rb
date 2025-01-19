# frozen_string_literal: true

require_relative 'piece'
require_relative 'square'
require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'board'

# A hopefully near-blackbox match of chess
# but which exposes the board for easy access.
class Game
  attr_reader :board

  def initialize
    @board = Board.new
    setup_board
  end

  private

  def setup_board
    clear_all_pieces
    setup_white_pieces
    setup_black_pieces
  end

  def clear_all_pieces
    @board = Board.new
  end

  def setup_white_pieces
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    8.times do |index|
      @board.place_piece([6, index], Pawn.new(black: false))
      @board.place_piece([7, index], back_row[index].new(black: false))
    end
  end

  def setup_black_pieces
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    8.times do |index|
      @board.place_piece([0, index], back_row[index].new(black: true))
      @board.place_piece([1, index], Pawn.new(black: true))
    end
  end
end
