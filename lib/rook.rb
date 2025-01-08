# frozen_string_literal: true

require_relative 'piece'

# Rook
class Rook < Piece
  def initialize(black: false)
    super(black ? '♜' : '♖', 'R')
  end
end
