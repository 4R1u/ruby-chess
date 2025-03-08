# frozen_string_literal: true

# A chess piece.
class Piece
  attr_reader :char, :letter, :black, :info

  def initialize(char = '♙', letter = '', black: false)
    @char = char
    @letter = letter
    @black = black
    @info = {}
  end

  def self.destination
    nil
  end

  def self.source
    nil
  end
end
