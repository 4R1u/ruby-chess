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
    src = find_source_pawn(dst, str) if dst
    return unless src && dst

    @board.info_at(src, :moven?, @moves.length)
    @board.move_piece(src, dst)
    @current_player = %w[white black].find { |player| player != @current_player }
    @moves << str
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
    dst = str.length <= 4 ? [8 - str[-1].to_i, str[-2].ord - 'a'.ord] : [8 - str[3].to_i, str[2].ord - 'a'.ord]
    dst if @board.board[dst[0]][dst[1]].piece&.black !=
           (@current_player == 'black')
  end

  def find_source_pawn(dst, str)
    if str.length > 2
      find_en_passant_source(dst, str) || find_capturing_pawn(dst, str[0].ord - 'a'.ord)
    elsif @board.board[dst[0]][dst[1]].piece.nil?
      find_pawn_source_one_square_behind(dst) ||
        find_pawn_source_two_squares_behind(dst)
    end
  end

  def find_pawn_source_one_square_behind(dst)
    src = [dst[0] + (current_player == 'white' ? 1 : -1), dst[1]]
    piece = @board.board[src[0]][src[1]].piece
    return nil if piece.nil? || piece.black == (@current_player == 'white')

    src if piece.is_a?(Pawn)
  end

  def find_pawn_source_two_squares_behind(dst)
    src = [dst[0] + (@current_player == 'white' ? 2 : -2), dst[1]]
    piece = @board.board[src[0]][src[1]].piece

    src if piece.is_a?(Pawn) && !piece.info[:moven?] &&
           (piece.black != (@current_player == 'white'))
  end

  def find_capturing_pawn(dst, file_number)
    return unless (0..7).cover?(file_number)

    src = [dst[0] + (@current_player == 'white' ? 1 : -1), file_number]
    piece = @board.board[src[0]][src[1]].piece
    src if piece.is_a?(Pawn) && piece.black == (@current_player == 'black') &&
           (dst[1] - file_number).abs == 1 &&
           @board.board[dst[0]][dst[1]].piece&.black == (@current_player == 'white')
  end

  def find_en_passant_source(dst, str)
    src = [dst[0] + (@current_player == 'white' ? 1 : -1), str[0].ord - 'a'.ord]
    removed = [dst[0] + (@current_player == 'white' ? 1 : -1), dst[1]]

    return unless (0..7).cover?(src[0]) && (0..7).cover?(src[1]) &&
                  (0..7).cover?(dst[0]) && (0..7).cover?(dst[1]) &&
                  (0..7).cover?(removed[0]) && (0..7).cover?(removed[1])
    return unless @board.board[removed[0]][removed[1]].piece&.black == (@current_player == 'white')

    piece = @board.board[src[0]][src[1]].piece
    if piece.is_a?(Pawn) && piece.black == (@current_player == 'black') &&
       (dst[1] - src[1]).abs == 1
      @board.remove_piece(removed)
      src
    end
  end
end
