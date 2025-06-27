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
    gstr = str.sub('+', '')
    dst = [8 - gstr[-1].to_i, gstr[-2].ord - 'a'.ord]
    dst if game.board.valid_coords?(dst) &&
           (game.enemy?(dst) || (game.board.empty?(dst) && !gstr.include?('x')))
  end

  def self.source
    nil
  end

  def self.find_qualifier(str)
    gstr = str[-1] == '+' ? str.sub('+', '') : str
    return if gstr.length <= 3

    return gstr[1] if ('1'..'8').cover?(gstr[1])

    find_non_rank_qualifier(gstr)
  end

  def self.find_non_rank_qualifier(gstr)
    ('1'..'8').cover?(gstr[2]) ? [8 - gstr[2].to_i, gstr[1].ord - 'a'.ord] : (gstr[1] if ('a'..'h').cover?(gstr[1]))
  end

  def self.legal_moves(_src, _game)
    []
  end
end
