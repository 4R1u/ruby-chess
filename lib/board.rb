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
end
