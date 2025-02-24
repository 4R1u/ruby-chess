# frozen_string_literal: true

require_relative 'square'

# Chessboard
class Board
  def initialize(width = 8, height = 8)
    @board = Array.new(height) { Array.new(width) }
    black = false
    @board.each do |rank|
      rank.each_index do |index|
        rank[index] = Square.new(nil, dark: black)
        black = !black unless index == width - 1
      end
    end
  end

  def info_at(src, key, value = nil)
    piece = @board[src[0]][src[1]].piece
    return nil if piece.nil?

    if value.nil?
      piece.info[key]
    else
      piece.info[key] = value
    end
  end

  def output
    @board.each do |rank|
      rank.each(&:output)
      puts nil
    end
    nil
  end

  def board
    @board.map { |rank| rank.map(&:itself) }
  end

  def place_piece(coords, piece)
    @board[coords[0]][coords[1]].piece = piece
  end

  def remove_piece(coords)
    piece = @board[coords[0]][coords[1]].piece
    @board[coords[0]][coords[1]].piece = nil
    piece
  end

  def move_piece(src, dst)
    place_piece(dst, remove_piece(src))
  end

  def friend?(coords, current_player)
    @board[coords[0]][coords[1]].piece&.black ==
      (current_player == 'black')
  end

  def enemy?(coords, current_player)
    @board[coords[0]][coords[1]].piece&.black ==
      (current_player == 'white')
  end

  def pawn?(coords)
    @board[coords[0]][coords[1]].piece.is_a?(Pawn)
  end

  def valid_coords?(coords)
    (0..7).cover?(coords[0]) && (0..7).cover?(coords[1])
  end
end
