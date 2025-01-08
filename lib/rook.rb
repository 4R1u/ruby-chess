# frozen_string_literal: true

require_relative 'piece'

# Rook
class Rook < Piece
  attr_accessor :moven

  def initialize(black: false)
    super(black ? '♜' : '♖', '')
    @moven = false
  end
end
