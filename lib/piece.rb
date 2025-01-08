# frozen_string_literal: true

# A chess piece.
class Piece
  attr_reader :char, :letter, :black

  def initialize(char = '♙', letter = '', black: false)
    @char = char
    @letter = letter
    @black = black
  end
end
