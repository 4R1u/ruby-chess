# frozen_string_literal: true

require_relative 'piece'

# King
class King < Piece
  def initialize(black: false)
    super(black ? '♚' : '♔', 'K', black: black)
  end
end
