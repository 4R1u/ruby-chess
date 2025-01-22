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
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    setup_board
    @current_player = 'white'
  end

  def move(str)
    dst = find_destination(str)
    src = find_source_pawn(dst)
    return unless src && dst

    @board.move_piece(src, dst)
    @current_player = %w[white black].find { |player| player != @current_player }
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

  def find_destination(str)
    [8 - str[-1].to_i, str[-2].ord - 'a'.ord]
  end

  def find_source_pawn(dst)
    src = [dst[0] + (@current_player == 'white' ? 1 : -1), dst[1]]
    return src if find_pawn_source_one_square_behind(src)

    [src[0] + 1, src[1]] if find_pawn_source_two_squares_behind(src)
  end

  def find_pawn_source_one_square_behind(src)
    @board.board[src[0]][src[1]].piece.is_a?(Pawn)
  end

  def find_pawn_source_two_squares_behind(src)
    @board.board[src[0] + (@current_player == 'white' ? 1 : -1)][src[1]].piece.is_a?(Pawn)
  end
end
