# frozen_string_literal: true

# A chess piece.
class Piece
  def initialize(char = '♙', letter = '', dark: true)
    @char = char
    @letter = letter
    @dark = dark
  end

  def valid_move?(source, destination)
    source.all? { |num| (0..7).cover?(num) } &&
      destination.all? { |num| (0..7).cover?(num) }
  end
end
