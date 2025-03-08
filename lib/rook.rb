# frozen_string_literal: true

require_relative 'piece'

# Rook
class Rook < Piece
  def initialize(black: false)
    super(black ? '♜' : '♖', 'R', black: black)
  end

  def self.destination(str, game)
    dst = [8 - str[-1].to_i, str[-2].ord - 'a'.ord]
    dst if game.board.valid_coords?(dst) &&
           (game.enemy?(dst) || (game.board.empty?(dst) && !str.include?('x')))
  end
end
