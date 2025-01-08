# frozen_string_literal: true

# A chess piece.
class Piece
  attr_reader :char, :letter

  def initialize(char = '♙', letter = '')
    @char = char
    @letter = letter
  end
end
