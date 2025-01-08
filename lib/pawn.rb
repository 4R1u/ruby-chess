# frozen_string_literal: true

require_relative 'piece'

# Pawn (should implement normal moves,
# as well as moving two squares at the beginning, capturing and enpassant)
class Pawn < Piece
  attr_accessor :moven

  def initialize(black: false)
    super(black ? '♟' : '♙', '')
    @moven = false
  end
end
