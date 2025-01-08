# frozen_string_literal: true

require_relative 'piece'

# Pawn
class Pawn < Piece
  def initialize(black: false)
    super(black ? '♟' : '♙', '')
  end
end
