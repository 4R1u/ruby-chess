# frozen_string_literal: true

require_relative 'piece'

# Pawn (should implement normal moves,
# as well as moving two squares at the beginning, capturing and enpassant)
class Bishop < Piece
  def initialize(black: false)
    super(black ? '♝' : '♗', '')
  end
end
