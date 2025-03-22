# frozen_string_literal: true

require_relative 'piece'
require_relative 'rook'
require_relative 'bishop'

# Queen
class Queen < Piece
  def initialize(black: false)
    super(black ? '♛' : '♕', 'Q', black: black)
  end

  def self.destination(str, game)
    dst = [8 - str[-1].to_i, str[-2].ord - 'a'.ord]
    dst if game.board.valid_coords?(dst) &&
           (game.enemy?(dst) || (game.board.empty?(dst) && !str.include?('x')))
  end

  def self.source(dst, str, game)
    uniq = [nil, Bishop.source(dst, str, game, Queen),
            Rook.source(dst, str, game, Queen)].uniq
    uniq[1] if uniq.length == 2
  end
end
