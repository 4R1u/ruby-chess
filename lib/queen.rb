# frozen_string_literal: true

require_relative 'piece'
require_relative 'rook'
require_relative 'bishop'

# Queen
class Queen < Piece
  def initialize(black: false)
    super(black ? '♛' : '♕', 'Q', black: black)
  end

  def self.source(dst, str, game)
    uniq = [nil, Bishop.source(dst, str, game, Queen),
            Rook.source(dst, str, game, Queen)].uniq
    uniq[1] if uniq.length == 2
  end

  def self.legal_moves(src, game)
    Bishop.legal_moves(src, game, 'Q') + Rook.legal_moves(src, game, 'Q')
  end
end
