# frozen_string_literal: true

require_relative 'piece'

# Pawn
class Pawn < Piece
  attr_accessor :moven

  def initialize(black: false)
    super(black ? '♟' : '♙', '')
    @moven = false
  end
end
