# frozen_string_literal: true

require_relative 'piece'

# Pawn
class Pawn < Piece
  def initialize(black: false)
    super(black ? '♟' : '♙', '', black: black)
  end

  def self.destination(str, game)
    gstr = str.sub(' e.p.', '')
    dst = [8 - gstr[-1].to_i, gstr[-2].ord - 'a'.ord]
    dst unless game.friend?(dst)
  end
end
