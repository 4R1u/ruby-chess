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

  def self.destination(str, game)
    dst = [8 - str[-1].to_i, str[-2].ord - 'a'.ord]
    dst if game.board.valid_coords?(dst) &&
           (game.enemy?(dst) || (game.board.empty?(dst) && !str.include?('x')))
  end

  def self.source
    nil
  end

  def self.find_qualifier(str)
    return if str.length <= 3

    return str[1] if ('1'..'8').cover?(str[1])

    ('1'..'8').cover?(str[2]) ? [8 - str[2].to_i, str[1].ord - 'a'.ord] : (str[1] if ('a'..'h').cover?(str[1]))
  end
end
