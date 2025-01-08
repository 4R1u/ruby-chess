# frozen_string_literal: true

# A chess piece.
class Piece
  def initialize(char = '♙', letter = '')
    @char = char
    @letter = letter
  end
end
