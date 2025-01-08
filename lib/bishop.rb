# frozen_string_literal: true

require_relative 'piece'

# Bishop
class Bishop < Piece
  def initialize(black: false)
    super(black ? '♝' : '♗', 'B', black: black)
  end
end
