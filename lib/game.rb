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
    @moves = []
  end

  def move(str)
    dst = find_destination(str)
    src = find_source(dst, str) if dst
    return unless src && dst

    @board.info_at(src, :moven?, @moves.length)
    @board.move_piece(src, dst)
    @current_player = %w[white black].find { |player| player != @current_player }
    @moves << str
  end

  def friend?(coords)
    @board.board[coords[0]][coords[1]].piece&.black ==
      (@current_player == 'black')
  end

  def enemy?(coords)
    @board.board[coords[0]][coords[1]].piece&.black ==
      (@current_player == 'white')
  end

  def qualifies?(qualifier, coords, type)
    (qualifier.nil? || qualifier == coords || (qualifier.ord - 'a'.ord) == coords[1] ||
    ((8 - qualifier.to_i) == coords[0])) &&
      @board.board[coords[0]][coords[1]].piece.is_a?(type) && friend?(coords)
  end

  def forwards
    (@current_player == 'white' ? -1 : 1)
  end

  def backwards
    (@current_player == 'white' ? 1 : -1)
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

  def find_source(dst, str)
    piececlass = { R: Rook, N: Knight, B: Bishop, Q: Queen }[str[0].to_sym]
    piececlass ? piececlass.source(dst, str, self) : Pawn.source(dst, str, self)
  end

  def find_destination(str)
    piececlass = { R: Rook, N: Knight, B: Bishop, Q: Queen }[str[0].to_sym]
    piececlass ? piececlass.destination(str, self) : Pawn.destination(str, self)
  end
end
